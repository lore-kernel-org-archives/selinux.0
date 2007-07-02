Subject: Re: oracle policy
From: rob myers <rob.myers@gtri.gatech.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <463B5A4B.2090004@redhat.com>
References: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>
	 <463B5A4B.2090004@redhat.com>
Content-Type: multipart/mixed; boundary="=-fv0ytTQnF2pIYZIut+xd"
Date: Mon, 02 Jul 2007 18:37:05 -0400
Message-Id: <1183415825.3413.66.camel@rxm-581b.stl.gtri.gatech.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fv0ytTQnF2pIYZIut+xd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-05-04 at 12:07 -0400, Daniel J Walsh wrote:
> rob myers wrote:
> > hello
> >
> > i am working on writing some SELinux policy that will confine oracle to
> > its own domain on a RHEL5 machine running targeted policy.  my security
> > goal is to limit risk to the rest of the system from any potential
> > compromise of oracle.  as far as i know, no such policy exists publicly
> > yet.  i'd like to collaborate with anyone else that has an interest in
> > writing a similar policy for oracle.  my initial efforts are attached.
> > tips, pointers, and constructive criticism requested!

> I like to minimize the number of context in the file context,  The more 
> files in the context the more likely you are to get one wrong.  
> One general rule I use is if you domain does not need to modify a 
> file/directory, you should use the system defaults.  (Unless you want to 
> prevent other confined domains from reading the files, for security 
> purposes).  So do you really need  oracle_ro_t?

nope, not for my current security goals.  thanks for pointing that out.

> The only file that should be labeled oracle_exec_t is the domains entry 
> point.  Helper apps should be just labeled bin_t.  Or even better break 
> the helper apps and write policy for their specific tasks.  But this is 
> a lot more work.

again, you are correct.  there are many helper apps that do not need to
be labeled oracle_exec_t.  i've pared the list of binaries with
oracle_exec_t down to those that are called by the init script and that
need to be run in oracle_t.

i'm not sure what you mean by breaking the helper apps and writing
policy for their specific tasks.  could you refer me to an example or
explain a bit more?

> I like to avoid
> domain_auto_trans(unconfined_t, oracle_exec_t, oracle_t)
> 
> And only have the transition happen in the init scripts.  Transitioning 
> directly from unconfined_t ends up with lots of avcs when users do stuff 
> like
> 
> confined_app >> ~/mylog
> 
> Also you might be able to eliminate the ability to write to terminals by 
> doing this.

this did not obviate the need to write to terminals.  only transitioning
from init also introduces another problem- when a dbadmin stops and
restarts the database, the database comes back up in unconfined_t.  is
there a more elegant way to ensure that the database runs in oracle_t
than using domain_auto_trans()?

it seems a bit wacky for me to create a
corenet_dontaudit_tcp_connect_snmp_port interface as part of the oracle
interfaces... is there already a similar interface that i missed?  if
not, what is the correct way to do this?

the attached policy should incorporate all of your helpful suggestions,
and i believe it is much better as a result.  thanks again, and please
let me know how i can improve this version, too.

rob.

--=-fv0ytTQnF2pIYZIut+xd
Content-Disposition: attachment; filename=oracle.fc
Content-Type: text/plain; name=oracle.fc; charset=utf-8
Content-Transfer-Encoding: 7bit

#
# $Id: oracle.fc 885 2007-04-30 17:42:45Z rm153 $
#

# store database files in /u0X
/u0[0-9](/.*)?          gen_context(system_u:object_r:oracle_db_t,s0)

