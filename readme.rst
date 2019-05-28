
PHP Symfony Boilerplate
=======================

This project contains boilerplate files for a symfony application run in Divio cloud. To be compatible, the framework has to be slightly changed. All necessary changes are documented below.


Documentation
-------------

    Read the Getting Started guide if you are new to Symfony.
    Try the Symfony Demo application to learn Symfony in practice.
    Master Symfony with the Guides and Tutorials, the Components docs and the Best Practices reference.

Community
---------

    Join the Symfony Community and meet other members at the Symfony events.
    Get Symfony support on Stack Overflow, Slack, IRC, etc.
    Follow us on GitHub, Twitter and Facebook.
    Read our Code of Conduct and meet the CARE Team

Divio Cloud
-----------

Divio Cloud is cloud native service to quickly and easily deploy web projects with a no-fuss easy-to-use platform. The service seamlessly integrates with Divio Cloud due to Symfony`s flexible configuration and its wide support for databases and cloud services. However, the default configuration of Symfony has to be slightly extended to automatically get all the benefits from Divio Cloud like painless and zero-downtime deployments, auto-scaling, backups etc.

By using Divio Cloud you automatically get all the tools you are (or want to be ;)) used to out-of-the-box:


* a Docker setup for production and development
* a private git repository
* complete Symfony setup with all dependencies
* preinstalled and seamless AWS S3 integration
* composer on steroids with `prestissimo <https://github.com/hirak/prestissimo>`_
* a production environment using nginx and php-fpm
* the necessary frontend tools in the latest version


Installation
------------

After creating your project in the divio cloud interface, enter your applications dashboard and press ``DEPLOY`` to deploy the initial version on a test server. This will deploy a single server instance with your boilerplate ready to work in the cloud. Just click the link provided on the dashboard and the symfony default home will welcome you with a complete installation. Your new Symfony app is already deployed to the cloud, using your database and a cloud storage.

Development
^^^^^^^^^^^

First, you should install the ``divio-cli`` `command line application <http://docs.divio.com/en/latest/reference/divio-cli.html>`_ or the `Divio GUI <http://docs.divio.com/en/latest/reference/divio-app.html>`_ to get started. Please read the docs carefully and make sure the client is configured and ready to use before you continue as it will make sure all dependencies are present. The ``divio-cli`` makes use of docker to provide a local development environment. In the background ``docker-compose`` is used to provide all the services needed for development in an environment as similar as possible to the cloud running you production application. After making sure ``divio-cli`` is working fine, please tun the installation commands as follows and replace ``SLUG`` with the name you chose for your application:

.. code-block::

   $ divio project setup SLUG

This will clone the boilerplate to your local computer, download the database and setup your environment. To complete the php installation please enter the newly create directory (\ ``cd SLUG``\ ) named after your application, created by the ``git clone`` during the setup to enter the application root containing your symfony application sources and run

.. code-block::

   $ docker-compose run web php /app/divio/setup.php

This will make sure all directories needed are created, permissions are set correctly for development, run ``composer install`` to install all your requirements and migrate your database if necessary. *If you did NOT deploy to test prior to running the setup, your setup will complete but show an error message that the migrations have failed. This happens because your dependencies are missing during the setup and which is automatically fixed by running the ``setup.php`` script from above.*

You can now launch your development server by using

.. code-block::

   $ divio project up

which will open your browser with the welcome screen already opened.

If you need to use ``console`` or ``composer`` commands you can now either enter your docker container containing your web application or run a command directly like we did with ``setup.php``.

.. code-block::

   # To enter the running container and get a bash session
   $ docker-compose exec web bash

   # To directly run commands in your application
   $ docker-compose run web bin/console doctrine:migrations:migrate
   $ docker-compose run web composer install
