> This repository is the single source of truth for the articles in [neolambda studio's blog](https://neolambda.studio). 
> You can freely commit to this blog for new articles, or report errors with an issue.
> When commiting to this blog, please follow common rules below.

# Instructions on Write/Edit/Delete an Article

- [How to create a new article](#how-to-create-a-new-article)
- [Writing Article](#writing-article)
- [How to edit an existing article](#how-to-edit-an-existing-article)
- [How to delete an existing article](#how-to-delete-an-existing-article)
- [more about meta.json](#more-about-metajson)



## How to create a new article
[notion link](https://antique-speedwell-163.notion.site/c6be263f681f4513888508b6eab84fc9?v=1ee34de4c7a0469c8106897b8a9375ab) (read-only, you need permission to edit, please request via email, jan9won@gmail.com)
1. create notion page for the article if there isn't already
2. edit the notion page's status to "writing"
3. create new branch with the `./create-article` script
	```shell
	./create-article <category name> <title>
	```
	this script does 4 things
	- escape and concat your `<category name>` and `<title>` to make `id`
	- make new branch named with `id`
	- make new directory named with `id` and copy template files into it
	- populate `meta.json` template with following information
	    - `<title>` you entered
		  - your git's `username` and `email`
4. you can create markdown files named with it's language code. i.e. `ko.md` or `de.md`. You already have `en.md` as a template 
    - language code should follow 2-character ISO standard.
    - both `.md` and `.mdx` extensions are acceptable. `.md` files will also be parsed for `react-mdx` components

## Writing Article
1. When you have medias embedded in the article, put media files in the article's directory and referece it as a relative directory. (i.e. `./images/myimage.jpg`)
2. Edit `thumb.jpg`, which will be your article's thumbnail and banner.
3. If you have subcategories, you can add `subcategory` to meta.json.
4. wh you open template `en.md`, at the bottom of it, you'll see `references`,`related versions` and `last reviewd`. Populate them properly.
5. when finished, merge the branch (not rebase) to the main and pull request to Github origin. 
    - please squash your backup purposed commits
    - every merge-pull-request on the origin/main will trigger webhoook, which directly update blog's articles. so be sure about your pull requrests.
6. go to notion and make the status of the article "published"
7. editing and deleting articles should follow other directions below

## How to edit an existing article
1. go to the notion and edit article's status to "edit"
2. if there's a related github issue, go to the issue and change status and comment
3. create new branch with `id` from `./create-article` above. If you don't know it, you can run `./make-id` to see it.
4. when finished, merge to main and pull request to Github origin
5. go to the notion and edit status to "published" close the issue if it exisists

## How to delete an existing article
1. delete article's whole folder directly on the `main` branch.
2. if there's branch, delete it either. 
3. pull request to the Github origin
4. go to the notion and edit status to "deleted" and write the reason of deletion on the page

## more about meta.json
> any data that can be retrieved from the git repository will be automatically populated on `create-article` and `pre-commit` git hook.

1. `"author"` and `"email"` fields
    - author will be the creator of the article's file
    - authors' email and name will be found on git history. So configure your git properly before running `./create-article`

2. `created` and `edited` time
    - created time is the *first* time the file is merged to the `origin/main` branch
    - edited time is the *last* time the file merged to the `origin/main` branch
