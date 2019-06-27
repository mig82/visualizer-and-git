# Best Practices on using Kony Visualizer with Git

Tips and tricks to use Git with Kony Visualizer projects.

## Quick Start

To get started just copy, paste and execute this into your terminal.

```bash
brew install jq
git config --global alias.visconfig '!curl -L http://bit.ly/visgitaliases -o aliases.sh && \
 curl -L http://bit.ly/visgitfilters -o filters.sh && \
 chmod u+x aliases.sh && ./aliases.sh && \
 chmod u+x filters.sh && ./filters.sh && \
 rm aliases.sh && rm filters.sh'
git visconfig
```
This will download and run the filter and alias definitions.
Then, step into the root of your project and run:

```bash
git visinit
```

This will download the `.gitignore` and `.gitattributes` files into the root of your project.

**Done!** It's that simple.

Now, if you ever want to update the aliases and filters to the latest published to the master branch of this repository run:

```bash
git visconfig
```

Now read on if you want to find out what you just did.

## What to Ignore

Figuring out what to ignore and what to version in a Visualizer project is the subject of many questions. The cross-platform nature of Visualizer makes for a very complex project anatomy. I've done my best to experiment with different versions of Visualizer and document my findings here. If you just want to get started quickly and all you need is a `.gitignore` file, then step into the root directory of your Visualizer project and run:

    curl -O https://raw.githubusercontent.com/mig82/vis-git/master/.gitignore

You'll download a self-documented `.gitignore` file.

# Avoiding Unnecessary Merge Conflicts and Staying Sane

In a Visualizer project there will be files which are relevant and must be ignored, but which sometimes contain bits of data that is prone to generate merge conflicts, or minified contents which are not nice for versioning, or information which should not be versioned for security reasons. This section tackles such issues.
If you just want to get started, then step into the root directory of your Visualizer project and run:

    curl -O https://raw.githubusercontent.com/mig82/vis-git/master/.gitattributes

**Note:** You will also have to download and execute the `filters.sh` Bash script in order
to define the filters defined by `.gitattributes`.

	curl -O https://raw.githubusercontent.com/mig82/vis-git/master/filters.sh

## Removing Noise

There are some files which Visualizer constantly updates while you work on your
project. Some of these updates are relevant to your project, some of them are
only relevant to how you while you're working on it, and some of them are things
that simply should never go into an SCM.

Whether you're looking at how a particular view would render on an iPhone X or a
Samsung Galaxy is not really relevant to your peers working on the project and
should not be pushed to source control. The reason is that while you look at how
one view would render on iPhone, another developer may have looked at how it
would render on Android, and because this information is stored in view files,
pushing will cause merge conflicts for no good reason. This is a clear example
of metadata that you don't want to version.

The `filters.sh` Bash script in this repo defines a filter called `kony_views`.
This filter removes unwanted metadata -such as `platform` or `shellCSS`- from
the JSON files defining your views in order to avoid unnecessary merge conflicts.

The script also defines a filter called `kony_projectProperties` which prettifies
and resets some frequently changing keys -such as `isModified`- from your project's
`projectProperties.json` file in order to avoid unnecessary merge conflicts.

The script also defines a filter called `kony_projectprop` which sorts your
project's `projectprop.xml` file and keeps it sorted, so it will be easier to
find changes. It also removes unnecessary properties which change often like
`lastmodifiedtime` in order to avoid unnecessary merge conflicts.

These are applied by the `.gitattributes` file
which you *must* add *and* version along with your project.

## Knowing Exactly What Has Changed

Another example is the files that keep the configurations of the Fabric integration
services and object services being used. Whether you add or remove services or
service operations, you want to be able to see exactly what has changed.

The `filters.sh` Bash script in this repo defines a filter called `pretty_json`.
This filter prettifies and sorts JSON files.
This is applied to both `mobileFabricServiceConfigMap.json` and
`objectServicesConfigMap.json` by the `.gitattributes` file which you *must* add
 *and* version along with your project.

## Dependencies

The filters mentioned above which apply to JSON files -e.g.: `projectProperties.json`,
`mobileFabricServiceConfigMap.json`, as well as any JSON file describing a form,
widget, skin, popup, template, or the like, require a third party tool capable of
prettifying, sorting and transforming JSON files with ease. If you look closely at
`filters.sh` you'll see that this tool is the `jq` command.

> jq is a lightweight and flexible command-line JSON processor.

You can download and install the **jq** binaries from [here](https://stedolan.github.io/jq).

You can also find additional installation alternatives using package managers such as Homebrew, Chocolatey or directly from Github [here](https://github.com/stedolan/jq/wiki/Installation).

If you're a Mac user, then I strongly recommend using [Homebrew](https://brew.sh/):

    $ brew install jq

**Note:** I regularly use **jq** to inspect my projects' forms and widgets -e.g.:

    jq . forms/mobile/homeForm.sm/bodyFlex.json --sort-keys --tab

## Security

If you've decided to version your `HeadlessBuild.properties` file along with your
project, you should know there's an entry there for your Fabric password which
you should **NEVER** push to source control.

The `filters.sh` Bash script in this repo defines a filter called
`kony_headless_props`. This is used to remove the Fabric password from the `HeadlessBuild.properties` file so it will never be pushed to source control. It
is applied by the `.gitattributes` file which you *must* add *and* version along
 with your project.

# The Empty Directory Problem

When a Vis project is created a lot of empty directories are added to its structure. Sadly, [Git is unable to version empty directories](https://git.wiki.kernel.org/index.php/GitFaq#Can_I_add_empty_directories.3F). This means if a brand new project is pushed to a git repo, those empty directories won't be pushed. The problem with this is that
**in older Visualizer versions such as 7.x and below** when such a project is cloned by another developer, they will be unable to it. Vis will crash upon failing to find the directory structure it expects.

**Kony has fixed this problem in Visualizer versions 8.x+**, but for those working with older versions to get around this problem, you must force Git to push all these empty directories to source control. This can be done by adding a `.gitkeep` file to each empty directory. To do so, have a look at project Gitkeep [here](https://pypi.org/project/gitkeep2). It's a small Python library, so if you've already installed Python, you can install it by simply running:

    pip install gitkeep2

And then you can force Git to version all of your project's empty
directories by running:

    gitkeep r path/to/workspace/FooApp -m "Force keep empty dirs until we add stuff to them"

Of course, there are other tools and ways to add these `.gitkeep` files. This is just a recommendation.

## Other Candidates for Ignoring

The following is a list of files you can optionally ignore or not. Visualizer is
capable of re-generating them if missing, based on the versions of the plugins
your project uses. So if your `konyplugins.xml` file hasn't changed, these files
should always be the same regardless of which machine you build the project on.

This being said, I still version them because I like to be able to track whether
something has changed in them or not.

* modules/KonySyncLib.js
* modules/kony_sdk.js
