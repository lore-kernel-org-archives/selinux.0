Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CIrRIi018003
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:53:27 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CIpV8I011673
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:51:31 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id j0CItcR2012372
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:55:38 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id j0CItcOV012371
	for selinux@tycho.nsa.gov; Wed, 12 Jan 2005 13:55:38 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CIkhIi017908
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:46:43 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CIij8I011126
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 18:44:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j0CIkWW5011588
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:46:45 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j0CIkRr21437
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:46:27 -0500
Received: from [172.16.83.126] (vpn83-126.boston.redhat.com [172.16.83.126])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j0CIkNQd016637
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 13:46:23 -0500
Message-ID: <41E57081.4090500@redhat.com>
Date: Wed, 12 Jan 2005 13:46:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: New policy patch]
Content-Type: multipart/mixed;
 boundary="------------020400060605030305050005"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020400060605030305050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020400060605030305050005
Content-Type: message/rfc822;
 name="New policy patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="New policy patch"

Message-ID: <41E545EC.4050508@redhat.com>
Date: Wed, 12 Jan 2005 10:44:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: SELinux internal list <rhselinux-project@redhat.com>,
 Stephen Smalley <sds@epoch.ncsc.mil>,
 Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: New policy patch
Content-Type: multipart/mixed;
 boundary="------------030506090400050106040604"

This is a multi-part message in MIME format.
--------------030506090400050106040604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    Add customizable types.

    Add samba_home_dir support.

    Fix postgresql to run on ypbind platform

    Begin adding support for NFSV4 with Kerberos keys

    Add execmod to users for ld_so_t

    add execmem for mozilla

    Add unrestricted attribute to indicate domains using unconfined_t. 

    Also began using typeattribute. 



--------------030506090400050106040604
Content-Type: text/x-patch;
 name="policy-20050112.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20050112.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.21.1/attrib.te
--- nsapolicy/attrib.te	2004-12-21 10:59:56.000000000 -0500
+++ policy-1.21.1/attrib.te	2005-01-12 09:19:59.141059592 -0500
@@ -393,3 +393,8 @@
 # For labeling of domains whos transition can be disabled
 attribute transitionbool;
 
+# For labeling of file_context domains which users can change files to rather
+# then the default file context.  These file_context can survive a relabeling
+# of the file system.
+attribute customizable;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.21.1/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-01-12 08:14:47.039693689 -0500
+++ policy-1.21.1/domains/program/initrc.te	2005-01-12 09:18:27.139390056 -0500
@@ -12,7 +12,7 @@
 # initrc_exec_t is the type of the init program.
 #
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', `', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, nscd_client_domain;
 
 role system_r types initrc_t;
 uses_shlib(initrc_t);
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/init.te policy-1.21.1/domains/program/init.te
--- nsapolicy/domains/program/init.te	2005-01-12 08:14:47.017696186 -0500
+++ policy-1.21.1/domains/program/init.te	2005-01-12 09:18:27.140389944 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.21.1/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2005-01-12 08:14:47.055691874 -0500
+++ policy-1.21.1/domains/program/ldconfig.te	2005-01-12 09:18:27.140389944 -0500
@@ -8,7 +8,7 @@
 #
 # Rules for the ldconfig_t domain.
 #
