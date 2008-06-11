Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BGaMTr003026
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 12:36:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BGaLQD013925
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 16:36:21 GMT
Message-ID: <484FFEA2.3060609@redhat.com>
Date: Wed, 11 Jun 2008 12:34:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Corecommand.patch based off todays policy
Content-Type: multipart/mixed;
 boundary="------------050404060403020609090106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050404060403020609090106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lots of file context changes.

Added sys_chroot to chroot interface.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhP/qEACgkQrlYvE4MpobOP6ACfZO0yC2CrI6vYlMX6ieF+5Tpm
BvMAoMsRQrK+dt/nY6tqYhVsTSAoroPd
=s1n2
-----END PGP SIGNATURE-----

--------------050404060403020609090106
Content-Type: text/plain;
 name="kernel_corecommands.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_corecommands.patch"

--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2008-06-11 08:15:43.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/kernel/corecommands.fc	2008-06-11 10:06:56.000000000 -0400
@@ -7,11 +7,11 @@
 /bin/d?ash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash2			--	gen_context(system_u:object_r:shell_exec_t,s0)
+/usr/bin/git-shell		--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/ksh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/tcsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/zsh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
-
 #
 # /dev
 #
@@ -67,6 +67,12 @@
 
 /etc/security/namespace.init    --      gen_context(system_u:object_r:bin_t,s0)
 
+
+/etc/sysconfig/crond		-- gen_context(system_u:object_r:bin_t,s0)
+/etc/sysconfig/init		-- gen_context(system_u:object_r:bin_t,s0)
+/etc/sysconfig/libvirtd		-- gen_context(system_u:object_r:bin_t,s0)
+/etc/sysconfig/netconsole	-- gen_context(system_u:object_r:bin_t,s0)
+/etc/sysconfig/readonly-root 	-- gen_context(system_u:object_r:bin_t,s0)
 /etc/sysconfig/network-scripts/ifup-.*	-- gen_context(system_u:object_r:bin_t,s0)
 /etc/sysconfig/network-scripts/ifup-.*	-l gen_context(system_u:object_r:bin_t,s0)
 /etc/sysconfig/network-scripts/ifdown-.* -- gen_context(system_u:object_r:bin_t,s0)
@@ -100,11 +105,6 @@
 /lib/rcscripts/net\.modules\.d/helpers\.d/udhcpc-.* -- gen_context(system_u:object_r:bin_t,s0)
 ')
 
