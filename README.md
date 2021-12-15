# common rules of this repository

This is the single source of the truth for the article files for [neolambda.studio](https://neolambda.studio)'s blog. 

You can always commit to this blog for new articles, or for reporting errors. 

When commiting to this blog, please follow common rules below, on every commit to this repository.

## How to create a new article
[notion link](https://antique-speedwell-163.notion.site/c6be263f681f4513888508b6eab84fc9?v=1ee34de4c7a0469c8106897b8a9375ab) (read-only, you need permission to edit, please request via email, jan9won@gmail.com)
1. create notion page for the article if there isn't already
2. edit the notion page's status to "writing"
3. create new branch with the naming rule below
    - get the title of the article
    - use this command line function to escape it
    ```shell
        escape () {
            echo "$1" | tr '[:upper:]' '[:lower:]' | sed -r 's/([^a-zA-Z0-9])/-/g' | sed -e 's/--*/-/g'
        }
    ```
        1. make all characters lower case
        2. make all non-alphanumeric characters into "-" (minus character)
        3. if there is two or more recurring "-", reduce them into a single "-"
    - prepend the main category of the article with "/" (slash) as a perimeter
    - the result is `<category>/<escaped title>`
4. create new directory on the base directory, with the name the branch. `mkdir <category>/<escaped title>`
6. go to the created directory
5. create mdx article files named with it's language code. i.e. `touch en.mdx ko.mdx`. 
    - language code should follow 2-character ISO standard.
    - both .md and .mdx extensions are acceptable. use .mdx when it has mdx components in it.
6. create `images` folder. images embedded in the article should be in here.
7. create `thumb.png` for thumbnail. the size should be 1280x720
8. create meta.json for metadata. the detail of this file is below
9. when finished, merge the branch to the main branch. 
    - please consider squashing your backup purposed commits
    - every merge pull on the main branch will trigger webhoook to refresh blog's article listing. 
    - it's published directly without any further review so becareful when pulling the main branch merge. 
    - editing and deleting article should follow rules described below
10. go to notion and make the status of the article "published"

## what's ***not*** in meta.json

> any data that can be retrieved from the git repository

### name of authors
- main author is the creator of the article's file
- collaborators are the people who commited to the article's file
- author's id and name is based on git history, not Github

### created and last edited time of an article
- an article's creation time is the first time the file is merged to the main branch
- an article's last edited time is the last time the file merged to the main branch

## what's in meta.json

### "title" : String

title should be
- empty string (""), when the title of article and the folder's name
is same
- "<the edited title>", when the title is changed and diverged from
the folder's name

why it's needed
- to prevent extra works when the title changes
- branch rename
- folder rename
- notion rename
- to make the initial naming much easier, as it's not the permanent one

### "subcategory" : String[]
- the main category is determined by the directory of the article
- but if the article should have other categories than that, they should be added here.
- category name should directly reference existing directory's name

### "tag" : String[]
- anything that is not significant to be in the category list should be put here
- tags will be indexed for a search feature of the blog website

## How to edit an existing article
1. go to the notion and edit article's status to "edit"
2. if there's a related issue, go to the issue and change status properly
3. create new branch `<category>/<escaped title>` and edit on it
4. when finished, merge to main and push
5. go to the notion and edit status to "published" close the issue if it exisists

## How to delete an existing article
1. create new branch `<category>/<escaped title>` and edit on it
2. delete whole directory, and write commit message the reason of deletion
3. merge to main and push
4. go to the notion and edit status to "deleted" and write the reason of deletion on the page