-type ldconfig_t, domain, privlog, etc_writer ifdef(`targeted_policy', `, unrestricted' );
+type ldconfig_t, domain, privlog, etc_writer;
 type ldconfig_exec_t, file_type, sysadmfile, exec_type;
 
 role sysadm_r types ldconfig_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/login.te policy-1.21.1/domains/program/login.te
--- nsapolicy/domains/program/login.te	2004-12-11 06:31:18.000000000 -0500
+++ policy-1.21.1/domains/program/login.te	2005-01-12 09:18:27.141389832 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.21.1/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2005-01-12 08:14:47.086688356 -0500
+++ policy-1.21.1/domains/program/modutil.te	2005-01-12 09:18:27.142389719 -0500
@@ -69,7 +69,7 @@
 # Rules for the insmod_t domain.
 #
 
-type insmod_t, domain, privlog, sysctl_kernel_writer, privmem ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule, unrestricted' )
+type insmod_t, domain, privlog, sysctl_kernel_writer, privmem ifdef(`unlimitedUtils', `, admin, etc_writer, fs_domain, auth_write, privowner, privmodule' )
 ;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.21.1/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-01-12 08:14:47.150681092 -0500
+++ policy-1.21.1/domains/program/ssh.te	2005-01-12 09:18:27.143389607 -0500
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unconfined.te policy-1.21.1/domains/program/unconfined.te
--- nsapolicy/domains/program/unconfined.te	2004-08-24 15:35:26.000000000 -0400
+++ policy-1.21.1/domains/program/unconfined.te	2005-01-12 09:18:27.144389495 -0500
@@ -6,7 +6,7 @@
 # chcon -t unconfined_exec_t /usr/local/bin/appsrv
 # Or alternatively add it to /etc/security/selinux/src/policy/file_contexts/program/unconfined.fc
 
-type unconfined_t, domain, privlog, admin, privmem, fs_domain, auth_write, unrestricted;
+type unconfined_t, domain, privlog, admin, privmem, fs_domain, auth_write;
 type unconfined_exec_t, file_type, sysadmfile, exec_type;
 role sysadm_r types unconfined_t;
 domain_auto_trans(sysadm_t, unconfined_exec_t, unconfined_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/anaconda.te policy-1.21.1/domains/program/unused/anaconda.te
--- nsapolicy/domains/program/unused/anaconda.te	2004-12-09 10:26:08.000000000 -0500
+++ policy-1.21.1/domains/program/unused/anaconda.te	2005-01-12 09:18:27.144389495 -0500
@@ -10,7 +10,7 @@
 #
 # anaconda_t is the domain of the installation program
 #
-type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted;
+type anaconda_t, admin, etc_writer, fs_domain, privmem, auth_write, domain, privlog, privowner, privmodule, sysctl_kernel_writer;
 role system_r types anaconda_t;
 unconfined_domain(anaconda_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.1/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-01-12 08:14:47.372655899 -0500
+++ policy-1.21.1/domains/program/unused/apache.te	2005-01-12 09:18:27.145389382 -0500
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.21.1/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-01-12 08:14:47.490642507 -0500
+++ policy-1.21.1/domains/program/unused/cups.te	2005-01-12 09:18:27.146389270 -0500
@@ -248,3 +248,6 @@
 allow cupsd_t initrc_t:dbus send_msg;
 ')
 
+ifdef(`targeted_policy', `
+allow cupsd_t unconfined_t:dbus send_msg;
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.21.1/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.21.1/domains/program/unused/firstboot.te	2005-01-12 09:18:27.147389158 -0500
@@ -10,7 +10,7 @@
 #
 # firstboot_exec_t is the type of the firstboot executable.
 #
-application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer, unrestricted')
+application_domain(firstboot,`, admin, etc_writer, fs_domain, privmem, auth_write, privlog, privowner, privmodule, sysctl_kernel_writer')
 type firstboot_rw_t, file_type, sysadmfile;
 role system_r types firstboot_t;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.21.1/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-01-05 14:37:26.000000000 -0500
+++ policy-1.21.1/domains/program/unused/ftpd.te	2005-01-12 09:18:27.148389046 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.21.1/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-12-09 10:26:09.000000000 -0500
+++ policy-1.21.1/domains/program/unused/hotplug.te	2005-01-12 09:18:27.149388933 -0500
@@ -11,7 +11,7 @@
 # hotplug_exec_t is the type of the hotplug executable.
 #
 ifdef(`unlimitedUtils', `
-daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer, unrestricted')
+daemon_domain(hotplug, `, admin, etc_writer, fs_domain, privmem, auth_write, privowner, privmodule, domain, privlog, sysctl_kernel_writer')
 ', `
 daemon_domain(hotplug, `, privmodule')
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.21.1/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2005-01-12 08:14:47.700618675 -0500
+++ policy-1.21.1/domains/program/unused/inetd.te	2005-01-12 09:18:27.150388821 -0500
@@ -18,7 +18,7 @@
 # Rules for the inetd_t domain.
 #
 
-daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem, unrestricted')' )
+daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
 can_network(inetd_t)
 allow inetd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.21.1/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.21.1/domains/program/unused/pamconsole.te	2005-01-12 09:18:27.150388821 -0500
@@ -41,3 +41,4 @@
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
 allow initrc_t pam_var_console_t:dir r_dir_perms;
+allow pam_console_t file_context_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.21.1/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2005-01-12 08:14:47.980586899 -0500
+++ policy-1.21.1/domains/program/unused/postgresql.te	2005-01-12 09:18:27.151388709 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.21.1/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-12-09 10:26:09.000000000 -0500
+++ policy-1.21.1/domains/program/unused/rpcd.te	2005-01-12 09:18:27.152388597 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.21.1/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2005-01-12 08:14:48.024581906 -0500
+++ policy-1.21.1/domains/program/unused/rpm.te	2005-01-12 09:18:27.153388484 -0500
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.1/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.21.1/domains/program/unused/samba.te	2005-01-12 09:18:27.154388372 -0500
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
 
@@ -73,8 +73,7 @@
 allow smbd_t usr_t:file { getattr read };
 
 # Access Samba shares.
-allow smbd_t samba_share_t:dir create_dir_perms;
-allow smbd_t samba_share_t:file create_file_perms;
+create_dir_file(smbd_t, samba_share_t)
 
 ifdef(`logrotate.te', `
 # the application should be changed
@@ -117,3 +116,14 @@
 ')
 # Needed for winbindd
 allow smbd_t { samba_var_t smbd_var_run_t }:sock_file create_file_perms;
+
+# Support Samba sharing of home directories
+bool samba_enable_home_dirs false;
+
+if ( samba_enable_home_dirs ) {
+allow smbd_t home_root_t:dir { getattr search };
+allow smbd_t home_dir_type:dir { getattr search };
+allow smbd_t home_type:dir create_dir_perms;
+dontaudit smbd_t home_type:{ sock_file fifo_file chr_file blk_file } r_file_perms;
+}
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/spamd.te policy-1.21.1/domains/program/unused/spamd.te
--- nsapolicy/domains/program/unused/spamd.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.21.1/domains/program/unused/spamd.te	2005-01-12 09:18:27.155388260 -0500
@@ -64,5 +64,10 @@
 allow spamd_t nfs_t:file create_file_perms;
 }
 
+if (use_samba_home_dirs) {
+allow spamd_t cifs_t:dir rw_dir_perms;
+allow spamd_t cifs_t:file create_file_perms;
+}
+
 allow spamd_t home_root_t:dir getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.21.1/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-01-05 14:37:26.000000000 -0500
+++ policy-1.21.1/domains/program/unused/xdm.te	2005-01-12 09:18:27.156388147 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.21.1/domains/user.te
--- nsapolicy/domains/user.te	2004-12-21 10:59:57.000000000 -0500
+++ policy-1.21.1/domains/user.te	2005-01-12 09:18:27.156388147 -0500
@@ -10,6 +10,9 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Support SAMBA home directories
+bool use_samba_home_dirs false;
+
 # Allow users to run TCP servers (bind to ports and accept connection from
 # the same domain and outside users)  disabling this forces FTP passive mode
 # and may change other protocols 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/innd.fc policy-1.21.1/file_contexts/program/innd.fc
--- nsapolicy/file_contexts/program/innd.fc	2004-11-19 11:20:43.000000000 -0500
+++ policy-1.21.1/file_contexts/program/innd.fc	2005-01-12 09:18:27.157388035 -0500
@@ -1,5 +1,7 @@
 # innd
 /usr/sbin/innd.*	--	system_u:object_r:innd_exec_t
+/usr/bin/rpost          --      system_u:object_r:innd_exec_t
+/usr/bin/suck           --      system_u:object_r:innd_exec_t
 /var/run/innd(/.*)?		system_u:object_r:innd_var_run_t
 /etc/news(/.*)?			system_u:object_r:innd_etc_t
 /etc/news/boot		--	system_u:object_r:innd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mysqld.fc policy-1.21.1/file_contexts/program/mysqld.fc
--- nsapolicy/file_contexts/program/mysqld.fc	2004-11-19 11:20:44.000000000 -0500
+++ policy-1.21.1/file_contexts/program/mysqld.fc	2005-01-12 09:18:27.158387923 -0500
@@ -1,5 +1,5 @@
 # mysql database server
-/usr/sbin/mysqld	--	system_u:object_r:mysqld_exec_t
+/usr/sbin/mysqld(-max)?	--	system_u:object_r:mysqld_exec_t
 /usr/libexec/mysqld	--	system_u:object_r:mysqld_exec_t
 /var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
 /var/log/mysql.*	--	system_u:object_r:mysqld_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postgresql.fc policy-1.21.1/file_contexts/program/postgresql.fc
--- nsapolicy/file_contexts/program/postgresql.fc	2005-01-12 08:14:48.738500877 -0500
+++ policy-1.21.1/file_contexts/program/postgresql.fc	2005-01-12 09:18:27.159387811 -0500
@@ -13,8 +13,8 @@
 /usr/bin/pg_id		--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_restore	--	system_u:object_r:postgresql_exec_t
 
-/var/lib/postgres(ql)?(/.*)? system_u:object_r:postgresql_db_t
-/var/lib/pgsql(/.*)?		system_u:object_r:postgresql_db_t
+/var/lib/postgres(ql)?(/.*)? 	system_u:object_r:postgresql_db_t
+/var/lib/pgsql/data(/.*)?	system_u:object_r:postgresql_db_t
 /var/run/postgresql(/.*)?	system_u:object_r:postgresql_var_run_t
 /etc/postgresql(/.*)?		system_u:object_r:postgresql_etc_t
 /var/log/postgres\.log.* --	system_u:object_r:postgresql_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rpcd.fc policy-1.21.1/file_contexts/program/rpcd.fc
--- nsapolicy/file_contexts/program/rpcd.fc	2004-11-19 11:20:44.000000000 -0500
+++ policy-1.21.1/file_contexts/program/rpcd.fc	2005-01-12 09:18:27.159387811 -0500
@@ -3,6 +3,8 @@
 /usr/sbin/rpc\..*	--	system_u:object_r:rpcd_exec_t
 /usr/sbin/rpc\.nfsd	--	system_u:object_r:nfsd_exec_t
 /usr/sbin/exportfs	--	system_u:object_r:nfsd_exec_t
+/usr/sbin/rpc\.gssd	--	system_u:object_r:gssd_exec_t
+/usr/sbin/rpc\.svcgssd	--	system_u:object_r:gssd_exec_t
 /usr/sbin/rpc\.mountd	--	system_u:object_r:nfsd_exec_t
 /var/run/rpc\.statd\.pid	--	system_u:object_r:rpcd_var_run_t
 /var/run/rpc\.statd(/.*)?	system_u:object_r:rpcd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.21.1/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2005-01-12 08:14:48.813492366 -0500
+++ policy-1.21.1/file_contexts/program/udev.fc	2005-01-12 09:18:27.204382758 -0500
@@ -8,5 +8,5 @@
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
 /etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
-/dev/\.udev\.tdb	--	system_u:object_r:udev_tdb_t
+/dev/\.udev\.tdb/.*	--	system_u:object_r:udev_tdb_t
 /sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.1/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-12-09 10:26:10.000000000 -0500
+++ policy-1.21.1/macros/base_user_macros.te	2005-01-12 09:18:27.205382646 -0500
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
@@ -167,6 +178,7 @@
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
+ifdef(`samba.te', `samba_domain($1)')
 ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.1/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-01-12 08:14:48.985472846 -0500
+++ policy-1.21.1/macros/global_macros.te	2005-01-12 09:18:27.206382534 -0500
@@ -504,6 +504,8 @@
 #
 define(`unconfined_domain', `
 
+typeattribute $1 unrestricted;
+
 # Mount/unmount any filesystem. 
 allow $1 fs_type:filesystem *;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.21.1/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-01-12 08:14:49.097460136 -0500
+++ policy-1.21.1/macros/program/apache_macros.te	2005-01-12 09:18:27.207382421 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.21.1/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2004-12-21 10:59:58.000000000 -0500
+++ policy-1.21.1/macros/program/cdrecord_macros.te	2005-01-12 09:18:27.208382309 -0500
@@ -35,6 +35,9 @@
 if (use_nfs_home_dirs) {
 r_dir_file($1_cdrecord_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+r_dir_file($1_cdrecord_t, cifs_t)
+}
 allow $1_cdrecord_t etc_t:file { getattr read };
 
 # allow searching for cdrom-drive
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_agent_macros.te policy-1.21.1/macros/program/gpg_agent_macros.te
--- nsapolicy/macros/program/gpg_agent_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.21.1/macros/program/gpg_agent_macros.te	2005-01-12 09:18:27.209382197 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.21.1/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2004-12-16 11:38:03.000000000 -0500
+++ policy-1.21.1/macros/program/gpg_macros.te	2005-01-12 09:18:27.210382085 -0500
@@ -79,6 +79,9 @@
 if (use_nfs_home_dirs) {
 create_dir_file($1_gpg_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+create_dir_file($1_gpg_t, cifs_t)
+}
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
 allow $1_gpg_t devtty_t:chr_file rw_file_perms;
@@ -111,6 +114,9 @@
 if (use_nfs_home_dirs) {
 dontaudit $1_gpg_helper_t nfs_t:file { read write };
 }
+if (use_samba_home_dirs) {
+dontaudit $1_gpg_helper_t cifs_t:file { read write };
+}
 
 # communicate with the user 
 allow $1_gpg_helper_t $1_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.21.1/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.21.1/macros/program/lpr_macros.te	2005-01-12 09:18:27.210382085 -0500
@@ -81,6 +81,10 @@
 r_dir_file($1_lpr_t, nfs_t)
 }
 
+if (use_samba_home_dirs) {
+r_dir_file($1_lpr_t, cifs_t)
+}
+
 # Read and write shared files in the spool directory.
 allow $1_lpr_t print_spool_t:file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.1/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-12-21 10:59:59.000000000 -0500
+++ policy-1.21.1/macros/program/mozilla_macros.te	2005-01-12 09:18:27.211381972 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.21.1/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.21.1/macros/program/mta_macros.te	2005-01-12 09:18:27.212381860 -0500
@@ -99,8 +99,8 @@
 # Create dead.letter in user home directories.
 file_type_auto_trans($1_mail_t, $1_home_dir_t, $1_home_t, file)
 
-if (use_nfs_home_dirs) {
-rw_dir_create_file($1_mail_t, nfs_t)
+if (use_samba_home_dirs) {
+rw_dir_create_file($1_mail_t, cifs_t)
 }
 
 # if you do not want to allow dead.letter then use the following instead
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/samba_macros.te policy-1.21.1/macros/program/samba_macros.te
--- nsapolicy/macros/program/samba_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.1/macros/program/samba_macros.te	2005-01-12 09:18:27.213381748 -0500
@@ -0,0 +1,28 @@
+#
+# Macros for samba domains.
+#
+
+#
+# Authors:  Dan Walsh <dwalsh@redhat.com>
+#
+
+# 
+# samba_domain(domain_prefix)
+#
+# Define a derived domain for the samba program when executed
+# by a user domain.
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/samba.te. 
+#
+undefine(`samba_domain')
+ifdef(`samba.te', `
+define(`samba_domain',`
+if ( samba_enable_home_dirs ) {
+file_type_auto_trans(smbd_t, $1_home_dir_t, $1_home_t)
+}
+')
+', `
+define(`samba_domain',`')
+
+')dnl end if samba.te
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.21.1/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2005-01-05 14:37:27.000000000 -0500
+++ policy-1.21.1/macros/program/screen_macros.te	2005-01-12 09:18:27.214381636 -0500
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
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.21.1/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.21.1/macros/program/ssh_agent_macros.te	2005-01-12 09:18:27.215381523 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.21.1/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.21.1/macros/program/ssh_macros.te	2005-01-12 09:18:27.216381411 -0500
@@ -30,6 +30,9 @@
 if (use_nfs_home_dirs) {
 create_dir_file($1_ssh_t, nfs_t)
 }
+if (use_samba_home_dirs) {
+create_dir_file($1_ssh_t, cifs_t)
+}
 
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, ssh_exec_t, $1_ssh_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.21.1/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.21.1/macros/program/su_macros.te	2005-01-12 09:18:27.216381411 -0500
@@ -139,6 +139,9 @@
 if (use_nfs_home_dirs) {
 allow $1_su_t nfs_t:dir search;
 }
+if (use_samba_home_dirs) {
+allow $1_su_t cifs_t:dir search;
+}
 
 # Modify .Xauthority file (via xauth program).
 ifdef(`xauth.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.21.1/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.21.1/macros/program/xauth_macros.te	2005-01-12 09:18:27.217381299 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.21.1/Makefile
--- nsapolicy/Makefile	2005-01-12 08:14:46.613742034 -0500
+++ policy-1.21.1/Makefile	2005-01-12 09:18:27.218381186 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.21.1/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-01-12 08:14:49.606402372 -0500
+++ policy-1.21.1/targeted/domains/unconfined.te	2005-01-12 09:18:27.219381074 -0500
@@ -4,7 +4,7 @@
 # is not explicitly confined.  It has no restrictions.
 # It needs to be carefully protected from the confined domains.
 
-type unconfined_t, domain, privuser, privrole, privowner, admin, auth_write, fs_domain, privmem, unrestricted;
+type unconfined_t, domain, privuser, privrole, privowner, admin, auth_write, fs_domain, privmem;
 role system_r types unconfined_t;
 role user_r types unconfined_t;
 role sysadm_r types unconfined_t;
@@ -20,8 +20,8 @@
 type system_dbusd_var_run_t, file_type, sysadmfile;
 
 # User home directory type.
-type user_home_t, file_type, sysadmfile;
-type user_home_dir_t, file_type, sysadmfile;
+type user_home_t, file_type, sysadmfile, home_type;
+type user_home_dir_t, file_type, sysadmfile, home_dir_type;
 file_type_auto_trans(unconfined_t, home_root_t, user_home_dir_t, dir)
 file_type_auto_trans(unconfined_t, user_home_dir_t, user_home_t)
 
@@ -43,6 +43,11 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Support SAMBA home directories
+bool use_samba_home_dirs false;
+
+ifdef(`samba.te', `samba_domain(user)')
+
 # Allow system to run with NIS
 bool allow_ypbind false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/types/apache.te policy-1.21.1/targeted/types/apache.te
--- nsapolicy/targeted/types/apache.te	2004-05-27 14:52:37.000000000 -0400
+++ policy-1.21.1/targeted/types/apache.te	1969-12-31 19:00:00.000000000 -0500
@@ -1,5 +0,0 @@
-#
-# Rules required by apache for targeted policy
-#
-define(`admin_tty_type', `{ tty_device_t devpts_t }')
-
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.1/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.21.1/tunables/distro.tun	2005-01-12 09:18:27.220380962 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.1/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-12-11 06:31:22.000000000 -0500
+++ policy-1.21.1/tunables/tunable.tun	2005-01-12 09:18:27.221380850 -0500
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

--------------030506090400050106040604--


--------------020400060605030305050005--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
