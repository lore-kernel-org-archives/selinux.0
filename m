Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M05q7C012934
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 20:05:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3LNvxVU005608
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2005 23:58:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: New policy for DCC
Date: Fri, 22 Apr 2005 00:54:18 +1000
Cc: David Hampton <hampton-rh@rainbolthampton.net>, selinux@tycho.nsa.gov
References: <1111454598.18940.57.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1111454598.18940.57.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_e67ZCZPWc3gKVO7"
Message-Id: <200504220054.22405.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_e67ZCZPWc3gKVO7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 March 2005 12:23, David Hampton <hampton-rh@rainbolthampton.net> 
wrote:
> This is a new strict policy for the DCC spam filter.  It is based on the
> selinux-policy-strict-sources-1.23.2-1 fedora RPM.  This policy requires
> the definition of dcc reserved ports that were in the net_contexts diff
> I sent last Wednesday.  Please let me know if there are any problems
> with or changes needed to this policy.

Firstly daemons should not be started with su.  For correct handling of 
terminal file handles you should use /sbin/runuser to change the UID, it also 
requires less policy which makes things easier.

Why do you use init_service_domain() and domain_auto_trans(initrc_t, 
dcc_script_exec_t, dcc_script_t)?

Surely the daemon is to be started either from inittab or from an /etc/init.d 
script but not both.

Putting a unix domain socket in /etc is wrong.  Among other things it will 
probably break things for anyone who wants to run with a read-only root file 
system.

Types used under the /var/run directory generally should have the pidfile 
attribute so that they can be cleaned up by boot scripts if necessary.

There is a type dccm_sock_t defined which is not in the .fc file.

Allowing access to sshd_t:fd is not what you want, you want to use privfd:fd 
to allow the administrator to use a console login.  Also you want to use 
admin_tty_type:chr_file instead of sysadm_devpts_t:chr_file for the same 
reason.

I have attached some patches, but I think that more will need to be done.

For starters I don't think that there is a good cause for seven domains.  
Postfix has the current record with 13 domains and I believe that Postfix has 
too many, one of the reasons why I asked Tresys to add a feature to apol to 
compare the access granted to domains was to determine which domains of 
Postfix are not needed.

Without even knowing what DCC does I feel confident in guessing that it's not 
nearly half as complex as Postfix and doesn't need so many domains.  
Excessive domains makes the policy difficult to analyse.  For starters 
dccifd_t and dccm_t can be merged.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_e67ZCZPWc3gKVO7
Content-Type: text/x-diff;
  charset="utf-8";
  name="fc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fc.diff"

--- dcc.fc.old	2005-04-22 00:21:50.000000000 +1000
+++ dcc.fc	2005-04-22 00:26:01.000000000 +1000
@@ -2,16 +2,16 @@
 /etc/dcc(/.*)?				system_u:object_r:dcc_var_t
 /etc/dcc/map			--	system_u:object_r:dcc_client_map_t
 /etc/dcc/dccifd			-s	system_u:object_r:dccifd_sock_t
-/usr/bin/cdcc				system_u:object_r:cdcc_exec_t
-/usr/bin/dccproc			system_u:object_r:dcc_client_exec_t
-/usr/libexec/dcc/dbclean		system_u:object_r:dcc_dbclean_exec_t
-/usr/libexec/dcc/dccd			system_u:object_r:dccd_exec_t
-/usr/libexec/dcc/dccifd			system_u:object_r:dccifd_exec_t
-/usr/libexec/dcc/dccm			system_u:object_r:dccm_exec_t
-/usr/libexec/dcc/start-.*		system_u:object_r:dcc_script_exec_t
-/usr/libexec/dcc/stop-.*		system_u:object_r:dcc_script_exec_t
+/usr/bin/cdcc			--	system_u:object_r:cdcc_exec_t
+/usr/bin/dccproc		--	system_u:object_r:dcc_client_exec_t
+/usr/libexec/dcc/dbclean	--	system_u:object_r:dcc_dbclean_exec_t
+/usr/libexec/dcc/dccd		--	system_u:object_r:dccd_exec_t
+/usr/libexec/dcc/dccifd		--	system_u:object_r:dccifd_exec_t
+/usr/libexec/dcc/dccm		--	system_u:object_r:dccm_exec_t
+/usr/libexec/dcc/start-.*	--	system_u:object_r:dcc_script_exec_t
+/usr/libexec/dcc/stop-.*	--	system_u:object_r:dcc_script_exec_t
 /var/dcc(/.*)?				system_u:object_r:dcc_var_t
 /var/dcc/map			--	system_u:object_r:dcc_client_map_t
