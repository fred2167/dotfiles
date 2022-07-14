# Build the initial commit graph
cd ~/Uber/go-code
git checkout main
git pull
git show-ref -s | git commit-graph write --stdin-commits

# Enable commit graph writes on fetch
git config fetch.writeCommitGraph true

# Reduce Git verbosity
git config merge.stat false
git config rebase.stat false

# Create a new sparse work tree
mkdir ~/Uber/go-code-sparse
git-bzl new ~/Uber/go-code ~/Uber/go-code-sparse

# Add targets
cd ~/Uber/go-code-sparse
git-bzl add src/code.uber.internal/amd
git-bzl add idl/code.uber.internal/amd
