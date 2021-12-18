
> This repository is the single source of truth for the articles in [neolambda studio's blog](https://neolambda.studio). 
> 
> You can freely commit to this blog for new articles, or report errors with an issue.
> 
> When commiting, please follow common rules below.

<br/>

Table of Contents

- [Structure of this Repository](#structure-of-this-repository)
- [Instructions on CRUD](#instructions-on-crud)
	- [Create](#create)
	- [Write](#write)
	- [Update](#update)
	- [Delete](#delete)
- [More About `meta.json`](#more-about-metajson)

<br/>

# Structure of this Repository

```
this repository
│	create-article.sh
│	create-branch.sh
│	create-id.sh
│
└───template
│	│   en.md
│	│   meta.json
│	│   thumb.jpg
│	│   
│	└───images
│	│
│	└───<image files>
│
└───<main category names>
	│
	└───<article names>
		│   <language codes>.md
		│   meta.json
		│   thumb.jpg
		│
		└───images
		│
		└───<image files>
	    
```

---

# Instructions on CRUD

## Create
1. **edit the notion page's status to "writing"**
2. **create new branch with the `./create-article.sh` script**

	```shell
	./create-article.sh <category name> <title>
	```
	
	- `<category>` name and `<title>` has no rules, and will be escaped automatically
	- FYI, this script does 4 major jobs
		- escape and concat your `<category name>` and `<title>` to make `id`
		- make new branch named with `id`
		- make new directory named with `id` and copy template files into it
		- populate `meta.json` with user's git config

## Write
1. **create markdown files named with it's language code**

	- (i.e. `ko.md` or `de.md`)
	- You already have `en.md` as a template
	- language code should follow 2-character ISO standard
	- both `.md` and `.mdx` extensions are acceptable. `.md` files will also be parsed for `react-mdx` components

2. **Embed medias and MDX components in the article**

	- put files in the article's root directory
	- referece it as a relative directory
	- (i.e. `./images/myimage.jpg` or `.components/mycomponent.tsx`)

3. **Edit `thumb.jpg` for your article's thumbnail and in-page banner**

	- thumbnail format rules can be found on template `thumbs.jpg` added while creating article

4. **Add `subcategory` to meta.json, if you have more categories to add**

5. **Write `References` block**

	- when you open template `en.md`, at the bottom of it, you'll see `references`,`related versions` and `last reviewd`. Populate them properly.

6. **Commiting**

	- merge the branch (not rebase) to the `main` and make pull request to Github origin
    - please squash your backup purposed commits
    - every merge-pull-request on the origin/main will trigger webhoook, which directly update blog's articles. so be sure about your pull requrests.

## Update

1. if there's a related github issue, go to the issue and change status and comment

2. create new branch with `id`. If you don't know it, 

	- you can run `./create-id.sh` to print it on shell
	- or `./create-branch.sh` to create branch automatically

3. when finished, squash your backup commits and make pull request to Github origin

4. close the related issue if it exisists

## Delete

1. delete article's whole folder directly on the `main` branch

2. if there's a branch, delete it either

3. write commit message with the reason of deletion

4. make a pull request to the Github origin

# More About `meta.json`
> any data that can be retrieved from the git repository will be automatically inserted to `meta.json`.
> 
> this happens while running `create-article.sh` and `pre-commit` git hook.

1. `"author"` and `"email"` fields

	- `"author"` is the creator of the article
    - author's `"email"` and `"name"` will be located with git history
    - please configure your git properly before commiting

2. `"created"` and `"edited"` fields

	- `"created"` is the timestamp of the *first* time article is merged to the `origin/main` branch
    - `"edited"` time is the timestamp of the *last* time article merged to the `origin/main` branch
