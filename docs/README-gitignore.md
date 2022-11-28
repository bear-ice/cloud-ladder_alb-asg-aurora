# Common repository: `.gitignore` file build branch & tools

For the common repository, this `_common/gitignore` branch provides
tools and source files used to build `.gitignore` files which can be
manually copied or have a _common_ fetch/merge into target repositories.

The source files come from repo `https://github.com/github/gitignore`,
which contains many specialized `source.gitignore` files as of
2022-11-06.  As the files in the source repo mostly go multiple years
without updates it is unlikely that upstream changes will make another
version necessary in the near future.

These files are placed in the `.working/gitignore` directory along with
`cat_to_gitignore.sh`, a simple tool to combine them while identifying
the source files.

## `cat_to_gitignore.sh` information

This tool builds a `gitignore` file (no leading `.`) or a similarly
named file in the current directory.

Options are passed as environment variables:
* repo -- the base URL of the source repository, this can be an empty
string to indicate that there was no source repository *(required)*
* gitignore_file -- the name of the gitignore file to generate (defaults
  to `gitignore`)
* date -- the date the source files were obtained/updated, in
  *YYYY-MM-DD* format (defaults to today's date)

Arguments are the file names found in the source repository.  The
relative directory structure should match the source repository (i.e. a
file named `Global/vim.gitignore` in the source directory should also be
in a `Global` subdirectory of the current directory).  This is to keep
the filename correct in the comments.

A typical invocation would be:
```
repo=https://github.com/github/gitignore date=2022-11-06 \
    gitignore_file=gitignore-primary \
    ./cat_to_gitignore.sh Primary.gitignore Global/Linux.gitignore \
    Global/Vim.gitignore
```
(likely there would be several more Global/... files included)

## Building specialized `.gitignore` files from multiple source files

1. Select the `source.gitignore` files.  These are generally one
   corresponding to the primary purpose from the working directory and
   several associated files from the `Global/` directory relating to OS,
   tools, etc.

2. (optional) Consult the original `https://github.com/github/gitignore`
   repository and see if any new files or versions should be added.:
   1. Download the new files & versions to the `.working/gitignore`
      directory.
   2. Check them into the `_common/gitignore` branch.

3. Select a output gitignore file to create, typically
    `gitignore-primary`.

4. Copy `gitignore-base` over `gitignore-primary` (or simply truncate
   it) and commit it to the branch.

5. Invoke `cat_to_gitignore.sh` with the list of `sourcefile.gitignore`
   files to be assembled (include any directories such as `/Global`).:

6. Commit the resulting file to branch `_common/gitignore`.

7. Go to your target repository and either simply copy the new
   `gitignore-primary` into your repository as `.gitignore`.
   Or alternately see the "Advanced" section.


## Advanced: fetch/merge across repositories based on `_special/common-base'

In order to facilitate future updates from the common repository one can
import the branch `_common/gitignore` to the target repository.
This only works for those target repositories based on commit `08bad07`,
tag `_special/common-base`.

1. Use git to fetch the `_common/gitignore` branch from the common repo
   into your target repo.
```
git fetch https://github.com/bear-ice/bear-ice_common _common/gitignore
```
2. Either you can use a merge commit
3. OR, you can use a squash commit (creating a cleaner commit history)
   or rebase.
4. Squash merge & rebase users in the future will have to integrate the
   commits from the original merge point to the head of the current
   branch.
