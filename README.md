# jh_informix_multi

TODO: Enter the cookbook description here.

$ ls -l
total 4
drwxrwxr-x. 3 ec2-user ec2-user 31 Jul 11 15:12 cookbooks
drwxrwxr-x. 4 ec2-user ec2-user 33 Jul 11 15:34 local-mode-cache
drwx------. 2 ec2-user ec2-user 43 Jul 11 15:18 nodes
-rw-rw-r--. 1 ec2-user ec2-user 53 Jul 11 15:18 solo.rb

$ cat solo.rb
cookbook_path ['/home/ec2-user/chef-repo/cookbooks']

cat ./.chef/knife.rb
cookbook_path [ '~/chef-repo/cookbooks' ]

$ ls cookbooks/
jh_informix_multi

sudo chef-solo -c solo.rb -o jh_informix_multi::default
