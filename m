Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LEcBIi012396
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 09:38:11 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0LEcC5L021112
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 14:38:12 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id j0LEeGZU026851
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 09:40:16 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id j0LEeGW1026850
	for selinux@tycho.nsa.gov; Fri, 21 Jan 2005 09:40:16 -0500
Message-ID: <41F03552.90806@redhat.com>
Date: Thu, 20 Jan 2005 17:48:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Karsten Wade <kwade@redhat.com>
Subject: Man pages added to policy file.
Content-Type: multipart/mixed;
 boundary="------------040400000400060505060000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040400000400060505060000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am adding these man pages to the policy file to attempt to describe 
how users might manipulate policy.

The goal was to describe Booleans and File Context that a user might 
want to manipulate.  Please review the man pages.
(IE translate them from dwalsh to English :^) )

I also attached the latest policy file that includes all changes 
including the previous patch I submitted.  The main new stuff
is around trying to get telnet, rlogin, and rshd to work.  We pretty 
much figured out that SELinux is not going to offer much
protection with targeted policy since these apps need to either 
transition directly to unconfined_t or to transition to login which
will transition to unconfined_t.

Looks like we will need to split up the apps via Priv-Separation in 
order to make this of much use.

Dan

--------------040400000400060505060000
Content-Type: text/plain;
 name="ftpd_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftpd_selinux.8"

.TH  "ftpd_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "ftpd Selinux Policy documentation"
.SH "NAME"
ftpd_selinux \- Security Enhanced Linux Policy for the ftp daemon
.SH "DESCRIPTION"

Security-Enhanced Linux secures the ftpd server via flexible mandatory access
control.  
.SH FILE_CONTEXTS
SELinux requires files to have an extended attributes to define the file type. 
Policy governs the access daemons have to these files. 
If you want to share files anonymously you must label the files and directories ftpd_anon_t.  So if you created a special directory /var/ftp, you 
would need to label the directory with the chcon tool.
.TP
chcon -t ftpd_anon_t /var/ftp
.TP
If you want to make this permanant IE, survive a relabel you must add an entry to the file_contexts.local file.
.TP
/etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
.br
/var/ftp(/.*)? system_u:object_r:ftpd_anon_t

.SH BOOLEANS
SELinux ftp daemon policy is customizable based on least access required.  So by 
default SElinux does not allow users to login and read their home directories.
.br
If you are setting up this machine as a ftpd server and wish to allow users to access their home
directorories you need to set the ftp_home_dir boolean. 
.TP
setsebool -P ftp_home_dir 1
.TP
ftpd can run either as a standalone daemon or as part of the xinetd domain.  If you want to run ftpd as a daemon you must set the ftpd_is_daemon boolean.
.TP
setsebool -P ftpd_is_daemon 1
.TP
You can disable SELinux protection for the ftpd daemon by executing:
.TP
setsebool -P ftpd_disable_trans 1
.br
system vsftpd restart
.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), ftpd(8), chcon(1), setsebool(8)



--------------040400000400060505060000
Content-Type: text/plain;
 name="httpd_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="httpd_selinux.8"

.TH  "httpd_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "httpd Selinux Policy documentation"
.SH "NAME"
httpd_selinux \- Security Enhanced Linux Policy for the httpd daemon
.SH "DESCRIPTION"

Security-Enhanced Linux secures the httpd server via flexible mandatory access
control.  
.SH FILE_CONTEXTS
SELinux requires files to have an extended attributes to define the file type. 
Policy governs the access daemons have to these files. 
SELinux httpd policy is very flexible allowing users to setup their web services in as secure a method as possible.
.TP 
The following file contexts types are defined for httpd:
.br

httpd_sys_content_t 
.br 
- Set files with httpd_sys_content_t for content which is available from all httpd scripts and the daemon.
.br

httpd_sys_script_exec_t  
.br 
- Set cgi scripts with httpd_sys_script_exec_t to allow them to run with access to all sys types.
.br

httpd_sys_script_ro_t 
.br
- Set files with httpd_sys_script_ro_t if you want httpd_sys_script_exec_t scripts to read the data, and disallow other sys scripts from access.
.br

httpd_sys_script_rw_t 
.br
- Set files with httpd_sys_script_rw_t if you want httpd_sys_script_exec_t scripts to read/write the data, and disallow other non sys scripts from access.
.br

httpd_sys_script_ra_t 
.br
- Set files with httpd_sys_script_ra_t if you want httpd_sys_script_exec_t scripts to read/append to the file, and disallow other non sys scripts from access.
.SH NOTE

With certain policies you can define addional file contexts based off of roles like user or staff.  httpd_user_script_exec_t can be defined, where it would only have access to "user" contexts.

.SH BOOLEANS
SELinux policy is customizable based on least access required.  So by 
default SElinux prevents certain http scripts from working.  httpd policy is extremely flexible and has several booleans that allow you to manipulate the policy and run httpd with the tightest access possible.
.TP
httpd can be setup to allow cgi scripts to be executed, set httpd_enable_cgi to allow this
.br

setsebool -P httpd_enable_cgi 1

.TP
httpd by default is not allowed to access users home directories.  If you want to allow access to users home directories you need to set the httpd_enable_homedirs boolean and change the context of the files that you want people to access off the home dir.
.br

setsebool -P httpd_enable_homedirs 1
.br
chcon -R -t httpd_sys_content_t ~user/public_html

.TP
httpd by default is not allowed access to the controling terminal.  In most cases this is prefered, because an intruder might be able to use the access to the terminal to gain priveledges. But in certain situations, httpd needs to prompt for a password to open a certificate file, terminal access is required.  Set the httpd_tty_comm boolean to allow terminal access.
.br

setsebool -P httpd_tty_comm 1

.TP
httpd can be configured to not differentiate file conteols based on context.  IE, all files labeled as httpd context can be read/write/execute.  Setting this context to false allows you to setup security policy such that one httpd service can not interfere with another.
.br

setsebool -P httpd_unified 0

.TP
You can disable SELinux protection for the httpd daemon by executing:
.br

setsebool -P httpd_disable_trans 1
.br
system httpd restart

.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), httpd(8), chcon(1), setsebool(8)



--------------040400000400060505060000
Content-Type: text/plain;
 name="kerberos_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kerberos_selinux.8"

.TH  "kerberos_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "kerberos Selinux Policy documentation"
.SH "NAME"
kerberos_selinux \- Security Enhanced Linux Policy for Kerberos.
.SH "DESCRIPTION"

Security-Enhanced Linux secures the system via flexible mandatory access
control. By default Kerberos access is not allowed, since it requires daemons to be allowed greater access to certain secure files and addtional access to the network.  
.SH BOOLEANS
.TP
You must set the allow_kerberos boolean to allow your system to work properly in a Kerberos environment.
.TP
setsebool -P allow_kerberos 1
.TP 
If you are running Kerberos daemons kadmind or krb5kdc you can disable the SELinux protection on these daemons by setting the krb5kdc_disable_trans and kadmind_disable_trans booleans.
.br

setsebool -P krb5kdc_disable_trans 1
.br
system krb5kdc restart
.br
setsebool -P kadmind_disable_trans booleans 1
.br
system kadmind restart

.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), kerberos(1), chcon(1), setsebool(8)

--------------040400000400060505060000
Content-Type: text/plain;
 name="named_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="named_selinux.8"

.TH  "named_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "named Selinux Policy documentation"
.SH "NAME"
named_selinux \- Security Enhanced Linux Policy for the Internet Name server (named) daemon
.SH "DESCRIPTION"

Security-Enhanced Linux secures the named server via flexible mandatory access
control.  
.SH BOOLEANS
SELinux policy is customizable based on least access required.  So by 
default SElinux policy does not allow named to write master zone files.  If you want to have this named update the master zone files you need to set the named_write_master_zones boolean.
.TP
.br
setsebool -P named_write_master_zones 1

.TP
You can disable SELinux protection for the named daemon by executing:
.TP
setsebool -P named_disable_trans 1
.br
system named restart
.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), named(8), chcon(1), setsebool(8)



--------------040400000400060505060000
Content-Type: text/plain;
 name="nfs_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs_selinux.8"

.TH  "nfs_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "nfs Selinux Policy documentation"
.SH "NAME"
nfs_selinux \- Security Enhanced Linux Policy for NFS
.SH "DESCRIPTION"

Security-Enhanced Linux secures the nfs server via flexible mandatory access
control.  
.SH BOOLEANS
SELinux policy is customizable based on least access required.  So by 
default SElinux policy does not allow nfs to share files.  If you want to 
setup this machine to share nfs partitions read only you must set the boolean nfs_export_all_ro boolean.

.TP
setsebool -P nfs_export_all_ro 1
.TP
If you want to share files read/write you must set the nfs_export_all_rw boolean.
.TP
setsebool -P nfs_export_all_rw 1

.TP
If you want to use a remote NFS server for the home directories on this machine you must set the use_nfs_home_dir boolean.
.TP
setsebool -P use_nfs_home_dirs 1
.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSpppO"
selinux(8), chcon(1), setsebool(8)

--------------040400000400060505060000
Content-Type: text/plain;
 name="nis_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nis_selinux.8"

.so man8/ypbind_selinux.8

--------------040400000400060505060000
Content-Type: text/plain;
 name="rsync_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rsync_selinux.8"

.TH  "rsync_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "rsync Selinux Policy documentation"
.SH "NAME"
rsync_selinux \- Security Enhanced Linux Policy for the rsync daemon
.SH "DESCRIPTION"

Security-Enhanced Linux secures the rsync server via flexible mandatory access
control.  
.SH FILE_CONTEXTS
SELinux requires files to have an extended attributes to define the file type. 
Policy governs the access daemons have to these files. 
If you want to share files using the rsync daemon you must label the files and directories ftpd_anon_t.  So if you created a special directory /var/rsync, you 
would need to label the directory with the chcon tool.
.TP
chcon -t ftpd_anon_t /var/rsync
.TP
If you want to make this permanant IE, survive a relabel you must add an entry to the file_contexts.local file.
.TP
/etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
.br
/var/rsync(/.*)? system_u:object_r:ftpd_anon_t

.SH BOOLEANS
.TP
You can disable SELinux protection for the rsync daemon by executing:
.TP
setsebool -P rsync_disable_trans 1
.br
system xinetd restart
.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), rsync(1), chcon(1), setsebool(8)

--------------040400000400060505060000
Content-Type: text/plain;
 name="samba_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="samba_selinux.8"

.TH  "samba_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "Samba Selinux Policy documentation"
.SH "NAME"
samba_selinux \- Security Enhanced Linux Policy for Samba
.SH "DESCRIPTION"

Security-Enhanced Linux secures the Samba server via flexible mandatory access
control.  
.SH FILE_CONTEXTS
SELinux requires files to have an extended attributes to define the file type. 
Policy governs the access daemons have to these files. 
If you want to share files other than home directories, those files must be 
labeled samba_share_t.  So if you created a special directory /var/eng, you 
would need to label the directory with the chcon tool.
.TP
chcon -t samba_share_t /var/eng
.TP
If you want to make this permanant IE, survive a relabel you must add an entry to the file_contexts.local file.
.TP
/etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
.br
/var/eng(/.*)? system_u:object_r:samba_share_t

