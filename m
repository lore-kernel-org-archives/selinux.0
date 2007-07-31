Subject: Re: oracle policy
From: rob myers <rob.myers@gtri.gatech.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <468A888C.1050404@redhat.com>
References: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>
	 <463B5A4B.2090004@redhat.com>
	 <1183415825.3413.66.camel@rxm-581b.stl.gtri.gatech.edu>
	 <468A888C.1050404@redhat.com>
Content-Type: multipart/mixed; boundary="=-OajaNu0uB9qKQqSzjGOJ"
Date: Tue, 31 Jul 2007 16:41:26 -0400
Message-Id: <1185914486.3413.313.camel@rxm-581b.stl.gtri.gatech.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OajaNu0uB9qKQqSzjGOJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-03 at 13:34 -0400, Daniel J Walsh wrote: 
> rob myers wrote:
> >
> > i'm not sure what you mean by breaking the helper apps and writing
> > policy for their specific tasks.  could you refer me to an example or
> > explain a bit more?
> >   
> If you look at postfix, you will see a good example.  The idea of least 
> privs is to give an app the least privs it needs to do a job.
> 
> As an example if your oracle app needed r/w access to the disk in order 
> to format it in a particular way, and the way it did this was to exec
> /usr/bin/oracle_disk_format  You could give oracle_t 
> fixed_disk_device_t:blk_file manage_blk_device_t; Or you could generate 
> a policy for oracle_disk_format_t,
> and only give the helper app that permission.   Oracle would only be 
> able to format the disk through the execing of the helper app.

ok, that makes sense.  the attached policy is a rewrite that attempts to
implement this suggestion.  feedback is always appreciated.

> >> I like to avoid
> >> domain_auto_trans(unconfined_t, oracle_exec_t, oracle_t)
> >>
> >> And only have the transition happen in the init scripts.  Transitioning 
> >> directly from unconfined_t ends up with lots of avcs when users do stuff 
> >> like
> >>
> >> confined_app >> ~/mylog
> >>
> >> Also you might be able to eliminate the ability to write to terminals by 
> >> doing this.
> >>     
> >
> > this did not obviate the need to write to terminals.  only transitioning
> > from init also introduces another problem- when a dbadmin stops and
> > restarts the database, the database comes back up in unconfined_t.  is
> > there a more elegant way to ensure that the database runs in oracle_t
> > than using domain_auto_trans()?
> >
> >   
> What is the command to stop and start the oracle database?  service 
> oracle restart should do the correct thing. 

the init script starts oracle like this:
daemon --user oracle dbstart ALL

dbstart is a shell script that eventually calls sqlplus like so:

sqlplus /nolog <<EOF
connect / as sysdba
startup pfile=$PFILE
EOF

and sqlplus is the oracle PL/SQL command line tool which eventually
calls the oracle binary.

the problem is that database admins do not start and stop the database
using "service".  they either use shell scripts that call sqlplus, or
they use sqlplus directly to start and stop the database.  thus, the
transition from init is not sufficient to insure that oracle runs
confined.  i've re-enabled the auto transition for now.

> > it seems a bit wacky for me to create a
> > corenet_dontaudit_tcp_connect_snmp_port interface as part of the oracle
> > interfaces... is there already a similar interface that i missed?  if
> > not, what is the correct way to do this?
> >
> >   
> Why is oracle trying to connect to the snmp port, and why do you want to 
> prevent it?

the oracle listener tries to connect to the tcp smux port on localhost
to determine if SNMP support should be enabled.  in the spirit of least
privilege, i wanted to prevent SNMP access because i do not use that
feature.  i created a tunable in case others desire SNMP support.

rob.

ps- for more information, there is a decent diagram that helps show how
oracle and interacts with its helper apps and files here:
http://www.oracle.com/technology/tech/migration/isv/docs/OracleArchitectureOverview.pdf

--=-OajaNu0uB9qKQqSzjGOJ
Content-Disposition: attachment; filename=oracle.fc
Content-Type: text/plain; name=oracle.fc; charset=utf-8
Content-Transfer-Encoding: 7bit

#
# $Id: oracle.fc 885 2007-04-30 17:42:45Z rm153 $
#

# store database files in /u0X
/u0[0-9](/.*)?          gen_context(system_u:object_r:oracle_dbfile_t,s0)

