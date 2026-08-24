# CSSS Event Sites

Mono-repo which contains event sites that the CSSS has used for marketing. Uses Nx and Astro for the modern sites.

## File structure

- `legacy/`: contains the static sites made before May 2026
- `sites/`: contains the code to generate event sites using Astro
- `packages/`: code and components that are shared across different event sites in `sites`

## Commands

These commands indicate what you can do once you've cloned the project.
The project graph will show you the dependencies of each site.

_Note:_ Make sure you put the hyphen between `<event>` and `<year>`; this is also referred to as the `site-name`.

| Description                   | Command                                         |
| ----------------------------- | ----------------------------------------------- |
| Create a new event site       | `npm run new-site <event> <year>`               |
| Develop one site              | `npx nx dev <event>-<year>`                         |
| Build one site                | `npx nx build <event>-<year>`                       |
| Build all sites               | `npx nx run-many --target=build`                    |
| Build changed sites           | `npx nx affected --target=build`                    |
| See changed sites             | `npx nx show projects --affected`                   |
| See project graph             | `npx nx graph`                                      |
| Lint active code              | `npm run lint`                                  |
| Format active code            | `npm run format`                                |
| Check formatting              | `npm run format:check`                          |
| Install package for all sites | `npm install <library> -w`                      |
| Install package for one site  | `npm install <library> --workspace=<site-name>` |

## Development

You'll need:
- `node`: Check the version required in `.node-version`.
- `git-lfs`: Follow the instructions on their [website](https://git-lfs.com/) to set it up.

1. Clone the repo, forking it if you need to.
2. `cd /path/to/csss-site-events`
3. `git lfs pull`
4. `npm ci`

Then, you can run sites using the commands above.