.SH BOOLEANS
.br 
SELinux policy is customizable based on least access required.  So by 
default SElinux policy turns off SELinux sharing of Home directories and 
the use of Samba shares from a remote machine as a home directory.
.TP
If you are setting up this machine as a Samba server and wish to share the homedirectories you need to set the samba_enable_home_dirs boolean. 
.br

setsebool -P samba_enable_home_dirs 1
.TP
If you want to use a remote Samba server for the home directories on this machine you must set the use_samba_home_dirs boolean.
.br 

setsebool -P use_samba_home_dirs 1
.TP
You can disable SELinux protection for the samba daemon by executing:
.br 

setsebool -P smbd_disable_trans 1
.br
system smb restart
.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), samba(7), chcon(1), setsebool(8)

--------------040400000400060505060000
Content-Type: text/plain;
 name="ypbind_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ypbind_selinux.8"

.TH  "ypbind_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "ypbind Selinux Policy documentation"
.SH "NAME"
ypbind_selinux \- Security Enhanced Linux Policy for NIS.
.SH "DESCRIPTION"

Security-Enhanced Linux secures the system via flexible mandatory access
control. By default NIS is not allowed, since it requires daemons to be allowed greater access to the network.  
.SH BOOLEANS
.TP
You must set the allow_ypbind boolean to allow your system to work properly in a NIS environment.
.TP
setsebool -P allow_ypbind 1
.TP
system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
.SH AUTHOR	
This manual page was written by Dan Walsh <dwalsh@redhat.com>.

.SH "SEE ALSO"
selinux(8), ypbind(8), chcon(1), setsebool(8)

--------------040400000400060505060000
Content-Type: text/x-patch;
 name="policy-20050120.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20050120.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.21.2/attrib.te
--- nsapolicy/attrib.te	2005-01-20 15:55:00.262368000 -0500
+++ policy-1.21.2/attrib.te	2005-01-20 16:08:43.903448000 -0500
@@ -393,3 +393,8 @@
 # For labeling of domains whos transition can be disabled
 attribute transitionbool;
 
+# For labeling of file_context domains which users can change files to rather
+# then the default file context.  These file_context can survive a relabeling
+# of the file system.
+attribute customizable;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.21.2/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-01-20 15:55:01.489140000 -0500
+++ policy-1.21.2/domains/program/initrc.te	2005-01-20 16:08:43.913438000 -0500
@@ -12,7 +12,7 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
 
 role system_r types initrc_t;
 uses_shlib(initrc_t);
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.21.2/domains/program/init.te
--- nsapolicy/domains/program/init.te	2005-01-20 15:55:01.373256000 -0500
+++ policy-1.21.2/domains/program/init.te	2005-01-20 16:08:43.967384000 -0500
@@ -14,7 +14,7 @@
 # by init during initialization.  This pipe is used
 # to communicate with init.
 #
