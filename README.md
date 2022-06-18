# Food Ordering

## Prerequisites

- [Git](https://git-scm.com/)
- [Visual Studio Code](https://code.visualstudio.com/)

## Setup

- Git clone `ssh://git@stash.travelline.lan:7999/tltool/food-flutter.git` into project folder
- Run `git update-index --assume-unchanged frontend\lib\main_develop.dart` in project folder
- Run `setup.bat` as **Administrator** in frontend folder
- Launch Visual Studio Code and open backend folder
- Launch Visual Studio Code and open frontend folder
  - Install all [Workspace recommended extensions](https://code.visualstudio.com/docs/editor/extension-gallery#_workspace-recommended-extensions)

## Workflow: Visual Studio Code (Backend)

| Task        | Shortcut | Command                  |
| ----------- | -------- | ------------------------ |
| Run backend | `F5`     | `Debug: Start Debugging` |

## Workflow: Visual Studio Code (Frontend)

| Task                                   | Shortcut       | Command                                       |
| -------------------------------------- | -------------- | --------------------------------------------- |
| Run application on selected device     | `F5`           | `Debug: Start Debugging`                      |
| Build application                      | `Ctrl+Shift+B` | `Tasks: Run Build Task`                       |
| Run tests                              | `Ctrl+T`       | `Tasks: Run Test Task`                        |
| Run static analyzer                    |                | `task Run static analyzer`                    |
| Check code formatting                  |                | `task Check code formatting`                  |
| Run code formatter                     |                | `task Run code formatter`                     |
| Run pre-release testing and validation |                | `task Run pre-release testing and validation` |
| Build localizations assets             |                | `task Build localizations assets`             |
| Build localizations                    |                | `task Build localizations`                    |

## Workflow: Contribution

Any programmer can contribute in [this repository](https://stash.travelline.lan/projects/TLTOOL/repos/food-flutter). There is the _Flutter UI_ swimlane on the [Kanban board for FOOD project](https://jira.travelline.ru/secure/RapidBoard.jspa?rapidView=400).

- Choose any unassigned issue with has a _To Do_ status and assign it to yourself.
- To start working on the issue:
  - Set the status of the task to state _In Progress_.
  - Create a new branch from _master_:
    - Name _feature_ branches like "feature/<JIRA_TASK_LINK_KEY>-<SOMETHING_ABOUT_TASK_SUMMARY>". For example, for task "FOOD-2 Добавить скрипт настройки окружения для начала работы с репозиторием" you can create a branch with name "feature/FOOD-2-add-setup-script".
    - Name _bugfix_ branches like "bugfix/<JIRA_TASK_LINK_KEY>-<SOMETHING_ABOUT_TASK_SUMMARY>".
- Create the _Pull Request_ of your work as soon as possible:
  - Name it "[WIP] <JIRA_TASK_LINK_KEY> <JIRA_TASK_SUMMARY>".
  - Add (_roman.petrov_, _alexey.starovoitov_, _alexey.ivanov_, denis.afanasev and _darya.scheglova_) as the reviewers.
- When the task is complete:
  - Make sure that _master_ branch is up to date and your branch is rebased onto _master_.
  - Remove the [WIP] prefix from pull request name.
  - Set the status of the task to state _Code Review_.
- Reviewers can offer some suggestions for code improvement. So, consider their ideas and make relevant changes to the code.
- Wait for the approvals by all reviewers.
- Squash all commits of your branch to one, name it "<JIRA_TASK_LINK_KEY> <JIRA_TASK_SUMMARY>".
- Merge your branch into _master_.

## FAQ

Q: Project's Flutter SDK version was updated. How can I update too?  
A: Run `git fetch` and then `git checkout <hash from flutter_sdk.version>` in Flutter SDK folder.

Q: Code should be compiled without any problem, but I see strange errors.  
A: Try run `flutter clean` in project folder or otherwise `pub cache repair`.