-ifdef(`distro_redhat',`
-/lib/dbus-1/dbus-daemon-launch-helper -- gen_context(system_u:object_r:bin_t,s0)
-/lib64/dbus-1/dbus-daemon-launch-helper -- gen_context(system_u:object_r:bin_t,s0)
-')
-
 #
 # /sbin
 #
@@ -128,6 +128,8 @@
 /opt/vmware/workstation/lib/lib/wrapper-gtk24\.sh -- gen_context(system_u:object_r:bin_t,s0)
 ')
 
+/opt/gutenprint/cups/lib/filter(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+
 #
 # /usr
 #
@@ -145,10 +147,7 @@
 /usr/lib(64)?/[^/]*firefox[^/]*/firefox -- gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/apt/methods.+	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/courier(/.*)?		gen_context(system_u:object_r:bin_t,s0)
-/usr/lib(64)?/cups/backend(/.*)? 	gen_context(system_u:object_r:bin_t,s0)
-/usr/lib(64)?/cups/cgi-bin/.*	--	gen_context(system_u:object_r:bin_t,s0)
-/usr/lib(64)?/cups/daemon(/.*)? 	gen_context(system_u:object_r:bin_t,s0)
-/usr/lib(64)?/cups/filter(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/cups(/.*)? 		gen_context(system_u:object_r:bin_t,s0)
 
 /usr/lib(64)?/cyrus-imapd/.*	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/dpkg/.+		--	gen_context(system_u:object_r:bin_t,s0)
@@ -179,6 +178,8 @@
 /usr/lib(64)?/xen/bin(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 
 /usr/libexec(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/usr/libsexec/sesh		--	gen_context(system_u:object_r:shell_exec_t,s0)
+
 /usr/libexec/openssh/sftp-server --	gen_context(system_u:object_r:bin_t,s0)
 
 /usr/local/lib(64)?/ipsec/.*	-- 	gen_context(system_u:object_r:bin_t,s0)
@@ -186,8 +187,12 @@
 /usr/local/Brother(/.*)?/lpd(/.*)?	gen_context(system_u:object_r:bin_t,s0)
 /usr/local/Printer/[^/]*/cupswrapper(/.*)? gen_context(system_u:object_r:bin_t,s0)
 /usr/local/Printer/[^/]*/lpd(/.*)?     	gen_context(system_u:object_r:bin_t,s0)
+/usr/local/linuxprinter/filters(/.*)?   gen_context(system_u:object_r:bin_t,s0)
 
+/usr/bin/scponly		--	gen_context(system_u:object_r:shell_exec_t,s0)
+/usr/sbin/scponlyc		--	gen_context(system_u:object_r:shell_exec_t,s0)
 /usr/sbin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
+/usr/sbin/smrsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 
 /usr/share/apr-0/build/[^/]+\.sh --	gen_context(system_u:object_r:bin_t,s0)
 /usr/share/apr-0/build/libtool --	gen_context(system_u:object_r:bin_t,s0)
@@ -214,9 +219,11 @@
 /etc/gdm/[^/]+/.*			gen_context(system_u:object_r:bin_t,s0)
 
 /usr/lib/.*/program(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/usr/lib64/.*/program(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib/bluetooth(/.*)?	--      gen_context(system_u:object_r:bin_t,s0)
-/usr/lib/vmware-tools/sbin32(/.*)?      gen_context(system_u:object_r:bin_t,s0)
 /usr/lib64/bluetooth(/.*)?	--      gen_context(system_u:object_r:bin_t,s0)
+/usr/lib/vmware-tools/sbin32(/.*)?      gen_context(system_u:object_r:bin_t,s0)
+/usr/lib/vmware-tools/sbin64(/.*)?      gen_context(system_u:object_r:bin_t,s0)
 /usr/share/authconfig/authconfig-gtk\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/authconfig/authconfig-tui\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/authconfig/authconfig\.py --	gen_context(system_u:object_r:bin_t,s0)
@@ -285,3 +292,13 @@
 ifdef(`distro_suse',`
 /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
 ')
+/usr/lib(64)?/nspluginwrapper/npconfig	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/nspluginwrapper/npviewer	gen_context(system_u:object_r:bin_t,s0)
+
+/usr/lib(64)?/ConsoleKit/scripts(/.*)?  gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/ConsoleKit/run-session.d(/.*)?  gen_context(system_u:object_r:bin_t,s0)
+/etc/ConsoleKit/run-session.d(/.*)?  gen_context(system_u:object_r:bin_t,s0)
+
+/lib/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:bin_t,s0)
+/lib64/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:bin_t,s0)
+
--- nsaserefpolicy/policy/modules/kernel/corecommands.if	2008-05-29 15:57:37.000000000 -0400
+++ serefpolicy-3.4.1/policy/modules/kernel/corecommands.if	2008-06-11 10:06:56.000000000 -0400
@@ -894,6 +894,7 @@
 
 	read_lnk_files_pattern($1,bin_t,bin_t)
 	can_exec($1,chroot_exec_t)
+	allow $1 self:capability sys_chroot;
 ')
 
 ########################################

--------------050404060403020609090106
Content-Type: application/pgp-signature;
 name="kernel_corecommands.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kernel_corecommands.patch.sig"

iEYEABECAAYFAkhP/qIACgkQrlYvE4MpobMZUwCfVOl/uih/BoICGPVecRDILKwNXcwAoKD5
lUWEESsE6qW2VWNdS19DRsvU
--------------050404060403020609090106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