-type init_t, domain, privlog, mlstrustedreader, mlstrustedwriter, sysctl_kernel_writer, nscd_client_domain ifdef(`targeted_policy', `, unrestricted');
+type init_t, domain, privlog, mlstrustedreader, mlstrustedwriter, sysctl_kernel_writer, nscd_client_domain;
 role system_r types init_t;
 uses_shlib(init_t);
 type init_exec_t, file_type, sysadmfile, exec_type;
@@ -141,3 +141,7 @@
 
 # file descriptors inherited from the rootfs.
 dontaudit init_t root_t:{ file chr_file } { read write }; 
+ifdef(`targeted_policy', `
+typeattribute init_t unrestricted;
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.21.2/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2005-01-20 15:55:01.564066000 -0500
+++ policy-1.21.2/domains/program/ldconfig.te	2005-01-20 16:08:43.976376000 -0500
@@ -8,7 +8,7 @@
 #
 # Rules for the ldconfig_t domain.
 #
-type ldconfig_t, domain, privlog, etc_writer ifdef(`targeted_policy', `, unrestricted' );
+type ldconfig_t, domain, privlog, etc_writer;
 type ldconfig_exec_t, file_type, sysadmfile, exec_type;
 
 role sysadm_r types ldconfig_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.21.2/domains/program/login.te
--- nsapolicy/domains/program/login.te	2005-01-20 15:55:01.624005000 -0500
+++ policy-1.21.2/domains/program/login.te	2005-01-20 16:08:43.986365000 -0500
@@ -84,6 +84,10 @@
 r_dir_file($1_login_t, nfs_t)
 }
 
+if (use_samba_home_dirs) {
+r_dir_file($1_login_t, cifs_t)
+}
+
 # FIXME: what is this for?
 ifdef(`xdm.te', `
 allow xdm_t $1_login_t:process signull;
@@ -126,6 +130,11 @@
 
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
 
+ifdef(`targeted_policy',`
+unconfined_domain($1_login_t)
+domain_auto_trans($1_login_t, shell_exec_t, unconfined_t)
+')
+
 ')dnl end login_domain macro
 #################################
 #
@@ -208,5 +217,18 @@
 # Relabel ptys created by rlogind.
 allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto };
 ')
+
+# Use the pty created by telnetd.
+ifdef(`telnetd.te', `
+allow remote_login_t telnetd_devpts_t:chr_file { setattr rw_file_perms };
+
+# Relabel ptys created by telnetd.
+allow remote_login_t telnetd_devpts_t:chr_file { relabelfrom relabelto };
+')
+
 allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto ioctl };
 allow remote_login_t fs_t:filesystem { getattr };
+
+# Allow remote login to resolve host names (passed in via the -h switch)
+can_resolve(remote_login_t)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.21.2/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-01-20 15:55:01.744884000 -0500
+++ policy-1.21.2/domains/program/modutil.te	2005-01-20 16:08:43.998353000 -0500
@@ -69,7 +69,7 @@
 # Rules for the insmod_t domain.
 #
 
-type insmod_t, domain, privlog, sysctl_kernel_writer, privmem ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule, unrestricted' )
+type insmod_t, domain, privlog, sysctl_kernel_writer, privmem ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule' )
 ;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.21.2/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-01-20 15:55:01.762867000 -0500
+++ policy-1.21.2/domains/program/mount.te	2005-01-20 16:08:44.066285000 -0500
@@ -101,3 +101,5 @@
 allow mount_t tmpfs_t:chr_file { read write };
 allow mount_t tmpfs_t:dir mounton;
 ')
+# tries to read /init
+dontaudit mount_t root_t:file {getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.21.2/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-01-20 15:55:02.034594000 -0500
+++ policy-1.21.2/domains/program/ssh.te	2005-01-20 16:08:44.076275000 -0500
@@ -80,6 +80,11 @@
 allow $1_t nfs_t:file { getattr read };
 }
 
+if (use_samba_home_dirs) {
+allow $1_t cifs_t:dir { search getattr };
+allow $1_t cifs_t:file { getattr read };
+}
+
 # Set exec context.
 can_setexec($1_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unconfined.te policy-1.21.2/domains/program/unconfined.te
--- nsapolicy/domains/program/unconfined.te	2004-08-24 15:35:26.000000000 -0400
+++ policy-1.21.2/domains/program/unconfined.te	2005-01-20 16:08:44.086266000 -0500
@@ -6,7 +6,7 @@
 # chcon -t unconfined_exec_t /usr/local/bin/appsrv
 # Or alternatively add it to /etc/security/selinux/src/policy/file_contexts/program/unconfined.fc
 
-type unconfined_t, domain, privlog, admin, privmem, fs_domain, auth_write, unrestricted;
+type unconfined_t, domain, privlog, admin, privmem, fs_domain, auth_write;
 type unconfined_exec_t, file_type, sysadmfile, exec_type;
 role sysadm_r types unconfined_t;
 domain_auto_trans(sysadm_t, unconfined_exec_t, unconfined_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.21.2/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2005-01-20 15:55:02.418210000 -0500
+++ policy-1.21.2/domains/program/unused/anaconda.te	2005-01-20 16:08:44.097254000 -0500
@@ -10,7 +10,7 @@
 #
 # anaconda_t is the domain of the installation program
 #
-type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted;
+type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer;
 role system_r types anaconda_t;
 unconfined_domain(anaconda_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.2/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-01-20 15:55:02.463165000 -0500
+++ policy-1.21.2/domains/program/unused/apache.te	2005-01-20 16:08:44.110241000 -0500
@@ -19,6 +19,13 @@
 #  the user CGI scripts, then relabel rule for user_r should be removed.
 #
 ###############################################################################
+
+define(`httpd_home_dirs', `
+r_dir_file(httpd_t, $1)
+r_dir_file(httpd_suexec_t, $1)
+can_exec(httpd_suexec_t, $1)
+')
+
 type http_port_t, port_type, reserved_port_type;
 
 bool httpd_unified false;
@@ -262,9 +269,10 @@
 allow httpd_suexec_t autofs_t:dir { search getattr };
 ')
 if (use_nfs_home_dirs && httpd_enable_homedirs) {
-r_dir_file(httpd_t, nfs_t)
-r_dir_file(httpd_suexec_t, nfs_t)
-can_exec(httpd_suexec_t, nfs_t)
+httpd_home_dirs(nfs_t)
+}
+if (use_samba_home_dirs && httpd_enable_homedirs) {
+httpd_home_dirs(cifs_t)
 }
 r_dir_file(httpd_t, fonts_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/auditd.te policy-1.21.2/domains/program/unused/auditd.te
--- nsapolicy/domains/program/unused/auditd.te	2004-06-17 10:31:14.000000000 -0400
+++ policy-1.21.2/domains/program/unused/auditd.te	2005-01-20 16:08:44.172179000 -0500
@@ -7,3 +7,6 @@
 allow auditd_t self:netlink_audit_socket { bind create getattr nlmsg_read nlmsg_write read write };
 allow auditd_t self:capability { net_admin sys_admin };
 allow auditd_t sysadm_tty_device_t:chr_file rw_file_perms;
+allow auditd_t self:unix_dgram_socket create_socket_perms;
+allow auditd_t etc_t:file { getattr read };
+log_domain(auditd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.21.2/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-01-20 15:55:03.903723000 -0500
+++ policy-1.21.2/domains/program/unused/cups.te	2005-01-20 16:08:44.273078000 -0500
@@ -248,3 +248,6 @@
 allow cupsd_t initrc_t:dbus send_msg;
 ')
 
+ifdef(`targeted_policy', `
+allow cupsd_t unconfined_t:dbus send_msg;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.21.2/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2005-01-20 15:55:04.673954000 -0500
+++ policy-1.21.2/domains/program/unused/dhcpd.te	2005-01-20 16:08:44.285066000 -0500
@@ -41,6 +41,7 @@
 
 # Use capabilities
 allow dhcpd_t self:capability { net_raw net_bind_service };
+dontaudit dhcpd_t self:capability  net_admin;
 
 # Allow access to the dhcpd file types
 type dhcp_state_t, file_type, sysadmfile;
@@ -72,3 +73,5 @@
 allow dhcpd_t self:capability { chown dac_override setgid setuid sys_chroot };
 allow initrc_t dhcpd_state_t:file setattr;
 ')
+r_dir_file(dhcpd_t, usr_t)
+allow dhcpd_t { urandom_device_t random_device_t }:chr_file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.21.2/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2005-01-20 15:55:05.570055000 -0500
+++ policy-1.21.2/domains/program/unused/firstboot.te	2005-01-20 16:08:44.296055000 -0500
@@ -10,7 +10,7 @@
 #
 # firstboot_exec_t is the type of the firstboot executable.
 #
-application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted')
+application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer')
 type firstboot_rw_t, file_type, sysadmfile;
 role system_r types firstboot_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.21.2/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-01-20 15:55:05.633991000 -0500
+++ policy-1.21.2/domains/program/unused/ftpd.te	2005-01-20 16:08:44.307044000 -0500
@@ -100,14 +100,15 @@
 # allow access to /home
 allow ftpd_t home_root_t:dir { getattr search };
 }
-
-if (ftp_home_dir && use_nfs_home_dirs) {
-allow ftpd_t nfs_t:dir r_dir_perms;
-allow ftpd_t nfs_t:file r_file_perms;
+if (use_nfs_home_dirs && ftp_home_dir) {
+	r_dir_file(ftpd_t, nfs_t)
+}
+if (use_samba_home_dirs && ftp_home_dir) {
+	r_dir_file(ftpd_t, cifs_t)
 }
 dontaudit ftpd_t selinux_config_t:dir search;
 #
 # Type for access to anon ftp
 #
-type ftpd_anon_t, file_type, sysadmfile;
+type ftpd_anon_t, file_type, sysadmfile, customizable;
 r_dir_file(ftpd_t,ftpd_anon_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.21.2/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-01-20 15:55:06.013612000 -0500
+++ policy-1.21.2/domains/program/unused/hald.te	2005-01-20 16:08:44.330024000 -0500
@@ -71,3 +71,4 @@
 allow hald_t device_t:chr_file create_file_perms;
 tmp_domain(hald)
 allow hald_t mnt_t:dir search;
+r_dir_file(hald_t, proc_net_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.21.2/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2005-01-20 15:55:06.069555000 -0500
+++ policy-1.21.2/domains/program/unused/hotplug.te	2005-01-20 16:08:44.343008000 -0500
@@ -11,7 +11,7 @@
 # hotplug_exec_t is the type of the hotplug executable.
 #
 ifdef(`unlimitedUtils', `
-daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, unrestricted')
+daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer')
 ', `
 daemon_domain(hotplug, `, privmodule')
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.21.2/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2005-01-20 15:55:06.207417000 -0500
+++ policy-1.21.2/domains/program/unused/inetd.te	2005-01-20 16:08:44.465885000 -0500
@@ -10,7 +10,6 @@
 # Rules for the inetd_t domain and
 # the inetd_child_t domain.
 #
-type telnet_port_t, port_type, reserved_port_type;
 type biff_port_t, port_type, reserved_port_type;
 
 #################################
@@ -18,7 +17,7 @@
 # Rules for the inetd_t domain.
 #
 
-daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem, unrestricted')' )
+daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
 can_network(inetd_t)
 allow inetd_t self:unix_dgram_socket create_socket_perms;
@@ -44,9 +43,7 @@
 allow inetd_t sbin_t:lnk_file read;
 
 # Bind to the telnet, ftp, rlogin and rsh ports.
-allow inetd_t telnet_port_t:tcp_socket name_bind;
 ifdef(`ftpd.te', `allow inetd_t ftp_port_t:tcp_socket name_bind;')
-ifdef(`rlogind.te', `allow inetd_t rlogin_port_t:tcp_socket name_bind;')
 ifdef(`rshd.te', `allow inetd_t rsh_port_t:tcp_socket name_bind;')
 ifdef(`talk.te', `
 allow inetd_t talk_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lvm.te policy-1.21.2/domains/program/unused/lvm.te
--- nsapolicy/domains/program/unused/lvm.te	2005-01-20 15:55:07.377246000 -0500
+++ policy-1.21.2/domains/program/unused/lvm.te	2005-01-20 16:08:44.476874000 -0500
@@ -103,6 +103,7 @@
 dontaudit lvm_t ttyfile:chr_file getattr;
 dontaudit lvm_t device_t:{ fifo_file dir chr_file blk_file } getattr;
 dontaudit lvm_t devpts_t:dir { getattr read };
+
 ifdef(`gpm.te', `
 dontaudit lvm_t gpmctl_t:sock_file getattr;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.21.2/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2005-01-20 15:55:08.229393000 -0500
+++ policy-1.21.2/domains/program/unused/named.te	2005-01-20 16:08:44.487863000 -0500
@@ -85,8 +85,8 @@
 allow named_t sysctl_kernel_t:file r_file_perms;
 
 # Read /proc/cpuinfo.
-allow named_t proc_t:dir r_dir_perms;
-allow named_t proc_t:file r_file_perms;
+r_dir_file(named_t, proc_t)
+r_dir_file(named_t, proc_net_t)
 
 # Read /dev/random.
 allow named_t device_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.21.2/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2005-01-20 15:55:09.053568000 -0500
+++ policy-1.21.2/domains/program/unused/pamconsole.te	2005-01-20 16:08:44.573778000 -0500
@@ -41,3 +41,4 @@
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
 allow initrc_t pam_var_console_t:dir r_dir_perms;
+allow pam_console_t file_context_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.21.2/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-01-20 15:55:09.559062000 -0500
+++ policy-1.21.2/domains/program/unused/postgresql.te	2005-01-20 16:08:44.584766000 -0500
@@ -53,6 +53,7 @@
 
 # Use the network.
 can_network_server(postgresql_t)
+can_ypbind(postgresql_t)
 allow postgresql_t self:fifo_file { getattr read write ioctl };
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(postgresql_t, self)
@@ -84,6 +85,7 @@
 
 # Allow access to the postgresql databases
 create_dir_file(postgresql_t, postgresql_db_t)
+file_type_auto_trans(postgresql_t, var_lib_t, postgresql_db_t)
 allow postgresql_t var_lib_t:dir { getattr search };
 
 # because postgresql start scripts are broken and put the pid file in the DB
@@ -103,8 +105,8 @@
 allow postgresql_t devpts_t:dir search;
 
 allow postgresql_t { bin_t sbin_t }:dir search;
-allow postgresql_t { bin_t sbin_t }:lnk_file read;
-allow postgresql_t postgresql_exec_t:lnk_file read;
+allow postgresql_t { bin_t sbin_t }:lnk_file { getattr read };
+allow postgresql_t postgresql_exec_t:lnk_file { getattr read };
 
 allow postgresql_t self:sem create_sem_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.21.2/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2005-01-20 15:55:10.568052000 -0500
+++ policy-1.21.2/domains/program/unused/rhgb.te	2005-01-20 16:08:44.671679000 -0500
@@ -98,3 +98,4 @@
 allow initrc_t ramfs_t:sock_file write;
 allow initrc_t rhgb_t:unix_stream_socket { read write };
 
+allow rhgb_t default_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rlogind.te policy-1.21.2/domains/program/unused/rlogind.te
--- nsapolicy/domains/program/unused/rlogind.te	2005-01-20 15:55:10.664956000 -0500
+++ policy-1.21.2/domains/program/unused/rlogind.te	2005-01-20 16:08:44.681669000 -0500
@@ -9,13 +9,9 @@
 #
 # Rules for the rlogind_t domain.
 #
-type rlogin_port_t, port_type, reserved_port_type;
-type rlogind_t, domain, privlog, auth_chkpwd, privfd;
-role system_r types rlogind_t;
-uses_shlib(rlogind_t)
-can_network_server(rlogind_t)
-type rlogind_exec_t, file_type, sysadmfile, exec_type;
-domain_auto_trans(inetd_t, rlogind_exec_t, rlogind_t)
+remote_login_daemon(rlogind)
+typeattribute rlogind_t auth_chkpwd;
+
 ifdef(`tcpd.te', `
 domain_auto_trans(tcpd_t, rlogind_exec_t, rlogind_t)
 ')
@@ -23,61 +19,19 @@
 # for /usr/lib/telnetlogin
 can_exec(rlogind_t, rlogind_exec_t)
 
-tmp_domain(rlogind)
-
-# Inherit and use descriptors from inetd.
-allow rlogind_t inetd_t:fd use;
-
-# Use sockets inherited from inetd.
-allow rlogind_t inetd_t:tcp_socket rw_stream_socket_perms;
-
 # Use capabilities.
-allow rlogind_t self:capability { net_bind_service setuid setgid fowner fsetid chown dac_override sys_tty_config };
-
-# so telnetd can start a child process for the login
-allow rlogind_t self:process { fork signal_perms };
-
-allow rlogind_t self:unix_dgram_socket create_socket_perms;
-allow rlogind_t self:unix_stream_socket create_socket_perms;
+allow rlogind_t self:capability { net_bind_service };
 
 # Run login in remote_login_t.
-allow rlogind_t bin_t:dir search;
 allow remote_login_t inetd_t:fd use;
 allow remote_login_t inetd_t:tcp_socket rw_file_perms;
 
 # Send SIGCHLD to inetd on death.
 allow rlogind_t inetd_t:process sigchld;
 
-domain_auto_trans(rlogind_t, login_exec_t, remote_login_t)
-
-allow rlogind_t proc_t:dir search;
-allow rlogind_t proc_t:lnk_file read;
-allow rlogind_t self:dir search;
-allow rlogind_t self:lnk_file read;
-
-# Create ptys.
-can_create_pty(rlogind, `, server_pty')
-allow rlogind_t userpty_type:chr_file setattr;
-allow rlogind_t devtty_t:chr_file rw_file_perms;
-
-read_locale(rlogind_t)
-
-# for /etc/issue
-allow rlogind_t etc_runtime_t:file { getattr read };
-
-allow rlogind_t etc_t:file { getattr read };
-
-# Modify /var/run/utmp.
-allow rlogind_t { var_t var_run_t }:dir search;
-allow rlogind_t initrc_var_run_t:file rw_file_perms;
-
-# Modify /var/log/wtmp.
-allow rlogind_t var_log_t:dir search;
-allow rlogind_t wtmp_t:file rw_file_perms;
-allow rlogind_t urandom_device_t:chr_file { getattr read };
-dontaudit rlogind_t selinux_config_t:dir search;
-allow rlogind_t staff_home_dir_t:dir search;
-allow rlogind_t proc_t:file read;
+allow rlogind_t home_dir_type:dir search;
+allow rlogind_t home_type:file { getattr read };
 allow rlogind_t self:file { getattr read };
-allow rlogind_t self:fifo_file rw_file_perms;
-allow rlogind_t fs_t:filesystem { getattr };
+allow rlogind_t default_t:dir search;
+typealias rlogind_port_t alias rlogin_port_t;
+read_sysctl(rlogind_t);
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.21.2/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-01-20 15:55:10.767853000 -0500
+++ policy-1.21.2/domains/program/unused/rpcd.te	2005-01-20 16:08:44.691659000 -0500
@@ -126,3 +126,15 @@
 allow rpcd_t rpc_pipefs_t:sock_file { read write };
 dontaudit rpcd_t selinux_config_t:dir { search };
 allow rpcd_t proc_net_t:dir search;
+
+
+rpc_domain(gssd)
+can_kerberos(gssd_t)
+allow gssd_t krb5_keytab_t:file r_file_perms;
+allow gssd_t urandom_device_t:chr_file { getattr read };
+r_dir_file(gssd_t, tmp_t)
+tmp_domain(gssd)
+allow gssd_t self:fifo_file { read write };
+r_dir_file(gssd_t, proc_net_t)
+allow gssd_t rpc_pipefs_t:dir r_dir_perms;
+allow gssd_t rpc_pipefs_t:sock_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.21.2/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2005-01-20 15:55:10.896723000 -0500
+++ policy-1.21.2/domains/program/unused/rpm.te	2005-01-20 16:08:44.702648000 -0500
@@ -10,7 +10,7 @@
 # var_log_rpm_t is the type for rpm log files (/var/log/rpmpkgs*)
 # var_lib_rpm_t is the type for rpm files in /var/lib
 #
-type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd ifdef(`unlimitedRPM', `, unrestricted, auth_write');
+type rpm_t, domain, admin, etc_writer, privlog, privowner, privmem, priv_system_role, fs_domain, privfd;
 role system_r types rpm_t;
 uses_shlib(rpm_t)
 type rpm_exec_t, file_type, sysadmfile, exec_type;
@@ -115,7 +115,7 @@
 
 allow { insmod_t depmod_t } rpm_t:fifo_file rw_file_perms;
 
-type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role ifdef(`unlimitedRPM', `, unrestricted, auth_write');
+type rpm_script_t, domain, admin, etc_writer, privlog, privowner, privmodule, privmem, fs_domain, privfd, priv_system_role;
 # policy for rpm scriptlet
 role system_r types rpm_script_t;
 uses_shlib(rpm_script_t)
@@ -249,7 +249,9 @@
 allow initrc_t rpm_var_lib_t:file create_file_perms;
 
 ifdef(`unlimitedRPM', `
+typeattribute rpm_t auth_write;
 unconfined_domain(rpm_t)
+typeattribute rpm_script_t auth_write;
 unconfined_domain(rpm_script_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.21.2/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2005-01-20 15:55:10.965654000 -0500
+++ policy-1.21.2/domains/program/unused/rshd.te	2005-01-20 17:36:17.838846000 -0500
@@ -10,7 +10,7 @@
 # Rules for the rshd_t domain.
 #
 type rsh_port_t, port_type, reserved_port_type;
-daemon_sub_domain(inetd_t, rshd)
+daemon_sub_domain(inetd_t, rshd, `, auth_chkpwd, privuser, privrole')
 
 ifdef(`tcpd.te', `
 domain_auto_trans(tcpd_t, rshd_exec_t, rshd_t)
@@ -24,6 +24,9 @@
 
 # Use the network.
 can_network_server(rshd_t)
+allow rshd_t reserved_port_t:tcp_socket name_bind;
+dontaudit rshd_t reserved_port_type:tcp_socket name_bind;
+
 can_ypbind(rshd_t)
 
 allow rshd_t etc_t:file { getattr read };
@@ -32,8 +35,35 @@
 allow rshd_t self:unix_stream_socket create_stream_socket_perms;
 allow rshd_t { home_root_t home_dir_type }:dir { search getattr };
 can_kerberos(rshd_t)
-allow rshd_t tmp_t:dir { search };
+allow rshd_t { bin_t sbin_t tmp_t}:dir { search };
+allow rshd_t { bin_t sbin_t }:lnk_file r_file_perms;
 ifdef(`rlogind.te', `
 allow rshd_t rlogind_tmp_t:file rw_file_perms;
 ')
 allow rshd_t urandom_device_t:chr_file { getattr read };
+
+# Read the user's .rhosts file.
+allow rshd_t home_type:file  r_file_perms ;
+
+# Random reasons
+can_getsecurity(rshd_t)
+can_setexec(rshd_t)
+r_dir_file(rshd_t, selinux_config_t)
+r_dir_file(rshd_t, default_context_t)
+read_sysctl(rshd_t);
+
+if (use_nfs_home_dirs) {
+r_dir_file(rshd_t, nfs_t)
+}
+
+if (use_samba_home_dirs) {
+r_dir_file(rshd_t, cifs_t)
+}
+
+allow rshd_t self:process { fork signal setsched setpgid };
+allow rshd_t self:fifo_file rw_file_perms;
+
+ifdef(`targeted_policy', `
+unconfined_domain(rshd_t)
+domain_auto_trans(rshd_t,shell_exec_t,unconfined_t)
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te.old policy-1.21.2/domains/program/unused/rshd.te.old
--- nsapolicy/domains/program/unused/rshd.te.old	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/domains/program/unused/rshd.te.old	2005-01-20 17:33:35.811034000 -0500
@@ -0,0 +1,53 @@
+#DESC RSHD - RSH daemon
+#
+# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
+# X-Debian-Packages: rsh-server rsh-redone-server
+# Depends: inetd.te
+#
+
+#################################
+#
+# Rules for the rshd_t domain.
+#
+type rsh_port_t, port_type, reserved_port_type;
+daemon_sub_domain(inetd_t, rshd, `, auth_chkpwd')
+
+ifdef(`tcpd.te', `
+domain_auto_trans(tcpd_t, rshd_exec_t, rshd_t)
+')
+
+# Use sockets inherited from inetd.
+allow rshd_t inetd_t:tcp_socket rw_stream_socket_perms;
+
+# Use capabilities.
+allow rshd_t self:capability { net_bind_service setuid setgid fowner fsetid chown dac_override};
+
+# Use the network.
+can_network_server(rshd_t)
+allow rshd_t reserved_port_t:tcp_socket name_bind;
+dontaudit rshd_t reserved_port_type:tcp_socket name_bind;
+
+can_ypbind(rshd_t)
+
+allow rshd_t etc_t:file { getattr read };
+read_locale(rshd_t)
+allow rshd_t self:unix_dgram_socket create_socket_perms;
+allow rshd_t self:unix_stream_socket create_stream_socket_perms;
+allow rshd_t { home_root_t home_dir_type }:dir { search getattr };
+can_kerberos(rshd_t)
+allow rshd_t tmp_t:dir { search };
+ifdef(`rlogind.te', `
+allow rshd_t rlogind_tmp_t:file rw_file_perms;
+')
+allow rshd_t urandom_device_t:chr_file { getattr read };
+
+# Read the user's .rhosts file.
+allow rshd_t home_type:file  r_file_perms ;
+
+# Random reasons
+dontaudit rshd_t selinux_config_t:dir search;
+r_dir_file(rshd_t, proc_t)
+allow rshd_t self:file r_file_perms;
+allow rshd_t self:process { fork signal setsched };
+allow rshd_t self:fifo_file r_file_perms;
+read_sysctl(rshd_t);
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.2/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-01-20 15:55:11.129491000 -0500
+++ policy-1.21.2/domains/program/unused/samba.te	2005-01-20 16:08:44.782569000 -0500
@@ -7,14 +7,14 @@
 #################################
 #
 # Declarations for Samba
-#
+#n
 
 daemon_domain(smbd, `, privhome, auth_chkpwd')
 daemon_domain(nmbd)
 type samba_etc_t, file_type, sysadmfile, usercanread;
 type samba_log_t, file_type, sysadmfile, logfile;
 type samba_var_t, file_type, sysadmfile;
-type samba_share_t, file_type, sysadmfile;
+type samba_share_t, file_type, sysadmfile, customizable;
 type samba_secrets_t, file_type, sysadmfile;
 typealias samba_var_t alias samba_spool_t;
 
@@ -45,7 +45,7 @@
 allow smbd_t smbd_port_t:tcp_socket name_bind;
 
 # Use capabilities.
-allow smbd_t self:capability { setgid setuid sys_resource net_bind_service lease };
+allow smbd_t self:capability { setgid setuid sys_resource net_bind_service lease dac_override dac_read_search };
 
 # Use the network.
 can_network_server(smbd_t)
@@ -73,8 +73,7 @@
 allow smbd_t usr_t:file { getattr read };
 
 # Access Samba shares.
-allow smbd_t samba_share_t:dir create_dir_perms;
-allow smbd_t samba_share_t:file create_file_perms;
+create_dir_file(smbd_t, samba_share_t)
 
 ifdef(`logrotate.te', `
 # the application should be changed
@@ -117,3 +116,7 @@
 ')
 # Needed for winbindd
 allow smbd_t { samba_var_t smbd_var_run_t }:sock_file create_file_perms;
+
+# Support Samba sharing of home directories
+bool samba_enable_home_dirs false;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.21.2/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2005-01-20 15:55:12.355264000 -0500
+++ policy-1.21.2/domains/program/unused/spamd.te	2005-01-20 16:08:44.872478000 -0500
@@ -64,5 +64,10 @@
 allow spamd_t nfs_t:file create_file_perms;
 }
 
+if (use_samba_home_dirs) {
+allow spamd_t cifs_t:dir rw_dir_perms;
+allow spamd_t cifs_t:file create_file_perms;
+}
+
 allow spamd_t home_root_t:dir getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/telnetd.te policy-1.21.2/domains/program/unused/telnetd.te
--- nsapolicy/domains/program/unused/telnetd.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/domains/program/unused/telnetd.te	2005-01-20 16:08:44.889461000 -0500
@@ -0,0 +1,10 @@
+# telnet server daemon
+#
+
+#################################
+#
+# Rules for the telnetd_t domain 
+#
+
+remote_login_daemon(telnetd)
+typealias telnetd_port_t alias telnet_port_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.21.2/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-01-20 15:55:13.384233000 -0500
+++ policy-1.21.2/domains/program/unused/udev.te	2005-01-20 16:08:44.971379000 -0500
@@ -122,3 +122,18 @@
 allow udev_t self:rawip_socket create_socket_perms;
 dontaudit udev_t domain:dir r_dir_perms;
 dontaudit udev_t ttyfile:chr_file unlink;
+ifdef(`hotplug.te', `
+r_dir_file(udev_t, hotplug_var_run_t)
+')
+r_dir_file(udev_t, modules_object_t)
+#
+# Udev is now writing dhclient-eth*.conf* files.
+#
+ifdef(`dhcpd.te', `define(`use_dhcp')')
+ifdef(`dhcpc.te', `define(`use_dhcp')')
+ifdef(`use_dhcp', `
+allow udev_t dhcp_etc_t:file rw_file_perms;
+file_type_auto_trans(udev_t, etc_t, dhcp_etc_t, file)
+')
+r_dir_file(udev_t, domain)
+allow udev_t modules_dep_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.21.2/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-01-20 15:55:14.306310000 -0500
+++ policy-1.21.2/domains/program/unused/xdm.te	2005-01-20 16:08:45.067283000 -0500
@@ -126,7 +126,7 @@
 allow xdm_t dri_device_t:chr_file rw_file_perms;
 allow xdm_t device_t:dir rw_dir_perms;
 allow xdm_t agp_device_t:chr_file rw_file_perms;
-allow xdm_t misc_device_t:chr_file { setattr getattr };
+allow xdm_t { xserver_misc_device_t misc_device_t }:chr_file { setattr getattr };
 allow xdm_t v4l_device_t:chr_file { setattr getattr };
 allow xdm_t scanner_device_t:chr_file { setattr getattr };
 allow xdm_t tty_device_t:chr_file { ioctl read write setattr getattr };
@@ -290,6 +290,12 @@
 can_exec(xdm_t, nfs_t)
 }
 
+if (use_samba_home_dirs) {
+allow { xdm_t xdm_xserver_t } cifs_t:dir create_dir_perms;
+allow { xdm_t xdm_xserver_t } cifs_t:{file lnk_file} create_file_perms;
+can_exec(xdm_t, cifs_t)
+}
+
 # for .dmrc
 allow xdm_t user_home_dir_type:dir { getattr search };
 allow xdm_t user_home_type:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.21.2/domains/user.te
--- nsapolicy/domains/user.te	2005-01-20 15:55:00.950679000 -0500
+++ policy-1.21.2/domains/user.te	2005-01-20 16:08:45.075275000 -0500
@@ -10,6 +10,9 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Support SAMBA home directories
+bool use_samba_home_dirs false;
+
 # Allow users to run TCP servers (bind to ports and accept connection from
 # the same domain and outside users)  disabling this forces FTP passive mode
 # and may change other protocols 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/auditd.fc policy-1.21.2/file_contexts/program/auditd.fc
--- nsapolicy/file_contexts/program/auditd.fc	2004-03-17 13:26:06.000000000 -0500
+++ policy-1.21.2/file_contexts/program/auditd.fc	2005-01-20 16:08:45.084269000 -0500
@@ -1,2 +1,3 @@
 # auditd
 /sbin/auditd		--	system_u:object_r:auditd_exec_t
+/var/log/audit.log 	-- 	system_u:object_r:auditd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/gpg.fc policy-1.21.2/file_contexts/program/gpg.fc
--- nsapolicy/file_contexts/program/gpg.fc	2005-01-20 15:55:16.670943000 -0500
+++ policy-1.21.2/file_contexts/program/gpg.fc	2005-01-20 16:08:45.094256000 -0500
@@ -1,4 +1,5 @@
 # gpg
 HOME_DIR/\.gnupg(/.+)?	system_u:object_r:ROLE_gpg_secret_t
 /usr/bin/gpg		--	system_u:object_r:gpg_exec_t
+/usr/bin/kgpg		--	system_u:object_r:gpg_exec_t
 /usr/lib/gnupg/gpgkeys.*	--	system_u:object_r:gpg_helper_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/innd.fc policy-1.21.2/file_contexts/program/innd.fc
--- nsapolicy/file_contexts/program/innd.fc	2005-01-20 15:55:17.258355000 -0500
+++ policy-1.21.2/file_contexts/program/innd.fc	2005-01-20 16:08:45.171180000 -0500
@@ -1,5 +1,7 @@
 # innd
 /usr/sbin/innd.*	--	system_u:object_r:innd_exec_t
+/usr/bin/rpost          --      system_u:object_r:innd_exec_t
+/usr/bin/suck           --      system_u:object_r:innd_exec_t
 /var/run/innd(/.*)?		system_u:object_r:innd_var_run_t
 /etc/news(/.*)?			system_u:object_r:innd_etc_t
 /etc/news/boot		--	system_u:object_r:innd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mysqld.fc policy-1.21.2/file_contexts/program/mysqld.fc
--- nsapolicy/file_contexts/program/mysqld.fc	2005-01-20 15:55:18.391223000 -0500
+++ policy-1.21.2/file_contexts/program/mysqld.fc	2005-01-20 16:08:45.181169000 -0500
@@ -1,5 +1,5 @@
 # mysql database server
-/usr/sbin/mysqld	--	system_u:object_r:mysqld_exec_t
+/usr/sbin/mysqld(-max)?	--	system_u:object_r:mysqld_exec_t
 /usr/libexec/mysqld	--	system_u:object_r:mysqld_exec_t
 /var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
 /var/log/mysql.*	--	system_u:object_r:mysqld_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.21.2/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2005-01-20 15:55:18.858754000 -0500
+++ policy-1.21.2/file_contexts/program/postgresql.fc	2005-01-20 16:08:45.271079000 -0500
@@ -13,9 +13,13 @@
 /usr/bin/pg_id		--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_restore	--	system_u:object_r:postgresql_exec_t
 
-/var/lib/postgres(ql)?(/.*)? system_u:object_r:postgresql_db_t
-/var/lib/pgsql(/.*)?		system_u:object_r:postgresql_db_t
+/var/lib/postgres(ql)?(/.*)? 	system_u:object_r:postgresql_db_t
+/var/lib/pgsql/data(/.*)?	system_u:object_r:postgresql_db_t
 /var/run/postgresql(/.*)?	system_u:object_r:postgresql_var_run_t
 /etc/postgresql(/.*)?		system_u:object_r:postgresql_etc_t
 /var/log/postgres\.log.* --	system_u:object_r:postgresql_log_t
 /var/log/postgresql(/.*)?	system_u:object_r:postgresql_log_t
+/usr/lib/pgsql/test/regres(/.*)?	system_u:object_r:postgresql_db_t
+/usr/lib/pgsql/test/regress/.*\.so	-- system_u:object_r:shlib_t
+/usr/lib/pgsql/test/regress/.*\.sh	-- system_u:object_r:bin_t
+/usr/lib/pgsql/test/regress/pg_regress	-- system_u:object_r:postgresql_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rlogind.fc policy-1.21.2/file_contexts/program/rlogind.fc
--- nsapolicy/file_contexts/program/rlogind.fc	2004-03-03 15:53:52.000000000 -0500
+++ policy-1.21.2/file_contexts/program/rlogind.fc	2005-01-20 16:08:45.280071000 -0500
@@ -1,6 +1,4 @@
 # rlogind and telnetd
 /usr/sbin/in\.rlogind	--	system_u:object_r:rlogind_exec_t
-/usr/sbin/in\.telnetd	--	system_u:object_r:rlogind_exec_t
 /usr/lib(64)?/telnetlogin	--	system_u:object_r:rlogind_exec_t
 /usr/kerberos/sbin/klogind --	system_u:object_r:rlogind_exec_t
-/usr/kerberos/sbin/telnetd --	system_u:object_r:rlogind_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rpcd.fc policy-1.21.2/file_contexts/program/rpcd.fc
--- nsapolicy/file_contexts/program/rpcd.fc	2005-01-20 15:55:19.455158000 -0500
+++ policy-1.21.2/file_contexts/program/rpcd.fc	2005-01-20 16:08:45.289061000 -0500
@@ -3,6 +3,8 @@
 /usr/sbin/rpc\..*	--	system_u:object_r:rpcd_exec_t
 /usr/sbin/rpc\.nfsd	--	system_u:object_r:nfsd_exec_t
 /usr/sbin/exportfs	--	system_u:object_r:nfsd_exec_t
+/usr/sbin/rpc\.gssd	--	system_u:object_r:gssd_exec_t
+/usr/sbin/rpc\.svcgssd	--	system_u:object_r:gssd_exec_t
 /usr/sbin/rpc\.mountd	--	system_u:object_r:nfsd_exec_t
 /var/run/rpc\.statd\.pid	--	system_u:object_r:rpcd_var_run_t
 /var/run/rpc\.statd(/.*)?	system_u:object_r:rpcd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/telnetd.fc policy-1.21.2/file_contexts/program/telnetd.fc
--- nsapolicy/file_contexts/program/telnetd.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/file_contexts/program/telnetd.fc	2005-01-20 16:08:45.303048000 -0500
@@ -0,0 +1,3 @@
+# telnetd
+/usr/sbin/in\.telnetd	--	system_u:object_r:telnetd_exec_t
+/usr/kerberos/sbin/telnetd --	system_u:object_r:telnetd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.21.2/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2005-01-20 15:55:20.838771000 -0500
+++ policy-1.21.2/file_contexts/program/udev.fc	2005-01-20 16:08:45.310042000 -0500
@@ -8,5 +8,5 @@
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
 /etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
-/dev/\.udev\.tdb	--	system_u:object_r:udev_tdb_t
+/dev/\.udev\.tdb/.*	--	system_u:object_r:udev_tdb_t
 /sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.21.2/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-01-20 15:55:14.739876000 -0500
+++ policy-1.21.2/file_contexts/types.fc	2005-01-20 16:08:45.319031000 -0500
@@ -280,6 +280,7 @@
 /var/db/shadow.*	--	system_u:object_r:shadow_t
 /etc/blkid\.tab.*	--	system_u:object_r:etc_runtime_t
 /etc/fstab\.REVOKE	--	system_u:object_r:etc_runtime_t
+/etc/\.fstab\.hal\..+	--	system_u:object_r:etc_runtime_t
 /etc/HOSTNAME		--	system_u:object_r:etc_runtime_t
 /etc/ioctl\.save	--	system_u:object_r:etc_runtime_t
 /etc/mtab		--	system_u:object_r:etc_runtime_t
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.21.2/genfs_contexts
--- nsapolicy/genfs_contexts	2005-01-20 15:55:00.327304000 -0500
+++ policy-1.21.2/genfs_contexts	2005-01-20 16:08:45.368981000 -0500
@@ -89,6 +89,7 @@
 # nfs
 genfscon nfs /				system_u:object_r:nfs_t
 genfscon nfs4 /				system_u:object_r:nfs_t
+genfscon afs /				system_u:object_r:nfs_t
 
 # reiserfs - until xattr security support works properly
 genfscon reiserfs /			system_u:object_r:nfs_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.2/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-01-20 15:55:21.841767000 -0500
+++ policy-1.21.2/macros/base_user_macros.te	2005-01-20 16:08:45.376973000 -0500
@@ -2,6 +2,12 @@
 # Macros for all user login domains.
 #
 
+define(`network_home_dir', `
+create_dir_file($1, $2)
+can_exec($1, $2)
+allow $1 $2:{ sock_file fifo_file } create_file_perms;
+')
+
 #
 # base_user_domain(domain_prefix)
 #
@@ -38,6 +44,7 @@
 
 # Allow text relocations on system shared libraries, e.g. libGL.
 allow $1_t shlib_t:file execmod;
+allow $1_t ld_so_t:file execmod;
 
 #
 # kdeinit wants this access
@@ -70,11 +77,15 @@
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
+
 if (use_nfs_home_dirs) {
-create_dir_file($1_t, nfs_t)
-can_exec($1_t, nfs_t)
-allow $1_t nfs_t:{ sock_file fifo_file } create_file_perms;
+network_home_dir($1_t, nfs_t)
 }
+
+if (use_samba_home_dirs) {
+network_home_dir($1_t, cifs_t)
+}
+
 if (user_rw_noexattrfile) {
 create_dir_file($1_t, noexattrfile)
 create_dir_file($1_t, removable_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.2/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-01-20 15:55:22.039569000 -0500
+++ policy-1.21.2/macros/global_macros.te	2005-01-20 16:08:45.470879000 -0500
@@ -504,6 +504,8 @@
 #
 define(`unconfined_domain', `
 
+typeattribute $1 unrestricted;
+
 # Mount/unmount any filesystem. 
 allow $1 fs_type:filesystem *;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.21.2/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-01-20 15:55:22.676931000 -0500
+++ policy-1.21.2/macros/program/apache_macros.te	2005-01-20 16:08:45.479870000 -0500
@@ -3,7 +3,7 @@
 
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, ifelse($1, sys, `', `$1_file_type, ') httpdcontent, sysadmfile;
+type httpd_$1_content_t, file_type, ifelse($1, sys, `', `$1_file_type, ') httpdcontent, sysadmfile, customizable;
 ifelse($1, sys, `
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
 ')
@@ -14,7 +14,7 @@
 
 # This type is used for executable scripts files
 #
-type httpd_$1_script_exec_t, file_type, sysadmfile;
+type httpd_$1_script_exec_t, file_type, sysadmfile, customizable;
 
 # Type that CGI scripts run as
 type httpd_$1_script_t, domain, privmail, nscd_client_domain;
@@ -41,6 +41,7 @@
 read_locale(httpd_$1_script_t)
 allow httpd_$1_script_t fs_t:filesystem getattr;
 allow httpd_$1_script_t self:unix_stream_socket create_socket_perms;
+allow httpd_$1_script_t httpd_t:unix_stream_socket { read write };
 
 allow httpd_$1_script_t { self proc_t }:file { getattr read };
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
@@ -57,9 +58,9 @@
 # The following are the only areas that 
 # scripts can read, read/write, or append to
 #
-type httpd_$1_script_ro_t, file_type, httpdcontent, sysadmfile;
-type httpd_$1_script_rw_t, file_type, httpdcontent, sysadmfile;
-type httpd_$1_script_ra_t, file_type, httpdcontent, sysadmfile;
+type httpd_$1_script_ro_t, file_type, httpdcontent, sysadmfile, customizable;
+type httpd_$1_script_rw_t, file_type, httpdcontent, sysadmfile, customizable;
+type httpd_$1_script_ra_t, file_type, httpdcontent, sysadmfile, customizable;
 file_type_auto_trans(httpd_$1_script_t, tmp_t, httpd_$1_script_rw_t)
 
 ifdef(`slocate.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.21.2/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2004-12-20 16:27:46.000000000 -0500
+++ policy-1.21.2/macros/program/cdrecord_macros.te	2005-01-20 16:08:45.577772000 -0500
@@ -35,6 +35,9 @@
 if (use_nfs_home_dirs) {
 r_dir_file($1_cdrecord_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+r_dir_file($1_cdrecord_t, cifs_t)
+}
 allow $1_cdrecord_t etc_t:file { getattr read };
 
 # allow searching for cdrom-drive
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_agent_macros.te policy-1.21.2/macros/program/gpg_agent_macros.te
--- nsapolicy/macros/program/gpg_agent_macros.te	2005-01-20 15:55:23.552055000 -0500
+++ policy-1.21.2/macros/program/gpg_agent_macros.te	2005-01-20 16:08:45.682668000 -0500
@@ -51,6 +51,9 @@
 if (use_nfs_home_dirs) {
 create_dir_file($1_gpg_agent_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+create_dir_file($1_gpg_agent_t, cifs_t)
+}
 
 allow $1_gpg_agent_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_gpg_agent_t self:fifo_file { getattr read write };
@@ -111,6 +114,12 @@
 dontaudit $1_gpg_pinentry_t nfs_t:dir { read write };
 dontaudit $1_gpg_pinentry_t nfs_t:file write;
 }
+if (use_samba_home_dirs) {
+allow $1_gpg_pinentry_t cifs_t:dir { getattr search };
+allow $1_gpg_pinentry_t cifs_t:file { getattr read };
+dontaudit $1_gpg_pinentry_t cifs_t:dir { read write };
+dontaudit $1_gpg_pinentry_t cifs_t:file write;
+}
 
 # read /etc/X11/qtrc
 allow $1_gpg_pinentry_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.21.2/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2005-01-20 15:55:23.600008000 -0500
+++ policy-1.21.2/macros/program/gpg_macros.te	2005-01-20 16:08:45.771578000 -0500
@@ -23,7 +23,10 @@
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
-
+#
+# Is this Ok?
+# 
+allow $1_gpg_t gpg_exec_t:file execmod;
 can_network($1_gpg_t)
 can_ypbind($1_gpg_t)
 
@@ -79,6 +82,9 @@
 if (use_nfs_home_dirs) {
 create_dir_file($1_gpg_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+create_dir_file($1_gpg_t, cifs_t)
+}
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
 allow $1_gpg_t devtty_t:chr_file rw_file_perms;
@@ -111,6 +117,9 @@
 if (use_nfs_home_dirs) {
 dontaudit $1_gpg_helper_t nfs_t:file { read write };
 }
+if (use_samba_home_dirs) {
+dontaudit $1_gpg_helper_t cifs_t:file { read write };
+}
 
 # communicate with the user 
 allow $1_gpg_helper_t $1_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.21.2/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2005-01-20 15:55:23.722884000 -0500
+++ policy-1.21.2/macros/program/inetd_macros.te	2005-01-20 16:08:45.780569000 -0500
@@ -11,8 +11,17 @@
 type $1_t, domain, privlog, nscd_client_domain;
 role system_r types $1_t;
 
+#
+# Allows user to define a tunable to disable domain transition
+#
+bool $1_disable_trans false;
+if ($1_disable_trans) {
+can_exec(initrc_t, $1_exec_t)
+can_exec(sysadm_t, $1_exec_t)
+} else {
 domain_auto_trans(inetd_t, $1_exec_t, $1_t)
 allow inetd_t $1_t:process sigkill;
+}
 
 can_network_server($1_t)
 can_ypbind($1_t)
@@ -37,12 +46,15 @@
 allow $1_t var_t:dir search;
 var_run_domain($1)
 
+# Inherit and use descriptors from inetd.
+allow $1_t inetd_t:fd use;
+
 # for identd
 allow $1_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow $1_t self:capability { setuid setgid };
 allow $1_t home_root_t:dir search;
 allow $1_t self:dir search;
-allow $1_t self:file { getattr read };
+allow $1_t self:{ lnk_file file } { getattr read };
 can_kerberos($1_t)
 allow $1_t urandom_device_t:chr_file r_file_perms;
 type $1_port_t, port_type, reserved_port_type;
@@ -63,3 +75,25 @@
 ')
 r_dir_file($1_t, proc_net_t)
 ')
+define(`remote_login_daemon', `
+inetd_child_domain($1)
+
+# Execute /bin/login on a new PTY
+allow $1_t { bin_t sbin_t }:dir search;
+domain_auto_trans($1_t, login_exec_t, remote_login_t)
+can_create_pty($1, `, server_pty, userpty_type')
+allow $1_t self:capability { fsetid chown fowner sys_tty_config dac_override } ;
+
+# Append to /var/log/wtmp.
+allow $1_t var_log_t:dir search;
+allow $1_t wtmp_t:file rw_file_perms;
+allow $1_t initrc_var_run_t:file rw_file_perms;
+
+# Allow reading of /etc/issue.net
+allow $1_t etc_runtime_t:file r_file_perms;
+
+# Allow krb5 $1 to use fork and open /dev/tty for use
+allow $1_t userpty_type:chr_file setattr;
+allow $1_t devtty_t:chr_file rw_file_perms;
+dontaudit $1_t selinux_config_t:dir search;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.21.2/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2005-01-20 15:55:24.146460000 -0500
+++ policy-1.21.2/macros/program/lpr_macros.te	2005-01-20 16:08:45.789560000 -0500
@@ -81,6 +81,10 @@
 r_dir_file($1_lpr_t, nfs_t)
 }
 
+if (use_samba_home_dirs) {
+r_dir_file($1_lpr_t, cifs_t)
+}
+
 # Read and write shared files in the spool directory.
 allow $1_lpr_t print_spool_t:file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.2/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-01-20 15:55:24.252355000 -0500
+++ policy-1.21.2/macros/program/mozilla_macros.te	2005-01-20 16:08:45.798551000 -0500
@@ -25,7 +25,7 @@
 allow $1_mozilla_t $1_t:process signull;
 
 # Set resource limits and scheduling info.
-allow $1_mozilla_t self:process { setrlimit setsched };
+allow $1_mozilla_t self:process { execmem setrlimit setsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
@@ -40,6 +40,9 @@
 if (use_nfs_home_dirs) {
 create_dir_file($1_mozilla_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+create_dir_file($1_mozilla_t, cifs_t)
+}
 ifdef(`automount.te', `
 allow $1_mozilla_t autofs_t:dir { search getattr };
 ')dnl end if automount
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.21.2/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2005-01-20 15:55:24.638967000 -0500
+++ policy-1.21.2/macros/program/mta_macros.te	2005-01-20 16:08:45.807542000 -0500
@@ -99,8 +99,8 @@
 # Create dead.letter in user home directories.
 file_type_auto_trans($1_mail_t, $1_home_dir_t, $1_home_t, file)
 
-if (use_nfs_home_dirs) {
-rw_dir_create_file($1_mail_t, nfs_t)
+if (use_samba_home_dirs) {
+rw_dir_create_file($1_mail_t, cifs_t)
 }
 
 # if you do not want to allow dead.letter then use the following instead
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.21.2/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2005-01-20 15:55:25.202403000 -0500
+++ policy-1.21.2/macros/program/screen_macros.te	2005-01-20 16:08:45.816533000 -0500
@@ -43,6 +43,9 @@
 if (use_nfs_home_dirs) {
 domain_auto_trans($1_screen_t, nfs_t, $1_t)
 }
+if (use_samba_home_dirs) {
+domain_auto_trans($1_screen_t, cifs_t, $1_t)
+}
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_screen_t $1_gph_t:fd use;')
@@ -53,6 +56,9 @@
 if (use_nfs_home_dirs) {
 r_dir_file($1_screen_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+r_dir_file($1_screen_t, cifs_t)
+}
 
 allow $1_screen_t privfd:fd use;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.21.2/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2005-01-20 15:55:25.701903000 -0500
+++ policy-1.21.2/macros/program/ssh_agent_macros.te	2005-01-20 16:08:45.825524000 -0500
@@ -43,6 +43,9 @@
 ')
 rw_dir_create_file($1_ssh_agent_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+rw_dir_create_file($1_ssh_agent_t, cifs_t)
+}
 
 uses_shlib($1_ssh_agent_t)
 read_locale($1_ssh_agent_t)
@@ -73,6 +76,9 @@
 if (use_nfs_home_dirs) {
 domain_auto_trans($1_ssh_agent_t, nfs_t, $1_t)
 }
+if (use_samba_home_dirs) {
+domain_auto_trans($1_ssh_agent_t, cifs_t, $1_t)
+}
 allow $1_ssh_agent_t bin_t:dir search;
 
 # allow reading of /usr/bin/X11 (is a symlink)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.21.2/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-01-20 15:55:25.832772000 -0500
+++ policy-1.21.2/macros/program/ssh_macros.te	2005-01-20 16:08:45.834515000 -0500
@@ -30,6 +30,9 @@
 if (use_nfs_home_dirs) {
 create_dir_file($1_ssh_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+create_dir_file($1_ssh_t, cifs_t)
+}
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, ssh_exec_t, $1_ssh_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.21.2/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-01-20 15:55:25.974630000 -0500
+++ policy-1.21.2/macros/program/su_macros.te	2005-01-20 16:08:45.843506000 -0500
@@ -139,6 +139,9 @@
 if (use_nfs_home_dirs) {
 allow $1_su_t nfs_t:dir search;
 }
+if (use_samba_home_dirs) {
+allow $1_su_t cifs_t:dir search;
+}
 
 # Modify .Xauthority file (via xauth program).
 ifdef(`xauth.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.21.2/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2005-01-20 15:55:26.374230000 -0500
+++ policy-1.21.2/macros/program/xauth_macros.te	2005-01-20 16:08:45.852497000 -0500
@@ -86,6 +86,12 @@
 ')
 rw_dir_create_file($1_xauth_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+rw_dir_create_file($1_xauth_t, cifs_t)
+}
+if (use_samba_home_dirs) {
+rw_dir_create_file($1_xauth_t, cifs_t)
+}
 ')dnl end xauth_domain macro
 
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.21.2/Makefile
--- nsapolicy/Makefile	2005-01-20 15:55:00.136494000 -0500
+++ policy-1.21.2/Makefile	2005-01-20 16:08:45.859490000 -0500
@@ -53,7 +53,7 @@
 FCFILES=tmp/program_used_flags.te file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) file_contexts/distros.fc $(wildcard file_contexts/misc/*.fc)
 
 APPDIR=$(CONTEXTPATH)
-APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context removable_context dbus_contexts) $(CONTEXTPATH)/files/media
+APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context removable_context dbus_contexts customizable_types) $(CONTEXTPATH)/files/media
 
 $(USERPATH)/system.users: $(ALL_TUNABLES) $(USER_FILES) policy.conf
 	@mkdir -p $(USERPATH)
@@ -75,6 +75,7 @@
 tmp/valid_fc: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) $(USERPATH)/system.users $(USERPATH)/local.users
 	@echo "Validating file_contexts ..."	
 	$(SETFILES) -q -c $(LOADPATH) $(FCPATH)
+	@touch tmp/valid_fc
 
 install: tmp/valid_fc
 
@@ -90,6 +91,11 @@
 	mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
+$(APPDIR)/customizable_types: policy.conf
+	mkdir -p $(APPDIR)
+	@grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > tmp/customizable_types
+	install -m 644 tmp/customizable_types $@ 
+
 $(APPDIR)/default_type: appconfig/default_type
 	mkdir -p $(APPDIR)
 	install -m 644 $< $@
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/ftpd_selinux.8 policy-1.21.2/man/man8/ftpd_selinux.8
--- nsapolicy/man/man8/ftpd_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/ftpd_selinux.8	2005-01-20 16:08:45.868483000 -0500
@@ -0,0 +1,48 @@
+.TH  "ftpd_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "ftpd Selinux Policy documentation"
+.SH "NAME"
+ftpd_selinux \- Security Enhanced Linux Policy for the ftp daemon
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the ftpd server via flexible mandatory access
+control.  
+.SH FILE_CONTEXTS
+SELinux requires files to have an extended attributes to define the file type. 
+Policy governs the access daemons have to these files. 
+If you want to share files anonymously you must label the files and directories ftpd_anon_t.  So if you created a special directory /var/ftp, you 
+would need to label the directory with the chcon tool.
+.TP
+chcon -t ftpd_anon_t /var/ftp
+.TP
+If you want to make this permanant IE, survive a relabel you must add an entry to the file_contexts.local file.
+.TP
+/etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
+.br
+/var/ftp(/.*)? system_u:object_r:ftpd_anon_t
+
+.SH BOOLEANS
+SELinux ftp daemon policy is customizable based on least access required.  So by 
+default SElinux does not allow users to login and read their home directories.
+.br
+If you are setting up this machine as a ftpd server and wish to allow users to access their home
+directorories you need to set the ftp_home_dir boolean. 
+.TP
+setsebool -P ftp_home_dir 1
+.TP
+ftpd can run either as a standalone daemon or as part of the xinetd domain.  If you want to run ftpd as a daemon you must set the ftpd_is_daemon boolean.
+.TP
+setsebool -P ftpd_is_daemon 1
+.TP
+You can disable SELinux protection for the ftpd daemon by executing:
+.TP
+setsebool -P ftpd_disable_trans 1
+.br
+system vsftpd restart
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), ftpd(8), chcon(1), setsebool(8)
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/httpd_selinux.8 policy-1.21.2/man/man8/httpd_selinux.8
--- nsapolicy/man/man8/httpd_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/httpd_selinux.8	2005-01-20 16:08:45.875474000 -0500
@@ -0,0 +1,88 @@
+.TH  "httpd_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "httpd Selinux Policy documentation"
+.SH "NAME"
+httpd_selinux \- Security Enhanced Linux Policy for the httpd daemon
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the httpd server via flexible mandatory access
+control.  
+.SH FILE_CONTEXTS
+SELinux requires files to have an extended attributes to define the file type. 
+Policy governs the access daemons have to these files. 
+SELinux httpd policy is very flexible allowing users to setup their web services in as secure a method as possible.
+.TP 
+The following file contexts types are defined for httpd:
+.br
+
+httpd_sys_content_t 
+.br 
+- Set files with httpd_sys_content_t for content which is available from all httpd scripts and the daemon.
+.br
+
+httpd_sys_script_exec_t  
+.br 
+- Set cgi scripts with httpd_sys_script_exec_t to allow them to run with access to all sys types.
+.br
+
+httpd_sys_script_ro_t 
+.br
+- Set files with httpd_sys_script_ro_t if you want httpd_sys_script_exec_t scripts to read the data, and disallow other sys scripts from access.
+.br
+
+httpd_sys_script_rw_t 
+.br
+- Set files with httpd_sys_script_rw_t if you want httpd_sys_script_exec_t scripts to read/write the data, and disallow other non sys scripts from access.
+.br
+
+httpd_sys_script_ra_t 
+.br
+- Set files with httpd_sys_script_ra_t if you want httpd_sys_script_exec_t scripts to read/append to the file, and disallow other non sys scripts from access.
+.SH NOTE
+
+With certain policies you can define addional file contexts based off of roles like user or staff.  httpd_user_script_exec_t can be defined, where it would only have access to "user" contexts.
+
+.SH BOOLEANS
+SELinux policy is customizable based on least access required.  So by 
+default SElinux prevents certain http scripts from working.  httpd policy is extremely flexible and has several booleans that allow you to manipulate the policy and run httpd with the tightest access possible.
+.TP
+httpd can be setup to allow cgi scripts to be executed, set httpd_enable_cgi to allow this
+.br
+
+setsebool -P httpd_enable_cgi 1
+
+.TP
+httpd by default is not allowed to access users home directories.  If you want to allow access to users home directories you need to set the httpd_enable_homedirs boolean and change the context of the files that you want people to access off the home dir.
+.br
+
+setsebool -P httpd_enable_homedirs 1
+.br
+chcon -R -t httpd_sys_content_t ~user/public_html
+
+.TP
+httpd by default is not allowed access to the controling terminal.  In most cases this is prefered, because an intruder might be able to use the access to the terminal to gain priveledges. But in certain situations, httpd needs to prompt for a password to open a certificate file, terminal access is required.  Set the httpd_tty_comm boolean to allow terminal access.
+.br
+
+setsebool -P httpd_tty_comm 1
+
+.TP
+httpd can be configured to not differentiate file conteols based on context.  IE, all files labeled as httpd context can be read/write/execute.  Setting this context to false allows you to setup security policy such that one httpd service can not interfere with another.
+.br
+
+setsebool -P httpd_unified 0
+
+.TP
+You can disable SELinux protection for the httpd daemon by executing:
+.br
+
+setsebool -P httpd_disable_trans 1
+.br
+system httpd restart
+
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), httpd(8), chcon(1), setsebool(8)
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/kerberos_selinux.8 policy-1.21.2/man/man8/kerberos_selinux.8
--- nsapolicy/man/man8/kerberos_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/kerberos_selinux.8	2005-01-20 16:08:46.168181000 -0500
@@ -0,0 +1,31 @@
+.TH  "kerberos_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "kerberos Selinux Policy documentation"
+.SH "NAME"
+kerberos_selinux \- Security Enhanced Linux Policy for Kerberos.
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the system via flexible mandatory access
+control. By default Kerberos access is not allowed, since it requires daemons to be allowed greater access to certain secure files and addtional access to the network.  
+.SH BOOLEANS
+.TP
+You must set the allow_kerberos boolean to allow your system to work properly in a Kerberos environment.
+.TP
+setsebool -P allow_kerberos 1
+.TP 
+If you are running Kerberos daemons kadmind or krb5kdc you can disable the SELinux protection on these daemons by setting the krb5kdc_disable_trans and kadmind_disable_trans booleans.
+.br
+
+setsebool -P krb5kdc_disable_trans 1
+.br
+system krb5kdc restart
+.br
+setsebool -P kadmind_disable_trans booleans 1
+.br
+system kadmind restart
+
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), kerberos(1), chcon(1), setsebool(8)
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/named_selinux.8 policy-1.21.2/man/man8/named_selinux.8
--- nsapolicy/man/man8/named_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/named_selinux.8	2005-01-20 16:08:46.177174000 -0500
@@ -0,0 +1,29 @@
+.TH  "named_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "named Selinux Policy documentation"
+.SH "NAME"
+named_selinux \- Security Enhanced Linux Policy for the Internet Name server (named) daemon
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the named server via flexible mandatory access
+control.  
+.SH BOOLEANS
+SELinux policy is customizable based on least access required.  So by 
+default SElinux policy does not allow named to write master zone files.  If you want to have this named update the master zone files you need to set the named_write_master_zones boolean.
+.TP
+.br
+setsebool -P named_write_master_zones 1
+
+.TP
+You can disable SELinux protection for the named daemon by executing:
+.TP
+setsebool -P named_disable_trans 1
+.br
+system named restart
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), named(8), chcon(1), setsebool(8)
+
+
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/nfs_selinux.8 policy-1.21.2/man/man8/nfs_selinux.8
--- nsapolicy/man/man8/nfs_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/nfs_selinux.8	2005-01-20 16:08:46.187162000 -0500
@@ -0,0 +1,30 @@
+.TH  "nfs_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "nfs Selinux Policy documentation"
+.SH "NAME"
+nfs_selinux \- Security Enhanced Linux Policy for NFS
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the nfs server via flexible mandatory access
+control.  
+.SH BOOLEANS
+SELinux policy is customizable based on least access required.  So by 
+default SElinux policy does not allow nfs to share files.  If you want to 
+setup this machine to share nfs partitions read only you must set the boolean nfs_export_all_ro boolean.
+
+.TP
+setsebool -P nfs_export_all_ro 1
+.TP
+If you want to share files read/write you must set the nfs_export_all_rw boolean.
+.TP
+setsebool -P nfs_export_all_rw 1
+
+.TP
+If you want to use a remote NFS server for the home directories on this machine you must set the use_nfs_home_dir boolean.
+.TP
+setsebool -P use_nfs_home_dirs 1
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSpppO"
+selinux(8), chcon(1), setsebool(8)
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/nis_selinux.8 policy-1.21.2/man/man8/nis_selinux.8
--- nsapolicy/man/man8/nis_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/nis_selinux.8	2005-01-20 16:08:46.198151000 -0500
@@ -0,0 +1 @@
+.so man8/ypbind_selinux.8
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/rsync_selinux.8 policy-1.21.2/man/man8/rsync_selinux.8
--- nsapolicy/man/man8/rsync_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/rsync_selinux.8	2005-01-20 16:08:46.207143000 -0500
@@ -0,0 +1,35 @@
+.TH  "rsync_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "rsync Selinux Policy documentation"
+.SH "NAME"
+rsync_selinux \- Security Enhanced Linux Policy for the rsync daemon
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the rsync server via flexible mandatory access
+control.  
+.SH FILE_CONTEXTS
+SELinux requires files to have an extended attributes to define the file type. 
+Policy governs the access daemons have to these files. 
+If you want to share files using the rsync daemon you must label the files and directories ftpd_anon_t.  So if you created a special directory /var/rsync, you 
+would need to label the directory with the chcon tool.
+.TP
+chcon -t ftpd_anon_t /var/rsync
+.TP
+If you want to make this permanant IE, survive a relabel you must add an entry to the file_contexts.local file.
+.TP
+/etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
+.br
+/var/rsync(/.*)? system_u:object_r:ftpd_anon_t
+
+.SH BOOLEANS
+.TP
+You can disable SELinux protection for the rsync daemon by executing:
+.TP
+setsebool -P rsync_disable_trans 1
+.br
+system xinetd restart
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), rsync(1), chcon(1), setsebool(8)
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/samba_selinux.8 policy-1.21.2/man/man8/samba_selinux.8
--- nsapolicy/man/man8/samba_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/samba_selinux.8	2005-01-20 16:08:46.217132000 -0500
@@ -0,0 +1,51 @@
+.TH  "samba_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "Samba Selinux Policy documentation"
+.SH "NAME"
+samba_selinux \- Security Enhanced Linux Policy for Samba
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the Samba server via flexible mandatory access
+control.  
+.SH FILE_CONTEXTS
+SELinux requires files to have an extended attributes to define the file type. 
+Policy governs the access daemons have to these files. 
+If you want to share files other than home directories, those files must be 
+labeled samba_share_t.  So if you created a special directory /var/eng, you 
+would need to label the directory with the chcon tool.
+.TP
+chcon -t samba_share_t /var/eng
+.TP
+If you want to make this permanant IE, survive a relabel you must add an entry to the file_contexts.local file.
+.TP
+/etc/selinux/POLICYTYPE/contexts/files/file_contexts.local
+.br
+/var/eng(/.*)? system_u:object_r:samba_share_t
+
+.SH BOOLEANS
+.br 
+SELinux policy is customizable based on least access required.  So by 
+default SElinux policy turns off SELinux sharing of Home directories and 
+the use of Samba shares from a remote machine as a home directory.
+.TP
+If you are setting up this machine as a Samba server and wish to share the homedirectories you need to set the samba_enable_home_dirs boolean. 
+.br
+
+setsebool -P samba_enable_home_dirs 1
+.TP
+If you want to use a remote Samba server for the home directories on this machine you must set the use_samba_home_dirs boolean.
+.br 
+
+setsebool -P use_samba_home_dirs 1
+.TP
+You can disable SELinux protection for the samba daemon by executing:
+.br 
+
+setsebool -P smbd_disable_trans 1
+.br
+system smb restart
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), samba(7), chcon(1), setsebool(8)
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/ypbind_selinux.8 policy-1.21.2/man/man8/ypbind_selinux.8
--- nsapolicy/man/man8/ypbind_selinux.8	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.2/man/man8/ypbind_selinux.8	2005-01-20 16:08:46.226123000 -0500
@@ -0,0 +1,19 @@
+.TH  "ypbind_selinux"  "8"  "17 Jan 2005" "dwalsh@redhat.com" "ypbind Selinux Policy documentation"
+.SH "NAME"
+ypbind_selinux \- Security Enhanced Linux Policy for NIS.
+.SH "DESCRIPTION"
+
+Security-Enhanced Linux secures the system via flexible mandatory access
+control. By default NIS is not allowed, since it requires daemons to be allowed greater access to the network.  
+.SH BOOLEANS
+.TP
+You must set the allow_ypbind boolean to allow your system to work properly in a NIS environment.
+.TP
+setsebool -P allow_ypbind 1
+.TP
+system-config-securitylevel is a GUI tool available to customize SELinux policy settings.
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+
+.SH "SEE ALSO"
+selinux(8), ypbind(8), chcon(1), setsebool(8)
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.21.2/net_contexts
--- nsapolicy/net_contexts	2005-01-20 15:55:00.429201000 -0500
+++ policy-1.21.2/net_contexts	2005-01-20 16:08:46.232117000 -0500
@@ -43,7 +43,7 @@
 portcon tcp 21 system_u:object_r:ftp_port_t
 ')
 ifdef(`ssh.te', `portcon tcp 22 system_u:object_r:ssh_port_t')
-ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnet_port_t')
+ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnetd_port_t')
 ifdef(`mta.te', `
 portcon tcp 25 system_u:object_r:smtp_port_t
 portcon tcp 465 system_u:object_r:smtp_port_t
@@ -99,7 +99,7 @@
 portcon tcp 636 system_u:object_r:ldap_port_t
 portcon udp 636 system_u:object_r:ldap_port_t
 ')
-ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogin_port_t')
+ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogind_port_t')
 ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
 ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
 ifdef(`syslogd.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/appconfig/default_contexts policy-1.21.2/targeted/appconfig/default_contexts
--- nsapolicy/targeted/appconfig/default_contexts	2005-01-20 15:55:26.929674000 -0500
+++ policy-1.21.2/targeted/appconfig/default_contexts	2005-01-20 17:32:56.376510000 -0500
@@ -1,2 +1,4 @@
 system_r:unconfined_t	system_r:unconfined_t
 system_r:initrc_t	system_r:unconfined_t
+system_r:remote_login_t system_r:unconfined_t
+system_r:rshd_t		system_r:unconfined_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/crond.te policy-1.21.2/targeted/domains/program/crond.te
--- nsapolicy/targeted/domains/program/crond.te	2005-01-11 16:01:53.000000000 -0500
+++ policy-1.21.2/targeted/domains/program/crond.te	2005-01-20 17:26:26.199077000 -0500
@@ -11,6 +11,8 @@
 # This domain is defined just for targeted policy.
 #
 type crond_exec_t, file_type, sysadmfile, exec_type;
+type crond_t, domain;
+type system_crond_t, domain;
 type anacron_exec_t, file_type, sysadmfile, exec_type;
 type system_crond_tmp_t, file_type, sysadmfile;
 type system_cron_spool_t, file_type, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.21.2/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-01-20 15:55:27.234369000 -0500
+++ policy-1.21.2/targeted/domains/unconfined.te	2005-01-20 17:26:10.412879000 -0500
@@ -4,7 +4,7 @@
 # is not explicitly confined.  It has no restrictions.
 # It needs to be carefully protected from the confined domains.
 
-type unconfined_t, domain, privuser, privrole, privowner, admin, auth_write, fs_domain, privmem, unrestricted;
+type unconfined_t, domain, privuser, privhome, privrole, privowner, admin, auth_write, fs_domain, privmem;
 role system_r types unconfined_t;
 role user_r types unconfined_t;
 role sysadm_r types unconfined_t;
@@ -13,17 +13,17 @@
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
 typealias bin_t alias su_exec_t;
-typealias unconfined_t alias { crond_t kernel_t logrotate_t sendmail_t sshd_t sysadm_t system_crond_t rpm_t rpm_script_t xdm_t };
+typealias unconfined_t alias { kernel_t logrotate_t sendmail_t sshd_t sysadm_t rpm_t rpm_script_t xdm_t };
 define(`admin_tty_type', `{ tty_device_t devpts_t }')
 
 #type of rundir to communicate with dbus
 type system_dbusd_var_run_t, file_type, sysadmfile;
 
 # User home directory type.
-type user_home_t, file_type, sysadmfile;
-type user_home_dir_t, file_type, sysadmfile;
+type user_home_t, file_type, sysadmfile, home_type;
+type user_home_dir_t, file_type, sysadmfile, home_dir_type;
 file_type_auto_trans(unconfined_t, home_root_t, user_home_dir_t, dir)
-file_type_auto_trans(unconfined_t, user_home_dir_t, user_home_t)
+file_type_auto_trans(privhome, user_home_dir_t, user_home_t)
 
 define(`user_typealias', `
 ifelse($1,`user',`',`
@@ -43,10 +43,14 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Support SAMBA home directories
+bool use_samba_home_dirs false;
+
 # Allow system to run with NIS
 bool allow_ypbind false;
 
 # Allow system to run with Kerberos
 bool allow_kerberos false;
 
-
+# allow reading of default file context
+bool read_default_t true;
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/types/apache.te policy-1.21.2/targeted/types/apache.te
--- nsapolicy/targeted/types/apache.te	2004-05-27 14:52:37.000000000 -0400
+++ policy-1.21.2/targeted/types/apache.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,5 +0,0 @@
-#
-# Rules required by apache for targeted policy
-#
-define(`admin_tty_type', `{ tty_device_t devpts_t }')
-
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.2/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.21.2/tunables/distro.tun	2005-01-20 16:08:46.262088000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.2/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-01-20 15:55:28.092510000 -0500
+++ policy-1.21.2/tunables/tunable.tun	2005-01-20 16:08:46.269082000 -0500
@@ -1,27 +1,24 @@
-# Allow users to execute the mount command
-dnl define(`user_can_mount')
-
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------040400000400060505060000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
