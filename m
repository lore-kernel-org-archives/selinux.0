Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24KUj1w011744
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:30:45 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24KUitr025035
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 20:30:44 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n24KUdYr008906
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:30:39 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n24KUdaI014442
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:30:39 -0500
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n24KUaQM012013
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 15:30:38 -0500
Message-ID: <49AEE4EC.6050002@redhat.com>
Date: Wed, 04 Mar 2009 15:30:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to libselinux to add svirt/virtual_domain context files.
Content-Type: multipart/mixed;
 boundary="------------030509090800070905090903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030509090800070905090903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

libvirt/svirt is being released to Rawhide today.  Needed to modify
libselinux to allow policy writers to define the default domain context
to run virtual images and and the default file context to label virtual
images.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmu5OsACgkQrlYvE4MpobMdKQCg3UXGHdCZ3HdNc5bQMbtnq2MK
IRYAn09zs3VTSeJb1IY+zJ5UV96sCPFh
=Kfww
-----END PGP SIGNATURE-----

--------------030509090800070905090903
Content-Type: text/plain;
 name="libselinux-svirt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-svirt.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-2.0.78/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2009-01-05 17:45:35.000000000 -0500
+++ libselinux-2.0.78/include/selinux/selinux.h	2009-03-04 15:23:52.000000000 -0500
@@ -459,6 +459,8 @@
 extern const char *selinux_file_context_local_path(void);
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
+extern const char *selinux_virtual_domain_context_path(void);
+extern const char *selinux_virtual_image_context_path(void);
 extern const char *selinux_x_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-2.0.78/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2009-01-05 17:45:35.000000000 -0500
+++ libselinux-2.0.78/src/file_path_suffixes.h	2009-03-04 15:23:52.000000000 -0500
@@ -20,3 +20,5 @@
     S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
     S_(X_CONTEXTS, "/contexts/x_contexts")
     S_(COLORS, "/secolor.conf")
+    S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
+    S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-2.0.78/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2009-01-05 17:45:35.000000000 -0500
+++ libselinux-2.0.78/src/selinux_config.c	2009-03-04 15:23:52.000000000 -0500
@@ -40,7 +40,9 @@
 #define SECURETTY_TYPES   18
 #define X_CONTEXTS        19
 #define COLORS            20
-#define NEL               21
+#define VIRTUAL_DOMAIN    21
+#define VIRTUAL_IMAGE     22
+#define NEL               23
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -391,3 +393,17 @@
 }
 
 hidden_def(selinux_x_context_path)
+
+const char *selinux_virtual_domain_context_path()
+{
+	return get_path(VIRTUAL_DOMAIN);
+}
+
+hidden_def(selinux_virtual_domain_context_path)
+
+const char *selinux_virtual_image_context_path()
+{
+	return get_path(VIRTUAL_IMAGE);
+}
+
+hidden_def(selinux_virtual_image_context_path)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-2.0.78/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2009-01-05 17:45:35.000000000 -0500
+++ libselinux-2.0.78/src/selinux_internal.h	2009-03-04 15:23:52.000000000 -0500
@@ -56,6 +56,8 @@
     hidden_proto(selinux_securetty_types_path)
     hidden_proto(selinux_failsafe_context_path)
     hidden_proto(selinux_removable_context_path)
+    hidden_proto(selinux_virtual_domain_context_path)
+    hidden_proto(selinux_virtual_image_context_path)
     hidden_proto(selinux_file_context_path)
     hidden_proto(selinux_file_context_homedir_path)
     hidden_proto(selinux_file_context_local_path)

--------------030509090800070905090903
Content-Type: application/pgp-signature;
 name="libselinux-svirt.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libselinux-svirt.patch.sig"

iEYEABECAAYFAkmu5OsACgkQrlYvE4MpobMViwCffJ0M78Gg0d0zQ00DeEBVTjrGYRUAnily
BZBFO6MQy8PBDt+d74zYwISk
--------------030509090800070905090903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
