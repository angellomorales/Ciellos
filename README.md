task 9 answer questions
•Business Central system topology in Saas.
    basically we get a tenant on Azure AD,
    for each tenant we get 4 environments, 1-production -3 sandbox over here we can publish diferent extensions on each environment
    under each environment we can get as many companies as we want and the extensions published on the environment will work for all companies on de same enviroment

• What is the life cycle of a Business Central extension in Saas?
    when you publish an app and it pass validation, this app will be available to install on the main system, when it is installed and MS make upgrades this app move with these upgrades so you basically dont need to do anything

    when you make updates to your app and it pass validations, you need to wait unitl major release update on microsoft to get your app updated

    if there is a bug you can create ticket to priorize update on your app 

• What are Business Central’s integration patterns (names, usages)? What is the main difference 
between them?

    this is the way that microsoft offer to integrate with other systems we can use Dataverse and webservice to interact whit the system

• What is Branching strategy? (Usages examples are required)

    branching strategy allow a developer team work on diferent features on the same app separately keeping integrity for example in the app we have main branch and develop branch 

    main branch manage production deployed code, we can create new branch from here to fix any production bug.

    develope branch manage new features code, over here we can create new branches for each new feature

    at the end we can merge all changes on any existing branch to test or deploy according to our needs
