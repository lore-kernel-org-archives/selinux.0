Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06966
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:57:20 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new policy
Date: Tue, 1 Oct 2002 19:57:09 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210011319460.14489-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210011319460.14489-100000@raven>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9VDBCKAURS67IU3IX3IK"
Message-Id: <200210011957.09306.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_9VDBCKAURS67IU3IX3IK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tue, 1 Oct 2002 19:20, Stephen Smalley wrote:
> On Tue, 1 Oct 2002, Russell Coker wrote:
> > Yes we do.  I think that we need to radically change the way setfiles
> > works for home directories.  But in the mean time just adding something
> > like the following to xauth.fc should do:
> > /home/[^/]*/.Xauthority.*     system_u:object_r:user_home_xauth_t
>
> Ok, and I also added an entry for /root/.Xauthority with the
> sysadm_home_xauth_t type.

I have attached a new patch that applies against the current CVS tree.  It 
adds some important things to the xauth support, particularly denying xdm_t 
write access to user_home_t.

Also there's a bunch of other things in the patch, the meaning of the patch 
should be obvious.

Steve, you may disagree with the xdm.te part, I think we've kept the alias for 
too long already...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_9VDBCKAURS67IU3IX3IK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru policy/domains/program/calamaris.te policy.new/domains/program/calamaris.te
--- policy/domains/program/calamaris.te	2002-10-01 18:40:37.000000000 +0200
+++ policy.new/domains/program/calamaris.te	2002-10-01 19:43:43.000000000 +0200
@@ -22,7 +22,7 @@
 rw_dir_create_file(calamaris_t, calamaris_www_t)
 
 # for when squid has a different UID
-allow calamaris_t self:capability dac_read_search;
+allow calamaris_t self:capability dac_override;
 
 log_domain(calamaris)
 
diff -ru policy/domains/program/courier.te policy.new/domains/program/courier.te
--- policy/domains/program/courier.te	2002-09-27 22:27:37.000000000 +0200
+++ policy.new/domains/program/courier.te	2002-10-01 19:43:43.000000000 +0200
@@ -105,7 +105,9 @@
 # imap needs to write files
 allow courier_pop_t home_root_t:dir { getattr search };
 allow courier_pop_t user_home_dir_type:dir { getattr search };
-rw_dir_create_file(courier_pop_t, user_home_type)
+# pop does not need to create subdirs, IMAP does
+#rw_dir_create_file(courier_pop_t, user_home_type)
+create_dir_file(courier_pop_t, user_home_type)
 
 # for calendaring
 courier_domain(pcp)
