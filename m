Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAMJfL18020356
	for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2006 14:41:21 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAMJedZx006848
	for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2006 19:40:40 GMT
Received: by wr-out-0506.google.com with SMTP id 57so90822wri
        for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2006 11:41:40 -0800 (PST)
Message-ID: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
Date: Wed, 22 Nov 2006 19:41:39 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: [RFC] Thunar filesystem manager policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm currently writing a policy for the Thunar filesystem manager, and
at the moment I'm having trouble making the policy work. I feel that
it has something to do with the following error message:

audit(1164224019.042:744): security_compute_sid:  invalid context
staff_u:sysadm_r:thunar_t for scontext=staff_u:sysadm_r:thunar_t
tcontext=system_u:object_r:thunar_exec_t tclass=process

Also, I'm having trouble getting the D-BUS daemons to transition into
my new policy domain when they start Thunar; how does one configure a
new policy to allow domain transitions of this type?

The policy files at the end of this message contain the policy I've
managed to create to date. It partially works, but until i fgiure out
the above issues I doubt I can make it work correctly. Criticism is
VERY welcome!

TIA!

Brad

<snip tag="thunar.te">
#
# Thunar policy
#

policy_module(thunar,1.0.0)

##############################
#
# Declarations
#

type thunar_t;
type thunar_exec_t;
domain_type(thunar_t)
domain_entry_file(thunar_t,thunar_exec_t)

type thunar_etc_t;
files_config_file(thunar_etc_t)

type thunar_lib_t;
files_type(thunar_lib_t)

########################################
#
# Local policy
#

allow thunar_t self:fifo_file { read write getattr };
allow thunar_t self:unix_stream_socket { connectto create_stream_socket_perms };
allow thunar_t self:shm create_shm_perms;
allow thunar_t self:sem create_sem_perms;
allow thunar_t self:process signal_perms;
allow thunar_t self:netlink_route_socket r_netlink_socket_perms;
allow thunar_t self:unix_dgram_socket create_socket_perms;
allow thunar_t self:tcp_socket create_stream_socket_perms;
allow thunar_t self:udp_socket create_socket_perms;
allow thunar_t self:socket create_socket_perms;

allow thunar_t thunar_etc_t:dir rw_dir_perms;
allow thunar_t thunar_etc_t:file create_file_perms;
allow thunar_t thunar_etc_t:lnk_file create_lnk_perms;

auth_dontaudit_read_shadow(thunar_t)
auth_dontaudit_exec_utempter(thunar_t)

can_exec(thunar_t,thunar_exec_t)

dev_read_sysfs(thunar_t)
dev_read_urand(thunar_t)
dev_read_rand(thunar_t)

files_read_all_files(thunar_t)
files_read_all_symlinks(thunar_t)
files_getattr_all_pipes(thunar_t)
files_getattr_all_sockets(thunar_t)
files_search_tmp(thunar_t)
files_search_home(thunar_t)

#files_list_home(thunar_t)
#files_read_usr_files(thunar_t)
#files_read_etc_files(thunar_t)

fs_getattr_all_fs(thunar_t)
fs_list_all(thunar_t)
fs_search_auto_mountpoints(thunar_t)

# Write to utmp.
init_rw_utmp(thunar_t)

libs_use_ld_so(thunar_t)
libs_use_shared_libs(thunar_t)
libs_exec_lib_files(thunar_t)

miscfiles_read_localization(thunar_t)
miscfiles_read_fonts(thunar_t)
</snip>

<snip tag="thunar.if">
## <summary>Thunar Filesystem Manager</summary>

