Message-ID: <4203B048.5070607@redhat.com>
Date: Fri, 04 Feb 2005 12:26:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Java Policy
Content-Type: multipart/mixed;
 boundary="------------060707050900040706030504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060707050900040706030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is policy for the java plugin.
Do not know if we want user apps that run java to transition.

Will be sending in a big diff later today, but wanted input sooner.

Dan

--------------060707050900040706030504
Content-Type: text/plain;
 name="java.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="java.fc"

#  java
/usr/java/jre.*/bin/java.+ --	system_u:object_r:java_exec_t

--------------060707050900040706030504
Content-Type: text/plain;
 name="java.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="java.te"

#DESC Netscape - Web browser
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser 
# X-Debian-Packages: java
#

# Type for the netscape, java or other browser executables.
type java_exec_t, file_type, sysadmfile, exec_type;

# Allow java to read files in the user home directory
bool disable_java false;
bool java_readhome false;

# Allow java to write files in the user home directory
bool java_writehome false;

# Everything else is in the java_domain macro in
# macros/program/java_macros.te.

--------------060707050900040706030504
Content-Type: text/plain;
 name="java_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="java_macros.te"

#
# Macros for java/java (or other browser) domains.
#

#
# Authors:  Dan Walsh <dwalsh@redhat.com> and Timothy Fraser 
#

