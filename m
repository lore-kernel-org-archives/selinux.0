Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5UBNCSI021354
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 07:23:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 41HrjT3J1Bz34qRT
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 11:23:09 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 41HrjR1rP8z34qRN
 for <selinux@tycho.nsa.gov>; Sat, 30 Jun 2018 11:23:07 +0000 (UTC)
Received: from ip-4ffd.proline.net.ua ([93.126.79.253]
 helo=localhost.localdomain)
 by frv149.fwdcdn.com with esmtpsa ID 1fZDy0-000Hbi-Ou
 for selinux@tycho.nsa.gov; Sat, 30 Jun 2018 14:23:00 +0300
From: Yuri Chornoivan <yurchor@ukr.net>
To: selinux <selinux@tycho.nsa.gov>
Date: Sat, 30 Jun 2018 14:22:59 +0300
Message-ID: <4626168.H9xaOJR6cL@localhost.localdomain>
In-Reply-To: <CAJfZ7=m6+TE-wKorvjxp6zUn3UQw_Ju2qrA5QqJRmgmPWJs+yg@mail.gmail.com>
References: <8230410.BG831gSa8N@localhost.localdomain>
 <CAJfZ7=m6+TE-wKorvjxp6zUn3UQw_Ju2qrA5QqJRmgmPWJs+yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1922878.6qEBsjPUR4"
Subject: Re: [PATCH] Fix minor typos
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.

--nextPart1922878.6qEBsjPUR4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=D1=81=D1=83=D0=B1=D0=BE=D1=82=D0=B0, 30 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=
=8F 2018 =D1=80. 12:55:42 EEST =D0=B2=D0=B8 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BB=D0=B8:
> On Sat, Jun 30, 2018 at 10:46 AM, Yuri Chornoivan <yurchor@ukr.net> wrote:
> > Hi,
> >=20
> > Attached is a minor fix for the typos in selinux's git/master. Many tha=
nks
> > for fixing them.
> >=20
> > The patch is also available here:
> >=20
> > https://github.com/fedora-selinux/selinux/pull/52/commits/
> > 7731e8fe46bce06a4915e5b772ce237b3021865b
>=20
> Hello,
> Your patch does not apply cleanly on
> https://github.com/SELinuxProject/selinux master branch because the
> typo in libselinux/man/man3/selinux_restorecon_xattr.3 has already
> been fixed, with
> https://github.com/SELinuxProject/selinux/commit/f42c3d4564322af9d6f57386=
0a1
> 48f07abb36a6f . Otherwise its content looks good to me. Thanks!
>=20
> On the way you sent your patch, we prefer inline patches (sent with
> "git send-email" for example) and we require a "Signed-off-by:" line
> in the description. Could you please update the description, remove
> the part which has already been fixed and send this patch again?
>=20
> Thanks,
> Nicolas

Many thanks for your review. The updated patch with a couple more fixes is=
=20
attached.

=46or some reason, 'git send-mail' does not work for my email provider ("Un=
able=20
to initialize SMTP properly.", other clients like KMail and Trojita work=20
fine). Sorry.

Best regards,
Yuri

--nextPart1922878.6qEBsjPUR4
Content-Disposition: attachment; filename="0001-Fix-minor-typos.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Fix-minor-typos.patch"

>From 5103283629018e7a9e3ebf56b3114a7ba905f925 Mon Sep 17 00:00:00 2001
From: Yuri Chornoivan <yurchor@ukr.net>
Date: Sat, 30 Jun 2018 13:51:24 +0300
Subject: [PATCH] Fix minor typos

