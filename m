Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SDkHrT025979
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 09:46:17 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SDjQHc008645
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 13:45:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: policy patch
Date: Sat, 28 Aug 2004 23:46:05 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <200408241818.40064.russell@coker.com.au> <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dyIMBWs8irRBjkS"
Message-Id: <200408282346.05926.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_dyIMBWs8irRBjkS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 28 Aug 2004 06:58, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> Also added:
>  allow hotplug_t udev_helper_exec_t:lnk_file read;
> It seems reasonable and I was seeing a lot of denials, but it might be
> possible to use a dontaudit.

I think that a better thing to do is to use "--" on the file_contexts entry 
for an executable file and have any sym-links with similar named get bin_t or 
sbin_t.  The contents of a sym-link are almost never of any relevance to the 
security of the system, but adding more rules increases the size of the 
policy and the work for all of us.  Also as a side-affect specifying the 
class of the object to be labelled makes setfiles run faster.

I have attached a patch which adds -- to all types ending in _exec_t.  It also 
fixes some bugs in the spamassasin policy and adds a couple of other file 
contexts things as well.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_dyIMBWs8irRBjkS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fc.diff"

diff -ru /usr/src/se/policy/file_contexts/program/distcc.fc file_contexts/program/distcc.fc
--- /usr/src/se/policy/file_contexts/program/distcc.fc	2004-07-29 06:04:18.000000000 +1000
+++ file_contexts/program/distcc.fc	2004-08-28 23:28:02.000000000 +1000
@@ -1,2 +1,2 @@
 # distcc
-/usr/bin/distccd		system_u:object_r:distccd_exec_t
+/usr/bin/distccd	--	system_u:object_r:distccd_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/dovecot.fc file_contexts/program/dovecot.fc
--- /usr/src/se/policy/file_contexts/program/dovecot.fc	2004-07-13 09:08:03.000000000 +1000
+++ file_contexts/program/dovecot.fc	2004-08-24 18:08:10.000000000 +1000
@@ -1,6 +1,12 @@
 # for Dovecot POP and IMAP server
 /usr/sbin/dovecot		--	system_u:object_r:dovecot_exec_t
