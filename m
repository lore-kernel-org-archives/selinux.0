Message-ID: <443BF4FD.9040906@redhat.com>
Date: Tue, 11 Apr 2006 14:27:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Python changes for libselinux
Content-Type: multipart/mixed;
 boundary="------------080100000401090201060609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080100000401090201060609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

t_output_helper is going away.

matchpathcon did not work.

--------------080100000401090201060609
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.30.1/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2006-01-04 10:37:35.000000000 -0500
+++ libselinux-1.30.1/src/selinuxswig.i	2006-04-11 14:23:41.000000000 -0400
@@ -29,8 +29,9 @@
 	$1 = &temp;
 }
 %typemap(argout) security_context_t * {
-	$result = t_output_helper($result, PyString_FromString(*$1));
+	$result = SWIG_Python_AppendOutput($result, PyString_FromString(*$1));
 }
+%typedef unsigned mode_t;
 
 extern int is_selinux_enabled(void);
 extern int is_selinux_mls_enabled(void);
@@ -114,6 +115,6 @@
 }
 
 %typemap(argout) char ** {
-	$result = t_output_helper($result, PyString_FromString(*$1));
+	$result = SWIG_Python_AppendOutput($result, PyString_FromString(*$1));
 }
 extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);

--------------080100000401090201060609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
