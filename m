Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5U8n4xF015612
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 04:49:05 -0400
Received: from ip-4ffd.proline.net.ua ([93.126.79.253]
 helo=localhost.localdomain)
 by frv157.fwdcdn.com with esmtpsa ID 1fZBWT-0006JF-Qw
 for selinux@tycho.nsa.gov; Sat, 30 Jun 2018 11:46:25 +0300
From: Yuri Chornoivan <yurchor@ukr.net>
To: selinux@tycho.nsa.gov
Date: Sat, 30 Jun 2018 11:46:25 +0300
Message-ID: <8230410.BG831gSa8N@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3358758.YTGUBmAEX3"
Subject: [PATCH] Fix minor typos
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.

--nextPart3358758.YTGUBmAEX3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Attached is a minor fix for the typos in selinux's git/master. Many thanks for 
fixing them.

The patch is also available here:

https://github.com/fedora-selinux/selinux/pull/52/commits/
7731e8fe46bce06a4915e5b772ce237b3021865b

Best regards,
Yuri
--nextPart3358758.YTGUBmAEX3
Content-Disposition: attachment; filename="0001-Fix-minor-typos.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Fix-minor-typos.patch"

>From 7731e8fe46bce06a4915e5b772ce237b3021865b Mon Sep 17 00:00:00 2001
From: Yuri Chornoivan <yurchor@ukr.net>
Date: Sat, 30 Jun 2018 11:33:23 +0300
Subject: [PATCH] Fix minor typos

---
 gui/html_util.py                                   | 2 +-
 libselinux/include/selinux/restorecon.h            | 4 ++--
 libselinux/man/man3/selinux_policy_root.3          | 2 +-
 libselinux/man/man3/selinux_restorecon_xattr.3     | 2 +-
 libselinux/src/selinux_restorecon.c                | 2 +-
 libsemanage/man/man3/semanage_count.3              | 2 +-
 libsemanage/man/man3/semanage_list.3               | 2 +-
 libsepol/src/node_record.c                         | 2 +-
 mcstrans/man/man8/setrans.conf.8                   | 2 +-
 python/semanage/seobject.py                        | 2 +-
 python/sepolicy/sepolicy-interface.8               | 2 +-
 python/sepolicy/sepolicy/help/system_boot_mode.txt | 2 +-
 python/sepolicy/sepolicy/manpage.py                | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/gui/html_util.py b/gui/html_util.py