#
# java_domain(domain_prefix, user)
#
# Define a derived domain for the java/java program when executed by
# a web browser.  
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/java.te. 
#
define(`java_domain',`
type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;

# The user role is authorized for this domain.
role $2_r types $1_java_t;
domain_auto_trans($1_t, java_exec_t, $1_java_t)

allow $1_java_t sound_device_t:chr_file rw_file_perms;
# Unrestricted inheritance from the caller.
allow $1_t $1_java_t:process { noatsecure siginh rlimitinh };
allow $1_java_t $1_t:process signull;

can_unix_connect($1_java_t, $1_t)
allow $1_java_t $1_t:unix_stream_socket { read write };

# This domain is granted permissions common to most domains (including can_net)
can_network_client($1_java_t)
can_ypbind($1_java_t)
allow $1_java_t self:process { fork signal_perms getsched setsched };
allow $1_java_t self:unix_stream_socket { connectto create_stream_socket_perms };
allow $1_java_t self:fifo_file rw_file_perms;
allow $1_java_t etc_runtime_t:file { getattr read };
allow $1_java_t fs_t:filesystem getattr;
read_locale($1_java_t)
r_dir_file($1_java_t, { proc_t proc_net_t })
allow $1_java_t self:dir search;
allow $1_java_t self:lnk_file read;
allow $1_java_t self:file { getattr read };

read_sysctl($1_java_t)

tmp_domain($1_java)
r_dir_file($1_java_t,{ fonts_t usr_t etc_t })

# Search bin directory under java for java executable
allow $1_java_t bin_t:dir search;
can_exec($1_java_t, java_exec_t)

# Allow connections to X server.
ifdef(`xserver.te', `

ifdef(`xdm.te', `
# for when /tmp/.X11-unix is created by the system
allow $1_java_t xdm_xserver_tmp_t:dir search;
allow $1_java_t xdm_t:fifo_file rw_file_perms;
allow $1_java_t xdm_tmp_t:dir search;
allow $1_java_t xdm_tmp_t:sock_file write;
')

ifdef(`startx.te', `
# for when /tmp/.X11-unix is created by the X server
allow $1_java_t $2_xserver_tmp_t:dir search;

# for /tmp/.X0-lock
allow $1_java_t $2_xserver_tmp_t:file getattr;

allow $1_java_t $2_xserver_tmp_t:sock_file rw_file_perms;
can_unix_connect($1_java_t, $2_xserver_t)
')dnl end startx

can_unix_connect($1_java_t, xdm_xserver_t)
allow xdm_xserver_t $1_java_t:fd use;
allow xdm_xserver_t $1_java_t:shm { associate getattr read unix_read };
dontaudit xdm_xserver_t $1_java_t:shm { unix_write write };

')dnl end xserver

allow $1_java_t self:shm create_shm_perms;

if (allow_execmem) {
allow $1_java_t self:process { execmem };
}
if (allow_execmod) {
#Required when starting java with /lib/tls/libc-
allow $1_java_t { texrel_shlib_t shlib_t }:file execmod;
allow $1_java_t ld_so_t:file execmod;
}
uses_shlib($1_java_t)
read_locale($1_java_t)
rw_dir_file($1_java_t, $1_rw_t)

allow $1_java_t ld_so_cache_t:file execute;
allow $1_java_t lib_t:file execute;
allow $1_java_t locale_t:file execute;
allow $1_java_t $1_java_tmp_t:file execute;

allow $1_java_t { random_device_t urandom_device_t }:chr_file ra_file_perms;

allow $1_java_t home_root_t:dir { getattr search };
file_type_auto_trans($1_java_t, $2_home_dir_t, $1_rw_t)
allow $1_java_t $2_home_xauth_t:file { getattr read };
allow $1_java_t $2_tmp_t:sock_file write;
allow $1_java_t $2_t:fd use;

allow $1_java_t var_t:dir getattr;
allow $1_java_t var_lib_t:dir { getattr search };

dontaudit $1_java_t fonts_t:file execute;
dontaudit $1_java_t sound_device_t:chr_file execute;
dontaudit $1_java_t $2_devpts_t:chr_file { read write };
dontaudit $1_java_t sysadm_devpts_t:chr_file { read write };
dontaudit $1_java_t devtty_t:chr_file { read write };
dontaudit $1_java_t tmpfs_t:file { execute read write };
dontaudit $1_java_t $1_rw_t:file { execute setattr };

')

--------------060707050900040706030504
Content-Type: text/plain;
 name="mozilla.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mozilla.fc"

#  netscape/mozilla
HOME_DIR/\.galeon(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
/usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
/usr/bin/epiphany-bin   --	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla-[0-9].* --	system_u:object_r:mozilla_exec_t
/usr/bin/mozilla-bin-[0-9].* --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/galeon/galeon -- system_u:object_r:mozilla_exec_t
/usr/lib(64)?/netscape/.+/communicator/communicator-smotif\.real -- system_u:object_r:mozilla_exec_t
/usr/lib(64)?/netscape/base-4/wrapper -- system_u:object_r:mozilla_exec_t
/usr/lib(64)?/mozilla[^/]*/reg.+	--	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/firefox[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/[^/]*firefox[^/]*/firefox-bin --	system_u:object_r:mozilla_exec_t
/usr/lib(64)?/[^/]*firefox[^/]*/firefox --	system_u:object_r:bin_t
/etc/mozpluggerrc system_u:object_r:mozilla_conf_t

--------------060707050900040706030504
Content-Type: text/plain;
 name="mozilla_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mozilla_macros.te"

#
# Macros for mozilla/mozilla (or other browser) domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser 
#

#
# mozilla_domain(domain_prefix)
#
# Define a derived domain for the mozilla/mozilla program when executed by
# a user domain.  
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/mozilla.te. 
#
define(`mozilla_domain',`
x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')

# Allow mozilla to browse files
file_browse_domain($1_mozilla_t)

allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;

# Unrestricted inheritance from the caller.
allow $1_t $1_mozilla_t:process { noatsecure siginh rlimitinh };
allow $1_mozilla_t $1_t:process signull;

# Set resource limits and scheduling info.
allow $1_mozilla_t self:process { setrlimit setsched };

allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
allow $1_mozilla_t var_lib_t:file { getattr read };
allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
allow $1_mozilla_t self:socket create_socket_perms;
allow $1_mozilla_t self:file { getattr read };

# for the orbit files of mozilla
allow $1_t $1_mozilla_rw_t:sock_file create_file_perms;
can_unix_connect($1_t, $1_mozilla_t)

if (use_nfs_home_dirs) {
create_dir_file($1_mozilla_t, nfs_t)
}
if (use_samba_home_dirs) {
create_dir_file($1_mozilla_t, cifs_t)
}
allow $1_mozilla_t autofs_t:dir { search getattr };

# for bash
allow $1_mozilla_t device_t:dir r_dir_perms;
allow $1_mozilla_t devpts_t:dir r_dir_perms;
allow $1_mozilla_t proc_t:file { getattr read };
r_dir_file($1_mozilla_t, proc_net_t)

allow $1_mozilla_t { var_t var_lib_t }:dir search;

# Execute downloaded programs.
can_exec($1_mozilla_t, $1_mozilla_rw_t)

dontaudit $1_mozilla_t tmpfile:dir setattr;

# Use printer
ifdef(`lpr.te', `
domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
# $1_lpr_t should only need read access to the tmp files
allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
')

#
# This is another place where I sould like to allow system customization.
# We need to allow the admin to select whether then want to allow mozilla
# access to the users home directories.
#
if (mozilla_readhome || mozilla_writehome) {
r_dir_file($1_mozilla_t, $1_home_t)
file_type_auto_trans($1_mozilla_t, tmp_t, $1_tmp_t)
} else {
file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
dontaudit $1_mozilla_t $1_home_t:dir setattr;
dontaudit $1_mozilla_t $1_home_t:file setattr;
}

if (mozilla_writehome) {
file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_rw_t)
allow $1_mozilla_t $1_home_t:dir setattr;
allow $1_mozilla_t $1_home_t:{ file lnk_file } rw_file_perms;
} dnl end if writehome

allow $1_mozilla_t $1_t:unix_stream_socket connectto;
allow $1_mozilla_t sysctl_net_t:dir search;
allow $1_mozilla_t sysctl_t:dir search;
ifdef(`cups.te', `
allow $1_mozilla_t cupsd_etc_t:dir search;
allow $1_mozilla_t cupsd_rw_etc_t:file { getattr read };
')
allow $1_mozilla_t $1_t:tcp_socket { read write };

allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
# running mplayer within firefox asks for this
allow $1_mozilla_t clock_device_t:chr_file r_file_perms;
# Mozilla tries to delete .fonts.cache-1
dontaudit $1_mozilla_t $1_home_t:file unlink;
allow $1_mozilla_t self:sem create_sem_perms;

#
# Rules needed to run java apps

java_domain($1_mozilla, $1)

ifdef(`xdm.te', `
allow $1_mozilla_t xdm_t:fifo_file { write read };
allow $1_mozilla_t xdm_tmp_t:dir search;
allow $1_mozilla_t xdm_tmp_t:file { getattr read };
allow $1_mozilla_t xdm_tmp_t:sock_file write;
')dnl end if xdm.te
if (allow_execmem) {
allow $1_mozilla_t self:process { execmem };
}

')dnl end mozilla macro


--------------060707050900040706030504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
