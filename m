Message-ID: <41F521F0.7090108@redhat.com>
Date: Mon, 24 Jan 2005 11:27:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Change fixfiles to use file_context.local if it exists.
Content-Type: multipart/mixed;
 boundary="------------090906040402010702030407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090906040402010702030407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090906040402010702030407
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.1/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-01-24 11:19:10.103136000 -0500
+++ policycoreutils-1.21.1/scripts/fixfiles	2005-01-24 11:19:28.998223000 -0500
@@ -37,11 +37,19 @@
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
-    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts
+    FC=`mktemp /var/tmp/file_contexts.XXXXXX`
+    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null
 else
     FC=/etc/security/selinux/file_contexts
 fi
 
+cleanup() {
+    if [ -e /etc/selinux/config -a -f "$FC" ]; then
+	rm -f $FC
+    fi
+}
+trap "cleanup" 0 1 2 3 13 15
+
 #
 # Log to either syslog or a LOGFILE
 #

--------------090906040402010702030407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
