# DriveBC.ca Caching
## Introduction
During high load scenarios such as winter storms, atmospheric rivers, flooding, etc there can be too much traffic hitting the Drivebc.ca desktop and mobile sites which causes reduced performance for end users.

## Goal
To reduce the load on the current infrastructure by implementing a scalable caching solution that we can place in front of the desktop and mobile sites to reduce the load on the backend servers by serving site assets that are frequently accessed.

## Release Process
If you need to make changes to the helm charts or to the nginx.conf file follow these steps to release from dev to prod:
1. Push your changes to `main` branch
1. `1. Build & Deploy to Dev` Github action will automatically deploy to the dev namespace
1. Once ready to release to `tst` manually trigger `2. Create Tag & Build/Deploy to Tst` Github action. 
    1. You will need to enter the version # you want to use and add a message
1. Once ready to release to `stg` manually trigger `3. Promote from Tst to Stg`
    1. IMPORTANT: You must select the `Tag` you want to release and not the branch
1. Once ready to release to `prd` create a new release by:
    1. Going to the `https://github.com/bcgov/DriveBC.ca-Caching/releases` 
    1. Click `Draft a new release`
    1. Under `Choose a tag` select the tag you want to release
    1. Click `Generate Release Notes`
    1. It should automatically give it a name
    1. Click `Publish release`
    1. This will automatically trigger the Github action to do the release


## License

```
Copyright 2024 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
