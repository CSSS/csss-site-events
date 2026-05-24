# CSSS Event Sites
Mono-repo which contains event sites that the CSSS has used for marketing. Uses Nx and Astro for the modern sites.

## File structure
* `legacy/`: contains the static sites made before May 2026
* `sites/`: contains the code to generate event sites using Astro
* `packages/`: code and components that are shared across different event sites in `sites`

## Commands
These commands indicate what you can do once you've cloned the project.
The project graph will show you the dependencies of each site.

*Note: make sure you put the hyphen between `<event>` and `<year>`.


| Description         | Command                      |
|---------------------|-------------------------------|
| Develop one site    | `nx dev <event>-<year>`       |
| Build one site      | `nx build <event>-<year>`     |
| Build all sites     | `nx run-many --target=build`  |
| Build changed sites | `nx affected --target=build`  |
| See changed sites   | `nx show projects --affected` |
| See project graph   | `nx graph`                    |