Signed-off-by: Yuri Chornoivan <yurchor@ukr.net>
---
 gui/html_util.py                                   | 2 +-
 libselinux/include/selinux/restorecon.h            | 4 ++--
 libselinux/man/man3/selinux_policy_root.3          | 2 +-
 libselinux/man/man5/virtual_domain_context.5       | 2 +-
 libselinux/man/man5/virtual_image_context.5        | 2 +-
 libselinux/src/selinux_restorecon.c                | 2 +-
 libsemanage/man/man3/semanage_count.3              | 2 +-
 libsemanage/man/man3/semanage_list.3               | 2 +-
 libsepol/src/node_record.c                         | 2 +-
 mcstrans/man/man8/setrans.conf.8                   | 2 +-
 python/semanage/seobject.py                        | 2 +-
 python/sepolicy/sepolicy-interface.8               | 2 +-
 python/sepolicy/sepolicy/help/system_boot_mode.txt | 2 +-
 python/sepolicy/sepolicy/manpage.py                | 2 +-
 sandbox/seunshare.8                                | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

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
diff --git a/libselinux/man/man5/virtual_domain_context.5 b/libselinux/man/man5/virtual_domain_context.5
index 2f555a0d..a76fe145 100644
--- a/libselinux/man/man5/virtual_domain_context.5
+++ b/libselinux/man/man5/virtual_domain_context.5
@@ -5,7 +5,7 @@ virtual_domain_context \- The SELinux virtual machine domain context configurati
 .SH "DESCRIPTION"
 The
 .I virtual_domain_context
-file contains a list of domain contexts that are available for use by the SELinux-aware virtulization API libvirt (see \fBlibvirtd\fR(8)).
+file contains a list of domain contexts that are available for use by the SELinux-aware virtualization API libvirt (see \fBlibvirtd\fR(8)).
 .sp
 .BR selinux_virtual_domain_context_path "(3) "
 will return the active policy path to this file. The default virtual domain context file is:
diff --git a/libselinux/man/man5/virtual_image_context.5 b/libselinux/man/man5/virtual_image_context.5
index 04cbd791..df1c0e90 100644
--- a/libselinux/man/man5/virtual_image_context.5
+++ b/libselinux/man/man5/virtual_image_context.5
@@ -5,7 +5,7 @@ virtual_image_context \- The SELinux virtual machine image context configuration
 .SH "DESCRIPTION"
 The
 .I virtual_image_context
-file contains a list of image contexts for use by the SELinux-aware virtulization API libvirt (see \fBlibvirtd\fR(8)).
+file contains a list of image contexts for use by the SELinux-aware virtualization API libvirt (see \fBlibvirtd\fR(8)).
 .sp
 .BR selinux_virtual_image_context_path "(3) "
 will return the active policy path to this file. The default virtual image context file is:
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
index b865a217..6ff89be3 100644
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
index acc161fe..0e1ca7b4 100644
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
index d3e14a8b..e5c81a7d 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2291,7 +2291,7 @@ class fcontextRecords(semanageRecords):
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
index ed8cb71c..cb211ba0 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -1283,7 +1283,7 @@ USERNAME ALL=(ALL) ROLE=%(user)s_r TYPE=%(user)s_t COMMAND
 .br
 sudo will run COMMAND as staff_u:%(user)s_r:%(user)s_t:LEVEL
 
-When using a a non login role, you need to setup SELinux so that your SELinux user can reach %(user)s_r role.
+When using a non login role, you need to setup SELinux so that your SELinux user can reach %(user)s_r role.
 
 Execute the following to see all of the assigned SELinux roles:
 
diff --git a/sandbox/seunshare.8 b/sandbox/seunshare.8
index 9e105a19..0da35261 100644
--- a/sandbox/seunshare.8
+++ b/sandbox/seunshare.8
@@ -16,7 +16,7 @@ within the specified context, using the alternate home directory and /tmp direct
 Alternate homedir to be used by the application.  Homedir must be owned by the user.
 .TP
 \fB\-t\ tmpdir
-Use alternate tempory directory to mount on /tmp.  tmpdir must be owned by the user.
+Use alternate temporary directory to mount on /tmp.  tmpdir must be owned by the user.
 .TP
 \fB\-C --capabilities\fR
 Allow apps executed within the namespace to use capabilities.  Default is no capabilities.
-- 
2.13.7


--nextPart1922878.6qEBsjPUR4--
