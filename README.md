``` html

     ___           ___           ___            ___    
    /  /\         /__/\         /  /\          /__/|   
   /  /++\        \  \+\       /  /++\        |  |+|   
  /  /+/\+\        \__\+\     /  /+/\+\       |  |+|   
 /  /+/~/++\   ___ /  /++\   /  /+/  \+\      |  |+|   
/__/+/ /+/\+\ /__/\  /+/\+\ /__/+/ \__\+\  ___|__|+|   
\  \+\/+/__\/ \  \+\/+/__\/ \  \+\ /  /+/ /__/+++++\   
 \  \++/       \  \++/       \  \+\  /+/  \__\~~~~++\  
  \  \+\        \  \+\        \  \+\/+/         \  \+\ 
   \  \+\        \  \+\        \  \++/           \  \+\
    \__\/         \__\/         \__\/             \__\/

      Ahoy = Puma + NGINX + Mina + Vagrant + Ansible
```

---

#### Ahoy will generate everything you need to deploy your Rails application

* Ansible scripts to provision your server with Nginx, Ruby, PostgreSQL, and recommended security settings (ssh hardening, firewall, fail2ban, etc.)
* Mina scripts to deploy your Rails application
* Puma application server configuration files
* An optional Vagrantfile with settings
* An *.env* directory that will use YAML to store your environment variables securely


**IMPORTANT:** Ahoy currently expects that your Rails application is using PostgreSQL. Depending on demand, there may be future support for MySQL.

## Installation and usage

**RECOMMENDATION:** You might want to first try this using a fresh Rails application so you can see how it effects your files before running this in your existing code base.

### Step 1

Add the gem to your Gemfile and bundle

```ruby
gem 'rails-ahoy'
```

    $ bundle install

Execute the following terminal command to launch Ahoy's interactive guide

    $ rails generate ahoy:init

Continue to next step AFTER you complete the interactive guide

### Step 2

If you don't have a production *secret_key_base*, generate one using:

    $ rake secret

This will produce something that looks like:

    $ f67395912d0ddd0de80a734822e73b327d007809123...

Now just copy and paste it into the following file:

    $ <YOUR RAILS APP>/.env/production_env.yml

**IMPORTANT:** At this point make sure to commit your changes and push them up to your repo!

### Step 3

**IMPORTANT:** For this step, you will need a freshly installed Ubuntu box with root ssh privileges. If you're not sure how to do this, contact your web hosting administrator.

From the root of your Rails application...

    $ cd config/ansible && ./production.sh

Executing `production.sh` will launch the provisioning process and setup your box so it can run Rails using Nginx as the web server, Puma as your application server, and PostgreSQL as your database.

**NOTE:** This process may take a while (15 mins or so), so sit back and relax.

### Step 4

**ASSUMPTION:** This step assumes that your code is hosted in a Github repo.

Once the provisioning process is complete, log into your box with the server user (ex: deployer)

    $ ssh deployer@<YOUR SERVER IP>

Once in, get your server user's public key

    $ cat ~/.ssh/id_rsa.pub

This will print out something like this:

	sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOv2hw90hySH+41A6NVjp6GXhBS/PUVmTot...

Copy the public key and paste it into your Rails application Github repo settings to allow SSH access.

### Step 5

Go back to the root of your Rails application and execute the following command:

    $ mina production setup

Then...

    $ mina production deploy

### Congratulations!

If everything worked as it should have, your Rails application should be up and running on the Web. Enjoy!


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails-ahoy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
