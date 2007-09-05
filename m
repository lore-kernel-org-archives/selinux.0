Message-ID: <46DF0DD5.3080207@redhat.com>
Date: Wed, 05 Sep 2007 16:13:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Role Creation Wizard
Content-Type: multipart/mixed;
 boundary="------------050604090401070505030800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050604090401070505030800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have been working on creating a role creation wizard, for policy
writers to be able to create user types and admin roles.

Working from a base line user (guest_t, xguest_t),  You can assign
transitions to other domains (mozilla, ssh) or to admin roles webadm_t,
dbadm_t.  Most of the work is done.

The admin roles will be able to manipulate there own service.  I have
begun labeling initscripts.

ls -lZ /etc/init.d/httpd
- -rwxr-xr-x  root root system_u:object_r:httpd_script_exec_t:s0
/etc/init.d/httpd

So a webadm_t will only be able to run /etc/init.d/httpd (Labeled
httpd_script_exec_t).

I don't want to require the use of run_init.  Mainly because this
requires the entry of the password,  (I don't want to give these admin
roles "rootok".  So pam_rootok will not fix this problem.  I am also not
sure if we transition to run_init, we can prevent the admin from
executing other init scripts.

So in my test environment I have created a terminal user mytuser_u;  and
an admin user mydbadm_t, which can modify postgresql and mysql environments.

# semanage user -l | grep mytuser
mytuser_u       mytuser    s0         s0
mydbadm_r mytuser_r

Then I assign the rwalsh account to it

semanage login -l | grep mytuser
rwalsh                    mytuser_u                 s0

I log in as rwalsh,
sudo/newrole to mydbadm_t

When I try to start the init script, I fail with the following error.


service mysqld restart
env: /etc/init.d/mysqld: Permission denied


This is happening because of the following SELINUX_ERR

grep SELINUX /var/log/audit/audit.log
type=SELINUX_ERR msg=audit(1189021260.698:974): security_compute_sid:
invalid context mytuser_u:system_r:initrc_t:s0 for
scontext=mytuser_u:mydbadm_r:mydbadm_t:s0
tcontext=system_u:object_r:mysqld_script_exec_t:s0 tclass=process

Which indicates system_r is not available to mytuser_u.

So in order to get this to work,  I will have to add system_r to every
admin user.  Which seems to me to be a potential risk.

We have role_transition and type_transition but no user_transition.

Any ideas on better way to handle this, or is my only choice run_init,
or system_r for the admin user.




Attaching my generated policy along with mysql.if (Important part is the
mysql_admin interface.)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG3w3UrlYvE4MpobMRAsLAAJ9gsOO4oiWKiCjWVsbtCigzCii++gCfRVi3
GH3cWZ/aaClg1xsZs9VuSnQ=
=QWyQ
-----END PGP SIGNATURE-----

--------------050604090401070505030800
Content-Type: text/plain;
 name="mytuser.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mytuser.te"

policy_module(mytuser,1.0.0)

########################################
#
# Declarations
#

userdom_unpriv_login_user(mytuser)

########################################
#
# mytuser local policy
#


seutil_run_newrole(mytuser_t,mytuser_r,{ mytuser_devpts_t mytuser_tty_device_t })

userdom_role_change_template(mytuser, mydbadm)

optional_policy(`
	sudo_per_role_template(mytuser,mytuser_t,mytuser_r)
')

--------------050604090401070505030800
Content-Type: text/plain;
 name="mydbadm.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mydbadm.te"


policy_module(mydbadm,1.0.0)

########################################
#
# Declarations
#

userdom_base_user_template(mydbadm)

########################################
#
# mydbadm local policy
#


optional_policy(`
	postgresql_admin(mydbadm_t,mydbadm_r, { mydbadm_tty_device_t mydbadm_devpts_t })
')

optional_policy(`
	mysql_admin(mydbadm_t,mydbadm_r, { mydbadm_tty_device_t mydbadm_devpts_t })
')

--------------050604090401070505030800
Content-Type: text/plain;
 name="mysql.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mysql.if"

## <summary>Policy for MySQL</summary>

########################################
## <summary>
##	Send a generic signal to MySQL.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`mysql_signal',`
	gen_require(`
		type mysqld_t;
	')

	allow $1 mysqld_t:process signal;
')

########################################
## <summary>
##	Connect to MySQL using a unix domain stream socket.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
## <rolecap/>
#
interface(`mysql_stream_connect',`
	gen_require(`
		type mysqld_t, mysqld_var_run_t;
	')

	stream_connect_pattern($1,mysqld_var_run_t,mysqld_var_run_t,mysqld_t)
')

########################################
## <summary>
##	Read MySQL configuration files.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
## <rolecap/>
#
interface(`mysql_read_config',`
	gen_require(`
		type mysqld_etc_t;
	')

	allow $1 mysqld_etc_t:dir { getattr read search };
	allow $1 mysqld_etc_t:file { read getattr };
	allow $1 mysqld_etc_t:lnk_file { getattr read };
')

########################################
## <summary>
##	Search the directories that contain MySQL
##	database storage.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
# cjp: "_dir" in the name is added to clarify that this
# is not searching the database itself.
interface(`mysql_search_db',`
	gen_require(`
		type mysqld_db_t;
	')

	files_search_var_lib($1)
	allow $1 mysqld_db_t:dir search;
')

########################################
## <summary>
##	Read and write to the MySQL database directory.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`mysql_rw_db_dirs',`
	gen_require(`
		type mysqld_db_t;
	')

	files_search_var_lib($1)
	allow $1 mysqld_db_t:dir rw_dir_perms;
')

########################################
## <summary>
##	Create, read, write, and delete MySQL database directories.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`mysql_manage_db_dirs',`
	gen_require(`
		type mysqld_db_t;
	')

	files_search_var_lib($1)
	allow $1 mysqld_db_t:dir manage_dir_perms;
')

########################################
## <summary>
##	Read and write to the MySQL database
##	named socket.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`mysql_rw_db_sockets',`
	gen_require(`
		type mysqld_db_t;
	')

	files_search_var_lib($1)
	allow $1 mysqld_db_t:dir search;
	allow $1 mysqld_db_t:sock_file rw_file_perms;
')

########################################
## <summary>
##	Write to the MySQL log.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`mysql_write_log',`
	gen_require(`
		type mysqld_log_t;
	')

	logging_search_logs($1)
	allow $1 mysqld_log_t:file { write append setattr ioctl };
')

########################################
## <summary>
##	Execute mysql server in the mysqld domain.
## </summary>
## <param name="domain">
##	<summary>
##	The type of the process performing this action.
##	</summary>
## </param>
#
interface(`mysql_script_domtrans',`
	gen_require(`
		type mysqld_script_exec_t;
	')

	init_script_domtrans_spec($1,mysqld_script_exec_t)
')

########################################
## <summary>
##	All of the rules required to administrate an mysql environment
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to be allowed to manage the mysql domain.
##	</summary>
## </param>
## <param name="terminal">
##	<summary>
##	The type of the terminal allow the mysql domain to use.
##	</summary>
## </param>
## <rolecap/>
#
interface(`mysql_admin',`

	gen_require(`
		type mysqld_t;
		type mysqld_var_run_t;
		type mysqld_tmp_t; 
		type mysqld_db_t;
		type mysqld_etc_t;
		type mysqld_log_t;
		type mysqld_script_exec_t;
	')

	allow $1 mysqld_t:process { ptrace signal_perms };
	
	# Allow $1 to restart the apache service
	mysql_script_domtrans($1)
	domain_role_change_exemption($1)
	domain_system_change_exemption($1)
	domain_obj_id_change_exemption($1)
	role_transition $2 mysqld_script_exec_t system_r;
	allow $2 system_r;

	manage_dirs_pattern($1,mysqld_var_run_t,mysqld_var_run_t)
	manage_files_pattern($1,mysqld_var_run_t,mysqld_var_run_t)

	manage_dirs_pattern($1,mysqld_db_t,mysqld_db_t)
	manage_files_pattern($1,mysqld_db_t,mysqld_db_t)

	manage_dirs_pattern($1,mysqld_etc_t,mysqld_etc_t)
	manage_files_pattern($1,mysqld_etc_t,mysqld_etc_t)

	manage_dirs_pattern($1,mysqld_log_t,mysqld_log_t)
	manage_files_pattern($1,mysqld_log_t,mysqld_log_t)

	manage_dirs_pattern($1,mysqld_tmp_t,mysqld_tmp_t)
	manage_files_pattern($1,mysqld_tmp_t,mysqld_tmp_t)
')

--------------050604090401070505030800
Content-Type: application/octet-stream;
 name="mytuser.te.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mytuser.te.sig"

iD8DBQBG3w3UrlYvE4MpobMRAnSxAJ96VL5VGMagbN7Up2P5exOmOtjOKwCfUCQUgv/EztXa
9Ixt2Ylj1BujNIY=
--------------050604090401070505030800
Content-Type: application/octet-stream;
 name="mydbadm.te.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mydbadm.te.sig"

iD8DBQBG3w3UrlYvE4MpobMRAhfTAJ9sMnEMyYhBZpEF0oTUc1/wqMVGAACeJ4TMLp6aof8q
PIK4AFacpM82ikQ=
--------------050604090401070505030800
Content-Type: application/octet-stream;
 name="mysql.if.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mysql.if.sig"

iD8DBQBG3w3UrlYvE4MpobMRAnvEAJ4gOgbdzpO5xHJHtLtRvEoesvfTdACgp/uiENNzCvCl
IR/4664t9hnAR2w=
--------------050604090401070505030800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