diff -ru policy/domains/program/dpkg.te policy.new/domains/program/dpkg.te
--- policy/domains/program/dpkg.te	2002-10-01 19:28:42.000000000 +0200
+++ policy.new/domains/program/dpkg.te	2002-10-01 19:43:43.000000000 +0200
@@ -157,7 +157,7 @@
 allow dpkg_t file_type:{ file lnk_file fifo_file sock_file } create_file_perms;
 ifdef(`devfsd.te',
 `allow dpkg_t file_type:{ chr_file blk_file } getattr;',
-`allow dpkg_t file_type:{ chr_file blk_file } { create getattr access setattr rename };')
+`allow dpkg_t file_type:{ chr_file blk_file } { create getattr setattr rename };')
 dontaudit dpkg_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
 allow dpkg_t proc_kmsg_t:file getattr;
 allow dpkg_t root_dir_type:dir getattr;
diff -ru policy/domains/program/inetd.te policy.new/domains/program/inetd.te
--- policy/domains/program/inetd.te	2002-09-21 05:01:26.000000000 +0200
+++ policy.new/domains/program/inetd.te	2002-10-01 19:43:43.000000000 +0200
@@ -32,8 +32,6 @@
 # Use capabilities.
 allow inetd_t self:capability { setuid setgid net_bind_service };
 
-# Use the network.
-can_network(inetd_t)
 # allow any domain to connect to inetd
 can_tcp_connect(domain, inetd_t)
 
@@ -78,8 +76,5 @@
 # Use sockets inherited from inetd.
 allow inetd_child_t inetd_t:tcp_socket rw_stream_socket_perms;
 
-# Use the network
-can_network(inetd_child_t)
-
 # for identd
 #allow inetd_child_t self:capability { setuid setgid };
diff -ru policy/domains/program/mrtg.te policy.new/domains/program/mrtg.te
--- policy/domains/program/mrtg.te	2002-09-27 22:27:38.000000000 +0200
+++ policy.new/domains/program/mrtg.te	2002-10-01 19:43:43.000000000 +0200
@@ -61,5 +61,9 @@
 dontaudit mrtg_t initrc_var_run_t:file { write lock };
 allow mrtg_t etc_runtime_t:file { getattr read };
 
+allow mrtg_t tmp_t:dir getattr;
+
 # should not need this!
 allow mrtg_t sysadm_home_dir_t:dir { search read getattr };
+dontaudit mrtg_t { boot_t device_t file_labels_t file_t lost_found_t }:dir getattr;
+dontaudit mrtg_t root_t:lnk_file getattr;
diff -ru policy/domains/program/named.te policy.new/domains/program/named.te
--- policy/domains/program/named.te	2002-10-01 19:28:44.000000000 +0200
+++ policy.new/domains/program/named.te	2002-10-01 19:43:43.000000000 +0200
@@ -91,6 +91,7 @@
 type ndc_exec_t, file_type,sysadmfile, exec_type;
 domain_auto_trans(sysadm_t, ndc_exec_t, ndc_t)
 uses_shlib(ndc_t)
+can_network(ndc_t)
 can_tcp_connect(ndc_t, named_t)
 allow { named_t ndc_t initrc_t } rndc_conf_t:file { getattr read };
 
diff -ru policy/domains/program/qmail.te policy.new/domains/program/qmail.te
--- policy/domains/program/qmail.te	2002-10-01 19:28:46.000000000 +0200
+++ policy.new/domains/program/qmail.te	2002-10-01 19:43:43.000000000 +0200
@@ -55,15 +55,11 @@
 allow qmail_lspawn_t qmail_spool_t:dir search;
 allow qmail_lspawn_t qmail_spool_t:file { read getattr };
 allow qmail_lspawn_t etc_t:file { getattr read };
-allow qmail_lspawn_t etc_qmail_t:dir { getattr search };
 dontaudit qmail_lspawn_t user_home_dir_type:dir { getattr search };
 
 qmail_daemon_domain(send)
-allow qmail_send_t var_spool_t:dir search;
 rw_dir_create_file(qmail_send_t, qmail_spool_t)
 allow qmail_send_t qmail_spool_t:fifo_file read;
-allow qmail_send_t etc_qmail_t:dir search;
-allow qmail_send_t etc_qmail_t:{ lnk_file file } read;
 allow qmail_send_t self:process { fork signal_perms };
 allow qmail_send_t self:fifo_file write;
 domain_auto_trans_read(qmail_send_t, qmail_queue_exec_t, qmail_queue_t)
@@ -101,9 +97,6 @@
 domain_auto_trans(qmail_local_t, qmail_queue_exec_t, qmail_queue_t)
 allow qmail_local_t qmail_queue_exec_t:file read;
 allow qmail_local_t qmail_spool_t:file { ioctl read };
-allow qmail_local_t etc_qmail_t:dir { getattr read search };
-allow qmail_local_t etc_qmail_t:file { getattr read };
-allow qmail_local_t qmail_spool_t:file { ioctl read };
 allow qmail_local_t self:fifo_file write;
 allow qmail_local_t sbin_t:dir search;
 
@@ -175,6 +168,7 @@
 allow qmail_serialmail_t self:process { fork signal_perms };
 allow qmail_serialmail_t proc_t:file { getattr read };
 allow qmail_serialmail_t { resolv_conf_t etc_runtime_t }:file { getattr read };
+allow qmail_serialmail_t home_root_t:dir search;
 allow qmail_serialmail_t user_home_dir_type:dir { search read getattr };
 rw_dir_create_file(qmail_serialmail_t, user_home_type)
 allow qmail_serialmail_t self:fifo_file { read write };
diff -ru policy/domains/program/radius.te policy.new/domains/program/radius.te
--- policy/domains/program/radius.te	2002-09-27 22:27:38.000000000 +0200
+++ policy.new/domains/program/radius.te	2002-10-01 19:43:43.000000000 +0200
@@ -49,7 +49,8 @@
 allow radiusd_t devtty_t:chr_file { read write };
 allow radiusd_t self:fifo_file rw_file_perms;
 # fsetid is for gzip which needs it when run from scripts
-allow radiusd_t self:capability { fsetid kill setuid setgid dac_override };
+# gzip also needs chown access to preserve GID for radwtmp files
+allow radiusd_t self:capability { chown fsetid kill setuid setgid dac_override };
 
 can_network(radiusd_t)
 allow radiusd_t { radius_port_t radacct_port_t }:udp_socket name_bind;
diff -ru policy/domains/program/rlogind.te policy.new/domains/program/rlogind.te
--- policy/domains/program/rlogind.te	2002-10-01 19:28:47.000000000 +0200
+++ policy.new/domains/program/rlogind.te	2002-10-01 19:43:43.000000000 +0200
@@ -45,5 +45,6 @@
 # Modify /var/log/wtmp.
 allow rlogind_t wtmp_t:file rw_file_perms;
 
-
-
+ifdef(`devfsd.te', `
+allow rlogind_t device_t:filesystem getattr;
+')
diff -ru policy/domains/program/rpcd.te policy.new/domains/program/rpcd.te
--- policy/domains/program/rpcd.te	2002-09-27 22:27:38.000000000 +0200
+++ policy.new/domains/program/rpcd.te	2002-10-01 19:43:43.000000000 +0200
@@ -16,6 +16,7 @@
 domain_auto_trans(initrc_t, rpcd_exec_t, rpcd_t)
 can_udp_send({ init_t initrc_t }, rpcd_t)
 can_udp_send(rpcd_t, { init_t initrc_t })
+allow init_t rpcd_t:udp_socket write;
 
 can_udp_send(rpcd_t, rpcd_t)
 can_udp_send(mount_t, rpcd_t)
@@ -28,9 +29,6 @@
 # Inherit and use descriptors from init
 allow rpcd_t init_t:fd use;
 
-# Use the network.
-can_network(rpcd_t)
-
 # rpcd_t needs to talk to the portmap_t domain
 can_udp_send(rpcd_t, portmap_t)
 
diff -ru policy/domains/program/squid.te policy.new/domains/program/squid.te
--- policy/domains/program/squid.te	2002-10-01 19:28:47.000000000 +0200
+++ policy.new/domains/program/squid.te	2002-10-01 19:43:43.000000000 +0200
@@ -8,7 +8,11 @@
 # Rules for the squid_t domain.
 #
 # squid_t is the domain the squid process runs in
-ifdef(`apache.te',`', `type http_cache_port_t, port_type;')
+ifdef(`apache.te',`
+can_tcp_connect(squid_t, httpd_t)
+', `
+type http_cache_port_t, port_type;
+')
 
 daemon_domain(squid)
 type squid_conf_t, file_type, sysadmfile;
diff -ru policy/domains/program/useradd.te policy.new/domains/program/useradd.te
--- policy/domains/program/useradd.te	2002-09-27 18:05:14.000000000 +0200
+++ policy.new/domains/program/useradd.te	2002-10-01 19:43:43.000000000 +0200
@@ -15,7 +15,6 @@
 domain_auto_trans(sysadm_t, useradd_exec_t, useradd_t)
 
 # Add/remove user home directories
-allow useradd_t home_root_t:dir rw_dir_perms;
 file_type_auto_trans(useradd_t, home_root_t, user_home_dir_t)
 file_type_auto_trans(useradd_t, user_home_dir_t, user_home_t)
 
diff -ru policy/domains/program/xdm.te policy.new/domains/program/xdm.te
--- policy/domains/program/xdm.te	2002-10-01 19:28:47.000000000 +0200
+++ policy.new/domains/program/xdm.te	2002-10-01 19:43:43.000000000 +0200
@@ -13,12 +13,12 @@
 # spawned by getty.
 # xdm_exec_t is the type of the [xgk]dm program
 #
-type xdm_t alias { gdm_t }, domain, privuser, privrole, privlog, auth, privowner, privmem;
+type xdm_t, domain, privuser, privrole, privlog, auth, privowner, privmem;
 role system_r types xdm_t;
 every_domain(xdm_t)
-type xdm_exec_t alias gdm_exec_t, file_type, sysadmfile, exec_type;
-type xdm_var_run_t alias gdm_var_run_t,file_type, sysadmfile, pidfile;
-type xdm_tmp_t alias gdm_tmp_t, file_type, sysadmfile, tmpfile;
+type xdm_exec_t, file_type, sysadmfile, exec_type;
+type xdm_var_run_t, file_type, sysadmfile, pidfile;
+type xdm_tmp_t, file_type, sysadmfile, tmpfile;
 type xsession_exec_t, file_type, sysadmfile, exec_type;
 
 # Run the X Display Manager in its own domain.
diff -ru policy/file_contexts/program/mailman.fc policy.new/file_contexts/program/mailman.fc
--- policy/file_contexts/program/mailman.fc	2002-10-01 18:40:37.000000000 +0200
+++ policy.new/file_contexts/program/mailman.fc	2002-10-01 19:43:43.000000000 +0200
@@ -7,3 +7,4 @@
 /usr/lib/mailman/mail/wrapper	system_u:object_r:mailman_mail_exec_t
 /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
 /etc/cron.daily/mailman		system_u:object_r:mailman_queue_exec_t
+/etc/cron.monthly/mailman	system_u:object_r:mailman_queue_exec_t
diff -ru policy/file_contexts/program/mysqld.fc policy.new/file_contexts/program/mysqld.fc
--- policy/file_contexts/program/mysqld.fc	2002-08-23 20:44:20.000000000 +0200
+++ policy.new/file_contexts/program/mysqld.fc	2002-10-01 19:43:43.000000000 +0200
@@ -1,7 +1,7 @@
 # mysql database server
 /usr/sbin/mysqld		system_u:object_r:mysqld_exec_t
 /var/run/mysqld(/.*)?		system_u:object_r:var_run_mysqld_t
-/var/log/mysql\.(err|log).*	system_u:object_r:mysqld_log_t
+/var/log/mysql.*		system_u:object_r:mysqld_log_t
 /var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
 /etc/my.cnf			system_u:object_r:etc_mysqld_t
 /etc/mysql(/.*)?		system_u:object_r:etc_mysqld_t
diff -ru policy/macros/program/crontab_macros.te policy.new/macros/program/crontab_macros.te
--- policy/macros/program/crontab_macros.te	2002-10-01 19:28:52.000000000 +0200
+++ policy.new/macros/program/crontab_macros.te	2002-10-01 19:43:43.000000000 +0200
@@ -41,6 +41,7 @@
 # Type of user crontabs once moved to cron spool.
 type $1_cron_spool_t, file_type, sysadmfile;
 # Use the type when creating files in /var/spool/cron.
+allow sysadm_crontab_t $1_cron_spool_t:file { getattr read };
 file_type_auto_trans($1_crontab_t, cron_spool_t, $1_cron_spool_t)
 ifdef(`fcron.te', `
 file_type_auto_trans($1_crontab_t, fcron_spool_t, $1_cron_spool_t)
@@ -62,7 +63,6 @@
 can_exec_any($1_crontab_t)
 
 # Read user crontabs 
-allow $1_crontab_t home_root_t:dir search;
 allow $1_crontab_t { $1_home_t $1_home_dir_t }:dir r_dir_perms;  
 allow $1_crontab_t $1_home_t:file r_file_perms;  
 
diff -ru policy/macros/program/lpr_macros.te policy.new/macros/program/lpr_macros.te
--- policy/macros/program/lpr_macros.te	2002-10-01 19:28:52.000000000 +0200
+++ policy.new/macros/program/lpr_macros.te	2002-10-01 19:43:43.000000000 +0200
@@ -53,7 +53,6 @@
 ifdef(`gnome-pty-helper.te', `allow $1_lpr_t $1_gph_t:fd use;')
 
 # Read user files. 
-allow $1_lpr_t home_root_t:dir search;
 allow $1_lpr_t { $1_home_t $1_home_dir_t }:dir search;  
 allow $1_lpr_t $1_home_t:{ file lnk_file } r_file_perms;  
 
@@ -79,6 +78,7 @@
 ifdef(`cups.te', `
 allow { $1_lpr_t $1_t } etc_cupsd_t:dir search;
 can_tcp_connect({ $1_lpr_t $1_t }, cupsd_t)
+file_type_auto_trans($1_lpr_t, cupsd_spool_t, $1_lpd_spool_t)
 ')
 
 ')
diff -ru policy/macros/program/mta_macros.te policy.new/macros/program/mta_macros.te
--- policy/macros/program/mta_macros.te	2002-10-01 19:28:53.000000000 +0200
+++ policy.new/macros/program/mta_macros.te	2002-10-01 19:43:43.000000000 +0200
@@ -30,6 +30,7 @@
 # Transition from the user domain to the derived domain.
 domain_auto_trans($1_t, sendmail_exec_t, $1_mail_t)
 ')
+can_exec($1_mail_t, sendmail_exec_t)
 
 # The user role is authorized for this domain.
 role $1_r types $1_mail_t;
@@ -70,7 +71,6 @@
 ifdef(`gnome-pty-helper.te', `allow $1_mail_t $1_gph_t:fd use;')
 
 # Create dead.letter in user home directories.
-allow $1_mail_t home_root_t:dir search;
 file_type_auto_trans($1_mail_t, $1_home_dir_t, $1_home_t)
 
 # if you do not want to allow dead.letter then use the following instead
diff -ru policy/macros/program/su_macros.te policy.new/macros/program/su_macros.te
--- policy/macros/program/su_macros.te	2002-10-01 19:28:53.000000000 +0200
+++ policy.new/macros/program/su_macros.te	2002-10-01 19:43:43.000000000 +0200
@@ -39,8 +39,6 @@
 # Write to utmp.
 allow $1_su_t initrc_var_run_t:file rw_file_perms;
 
-# Use the network.
-can_network($1_su_t)
 ')dnl end su_mini_domain
 
 define(`su_domain', `
diff -ru policy/macros/program/x_client_macros.te policy.new/macros/program/x_client_macros.te
--- policy/macros/program/x_client_macros.te	2002-10-01 18:45:25.000000000 +0200
+++ policy.new/macros/program/x_client_macros.te	2002-10-01 19:46:13.000000000 +0200
@@ -101,10 +101,7 @@
 allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
 
 # Read the home directory, e.g. for .Xauthority and to get to config files
-allow $1_$2_t home_root_t:dir search;
 file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_$2_rw_t)
-# for .Xauthority - need different perms for this
-allow $1_$2_t $1_home_t:file { read getattr };
 
 # Use a separate type for tmpfs/shm pseudo files.
 type $1_$2_tmpfs_t, file_type, sysadmfile;
diff -ru policy/macros/program/xserver_macros.te policy.new/macros/program/xserver_macros.te
--- policy/macros/program/xserver_macros.te	2002-10-01 19:28:53.000000000 +0200
+++ policy.new/macros/program/xserver_macros.te	2002-10-01 19:43:43.000000000 +0200
@@ -120,8 +120,6 @@
 # Use the mouse.
 allow $1_xserver_t mouse_device_t:chr_file rw_file_perms;
 
-allow $1_xserver_t home_root_t:dir search;
-
 ifelse($1, xdm, `
 dontaudit xdm_xserver_t sysadm_home_dir_t:dir { read search };
 ', `
diff -ru policy/macros/user_macros.te policy.new/macros/user_macros.te
--- policy/macros/user_macros.te	2002-10-01 19:28:52.000000000 +0200
+++ policy.new/macros/user_macros.te	2002-10-01 19:43:43.000000000 +0200
@@ -213,8 +213,7 @@
 allow $1_t xdm_xserver_tmp_t:dir search;
 
 ifelse(`$1', sysadm, `', `
-# gross hack - should not need this
-file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_t, file)
+file_type_auto_trans(xdm_t, $1_home_dir_t, $1_home_xauth_t, file)
 ')dnl end ifelse sysadm
 ')dnl end ifdef xdm.te
 

--------------Boundary-00=_9VDBCKAURS67IU3IX3IK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
