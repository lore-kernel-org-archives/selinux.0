Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDIqRhe005402
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:52:27 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDIqPCJ011275
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:52:26 GMT
Message-ID: <4D066B67.8060008@redhat.com>
Date: Mon, 13 Dec 2010 13:52:23 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Policycoreutils-scripts patch
Content-Type: multipart/mixed;
 boundary="------------000100030600070100030107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000100030600070100030107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Add man page for genhomedircon

Fix python scripts to use -Es
- -s stops python scripts from trying to read ~/.local directory for
shared libraries.

Fixfiles:
Added exclude_dirs to check if dirs exist and then exclude them from
restorecon call.  Add /var/lib/BackupPC to exclude list

Instead of excluding mounts based on hard coded types, I now look for
labeled in the /proc/self/mounts file

Use modern find command to delete files
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0Ga2cACgkQrlYvE4MpobNI8QCgm6vBA436RQndT603VUiJH2sb
oFEAoNt7WcOtspgYu8V3/OIpfpVLzx+W
=dfWL
-----END PGP SIGNATURE-----

--------------000100030600070100030107
Content-Type: text/plain;
 name="policycoreutils-scripts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-scripts.patch"

diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index 53b65b6..cc75a96 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -14,6 +14,7 @@ install: all
 	install -m 755 genhomedircon  $(SBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
+	install -m 644 genhomedircon.8 $(MANDIR)/man8/
 	install -m 644 chcat.8 $(MANDIR)/man8/
 
 clean:
diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
index 4038a99..9efcb22 100755
--- a/policycoreutils/scripts/chcat
+++ b/policycoreutils/scripts/chcat
@@ -1,4 +1,4 @@
-#! /usr/bin/python -E
+#! /usr/bin/python -Es
 # Copyright (C) 2005 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index ae519fc..0890811 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -21,6 +21,25 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 #
+# Get all mounted rw file systems that support seclabel
+#
+get_labeled_mounts() {
+# /dev is not listed in the mountab
+FS="`mount | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/\(rw/{print $3}';` /dev"
+for i in $FS; do 
+    grep --silent "$i ".*seclabel /proc/self/mounts && echo $i
+done
+}
+
+exclude_dirs() {
+    exclude= 
+    for i in /var/lib/BackupPC /home /tmp /dev; do 
+        [ -e $i ]  && exclude="$exclude -e $i"; 
+    done 
+    echo "$exclude"
+}
+
+#
 # Set global Variables
 #
 fullFlag=0
@@ -35,9 +54,7 @@ SYSLOGFLAG="-l"
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
-FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(rw/{print $3}';`
-FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(ro/{print $3}';`
-FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
+FILESYSTEMS=`get_labeled_mounts`
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
     . /etc/selinux/config
@@ -87,23 +104,10 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
                   esac; \
                fi; \
             done | \
-	while read pattern ; do sh -c "find $pattern \
-		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o \
-		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print0"; \
-		      done 2> /dev/null | \
-	 ${RESTORECON} $* -0 -f - 
+		      ${RESTORECON} -f - -R -p `exclude_dirs`; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
-#
-# Log all Read Only file systems 
-#
-LogReadOnly() {
-if [ ! -z "$FILESYSTEMSRO" ]; then
-    logit "Warning: Skipping the following R/O filesystems:"
-    logit "$FILESYSTEMSRO"
-fi
-}
 
 rpmlist() {
 rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
@@ -121,23 +125,16 @@ if [ ! -z "$PREFC" ]; then
 fi
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${FORCEFLAG} $* -R -i -f - 2>&1 >> $LOGFILE
+	rpmlist $i | ${RESTORECON} ${FORCEFLAG} $* -R -i -f - 2>&1 | cat >> $LOGFILE
     done
     exit $?
 fi
 if [ ! -z "$FILEPATH" ]; then
-    if [ -x /usr/bin/find ]; then
-	/usr/bin/find "$FILEPATH" \
-	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o -print0 | \
-	    ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
-    else
-	${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
-    fi
+    ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 | cat >> $LOGFILE
     return
 fi
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
-LogReadOnly
-${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
+${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMS} 2>&1 | cat >> $LOGFILE
 rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
 find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
 find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
@@ -146,8 +143,7 @@ exit $?
 
 fullrelabel() {
     logit "Cleaning out /tmp"
-    find /tmp/ -mindepth 1 -print0 | xargs -0 /bin/rm -f
-    LogReadOnly
+    find /tmp/ -mindepth 1 -delete
     restore
 }
 
diff --git a/policycoreutils/scripts/genhomedircon.8 b/policycoreutils/scripts/genhomedircon.8
new file mode 100644
index 0000000..6331660
--- /dev/null
+++ b/policycoreutils/scripts/genhomedircon.8
@@ -0,0 +1,37 @@
+.\" Hey, Emacs! This is an -*- nroff -*- source file.
+.\" Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation; either version 2 of
+.\" the License, or (at your option) any later version.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
+.\" USA.
+.\"
+.\"
+.TH GENHOMEDIRCON "8" "May 2010" "Security Enhanced Linux" "SELinux"
+.SH NAME
+genhomedircon \- generate SELinux file context configuration entries for user home directories 
+.SH SYNOPSIS
+.B genhomedircon
+is a script that executes semodule to rebuild policy and create the 
+labels for HOMEDIRS based on home directories returned by the getpw calls.
+
+This functionality is enabled via the usepasswd flag in /etc/selinux/semanage.conf.
+
+.SH AUTHOR
+This manual page was written by 
+.I Dan Walsh <dwalsh@redhat.com>

--------------000100030600070100030107
Content-Type: application/pgp-signature;
 name="policycoreutils-scripts.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-scripts.patch.sig"

iEYEABECAAYFAk0Ga2cACgkQrlYvE4MpobP3LgCeLGRDvgKe1giTiAejA5FyodLuYqUAoMsG
YxL6VTxH1UXPUL/QMc2uwFK3
--------------000100030600070100030107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
