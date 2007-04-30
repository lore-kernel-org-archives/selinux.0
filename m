Subject: oracle policy
From: rob myers <rob.myers@gtri.gatech.edu>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-IGa/McFMj9C80OcETj3C"
Date: Mon, 30 Apr 2007 17:37:39 -0400
Message-Id: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IGa/McFMj9C80OcETj3C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hello

i am working on writing some SELinux policy that will confine oracle to
its own domain on a RHEL5 machine running targeted policy.  my security
goal is to limit risk to the rest of the system from any potential
compromise of oracle.  as far as i know, no such policy exists publicly
yet.  i'd like to collaborate with anyone else that has an interest in
writing a similar policy for oracle.  my initial efforts are attached.
tips, pointers, and constructive criticism requested!

one of the problems with writing a general oracle policy is that
different people may install the software in different locations.  i've
chosen /opt/oracle/10.2.0, but maybe there is a more appropriate place
for it?

rob.

--=-IGa/McFMj9C80OcETj3C
Content-Disposition: attachment; filename=oracle.fc
Content-Type: text/plain; name=oracle.fc; charset=utf-8
Content-Transfer-Encoding: 7bit

#
# $Id: oracle.fc 885 2007-04-30 17:42:45Z rm153 $
#

# default oracle
/opt/oracle(/.*)?          gen_context(system_u:object_r:oracle_ro_t,s0)
/opt/oracle/admin(/.*)?          gen_context(system_u:object_r:oracle_config_t,s0)
/opt/oracle/admin/.*/?dump(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/u0[0-9](/.*)?          gen_context(system_u:object_r:oracle_db_t,s0)

# oracle 9iR2
/opt/oracle/product/9.2.0/bin/.*          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/9.2.0/jre/1\.4\.[2-9]/bin/.*          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/9.2.0/jre/1\.4\.[2-9]/lib/.*          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/9.2.0(/.*)?\.jar          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/9.2.0(/.*)?classes.*\.zip          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/9.2.0(/.*)?(nls_charset11.zip|cvd.zip)          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/9.2.0/lib/.*          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/9.2.0/dbs(/.*)?lk.*          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/9.2.0/ctx/lib/.*          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/9.2.0/ctx/bin/.*          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/9.2.0/rdbms/audit(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/9.2.0/(hs|ldap|network|ctx|sysman|rdbms|demo|mgw)/(.*/)?log(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/etc/oracle-9iR2(/.*)?          gen_context(system_u:object_r:oracle_ro_t,s0)
/opt/oracle/product/9.2.0/lib/libclntsh.so.9.0          gen_context(system_u:object_r:texrel_shlib_t,s0)
/opt/oracle/product/9.2.0/lib/libjox9.so          gen_context(system_u:object_r:texrel_shlib_t,s0)

# oracle 10gR2
/opt/oracle/product/10.2.0/bin/.*          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/10.2.0/jre/1\.4\.[2-9]/bin/.*          gen_context(system_u:object_r:oracle_exec_t,s0)
/opt/oracle/product/10.2.0/jre/1\.4\.[2-9]/lib/.*          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/10.2.0(/.*)?\.jar          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/10.2.0(/.*)?classes.*\.zip          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/10.2.0(/.*)?(nls_charset11.zip|cvd.zip)          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/10.2.0/lib/.*          gen_context(system_u:object_r:lib_t,s0)
/opt/oracle/product/10.2.0/dbs(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/10.2.0/log(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/10.2.0/rdbms/audit(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/opt/oracle/product/10.2.0/(hs|ldap|network|ctx|sysman|rdbms|demo|mgw)/(.*/)?log(/.*)?          gen_context(user_u:object_r:oracle_log_t,s0)
/etc/oracle-10gR2(/.*)?          gen_context(system_u:object_r:oracle_ro_t,s0)
/var/tmp/.oracle(/.*)?          gen_context(user_u:object_r:oracle_tmp_t,s0)
/opt/oracle/product/10.2.0/lib/libclntsh.so.10.1          gen_context(system_u:object_r:texrel_shlib_t,s0)
/opt/oracle/product/10.2.0/lib/libjox10.so          gen_context(system_u:object_r:texrel_shlib_t,s0)

--=-IGa/McFMj9C80OcETj3C
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

--=-IGa/McFMj9C80OcETj3C
Content-Disposition: attachment; filename=oracle.te
Content-Type: text/plain; name=oracle.te; charset=utf-8
Content-Transfer-Encoding: 7bit

policy_module(oracle,1.0.0)

########################################
#
# $Id: oracle.te 885 2007-04-30 17:42:45Z rm153 $
#

require {
        type snmp_port_t;
        type nscd_var_run_t;
        type fs_t;
        type proc_t;
        type initrc_tmp_t;
        class tcp_socket name_connect;
        class file { create_file_perms execute_no_trans };
        class dir { create_dir_perms };
        class fifo_file { rw_file_perms };
        class process { setpgid getsched execmem };
        class sem create_sem_perms;
        class shm create_shm_perms;
        class fd use;
        class netlink_route_socket create_netlink_socket_perms;
        class unix_stream_socket { create_stream_socket_perms connectto };
        class tcp_socket create_stream_socket_perms;
        class sock_file { create_file_perms };
        class udp_socket create_socket_perms;
        class filesystem getattr;
}

type oracle_t;

domain_type(oracle_t)

## Type for temporary files
type oracle_tmp_t;
files_tmp_file(oracle_tmp_t)

allow oracle_t oracle_tmp_t:file create_file_perms;
allow oracle_t oracle_tmp_t:dir create_dir_perms;
files_tmp_filetrans(oracle_t,oracle_tmp_t,{file dir})

## Type for log files
type oracle_log_t;
logging_log_file(oracle_log_t)

allow oracle_t oracle_log_t:file { unlink create rw_file_perms setattr };
allow oracle_t oracle_log_t:dir { setattr rw_dir_perms };

logging_log_filetrans(oracle_t,oracle_log_t,{file dir})

## Type for configuration files
type oracle_config_t;
files_config_file(oracle_config_t)

allow oracle_t oracle_config_t:file { getattr read create_file_perms };
allow oracle_t oracle_config_t:dir { create_dir_perms };

## Type for database files
type oracle_db_t;
files_config_file(oracle_db_t)

allow oracle_t oracle_db_t:file { getattr read create_file_perms };
allow oracle_t oracle_db_t:dir { create_dir_perms };

## Type for read only files
type oracle_ro_t;
files_config_file(oracle_ro_t)
files_read_all_files(oracle_ro_t)

allow oracle_t oracle_ro_t:dir { search getattr };
allow oracle_t oracle_ro_t:file { read getattr };

## Type for the daemon
type oracle_exec_t;
files_type(oracle_exec_t)
domain_entry_file(oracle_t, oracle_exec_t)
init_system_domain(oracle_t, oracle_exec_t)

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
corenet_non_ipsec_sendrecv(oracle_t)
corenet_tcp_bind_all_nodes(oracle_t)
corenet_udp_bind_all_nodes(oracle_t)
corenet_tcp_sendrecv_all_if(oracle_t)
corenet_udp_sendrecv_all_if(oracle_t)
corenet_tcp_sendrecv_all_nodes(oracle_t)
corenet_udp_sendrecv_all_nodes(oracle_t)
corenet_tcp_connect_generic_port(oracle_t)

# allow oracle to read networking configuration
sysnet_read_config(oracle_t)

# allow oracle to query ldap server
sysnet_use_ldap(oracle_t)

###
## executables
#
corecmd_exec_bin(oracle_t)

###
## acces to shared libraries
#
libs_use_ld_so(oracle_t)
libs_use_shared_libs(oracle_t)

# oracle can read sysctl settings
kernel_read_all_sysctls(oracle_t)

###
## Read /etc.
#
files_read_etc_files(oracle_t)

###
## read (and write) /dev/zero
#
dev_rw_zero(oracle_t)

###
## Allow read and write to terminals
#
term_use_all_user_ptys(oracle_t)

###
## Allow read of random devices
#
dev_read_rand(oracle_t)
dev_read_urand(oracle_t)

###
## Allow read and writing to shared memory
#
fs_rw_tmpfs_files(oracle_t)

###
## automatically transition to oracle_t each time oracle_exec_t is run
#
ifdef(`targeted_policy', `
    domain_auto_trans(unconfined_t, oracle_exec_t, oracle_t)
')

###
## additional oracle related permissions
#
allow oracle_t self:file { rw_file_perms };
allow oracle_t self:fifo_file { rw_file_perms };
allow oracle_t self:process { setpgid getsched };
allow oracle_t self:sem create_sem_perms;
allow oracle_t self:shm create_shm_perms;
allow oracle_t self:fd use;
allow oracle_t self:netlink_route_socket create_netlink_socket_perms;
allow oracle_t self:unix_stream_socket { create_stream_socket_perms connectto };
allow oracle_t oracle_tmp_t:file execute;
allow oracle_t oracle_tmp_t:sock_file create_file_perms;
allow oracle_t self:udp_socket create_socket_perms;
allow oracle_t self:tcp_socket create_stream_socket_perms;
allow oracle_t fs_t:filesystem getattr;
allow oracle_t nscd_var_run_t:dir r_dir_perms;
allow oracle_t self:process execmem;
allow oracle_t oracle_exec_t:file execute_no_trans;
allow oracle_t proc_t:file read;
allow oracle_t initrc_tmp_t:file r_file_perms;

###
## don't audit
#
corenet_dontaudit_send_snmp_server_packets(oracle_t)
corenet_dontaudit_send_snmp_client_packets(oracle_t)
dontaudit oracle_t snmp_port_t:tcp_socket name_connect;

--=-IGa/McFMj9C80OcETj3C
Content-Disposition: attachment; filename=oracle-10gR2.spec
Content-Type: text/plain; name=oracle-10gR2.spec; charset=utf-8
Content-Transfer-Encoding: 7bit

%define short_version 10.2.0
%define oracle_base /opt/oracle
%define oracle_uid 601
%define dba_gid 604
# Set to 1 to apply a critical patch update
%define apply_cpu 1
%define with_selinux 1

Summary: Oracle Database
Name: oracle-10gR2
Version: %{short_version}.3
Release: stl.9
License: Oracle Technology Network Development License
Group: Applications/Databases
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
AutoReqProv: no
Provides: oracle
%ifarch x86_64
Source0: 10201_database_linux_x86_64.tar.bz2
Source1: p5337014_10203_Linux-x86-64.zip
%if %apply_cpu
Source2: p5901891_10203_Linux-x86-64.zip
%endif
%else
Source0: 10201_database_linux32.zip
Source1: p5337014_10203_LINUX.zip
%if %apply_cpu
Source2: p5901891_10203_LINUX.zip
%endif
%endif
Source10: dbstart.stl
Source11: dbshut.stl
Source12: %{name}-custom.rsp
Source13: %{name}-patchset.rsp

%if %{with_selinux}
# SELinux policy 
Source20: oracle.if
Source21: oracle.te
Source22: oracle.fc
%endif

URL: http://www.oracle.com
BuildPreReq: jpackage-utils >= 0:1.5

%if %{with_selinux}
BuildPreReq: selinux-policy-devel >= 0:2.4.6-64
%endif

%description
Oracle Database 10gR2 is the first database designed for enterprise grid computing, the most flexible and cost-effective way to manage enterprise information. It cuts costs of management while providing the highest possible quality of service. In addition to numerous quality and performance enhancements, Oracle Database 10gR2 significantly reduces the costs of managing the IT environment, with a simplified install, greatly reduced configuration and management requirements, and automatic performance diagnosis and SQL tuning. These and other automated management capabilities help improve DBA and developer productivity and efficiency.

%prep
#
# Remind builder that this rpm clobbers files on the filesystem
#
echo "Warning: current oracle_base %{oracle_base} is about to be destroyed!"
sleep 15

#
# check environment
#
_UID=`id -u`
if [ "${_UID}" != "%{oracle_uid}" ]; then
    echo "Warning: current uid does not match oracle_uid!"
    exit 255
fi
_GID=`id -g`
if [ "${_GID}" != "%{dba_gid}" ]; then
    echo "Warning: current gid does not match dba_gid!"
    exit 255
fi
if [ "${HOME}" != "%{oracle_base}" ]; then
    echo "Warning: current home directory does not match oracle_base!"
    exit 255
fi
if [ ! -r /etc/oraInst.loc ]; then
    echo "Warning: opatch will fail if it cannot find oraInventory! (/etc/oraInst.loc)"
    exit 255
fi

#
# prepare environment
#
export ORACLE_BASE=%{oracle_base}
export ORACLE_HOME=${ORACLE_BASE}/product/%{short_version}

#
# extract the zip
#
%if %apply_cpu
%setup -D -q -b 1 -b 2 -n database
%else
%setup -D -q -b 1 -n database
%endif

#
# install the response file, temporarily, with correct permissions
#
mkdir -p $RPM_BUILD_ROOT
install -p -m 700 %{SOURCE12} $RPM_BUILD_ROOT/response_file.rsp
install -p -m 700 %{SOURCE13} $RPM_BUILD_ROOT/patchset.rsp

#
# fix paths in the response file
#
perl -p -i -e 's@%FROM_LOCATION%@%{_builddir}/database/stage/products.xml@g' $RPM_BUILD_ROOT/response_file.rsp
perl -p -i -e 's@%ORACLE_BASE%@%{oracle_base}@g' $RPM_BUILD_ROOT/response_file.rsp
perl -p -i -e 's@%SHORT_VERSION%@%{short_version}@g' $RPM_BUILD_ROOT/response_file.rsp

#
# run the installer
#
./runInstaller -silent -noconfig -responseFile $RPM_BUILD_ROOT/response_file.rsp -force -ignoreSysPrereqs -waitforcompletion

#
# run the patch installer
#
(cd ../Disk1 ; ./runInstaller -silent -noconfig -responseFile $RPM_BUILD_ROOT/patchset.rsp -force -ignoreSysPrereqs -waitforcompletion)

#
# run the CPU installer
#
%if %apply_cpu
perl -p -i -e 's@-m31@-m32@g' ${ORACLE_HOME}/bin/genoccish
(cd ../5901891 ; ${ORACLE_HOME}/OPatch/opatch apply)
%endif

#
# clean up install scripts
#
rm -f %{oracle_base}/product/%{short_version}/root.sh
rm -f %{oracle_base}/product/%{short_version}/root.sh.old
rm -f %{oracle_base}/product/%{short_version}/oraInst.loc

#
# fix permissions
#
find %{oracle_base} -exec chmod a-s {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.a' -exec chmod 644 {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.jar' -exec chmod 644 {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.so' -exec chmod 755 {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.so.*.?' -exec chmod 755 {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.msb' -exec chmod 644 {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.nlb' -exec chmod 644 {} \;
find %{oracle_base}/product/%{short_version} -type f -name '*.dat' -exec chmod 644 {} \;

#
# remove empty files
#
find %{oracle_base}/product/%{short_version} -type f -size 0b -exec rm -f {} \;

%build

%if %{with_selinux}

# build SELinux Policy Module
mkdir -p policy
pushd policy
cp %{SOURCE20} %{SOURCE21} %{SOURCE22} .
make -f /usr/share/selinux/devel/Makefile NAME=targeted
mv oracle.pp oracle-targeted.pp
make -f /usr/share/selinux/devel/Makefile NAME=strict
mv oracle.pp oracle-strict.pp
popd

%endif

%install
rm -rf $RPM_BUILD_ROOT
mkdir $RPM_BUILD_ROOT

%if %{with_selinux}

# install SELinux Policy Modules
install -m 0755 -d $RPM_BUILD_ROOT%{_datadir}/selinux/targeted
install -m 644 policy/oracle-targeted.pp $RPM_BUILD_ROOT%{_datadir}/selinux/targeted/oracle.pp
install -m 0755 -d $RPM_BUILD_ROOT%{_datadir}/selinux/strict
install -m 644 policy/oracle-strict.pp $RPM_BUILD_ROOT%{_datadir}/selinux/strict/oracle.pp

%endif

#
# create the init script
#
mkdir -p $RPM_BUILD_ROOT/%{_initrddir}
cat > $RPM_BUILD_ROOT/%{_initrddir}/%{name} << _____EOF_____
#!/bin/sh
#
# Init script for the Oracle Instance and Listener
#
# chkconfig: 345 91 19
# description: Startup/Shutdown Oracle Instance and Listener

###########################
# usage: %{name} { restart | start | stop }
#
# NOTES:
#  - Must be run as root because this script su's to oracle
#  - Start the listener before the database so that it auto-registers
#    immediately, rather than waiting a few minutes
#  - should autotransition to oracle domain by using daemon function
#
###########################

# Source function library.
if [ -x /etc/rc.d/init.d/functions ]; then
. /etc/rc.d/init.d/functions
fi

#############
# FUNCTIONS #
#############

#
# Start oracle and the listener
#
start () {
    lsnrstart
    if [ -x /etc/rc.d/init.d/functions ]; then
        daemon --user oracle dbstart ALL
    else
        su - oracle -c "dbstart ALL"
    fi
}

#
# Stop oracle and the listener
#
stop () {
    lsnrstop
    if [ -x /etc/rc.d/init.d/functions ]; then
        daemon --user oracle dbshut ALL
    else
        su - oracle -c "dbshut ALL"
    fi
}

#
# Start the listener
#
lsnrstart () {
    if [ -x /etc/rc.d/init.d/functions ]; then
        daemon --user oracle "lsnrctl start"
    else
        su - oracle -c "lsnrctl start"
    fi
}

#
# Stop the listener
#
lsnrstop () {
    if [ -x /etc/rc.d/init.d/functions ]; then
        daemon --user oracle "lsnrctl stop"
    else
        su - oracle -c "lsnrctl stop"
    fi
}

########
# MAIN #
########

case "\$1" in
  'start')
      start
      ;;

  'restart')
      stop
      start
      ;;

  'stop')
      stop
      ;;

  *)
      echo "Usage: \$0 { restart | start | stop }"
      ;;
esac

_____EOF_____

#
# create the oraInst.loc file, with correct permissions
#
mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}
cat > $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}/oraInst.loc << _EOF_
inventory_loc=%{oracle_base}/product/%{short_version}/oraInventory
inst_group=
_EOF_
chmod 664 $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}/oraInst.loc
chown oracle:dba $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}/oraInst.loc

#
# create the oratab file, with correct permissions
#
mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}
cat > $RPM_BUILD_ROOT/%{_sysconfdir}/%{name}/oratab << _EOF_
#

# This file is used by ORACLE utilities.  It is created by root.sh
# and updated by the Database Configuration Assistant when creating
# a database.

# A colon, ':', is used as the field terminator.  A new line terminates
# the entry.  Lines beginning with a pound sign, '#', are comments.
#
# Entries are of the form:
#   $ORACLE_SID:$ORACLE_HOME:<N|Y>:
#
# The first and second fields are the system identifier and home
# directory of the database respectively.  The third field indicates
# to the dbstart utility that the database should , "Y", or should not,
# "N", be brought up at system boot time.
#
# Multiple entries with the same $ORACLE_SID are not allowed.
#
*:%{oracle_base}/product/%{short_version}:Y
_EOF_

#
# move installed files to build root
#
DIR=`dirname %{oracle_base}`
mkdir -p $RPM_BUILD_ROOT/${DIR}
mv %{oracle_base} $RPM_BUILD_ROOT/${DIR}
chown oracle:dba $RPM_BUILD_ROOT/${DIR}

# install startup scripts that require a sid
mv $RPM_BUILD_ROOT/%{oracle_base}/product/%{short_version}/bin/dbstart $RPM_BUILD_ROOT/%{oracle_base}/product/%{short_version}/bin/dbstart.orig
install -p -m 755 %{SOURCE10} $RPM_BUILD_ROOT/%{oracle_base}/product/%{short_version}/bin/dbstart
mv $RPM_BUILD_ROOT/%{oracle_base}/product/%{short_version}/bin/dbshut $RPM_BUILD_ROOT/%{oracle_base}/product/%{short_version}/bin/dbshut.orig
install -p -m 755 %{SOURCE11} $RPM_BUILD_ROOT/%{oracle_base}/product/%{short_version}/bin/dbshut

# set up profile for all users
mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/profile.d
cat > $RPM_BUILD_ROOT/etc/profile.d/%{name}.sh << __EOF__

if [ -z "\$ORACLE_BASE" ]; then
    export ORACLE_BASE=%{oracle_base}
fi
if [ -z "\$ORACLE_HOME" ]; then
    export ORACLE_HOME=\${ORACLE_BASE}/product/%{short_version}
fi
if [ -z "\$ORACLE_SID" ]; then
    export ORACLE_SID=maverick
fi
if [ -z "\$ORACLE_TERM" ]; then
    export ORACLE_TERM=xterm
fi
if [ -z "\$TNS_ADMIN" ]; then
    export TNS_ADMIN=\${ORACLE_BASE}/admin/system/tnsadmin
fi
if [ -z "\$NLS_LANG" ]; then
    export NLS_LANG=AMERICAN
fi
if [ -z "\$ORA_NLS33" ]; then
    export ORA_NLS33=\${ORACLE_HOME}/ocommon/nls/admin/data
fi

myldpathmunge () {
        if [ -z "\$LD_LIBRARY_PATH" ] ; then
           LD_LIBRARY_PATH=\$1
        else
            if ! echo \$LD_LIBRARY_PATH | /bin/egrep -q "(^|:)\$1($|:)" ; then
               if [ "\$2" = "after" ] ; then
                  LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$1
               else
                  LD_LIBRARY_PATH=\$1:\$LD_LIBRARY_PATH
               fi
            fi
        fi
}

mypathmunge () {
        if ! echo \$PATH | /bin/egrep -q "(^|:)\$1($|:)" ; then
           if [ "\$2" = "after" ] ; then
              PATH=\$PATH:\$1
           else
              PATH=\$1:\$PATH
           fi
        fi
}

mypathmunge \$ORACLE_HOME/bin:\$ORACLE_HOME/lbin after
myldpathmunge \${ORACLE_HOME}/lib:\${LD_LIBRARY_PATH} before

export LD_LIBRARY_PATH PATH
unset mypathmunge
unset myldpathmunge

__EOF__


%clean rm -rf $RPM_BUILD_ROOT

%package -n %{name}-rdbms
Summary: Oracle Database RDBMS
Group: Applications/Databases
AutoReqProv: no

%description -n %{name}-rdbms
Oracle Database 10gR2 is the first database designed for enterprise grid computing, the most flexible and cost-effective way to manage enterprise information. It cuts costs of management while providing the highest possible quality of service. In addition to numerous quality and performance enhancements, Oracle Database 10gR2 significantly reduces the costs of managing the IT environment, with a simplified install, greatly reduced configuration and management requirements, and automatic performance diagnosis and SQL tuning. These and other automated management capabilities help improve DBA and developer productivity and efficiency.

%files -n %{name}-rdbms
%defattr(-,oracle,dba,0755)
%{oracle_base}/product/%{short_version}
%config(noreplace) %{_sysconfdir}/%{name}/oratab
%config %{_sysconfdir}/%{name}/oraInst.loc
%dir %{_sysconfdir}/%{name}
%config %attr(0770,root,dba) %{_initrddir}/%{name}
%config %attr(0775,root,dba) %{_sysconfdir}/profile.d/%{name}.sh
%if %{with_selinux}
%attr(0644,root,root) %{_datadir}/selinux/targeted/oracle.pp
%attr(0644,root,root) %{_datadir}/selinux/strict/oracle.pp
%endif

%pre -n %{name}-rdbms
OUTPUT=`grep dba /etc/group | tail -1 | awk -F: '{print $1}' `
if [ -z ${OUTPUT} ]; then
        groupadd -r -g %{dba_gid} -o dba
fi

OUTPUT=`grep oracle /etc/passwd | tail -1 | awk -F: '{print $1}' `
if [ -z ${OUTPUT} ]; then
        useradd -d %{oracle_base} -r -c Oracle -g dba -u %{oracle_uid} -o oracle -s /bin/bash
else
	# oracle may be installed, so shutdown any existing instances
	(service oracle stop ; exit 0) > /dev/null 2>&1
	(service oracle-9i stop ; exit 0) > /dev/null 2>&1
	(service oracle-9iR2 stop ; exit 0) > /dev/null 2>&1
	(service oracle-10g stop ; exit 0) > /dev/null 2>&1
	(service oracle-10gR2 stop ; exit 0) > /dev/null 2>&1
fi

%post -n %{name}-rdbms
OUTPUT=`grep kernel.shmmax /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase shmmax for oracle" >> /etc/sysctl.conf
	echo "kernel.shmmax = 2147483648" >> /etc/sysctl.conf
	sysctl -w kernel.shmmax=2147483648
fi 
OUTPUT=`grep fs.file-max /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase file-max for oracle" >> /etc/sysctl.conf
	echo "fs.file-max = 65536" >> /etc/sysctl.conf
	sysctl -w fs.file-max=65536
fi 
OUTPUT=`grep kernel.sem /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase for oracle" >> /etc/sysctl.conf
	echo "kernel.sem = 250 32000 100 128" >> /etc/sysctl.conf
	sysctl -w kernel.sem="250 32000 100 128"
fi 
OUTPUT=`grep net.core.rmem_default /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase default socket receive buffer size for oracle" >> /etc/sysctl.conf
	echo "net.core.rmem_default = 262144" >> /etc/sysctl.conf
	sysctl -w net.core.rmem_default=262144
fi 
OUTPUT=`grep net.core.rmem_max /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase maximum socket receive buffer size for oracle" >> /etc/sysctl.conf
	echo "net.core.rmem_max = 262144" >> /etc/sysctl.conf
	sysctl -w net.core.rmem_max=262144
fi 
OUTPUT=`grep net.core.wmem_default /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase default socket send buffer size for oracle" >> /etc/sysctl.conf
	echo "net.core.wmem_default = 262144" >> /etc/sysctl.conf
	sysctl -w net.core.wmem_default=262144
fi 
OUTPUT=`grep net.core.wmem_max /etc/sysctl.conf | awk '{print $1}' `
if [ -z ${OUTPUT} ]; then
	echo "# increase maximum socket send buffer size for oracle" >> /etc/sysctl.conf
	echo "net.core.wmem_max = 262144" >> /etc/sysctl.conf
	sysctl -w net.core.wmem_max=262144
fi 

# add oracle startup script to chkconfig, but turn off
chkconfig --add %{name}
chkconfig --levels 345 %{name} off

# add ojdbc14.jar to java shared dir
ORACLE_HOME=%{oracle_base}/product/%{short_version}
if [ ! -L %{_javadir}/ojdbc14-%{version}.jar ]; then
    ln -s ${ORACLE_HOME}/jdbc/lib/ojdbc14.jar %{_javadir}/ojdbc14-%{version}.jar
fi

# make sure temp directories exist with correct perms
mkdir -p /var/tmp/.oracle
chmod 01777 /var/tmp/.oracle
chown root /var/tmp/.oracle

# make sure a /var/opt/oracle directory exists, but don't add it as a
# file to the rpm as it may conflict with other versions of oracle
if [ ! -d /var/opt/oracle ]; then
   mkdir -p /var/opt/oracle
   chown oracle:dba /var/opt/oracle
fi

# needs to exist, but not as a file in the rpm because of version conflicts
if [ ! -r %{_sysconfdir}/oratab ]; then
   ln -s %{_sysconfdir}/%{name}/oratab %{_sysconfdir}/oratab
fi
# needs to exist, but not as a file in the rpm because of version conflicts
if [ ! -r %{_sysconfdir}/oraInst.loc ]; then
   ln -s %{_sysconfdir}/%{name}/oraInst.loc %{_sysconfdir}/oraInst.loc
fi
# needs to exist, but not as a file in the rpm because of version conflicts
if [ ! -r %{_sysconfdir}/oracle ]; then
   ln -s %{_sysconfdir}/%{name} %{_sysconfdir}/oracle
fi

%if %{with_selinux}

#
# SELinux
#
SELINUXTYPE=`grep ^SELINUXTYPE /etc/selinux/config | sed 's/^.*=//g'`
PP="%{_datadir}/selinux/${SELINUXTYPE}/oracle.pp"

if [ -e ${PP} ]; then
        # remove oracle ports if they are loaded
        SEPORT_STATUS=`semanage port -l | grep -c ^oracle`
        test ${SEPORT_STATUS} -gt 0 && semanage port -d -t oracle_port_t -p tcp 1521 || :

        # unload oracle policy package if it is loaded
        SEMOD_STATUS=`semodule -l | grep -c ^oracle`
        test ${SEMOD_STATUS} -gt 0 && semodule -n -r oracle || :

        # load oracle policy package
        semodule -i ${PP} || :

        # add oracle network ports since they cannot be included in a policy module
        semanage port -a -t oracle_port_t -p tcp 1521

        # restore oracle contexts
        /sbin/restorecon -R -v %{oracle_base}
        /sbin/restorecon -R -v /u0?
        /sbin/restorecon -R -v /etc
        /sbin/restorecon -R -v /var/tmp/.oracle
fi

%endif

%preun -n %{name}-rdbms
# shutdown existing oracle-10gR2 instances
(service %{name} stop ; exit 0) > /dev/null 2>&1

if [ -L %{_javadir}/ojdbc14-%{version}.jar ]; then
    rm -f %{_javadir}/ojdbc14-%{version}.jar
fi

%postun -n %{name}-rdbms
%if %{with_selinux}
if [ $1 -eq 0 ]; then           # rpm -e cases
        # remove oracle ports if they are loaded
        SEPORT_STATUS=`semanage port -l | grep -c ^oracle`
        test ${SEPORT_STATUS} -gt 0 && semanage port -d -t oracle_port_t -p tcp 1521 || :

        # unload oracle policy package if it is loaded
        SEMOD_STATUS=`semodule -l | grep -c ^oracle`
        test ${SEMOD_STATUS} -gt 0 && semodule -r oracle || :
elif [ $1 -eq 1 ]; then         # rpm -Uvh cases
        # don't do anything
        :
fi
%endif

%changelog
* Mon Apr 30 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.9
- SELinux policy cleanup
- add with_selinux flag

* Fri Apr 27 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.7
- spec clean ups, permission fixes
- don't need to set a listener password anymore
- fix invalid postun script

* Thu Apr 26 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.5
- many, many fixes

* Wed Apr 25 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.4
- build an initial selinux policy module which will require much refinement
- change oracle_base to /opt/oracle
- make home directory mode 0755

* Tue Apr 24 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.3
- rebuild with CPUAPR2007 (#5901891)

* Wed Jan 24 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.2
- add patch 5671740 for INCOMPLETE CALL STACK FOR LINUX 64-BIT WITH 2.6.9 KERNEL

* Wed Jan 24 2007 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.3-stl.1
- update to 10.2.0.3

* Fri Oct 20 2006 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.2-stl.8
- rebuild with CPUOCT2006

* Fri Aug  4 2006 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.2-stl.7
- rebuild with CPUJUL2006
- make /etc/oraInst.loc a prerequisite; moving oraInventoy becomes a non-issue

* Wed Jun 21 2006 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.2-stl.6
- rebuild with 10.2.0.2
- fix: allow dba to modify profile.d entry
- fix: permissions so that users not in dba group can use oracle apps
- fix: add oracle user with dba as primary group
- fix: add multiline to init script

* Mon Oct 31 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.1-stl.7
- rebuild for x86

* Wed Oct 26 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.1-stl.6
- rebuild for x86_64
- changed TNS_ADMIN to ~oracle/admin/system/tnsadmin
- use _javadir from jpackage-utils
- move oraInventory to version specific location

* Thu Oct 06 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.1-stl.5
- fix default permissions

* Tue Jul 26 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.1-stl.4
- change oracle_base to /home/oracle
- miscellaneous cleanup

* Mon Jul 25 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.1-stl.3
- switch to responsefile install

* Thu Jul 21 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10gR2-10.2.0.1-stl.1
- update to 10gR2
- add sysctl's
- make init script work better with SELinux

* Tue Apr 12 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.4-stl.1
- upgrade to 10.1.0.4
- convert ORACLE_HOME to short_version (10.1.0)
- documented install options
- no x86_64 version yet

* Mon Apr 11 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.3-stl.6
- fix changelog date
- fix oracle.sh script

* Mon Apr 11 2005 Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.3-stl.5
- sync with oracle-9iR2

* Tue Jan 25 2005  Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.3-stl.4
- symlinks for stuff in /etc/

* Tue Jan 25 2005  Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.3-stl.3
- fix error in postinstall
- add /var/opt/oracle
- do not add oracle driver to tomcat's common path

* Tue Jan 25 2005  Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.3-stl.2
- move oracle to oracle-10g everywhere to prevent conflicts
- link ojdbc14.jar to java share
- make arch specific
- fix quotes in kernel.sem parameters
- clean up scriptlets

* Fri Jan 21 2005  Rob Myers <rob.myers@gtri.gatech.edu> 10g-10.1.0.3-stl.1
- upgrade to 10.1.0.3
- lots of cleanup
- still need to get zimmer to rewrite dbstart/dbshut to specify sids

--=-IGa/McFMj9C80OcETj3C--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