+ifdef(`distro_redhat', `
 /usr/libexec/dovecot/dovecot-auth --	system_u:object_r:dovecot_auth_exec_t
+')
+ifdef(`distro_debian', `
+/usr/lib/dovecot/dovecot-auth	--	system_u:object_r:dovecot_auth_exec_t
+/usr/lib/dovecot/.+		--	system_u:object_r:bin_t
+')
 /usr/share/ssl/certs/dovecot.pem --	system_u:object_r:dovecot_cert_t
 /usr/share/ssl/private/dovecot.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
diff -ru /usr/src/se/policy/file_contexts/program/dpkg.fc file_contexts/program/dpkg.fc
--- /usr/src/se/policy/file_contexts/program/dpkg.fc	2004-08-19 17:10:38.000000000 +1000
+++ file_contexts/program/dpkg.fc	2004-08-28 23:25:01.000000000 +1000
@@ -15,7 +15,7 @@
 /usr/sbin/dpkg-preconfigure --	system_u:object_r:dpkg_exec_t
 /usr/sbin/install-menu	--	system_u:object_r:install_menu_exec_t
 /usr/share/applnk(/.*)?		system_u:object_r:debian_menu_t
-/usr/share/debconf(/.*)?	system_u:object_r:dpkg_exec_t
+/usr/share/debconf/.+	--	system_u:object_r:dpkg_exec_t
 /usr/share/debiandoc-sgml/saspconvert -- system_u:object_r:bin_t
 /usr/share/lintian/.+	--	system_u:object_r:bin_t
 /usr/share/kernel-package/.+ -- system_u:object_r:bin_t
diff -ru /usr/src/se/policy/file_contexts/program/firstboot.fc file_contexts/program/firstboot.fc
--- /usr/src/se/policy/file_contexts/program/firstboot.fc	2004-04-03 21:37:23.000000000 +1000
+++ file_contexts/program/firstboot.fc	2004-08-28 23:25:18.000000000 +1000
@@ -1,4 +1,4 @@
 # firstboot
 /usr/sbin/firstboot	-- system_u:object_r:firstboot_exec_t
 /usr/share/firstboot	system_u:object_r:firstboot_rw_t
-/usr/share/firstboot/firstboot.py	system_u:object_r:firstboot_exec_t
+/usr/share/firstboot/firstboot.py --	system_u:object_r:firstboot_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/initrc.fc file_contexts/program/initrc.fc
--- /usr/src/se/policy/file_contexts/program/initrc.fc	2004-08-28 12:05:09.000000000 +1000
+++ file_contexts/program/initrc.fc	2004-08-28 23:29:40.000000000 +1000
@@ -13,8 +13,12 @@
 /var/run/setmixer_flag	--	system_u:object_r:initrc_var_run_t
 # run_init
 /usr/sbin/run_init	--	system_u:object_r:run_init_exec_t
+ifdef(`distro_debian', `
 /usr/sbin/open_init_pty	--	system_u:object_r:initrc_exec_t
+')
 /etc/nologin.*		--	system_u:object_r:etc_runtime_t
 /etc/nohotplug		--	system_u:object_r:etc_runtime_t
+ifdef(`distro_redhat', `
 /halt                   --      system_u:object_r:etc_runtime_t
 /\.autofsck             --      system_u:object_r:etc_runtime_t
+')
diff -ru /usr/src/se/policy/file_contexts/program/jabberd.fc file_contexts/program/jabberd.fc
--- /usr/src/se/policy/file_contexts/program/jabberd.fc	2004-06-17 15:10:43.000000000 +1000
+++ file_contexts/program/jabberd.fc	2004-08-28 23:25:26.000000000 +1000
@@ -1,3 +1,3 @@
 # jabberd
-/usr/sbin/jabberd		system_u:object_r:jabberd_exec_t
+/usr/sbin/jabberd	--	system_u:object_r:jabberd_exec_t
 /var/lib/jabber(/.*)?		system_u:object_r:jabberd_var_lib_t
diff -ru /usr/src/se/policy/file_contexts/program/kerberos.fc file_contexts/program/kerberos.fc
--- /usr/src/se/policy/file_contexts/program/kerberos.fc	2004-06-24 22:50:07.000000000 +1000
+++ file_contexts/program/kerberos.fc	2004-08-28 23:25:48.000000000 +1000
@@ -1,11 +1,11 @@
 # MIT Kerberos krbkdc, kadmind
 /etc/krb5\.keytab       		system_u:object_r:krb5_keytab_t
-/usr(/local)?(/kerberos)?/sbin/krb5kdc 	system_u:object_r:krb5kdc_exec_t
-/usr(/local)?(/kerberos)?/sbin/kadmind	system_u:object_r:kadmind_exec_t
+/usr(/local)?(/kerberos)?/sbin/krb5kdc --	system_u:object_r:krb5kdc_exec_t
+/usr(/local)?(/kerberos)?/sbin/kadmind --	system_u:object_r:kadmind_exec_t
 /var/kerberos/krb5kdc(/.*)?		system_u:object_r:krb5kdc_conf_t
 /usr/local/var/krb5kdc(/.*)?		system_u:object_r:krb5kdc_conf_t
 /var/kerberos/krb5kdc/principal.*	system_u:object_r:krb5kdc_principal_t
 /usr/local/var/krb5kdc/principal.*	system_u:object_r:krb5kdc_principal_t
 /var/log/krb5kdc.log			system_u:object_r:krb5kdc_log_t
 /var/log/kadmind.log			system_u:object_r:kadmind_log_t
-/usr(/local)?/bin/ksu			system_u:object_r:su_exec_t
+/usr(/local)?/bin/ksu		--	system_u:object_r:su_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/named.fc file_contexts/program/named.fc
--- /usr/src/se/policy/file_contexts/program/named.fc	2004-08-28 12:05:10.000000000 +1000
+++ file_contexts/program/named.fc	2004-08-28 22:53:56.000000000 +1000
@@ -1,8 +1,10 @@
 # named
+ifdef(`distro_redhat', `
 /var/named(/.*)?		system_u:object_r:named_zone_t
 /var/named/slaves(/.*)?		system_u:object_r:named_cache_t
 /var/named/data(/.*)?		system_u:object_r:named_cache_t
 /etc/named\.conf	--	system_u:object_r:named_conf_t
+') dnl end distro_redhat
 
 ifdef(`distro_debian', `
 /etc/bind(/.*)?			system_u:object_r:named_zone_t
diff -ru /usr/src/se/policy/file_contexts/program/openca-ca.fc file_contexts/program/openca-ca.fc
--- /usr/src/se/policy/file_contexts/program/openca-ca.fc	2004-06-17 15:10:43.000000000 +1000
+++ file_contexts/program/openca-ca.fc	2004-08-28 23:26:09.000000000 +1000
@@ -5,4 +5,4 @@
 /var/lib/openca/crypto/keys(/.*)?	system_u:object_r:openca_var_lib_keys_t
 /usr/share/openca(/.*)?		system_u:object_r:openca_usr_share_t
 /usr/share/openca/htdocs(/.*)?	system_u:object_r:httpd_sys_content_t
-/usr/share/openca/cgi-bin/ca(/.*)?	system_u:object_r:openca_ca_exec_t
+/usr/share/openca/cgi-bin/ca/.+ --	system_u:object_r:openca_ca_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/prelink.fc file_contexts/program/prelink.fc
--- /usr/src/se/policy/file_contexts/program/prelink.fc	2004-02-25 17:05:05.000000000 +1100
+++ file_contexts/program/prelink.fc	2004-08-25 21:42:00.000000000 +1000
@@ -1,5 +1,8 @@
 # prelink - prelink ELF shared libraries and binaries to speed up startup time
 /usr/sbin/prelink		--	system_u:object_r:prelink_exec_t
+ifdef(`distro_debian', `
+/usr/sbin/prelink\.bin		--	system_u:object_r:prelink_exec_t
+')
 /etc/prelink.conf		--	system_u:object_r:etc_prelink_t
 /var/log/prelink.log		--	system_u:object_r:prelink_log_t
 /etc/prelink.cache		--	system_u:object_r:prelink_cache_t
diff -ru /usr/src/se/policy/file_contexts/program/rssh.fc file_contexts/program/rssh.fc
--- /usr/src/se/policy/file_contexts/program/rssh.fc	2004-08-24 05:46:54.000000000 +1000
+++ file_contexts/program/rssh.fc	2004-08-28 23:28:07.000000000 +1000
@@ -1,2 +1,2 @@
 # rssh
-/usr/bin/rssh			system_u:object_r:rssh_exec_t
+/usr/bin/rssh		--	system_u:object_r:rssh_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/seuser.fc file_contexts/program/seuser.fc
--- /usr/src/se/policy/file_contexts/program/seuser.fc	2003-11-27 05:04:46.000000000 +1100
+++ file_contexts/program/seuser.fc	2004-08-28 23:26:21.000000000 +1000
@@ -1,4 +1,4 @@
 # seuser
-/usr/bin/seuser	system_u:object_r:seuser_exec_t
+/usr/bin/seuser	--	system_u:object_r:seuser_exec_t
 /usr/apol/seuser.conf system_u:object_r:seuser_conf_t
 
diff -ru /usr/src/se/policy/file_contexts/program/spamassassin.fc file_contexts/program/spamassassin.fc
--- /usr/src/se/policy/file_contexts/program/spamassassin.fc	2004-05-05 05:35:53.000000000 +1000
+++ file_contexts/program/spamassassin.fc	2004-08-28 23:27:21.000000000 +1000
@@ -1,3 +1,3 @@
-/usr/bin/spamassassin		system_u:object_r:spamassassin_exec_t
-/root/\.spamassassin(/.*)?	system_u:object_r:staff_home_spamassassin_t
-/home/[^/]+/\.spamassassin(/.*)?	system_u:object_r:user_home_spamassassin_t
+# spamassasin
+/usr/bin/spamassassin	--	system_u:object_r:spamassassin_exec_t
+HOME_DIR/\.spamassassin(/.*)?	system_u:object_r:ROLE_home_spamassassin_t
diff -ru /usr/src/se/policy/file_contexts/program/spamc.fc file_contexts/program/spamc.fc
--- /usr/src/se/policy/file_contexts/program/spamc.fc	2004-05-05 05:35:53.000000000 +1000
+++ file_contexts/program/spamc.fc	2004-08-28 23:27:27.000000000 +1000
@@ -1 +1 @@
-/usr/bin/spamc		system_u:object_r:spamc_exec_t
+/usr/bin/spamc	--	system_u:object_r:spamc_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/udev.fc file_contexts/program/udev.fc
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-08-28 12:05:11.000000000 +1000
+++ file_contexts/program/udev.fc	2004-08-28 23:27:56.000000000 +1000
@@ -3,7 +3,7 @@
 /sbin/udev	--	system_u:object_r:udev_exec_t
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
-/etc/dev\.d(/.*)? 	system_u:object_r:udev_helper_exec_t
-/etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
+/etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
+/etc/hotplug.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
diff -ru /usr/src/se/policy/file_contexts/program/xfs.fc file_contexts/program/xfs.fc
--- /usr/src/se/policy/file_contexts/program/xfs.fc	2004-01-24 12:15:54.000000000 +1100
+++ file_contexts/program/xfs.fc	2004-08-26 00:11:03.000000000 +1000
@@ -1,3 +1,5 @@
 # xfs
 /tmp/\.font-unix(/.*)?		system_u:object_r:xfs_tmp_t
 /usr/X11R6/bin/xfs	--	system_u:object_r:xfs_exec_t
+/usr/X11R6/bin/xfs-xtt	--	system_u:object_r:xfs_exec_t
+/usr/bin/xfstt		--	system_u:object_r:xfs_exec_t

--Boundary-00=_dyIMBWs8irRBjkS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