index e93c20c7..420f6b96 100644
--- a/gui/html_util.py
+++ b/gui/html_util.py
@@ -145,7 +145,7 @@ def html_to_text(html, maxcol=80):
 
 def html_document(*body_components):
     '''Wrap the body components in a HTML document structure with a valid header.
-    Accepts a variable number of arguments of of which canb be:
+    Accepts a variable number of arguments of which can be:
     * string
     * a sequences of strings (tuple or list).
     * a callable object taking no parameters and returning a string or sequence of strings.
diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index de694cd9..595e7728 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -36,8 +36,8 @@ extern int selinux_restorecon(const char *pathname,
  */
 #define SELINUX_RESTORECON_NOCHANGE			0x0002
 /*
- * If set set change file label to that in spec file.
- * If not only change type component to that in spec file.
+ * If set, change file label to that in spec file.
+ * If not, only change type component to that in spec file.
  */
 #define SELINUX_RESTORECON_SET_SPECFILE_CTX		0x0004
 /*
diff --git a/libselinux/man/man3/selinux_policy_root.3 b/libselinux/man/man3/selinux_policy_root.3
index 63dc9010..75ac8ec0 100644
--- a/libselinux/man/man3/selinux_policy_root.3
+++ b/libselinux/man/man3/selinux_policy_root.3
@@ -18,7 +18,7 @@ reads the contents of the
 file to determine which policy files should be used for this machine.
 .
 .BR selinux_set_policy_root ()
-sets up all all policy paths based on the alternate root
+sets up all policy paths based on the alternate root
 
 .I /etc/selinux/config
 file to determine which policy files should be used for this machine.
diff --git a/libselinux/man/man3/selinux_restorecon_xattr.3 b/libselinux/man/man3/selinux_restorecon_xattr.3
index 7280c958..516d2669 100644
--- a/libselinux/man/man3/selinux_restorecon_xattr.3
+++ b/libselinux/man/man3/selinux_restorecon_xattr.3
@@ -119,7 +119,7 @@ By default
 .BR selinux_restorecon_xattr (3)
 will use the default set of specfiles described in
 .BR files_contexts (5)
-to calculate the initial SHA1 digest to be used for comparision.
+to calculate the initial SHA1 digest to be used for comparison.
 To change this default behavior
 .BR selabel_open (3)
 must be called specifying the required
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index ced41152..41f22250 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -116,7 +116,7 @@ static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
  *
  *  check_excluded() - Check if directory/fs is to be excluded when relabeling.
  *
- *  file_system_count() - Calculates the the number of files to be processed.
+ *  file_system_count() - Calculates the number of files to be processed.
  *                        The count is only used if SELINUX_RESTORECON_PROGRESS
  *                        is set and a mass relabel is requested.
  *
diff --git a/libsemanage/man/man3/semanage_count.3 b/libsemanage/man/man3/semanage_count.3
index b865a217..4fcafffe 100644
--- a/libsemanage/man/man3/semanage_count.3
+++ b/libsemanage/man/man3/semanage_count.3
@@ -23,7 +23,7 @@ The count function will return the number of all objects in the selected locatio
 .B Parameters:
 The 
 .I handle
-is used to track persistent state across semanage calls, and for error reporting. The number of objects will be stored at the location poined by 
+is used to track persistent state across semanage calls, and for error reporting. The number of objects will be stored at the location pointed by 
 .I response.
 
 .TP
diff --git a/libsemanage/man/man3/semanage_list.3 b/libsemanage/man/man3/semanage_list.3
index acc161fe..47d63b94 100644
--- a/libsemanage/man/man3/semanage_list.3
+++ b/libsemanage/man/man3/semanage_list.3
@@ -25,7 +25,7 @@ The list function will return an array of all the objects in the selected locati
 .B Parameters:
 The 
 .I handle
-is used to track persistent state across semanage calls, and for error reporting. The function will allocate and populate the the array of objects, and store it at the location pointed by  
+is used to track persistent state across semanage calls, and for error reporting. The function will allocate and populate the array of objects, and store it at the location pointed by  
 .I objects.
 It will write the number of objects at the location pointed by 
 .I count.
diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
index 6189c312..f3e78ff3 100644
--- a/libsepol/src/node_record.c
+++ b/libsepol/src/node_record.c
@@ -83,7 +83,7 @@ static int node_parse_addr(sepol_handle_t * handle,
 }
 
 /* Allocates a sufficiently large buffer (addr, addr_sz)
- * according the the protocol */
+ * according to the protocol */
 
 static int node_alloc_addr(sepol_handle_t * handle,
 			   int proto, char **addr, size_t * addr_sz)
diff --git a/mcstrans/man/man8/setrans.conf.8 b/mcstrans/man/man8/setrans.conf.8
index dcf29b7d..b7609921 100644
--- a/mcstrans/man/man8/setrans.conf.8
+++ b/mcstrans/man/man8/setrans.conf.8
@@ -59,7 +59,7 @@ defines a translation of s15:c0.c1023 to SystemHigh. c0.c1023 is shorthand for a
 
 .TP 
 s0\-s15:c0.c1023=SystemLow\-SystemHigh\fR
-defines a range translation of of s0\-s15:c0.c1023 to SystemLow\-SystemHigh. The two range components are separated by a dash.
+defines a range translation of s0\-s15:c0.c1023 to SystemLow\-SystemHigh. The two range components are separated by a dash.
 
 .TP 
 s0:c0=PatientRecord\fR
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index c76dce85..1ec3cc52 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2299,7 +2299,7 @@ class fcontextRecords(semanageRecords):
             raise ValueError(_("Target %s is not valid. Target is not allowed to end with '/'") % target)
 
         if substitute != "/" and substitute[-1] == "/":
-            raise ValueError(_("Substiture %s is not valid. Substitute is not allowed to end with '/'") % substitute)
+            raise ValueError(_("Substitute %s is not valid. Substitute is not allowed to end with '/'") % substitute)
 
         if target in self.equiv.keys():
             raise ValueError(_("Equivalence class for %s already exists") % target)
diff --git a/python/sepolicy/sepolicy-interface.8 b/python/sepolicy/sepolicy-interface.8
index 02c4c1a5..3e74ea62 100644
--- a/python/sepolicy/sepolicy-interface.8
+++ b/python/sepolicy/sepolicy-interface.8
@@ -31,7 +31,7 @@ List all interfaces
 List all domains with SELinux user role interface
 .TP
 .I                \-v, \-\-verbose
-Display extended information about the interface including parameters and desctiprion if available.
+Display extended information about the interface including parameters and description if available.
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/sepolicy/sepolicy/help/system_boot_mode.txt b/python/sepolicy/sepolicy/help/system_boot_mode.txt
index e8482d73..350873d6 100644
--- a/python/sepolicy/sepolicy/help/system_boot_mode.txt
+++ b/python/sepolicy/sepolicy/help/system_boot_mode.txt
@@ -10,4 +10,4 @@ SELinux Systems can boot in three different modes.
 
 You can use this screen to change the enforcing mode.
 
-Note if you disable SELinux, you will need to to reboot, to turn it off.  Also the next time you turn SELinux on, a full system relabel will be performed.
+Note if you disable SELinux, you will need to reboot, to turn it off.  Also the next time you turn SELinux on, a full system relabel will be performed.
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 8121e5cf..751f45a9 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -1260,7 +1260,7 @@ USERNAME ALL=(ALL) ROLE=%(user)s_r TYPE=%(user)s_t COMMAND
 .br
 sudo will run COMMAND as staff_u:%(user)s_r:%(user)s_t:LEVEL
 
-When using a a non login role, you need to setup SELinux so that your SELinux user can reach %(user)s_r role.
+When using a non login role, you need to setup SELinux so that your SELinux user can reach %(user)s_r role.
 
 Execute the following to see all of the assigned SELinux roles:
 
-- 
2.13.7


--nextPart3358758.YTGUBmAEX3--