#######################################
## <summary>
##	The per role template for the thunar module.
## </summary>
## <desc>
##	<p>
##	This template creates a derived domains which are used
##	for the Thunar filesystem manager.
##	</p>
## </desc>
## <param name="userdomain_prefix">
##	<summary>
##	The prefix of the user domain (e.g., user
##	is the prefix for user_t).
##	</summary>
## </param>
## <param name="user_domain">
##	<summary>
##	The type of the user domain.
##	</summary>
## </param>
## <param name="user_role">
##	<summary>
##	The role associated with the user domain.
##	</summary>
## </param>
#
template(`thunar_per_role_template',`
	gen_require(`
		type thunar_t;
	')

	##############################
	#
	# Declarations
	#

	# Type for program
	type $1_thunar_t;
	domain_type($1_thunar_t)
	domain_entry_file($1_thunar_t,thunar_exec_t)
	domain_interactive_fd($1_thunar_t)
	role $3 types $1_thunar_t;

	type $1_thunar_home_t alias $1_thunar_rw_t;
	files_poly_member($1_thunar_home_t)
	userdom_user_home_content($1,$1_thunar_home_t)

	corecmd_search_bin($1_thunar_t)
        domain_auto_trans($2, thunar_exec_t, thunar_t)

	##############################
	#
	# $1_thunar_t local policy
	#

	allow $1_thunar_t self:fifo_file { read write getattr };
	allow $1_thunar_t self:unix_stream_socket { connectto
create_stream_socket_perms };
	allow $1_thunar_t self:shm create_shm_perms;
	allow $1_thunar_t self:sem create_sem_perms;
	allow $1_thunar_t self:process signal_perms;
	allow $1_thunar_t self:netlink_route_socket r_netlink_socket_perms;
	allow $1_thunar_t self:unix_dgram_socket create_socket_perms;
	allow $1_thunar_t self:tcp_socket create_stream_socket_perms;
	allow $1_thunar_t self:udp_socket create_socket_perms;
	allow $1_thunar_t self:socket create_socket_perms;

	allow thunar_t thunar_etc_t:dir rw_dir_perms;
	allow thunar_t thunar_etc_t:file create_file_perms;

	auth_dontaudit_read_shadow(thunar_t)
	auth_dontaudit_exec_utempter(thunar_t)

	can_exec(thunar_t,thunar_exec_t)

	dev_read_sysfs(thunar_t)
	dev_read_urand(thunar_t)
	dev_read_rand(thunar_t)

	files_read_all_files(thunar_t)
	files_read_all_symlinks(thunar_t)
	files_getattr_all_pipes(thunar_t)
	files_getattr_all_sockets(thunar_t)
	files_search_tmp(thunar_t)
	files_search_home(thunar_t)

	fs_getattr_all_fs(thunar_t)
	fs_list_all(thunar_t)
	fs_search_auto_mountpoints(thunar_t)

	# Write to utmp.
	init_rw_utmp(thunar_t)

	libs_use_ld_so(thunar_t)
	libs_use_shared_libs(thunar_t)
	libs_exec_lib_files(thunar_t)

	miscfiles_read_localization(thunar_t)
	miscfiles_read_fonts(thunar_t)
')

########################################
## <summary>
##	Transition to the thunar domain.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
#
interface(`thunar_domtrans',`
	gen_require(`
		type thunar_t, thunar_exec_t;
	')

	corecmd_search_bin($1)
	domain_auto_trans($1,thunar_exec_t,thunar_t)

	allow $1 thunar_t:fd use;
	allow thunar_t $1:fd use;
	allow thunar_t $1:fifo_file rw_file_perms;
	allow thunar_t $1:process sigchld;
')

########################################
## <summary>
##	Execute the thunar program in the thunar domain.
## </summary>
## <param name="domain">
##	<summary>
##	The type of the process performing this action.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to allow the thunar domain.
##	</summary>
## </param>
## <param name="terminal">
##	<summary>
##	The type of the terminal allow the thunar domain to use.
##	</summary>
## </param>
## <rolecap/>
#
interface(`thunar_run',`
	gen_require(`
		type loadkeys_t;
	')

	thunar_domtrans($1)
	role $2 types thunar_t;
	allow thunar_t $3:chr_file rw_term_perms;
')
</snip>

<snip tag="thunar.fc">
#
# Thunar/Gamin policy
#
/usr/bin/Thunar 	--	gen_context(system_u:object_r:thunar_exec_t,s0)
/etc/xdg/Thunar(/.*)?           gen_context(system_u:object_r:thunar_etc_t,s0)
/usr/lib/thunar(/.*)?		gen_context(system_u:object_r:thunar_lib_t,s0)

/usr/lib/gamin/gam_server --	gen_context(system_u:object_r:thunar_exec_t,s0)
/etc/gamin(/.*)?		gen_context(system_u:object_r:thunar_etc_t,s0)

ifdef(`strict_policy',`
HOME_DIR/\.cache(/.*)?		gen_context(system_u:object_r:ROLE_thunar_home_t,s0)
HOME_DIR/\.config(/.*)?		gen_context(system_u:object_r:ROLE_thunar_home_t,s0)
HOME_DIR/\.local(/.*)?		gen_context(system_u:object_r:ROLE_thunar_home_t,s0)
')
</snip>
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
