#!/bin/sh
# Apply this template, and optionally a stack preset, to a project.
set -eu

BEGIN_MARK='<!-- stack:begin -->'
END_MARK='<!-- stack:end -->'
FILES='AGENTS.md CLAUDE.md docs/PRD.md docs/DESIGN_SYSTEM.md docs/ARCHITECTURE.md'

usage() {
  cat >&2 <<'EOF'
Usage:
  scripts/apply.sh <stack> <target-dir> [--force]
      Copy the template into an existing project. Files that already exist
      are kept unless --force is given.

  scripts/apply.sh <stack> --in-place
      Turn a repo created from this template into a project: apply the stack
      preset, then remove the template's own files (stacks/, scripts/,
      LICENSE) and replace README.md with a stub.

<stack> is "generic" or a folder name under stacks/ (nextjs, swift, expo, electron).
EOF
  exit 1
}

die() {
  echo "error: $*" >&2
  exit 1
}

# Replace everything between the stack markers in $1 with the contents of $2.
inject() {
  awk -v snippet="$2" -v begin="$BEGIN_MARK" -v end="$END_MARK" '
    index($0, begin) { print; while ((getline line < snippet) > 0) print line; skip = 1; next }
    index($0, end)   { skip = 0 }
    !skip
  ' "$1" > "$1.tmp"
  mv "$1.tmp" "$1"
}

print_next_step() {
  cat <<'EOF'

Next: open the project in your AI coding tool and paste this prompt.

  I'm building [describe your app in 2 to 3 sentences]. It's for [who it's for].
  Fill in the bracketed parts of docs/PRD.md, docs/DESIGN_SYSTEM.md,
  docs/ARCHITECTURE.md and AGENTS.md. Keep the structure and headings.
  Ask me up to 5 questions first if anything important is unclear.
EOF
}

apply_to_target() {
  [ -d "$target" ] || die "$target is not a directory"
  target=$(cd "$target" && pwd)
  [ "$target" != "$root" ] || die "target is the template itself; use --in-place"

  agents_written=0
  for f in $FILES; do
    src=$root/$f
    if [ "$stack" != generic ] && [ "$f" = docs/ARCHITECTURE.md ]; then
      src=$preset/ARCHITECTURE.md
    fi
    dest=$target/$f
    if [ -e "$dest" ] && [ "$force" -eq 0 ]; then
      echo "skipped  $f (already exists)"
      continue
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "wrote    $f"
    if [ "$f" = AGENTS.md ]; then agents_written=1; fi
  done

  if [ "$stack" != generic ]; then
    if [ "$agents_written" -eq 1 ]; then
      inject "$target/AGENTS.md" "$preset/AGENTS.stack.md"
    else
      echo "note     AGENTS.md was kept, so the $stack rules were not added."
      echo "         Merge $preset/AGENTS.stack.md by hand, or rerun with --force."
    fi
  fi
}

apply_in_place() {
  if [ "$stack" != generic ]; then
    cp "$preset/ARCHITECTURE.md" "$root/docs/ARCHITECTURE.md"
    inject "$root/AGENTS.md" "$preset/AGENTS.stack.md"
    echo "applied  $stack preset"
  fi

  cat > "$root/README.md" <<'EOF'
# [Project name]

[One sentence on what this project is.]

## Getting started

See the Commands section in `AGENTS.md`.

## Project docs

- `docs/PRD.md`: what we're building and why
- `docs/DESIGN_SYSTEM.md`: how it should look
- `docs/ARCHITECTURE.md`: how it's built
- `AGENTS.md`: rules for AI coding agents (`CLAUDE.md` imports it)
EOF
  echo "wrote    README.md (project stub)"

  rm -rf "$root/stacks" "$root/scripts" "$root/LICENSE"
  echo "removed  stacks/ scripts/ LICENSE"
}

# Everything runs from main so the script is fully read before --in-place deletes it.
main() {
  [ $# -ge 2 ] || usage
  stack=$1
  shift

  target=''
  force=0
  in_place=0
  for arg in "$@"; do
    case $arg in
      --force) force=1 ;;
      --in-place) in_place=1 ;;
      -*) usage ;;
      *)
        [ -z "$target" ] || usage
        target=$arg
        ;;
    esac
  done

  root=$(cd "$(dirname "$0")/.." && pwd)
  preset=$root/stacks/$stack
  case $stack in
    generic) ;;
    */* | .*) usage ;;
    *) [ -d "$preset" ] || die "unknown stack \"$stack\" (no folder at stacks/$stack)" ;;
  esac

  if [ "$in_place" -eq 1 ]; then
    [ -z "$target" ] || usage
    apply_in_place
  else
    [ -n "$target" ] || usage
    apply_to_target
  fi

  print_next_step
}

main "$@"
