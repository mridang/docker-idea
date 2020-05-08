# Docker Images for Jetbrains' IDEs

Docker images for select Jetbrains' IDEs - IntelliJ and PHPStorm.

Requirements
------------

Docker

Installation
------------

Pull the required image using

About
------------

In order to inspect your codebase using the provided images, you'll need to run
the Jetbrains CLI inspection tool. This is the entry-point for all containers in
this repository.

The project to be analysed must be a valid IDEA project. You are required to version-control the `.idea` folder:
* `.idea/inspectionProfiles/Project_Default.xml` - analyzer settings.
* `.idea/modules.xml` - or you'll get the error - "This project contains no modules"
* `.idea/misc.xml` - or you'll get the error - "The JDK is not configured properly for this project"
* `*. iml-*` - or you'll get an error about a non-configured JDK in the module.



### Inspecting a PHP project

`docker run --volume=$(pwd):/app docker.pkg.github.com/mridang/docker-idea/phpstorm:2020.1.1 /app /app/.idea/inspectionProfiles/Project_Default.xml /app/output -d /app -v2`

### Inspecting a Java project

`docker run --volume=$(pwd):/app docker.pkg.github.com/mridang/docker-idea/intellij:2018.1.1 /app /app/.idea/inspectionProfiles/Project_Default.xml /app/output -d /app -v2`

Authors
-------

* Mridang Agarwalla

Credits
-------

* Ivan Ponomarev (@inponomarev) for the writing the article which heloped me iron
out kinks. https://habr.com/ru/post/450214/

License
-------

Licensed under the MIT License - see the LICENSE file for details.