# store database specific files under /opt/oracle/admin/$ORACLE_SID hierarchy
# treat dump files and audits as log files
/opt/oracle/admin/(.*/)?(a|b|c|u)dump(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/admin/(.*/)?audit(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)

# otherwise these would default to bin_t
/opt/oracle/product/(.*/)?bin/dbshut          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/(.*/)?bin/dbstart          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/(.*/)?bin/lsnrctl          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/(.*/)?bin/oracle          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/(.*/)?bin/oracle0          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/(.*/)?bin/sqlplus          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/(.*/)?bin/tnslsnr          gen_context(system_u:object_r:oracle_exec_t,s0)
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

--=-fv0ytTQnF2pIYZIut+xd
Content-Disposition: attachment; filename=oracle.if
Content-Type: text/plain; name=oracle.if; charset=utf-8
Content-Transfer-Encoding: 7bit

## <summary>Oracle policy</summary>
## <desc>
##	<p>
##		Oracle policy $Id: oracle.if 885 2007-04-30 17:42:45Z rm153 $
##	</p>
## </desc>

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

--=-fv0ytTQnF2pIYZIut+xd
Content-Disposition: attachment; filename=oracle.te
Content-Type: text/plain; name=oracle.te; charset=utf-8
Content-Transfer-Encoding: 7bit

policy_module(oracle,1.0.0)

########################################
#
# $Id: oracle.te 885 2007-04-30 17:42:45Z rm153 $
#

type oracle_t;

domain_type(oracle_t)

## Type for log files
type oracle_log_t;
logging_log_file(oracle_log_t)

allow oracle_t oracle_log_t:file { unlink create rw_file_perms setattr };
allow oracle_t oracle_log_t:dir { setattr rw_dir_perms };

logging_log_filetrans(oracle_t,oracle_log_t,{file dir})

## Type for database files
type oracle_db_t;
files_config_file(oracle_db_t)

allow oracle_t oracle_db_t:file { getattr read create_file_perms };
allow oracle_t oracle_db_t:dir { create_dir_perms };

## Type for temporary files
type oracle_tmp_t;
files_tmp_file(oracle_tmp_t)

allow oracle_t oracle_tmp_t:file { create_file_perms };
allow oracle_t oracle_tmp_t:dir { create_dir_perms };
allow oracle_t oracle_tmp_t:sock_file { create_file_perms };
files_tmp_filetrans(oracle_t, oracle_tmp_t, { file dir sock_file })

## Type for the daemon
type oracle_exec_t;
files_type(oracle_exec_t)
domain_entry_file(oracle_t, oracle_exec_t)

## Allow init to run oracle_exec_t programs in oracle_t
init_daemon_domain(oracle_t, oracle_exec_t)

# read /proc
kernel_getattr_proc_files(oracle_t)
kernel_read_proc_symlinks(oracle_t)

# localization support
miscfiles_read_localization(oracle_t)

###
## networking
#

# define oracle ports
type oracle_port_t;
# for refpolicy-20070629
#corenet_port(oracle_port_t)
# for RHEL5 policy
corenet_port_type(oracle_port_t)

#
# you cannot create ports in a policy module so use semanage instead
# - https://www.redhat.com/archives/fedora-selinux-list/2007-April/msg00078.html
# portcon tcp 1521 system_u:object_r:oracle_port_t:s0;
# semanage port -a -t oracle_port_t -p tcp 1521

# allow sending and receiving on oracle ports
corenet_tcp_bind_oracle_port(oracle_t)
corenet_tcp_sendrecv_oracle_port(oracle_t)
corenet_tcp_connect_oracle_port(oracle_t)

# allow oracle to send traffic to all nodes
# for refpolicy-20070629
#corenet_all_recvfrom_unlabeled(oracle_t)
# for RHEL5 policy
corenet_non_ipsec_sendrecv(oracle_t)

corenet_tcp_bind_all_nodes(oracle_t)
corenet_udp_bind_all_nodes(oracle_t)
corenet_tcp_sendrecv_all_if(oracle_t)
corenet_udp_sendrecv_all_if(oracle_t)
corenet_tcp_sendrecv_all_nodes(oracle_t)
corenet_udp_sendrecv_all_nodes(oracle_t)
corenet_tcp_connect_generic_port(oracle_t)

###
## Allow oracle to query ldap server
#
sysnet_use_ldap(oracle_t)
auth_use_nsswitch(oracle_t)

###
## executables
#
corecmd_exec_bin(oracle_t)

###
## Allow access to shared libraries
#
libs_use_ld_so(oracle_t)
libs_use_shared_libs(oracle_t)

###
## Allow read system settings and state
#
kernel_read_all_sysctls(oracle_t)
sysnet_read_config(oracle_t)
kernel_read_system_state(oracle_t)

###
## Allow read /etc.
#
files_read_etc_files(oracle_t)

###
## Allow read (and write) /dev/zero
#
dev_rw_zero(oracle_t)

###
## Allow read of random devices
#
dev_read_rand(oracle_t)
dev_read_urand(oracle_t)

###
## Allow read and write to terminals
#
term_use_all_user_ptys(oracle_t)

###
## Allow read and writing to shared memory
#
fs_rw_tmpfs_files(oracle_t)

###
## Allow reading of usr files
#
files_read_usr_files(oracle_t)

###
## additional oracle related permissions
#
allow oracle_t self:file { rw_file_perms };
allow oracle_t self:fifo_file { rw_file_perms };
allow oracle_t self:process { setpgid getsched };
allow oracle_t self:sem create_sem_perms;
allow oracle_t self:shm create_shm_perms;
allow oracle_t self:fd use;
allow oracle_t self:unix_stream_socket { create_stream_socket_perms connectto };
allow oracle_t self:udp_socket create_socket_perms;
allow oracle_t self:tcp_socket create_stream_socket_perms;
allow oracle_t self:process execmem;
allow oracle_t oracle_exec_t:file execute_no_trans;

###
## Allow oracle to get attributes of filesystems
#
fs_getattr_all_fs(oracle_t)

###
## don't audit
#
corenet_dontaudit_tcp_connect_snmp_port(oracle_t)

--=-fv0ytTQnF2pIYZIut+xd--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