-/var/run/dcc				system_u:object_r:dcc_var_run_t
+/var/run/dcc			-d	system_u:object_r:dcc_var_run_t
 /var/run/dcc/map		--	system_u:object_r:dcc_client_map_t
 /var/run/dcc/dccifd		-s	system_u:object_r:dccifd_sock_t

--Boundary-00=_e67ZCZPWc3gKVO7
Content-Type: text/x-diff;
  charset="utf-8";
  name="te.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="te.diff"

--- dcc.te.old	2005-04-22 00:21:46.000000000 +1000
+++ dcc.te	2005-04-22 00:51:36.000000000 +1000
@@ -13,7 +13,7 @@
 # Files common to all dcc programs
 type dcc_client_map_t, file_type, sysadmfile;
 type dcc_var_t, file_type, sysadmfile;
-type dcc_var_run_t, file_type, sysadmfile;
+type dcc_var_run_t, file_type, sysadmfile, pidfile;
 
 
 ##########
@@ -23,8 +23,6 @@
 # common to all dcc variants
 #
 define(`dcc_common',`
-# Access files in /var/dcc. The map file can be updated
-r_dir_file($1_t, dcc_var_t)
 allow $1_t dcc_client_map_t:file rw_file_perms;
 
 # Read mtab, nsswitch and locale
@@ -46,11 +44,7 @@
 # Triggered by a call to gethostid(2) in dcc client libs
 allow $1_t self:unix_stream_socket { connect create };
 
-allow $1_t sysadm_su_t:process { sigchld };
 allow $1_t dcc_script_t:fd use;
-
-dontaudit $1_t kernel_t:fd use;
-dontaudit $1_t root_t:file read;
 ')
 
 
@@ -87,13 +81,14 @@
 application_domain(cdcc, `, nscd_client_domain')
 role system_r types cdcc_t;
 dcc_common(cdcc)
+r_dir_file(cdcc_t, dcc_var_t)
 
 # suid program
 allow cdcc_t self:capability setuid;
 
 # Running from the command line
-allow cdcc_t sshd_t:fd use;
-allow cdcc_t sysadm_devpts_t:chr_file rw_file_perms;
+allow cdcc_t privfd:fd use;
+allow cdcc_t admin_tty_type:chr_file rw_file_perms;
 
 
 
@@ -117,9 +112,6 @@
 # Updating dcc_db, flod, ...
 create_dir_notdevfile(dccifd_t, dcc_var_t);
 
-# Updating map, ...
-allow dccifd_t dcc_client_map_t:file rw_file_perms;
-
 # dccifd communications socket
 type dccifd_sock_t, file_type, sysadmfile;
 file_type_auto_trans(dccifd_t, dcc_var_t, dccifd_sock_t, sock_file)
@@ -137,7 +129,6 @@
 
 # Updating map, ...
 create_dir_notdevfile(dccm_t, dcc_var_t);
-allow dccm_t dcc_client_map_t:file rw_file_perms;
 
 # dccm communications socket
 type dccm_sock_t, file_type, sysadmfile;
@@ -150,13 +141,14 @@
 application_domain(dcc_client, `, privlog, nscd_client_domain')
 role system_r types dcc_client_t;
 dcc_common(dcc_client)
+r_dir_file(dcc_client_t, dcc_var_t)
 
 # suid program
 allow dcc_client_t self:capability setuid;
 
 # Running from the command line
-allow dcc_client_t sshd_t:fd use;
-allow dcc_client_t sysadm_devpts_t:chr_file rw_file_perms;
+allow dcc_client_t privfd:fd use;
+allow dcc_client_t admin_tty_type:chr_file rw_file_perms;
 
 
 ##########
@@ -180,8 +172,8 @@
 allow dcc_dbclean_t proc_t:file { getattr read };
 
 # Running from the command line
-allow dcc_dbclean_t sshd_t:fd use;
-allow dcc_dbclean_t sysadm_devpts_t:chr_file rw_file_perms;
+allow dcc_dbclean_t privfd:fd use;
+allow dcc_dbclean_t admin_tty_type:chr_file rw_file_perms;
 
 ##########
 ##########
@@ -197,19 +189,16 @@
 general_proc_read_access(dcc_script_t)
 can_exec_any(dcc_script_t)
 dcc_common(dcc_script)
+r_dir_file(dcc_script_t, dcc_var_t)
 
 # Allow calling the script from an init script (initrt_t) or from
-# rc.local (staff_t)
-domain_auto_trans({ initrc_t staff_t }, dcc_script_exec_t, dcc_script_t)
+# rc.local
+domain_auto_trans(initrc_t, dcc_script_exec_t, dcc_script_t)
 
-# Start up the daemon process.  These scripts run 'su' to change to
-# the dcc user (even though the default dcc user is root).
 allow dcc_script_t self:capability setuid;
-su_restricted_domain(dcc_script, system)
-role system_r types dcc_script_su_t;
-domain_auto_trans(dcc_script_su_t, dccd_exec_t, dccd_t)
-domain_auto_trans(dcc_script_su_t, dccm_exec_t, dccm_t)
-domain_auto_trans(dcc_script_su_t, dccifd_exec_t, dccifd_t)
+domain_auto_trans(dcc_script_t, dccd_exec_t, dccd_t)
+domain_auto_trans(dcc_script_t, dccm_exec_t, dccm_t)
+domain_auto_trans(dcc_script_t, dccifd_exec_t, dccifd_t)
 
 # Stop the daemon process
 allow dcc_script_t { dccifd_t dccm_t }:process { sigkill signal };
@@ -218,19 +207,11 @@
 allow dcc_script_t { var_t var_run_t dcc_var_run_t}:dir { getattr search };
 allow dcc_script_t { dccifd_var_run_t dccm_var_run_t }:file { getattr read };
 
-allow { dcc_script_t dcc_script_su_t } initrc_t:fd use;
-allow { dcc_script_t dcc_script_su_t } devpts_t:dir search;
-allow { dcc_script_t dcc_script_su_t } initrc_devpts_t:chr_file rw_file_perms;
+allow dcc_script_t devpts_t:dir search;
+allow dcc_script_t initrc_devpts_t:chr_file rw_file_perms;
 allow dcc_script_t devtty_t:chr_file { read write };
-allow dcc_script_su_t sysadm_home_dir_t:dir search;
-allow dcc_script_su_t sysadm_t:process { noatsecure rlimitinh siginh transition };
-allow dcc_script_su_t initrc_devpts_t:chr_file { relabelfrom relabelto };
-
-dontaudit dcc_script_su_t kernel_t:fd use;
-dontaudit dcc_script_su_t root_t:file read;
-dontaudit dcc_script_t { home_root_t user_home_dir_t}:dir { getattr search };
 
-allow sysadm_t dcc_script_t:fd use;
+dontaudit dcc_script_t home_root_t:dir { getattr search };
 
 ##########
 ##########

--Boundary-00=_e67ZCZPWc3gKVO7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