# store database specific files under /opt/oracle/admin/$ORACLE_SID hierarchy
# treat dump files and audits as log files
/opt/oracle/admin/(.*/)?(a|b|c|u)dump(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/admin/(.*/)?audit(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)

# otherwise these would default to bin_t
/opt/oracle/product/(.*/)?bin/dbshut          gen_context(system_u:object_r:oracle_script_exec_t,s0)
/opt/oracle/product/(.*/)?bin/dbstart          gen_context(system_u:object_r:oracle_script_exec_t,s0)
/opt/oracle/product/(.*/)?bin/lsnrctl          gen_context(system_u:object_r:oracle_lsnrctl_exec_t,s0)
/opt/oracle/product/(.*/)?bin/oracle          gen_context(system_u:object_r:oracle_db_exec_t,s0)
/opt/oracle/product/(.*/)?bin/sqlplus          gen_context(system_u:object_r:oracle_sqlplus_exec_t,s0)
/opt/oracle/product/(.*/)?bin/tnslsnr          gen_context(system_u:object_r:oracle_tnslsnr_exec_t,s0)
# many jars are not located under lib, jre, or java directories
/opt/oracle/product/(.*/)?.+\.jar          gen_context(system_u:object_r:shlib_t,s0)
# otherwise these would default to shlib_t
/opt/oracle/product/(.*/)?lib/libclntsh\.so\.10.*          gen_context(system_u:object_r:texrel_shlib_t,s0)
/opt/oracle/product/(.*/)?lib/libjox10\.so          gen_context(system_u:object_r:texrel_shlib_t,s0)
# certain logs are kept under the ORACLE_HOME hierarchy
/opt/oracle/product/(.*/)?dbs(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/(.*/)?log(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/(.*/)?rdbms/audit(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)

# otherwise this would be unlabeled
/var/tmp/.oracle(/.*)?          gen_context(user_u:object_r:oracle_tmp_t,s0)

--=-OajaNu0uB9qKQqSzjGOJ
Content-Disposition: attachment; filename=oracle.if
Content-Type: text/plain; name=oracle.if; charset=utf-8
Content-Transfer-Encoding: 7bit

## <summary>Oracle policy</summary>
## <desc>
##	<p>
##		Oracle policy $Id: oracle.if 885 2007-04-30 17:42:45Z rm153 $
##	</p>
## </desc>

########################################
## <summary>
##      Creates types and rules common to all oracle processes
## </summary>
## <param name="prefix">
##      <summary>
##      The domain.
##      </summary>
## </param>
#
template(`oracle_common_template',`
	gen_require(`
		type oracle_tmp_t;
		type oracle_log_t;
	')
	# Define domain type
	type oracle_$1_t;
	domain_type(oracle_$1_t)
	# Define file type
	type oracle_$1_exec_t;
	files_type(oracle_$1_exec_t)
	# Create an entry point
	domain_entry_file(oracle_$1_t, oracle_$1_exec_t)
	# Allow access to shared libraries
	libs_use_ld_so(oracle_$1_t)
	libs_use_shared_libs(oracle_$1_t)
	# Allow read access to generic files
	files_read_usr_files(oracle_$1_t)
	# Allow read access to etc files
	files_read_etc_files(oracle_$1_t)
	# Allow read access to tmp files
	files_list_tmp(oracle_$1_t)
	# localization support
	miscfiles_read_localization(oracle_$1_t)
	# Allow sending traffic to all nodes
	# for refpolicy-20070629
	corenet_all_recvfrom_unlabeled(oracle_$1_t)
	# for RHEL5 policy
	#corenet_non_ipsec_sendrecv(oracle_$1_t)
	# Allow socket creation
	allow oracle_$1_t self:udp_socket create_socket_perms;
	allow oracle_$1_t self:tcp_socket create_stream_socket_perms;
	logging_log_filetrans(oracle_$1_t,oracle_log_t,{ file dir })
	files_tmp_filetrans(oracle_$1_t, oracle_tmp_t, { file dir sock_file })
	# Allow access to oracle temporary files
	allow oracle_$1_t oracle_tmp_t:file { create_file_perms };
	allow oracle_$1_t oracle_tmp_t:dir { create_dir_perms };
	allow oracle_$1_t oracle_tmp_t:sock_file { create_file_perms };
	# Allow access to oracle log files
	allow oracle_$1_t oracle_log_t:file { unlink create rw_file_perms setattr };
	allow oracle_$1_t oracle_log_t:dir { setattr rw_dir_perms };
')

########################################
## <summary>
##      Creates rules for oracle processes that
##      interact with the user
## </summary>
## <param name="prefix">
##      <summary>
##      Prefix for the domain.
##      </summary>
## </param>
#
template(`oracle_ui_template',`
	# get common types and rules
	oracle_common_template($1)
	# Allow init to run oracle applications in the correct domain
	init_daemon_domain(oracle_$1_t, oracle_$1_exec_t)
	# Allow user interaction via pty
	term_use_all_user_ptys(oracle_$1_t)
	# Allow fifo creation to self
	allow oracle_$1_t self:fifo_file { create_file_perms };
	# Allow network init to read network config files
	sysnet_read_config(oracle_$1_t)
')

########################################
## <summary>
##      Creates types and rules for oracle server processes
## </summary>
## <param name="prefix">
##      <summary>
##      Prefix for the domain.
##      </summary>
## </param>
#
template(`oracle_server_template',`
	# get common types and rules
	oracle_common_template($1)
	# Allow read and writing to shared memory
	fs_rw_tmpfs_files(oracle_$1_t)
	# Allow getting attributes of filesystems
	fs_getattr_all_fs(oracle_$1_t)
	# Allow querying an ldap server
	sysnet_use_ldap(oracle_$1_t)
	auth_use_nsswitch(oracle_$1_t)
	# Do not audit server processes trying to access ptys
	dontaudit oracle_$1_t devpts_t:chr_file { read write };
')


############################################################
## <summary>
##	Send and receive TCP traffic on an oracle port
## </summary>
## <desc>
##	<p>
##		Use this interface to send and receive TCP traffic on
##		the oracle port
##	</p>
## </desc>
## <param name="domain">
##	<summary>
##		Domain allowed access
##	</summary>
## </param>
#
interface(`corenet_tcp_sendrecv_oracle_port',`
	gen_require(`
		type oracle_port_t;
	')

	allow $1 oracle_port_t:tcp_socket { send_msg recv_msg };

')

############################################################
## <summary>
##	Bind to a TCP oracle port
## </summary>
## <desc>
##	<p>
##		Use this interface to bind to a TCP oracle port
##	</p>
## </desc>
## <param name="domain">
##	<summary>
##		Domain allowed access
##	</summary>
## </param>
#
interface(`corenet_tcp_bind_oracle_port',`
	gen_require(`
		type oracle_port_t;
	')

	allow $1 oracle_port_t:tcp_socket name_bind;
	
')

############################################################
## <summary>
##	Connect to an oracle TCP port
## </summary>
## <desc>
##	<p>
##		Use this interface to connect to an oracle TCP port
##	</p>
## </desc>
## <param name="domain">
##	<summary>
##		Domain allowed access
##	</summary>
## </param>
#
interface(`corenet_tcp_connect_oracle_port',`
	gen_require(`
		type oracle_port_t;
	')

	allow $1 oracle_port_t:tcp_socket name_connect;

')

############################################################
## <summary>
##	 Do not audit attempts to make a TCP connection to the snmp port.
## </summary>
## <desc>
##	<p>
##		Use this interface to prevent auditing attempts to make a TCP connection to the snmp port.
##	</p>
## </desc>
## <param name="domain">
##	<summary>
##		Domain not to audit.
##	</summary>
## </param>
#
interface(`corenet_dontaudit_tcp_connect_snmp_port',`
	gen_require(`
		type snmp_port_t;
	')

	dontaudit $1 snmp_port_t:tcp_socket name_connect;
')

--=-OajaNu0uB9qKQqSzjGOJ
Content-Disposition: attachment; filename=oracle.te
Content-Type: text/plain; name=oracle.te; charset=utf-8
Content-Transfer-Encoding: 7bit

policy_module(oracle,1.0.0)

########################################
#
# $Id: oracle.te 885 2007-04-30 17:42:45Z rm153 $
#

########################################
#
# Declarations
#

## <desc>
## <p>
## Allow oracle SNMP support.
## </p>
## </desc>
gen_tunable(oracle_snmp_support,false)

########################################
#
# Policy
#

# Type for log files
type oracle_log_t;
logging_log_file(oracle_log_t)

# Type for temporary files
type oracle_tmp_t;
files_tmp_file(oracle_tmp_t)

oracle_server_template(db)
oracle_server_template(tnslsnr)
oracle_ui_template(lsnrctl)
oracle_ui_template(sqlplus)

# Alias scripts (e.g., dbstart, dbshut) to sqlplus
typealias oracle_sqlplus_t alias oracle_script_t;
typealias oracle_sqlplus_exec_t alias oracle_script_exec_t;

# Type for database files
type oracle_dbfile_t;
files_config_file(oracle_dbfile_t)

# Allow the oracle process to write to the db files
allow oracle_db_t oracle_dbfile_t:file { getattr read create_file_perms };
allow oracle_db_t oracle_dbfile_t:dir { create_dir_perms };

# Automatically transition to the correct domain
ifdef(`targeted_policy', `
    domain_auto_trans(oracle_sqlplus_t, oracle_db_exec_t, oracle_db_t)
    domain_auto_trans(oracle_lsnrctl_t, oracle_tnslsnr_exec_t, oracle_tnslsnr_t)
    domain_auto_trans(unconfined_t, oracle_sqlplus_exec_t, oracle_sqlplus_t)
    domain_auto_trans(unconfined_t, oracle_lsnrctl_exec_t, oracle_lsnrctl_t)
')

###
## networking
#

# define oracle ports
type oracle_port_t;
# for refpolicy-20070629
corenet_port(oracle_port_t)
# for RHEL5 policy
#corenet_port_type(oracle_port_t)

#
# you cannot create ports in a policy module so use semanage instead
# - https://www.redhat.com/archives/fedora-selinux-list/2007-April/msg00078.html
# semanage port -a -t oracle_port_t -p tcp 1521

# allow sending and receiving on oracle ports
corenet_tcp_bind_oracle_port(oracle_tnslsnr_t)
corenet_tcp_sendrecv_oracle_port(oracle_tnslsnr_t)
corenet_tcp_connect_oracle_port(oracle_lsnrctl_t)
corenet_tcp_connect_oracle_port(oracle_tnslsnr_t)
corenet_tcp_connect_oracle_port(oracle_db_t)

corenet_tcp_bind_all_nodes(oracle_tnslsnr_t)
corenet_udp_bind_all_nodes(oracle_tnslsnr_t)
corenet_tcp_sendrecv_all_if(oracle_tnslsnr_t)
corenet_udp_sendrecv_all_if(oracle_tnslsnr_t)
corenet_tcp_sendrecv_all_nodes(oracle_tnslsnr_t)
corenet_udp_sendrecv_all_nodes(oracle_tnslsnr_t)
corenet_tcp_connect_generic_port(oracle_tnslsnr_t)
corenet_udp_bind_lo_node(oracle_db_t)
corenet_udp_bind_lo_node(oracle_sqlplus_t)

###
## executables
#
corecmd_exec_bin(oracle_sqlplus_t)
corecmd_search_bin(oracle_lsnrctl_t)
corecmd_search_bin(oracle_db_t)

###
## devices
#
dev_read_rand(oracle_db_t)
dev_read_urand(oracle_db_t)
dev_rw_zero(oracle_db_t)

###
## Allow reading proc, system settings, and state
#
kernel_read_all_sysctls(oracle_sqlplus_t)
kernel_read_system_state(oracle_sqlplus_t)
kernel_read_all_sysctls(oracle_db_t)
kernel_read_system_state(oracle_db_t)
kernel_getattr_proc_files(oracle_db_t)
kernel_read_proc_symlinks(oracle_db_t)

###
## additional permissions
#
# Allow fifos
allow oracle_db_t self:fifo_file { rw_file_perms };

# Allow semaphores and shared memory
allow oracle_db_t self:sem create_sem_perms;
allow oracle_db_t self:shm create_shm_perms;

# Allow execing
can_exec(oracle_db_t, oracle_db_exec_t)
can_exec(oracle_sqlplus_t, oracle_sqlplus_exec_t)

# Allow tnslsnr to use lsnrctl fds
allow oracle_tnslsnr_t oracle_lsnrctl_t:fd use;
allow oracle_tnslsnr_t oracle_lsnrctl_t:fifo_file { rw_file_perms };

# Allow tnslsnr to execmem
allow oracle_tnslsnr_t self:process { execmem };

# Allow oracle db to use sqlplus fds and to signal
allow oracle_db_t oracle_sqlplus_t:fd use;
allow oracle_db_t oracle_sqlplus_t:fifo_file { rw_file_perms };
allow oracle_db_t oracle_sqlplus_t:process sigchld;

# Allow lsnrctl to connect to tnslsnr via unix stream socket
allow oracle_lsnrctl_t oracle_tnslsnr_t:unix_stream_socket connectto;

# Allow sqlplus to get filesystem attributes
fs_getattr_all_fs(oracle_sqlplus_t)

tunable_policy(`oracle_snmp_support',`
	corenet_tcp_connect_snmp_port(oracle_tnslsnr_t)
	corenet_tcp_sendrecv_snmp_port(oracle_tnslsnr_t)
',`
	corenet_dontaudit_tcp_connect_snmp_port(oracle_tnslsnr_t)
')

--=-OajaNu0uB9qKQqSzjGOJ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
