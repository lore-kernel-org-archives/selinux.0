Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OKkbaI029515
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:46:37 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OKkto9020930
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 20:46:55 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1OKkaWk020951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:46:36 -0500
Received: from localhost.localdomain (vpn-11-226.rdu.redhat.com [10.11.11.226])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1OKkZGb007997
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:46:35 -0500
Message-ID: <4B85902B.70300@redhat.com>
Date: Wed, 24 Feb 2010 15:46:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Fixfiles using new setfiles/restorecon simplification
Content-Type: multipart/mixed;
 boundary="------------000504010704040903010201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000504010704040903010201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000504010704040903010201
Content-Type: text/plain;
 name="fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fixfiles.patch"

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index ae519fc..135835f 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -35,8 +35,8 @@ SYSLOGFLAG="-l"
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
-FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(rw/{print $3}';`
-FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs ).*\(ro/{print $3}';`
+FILESYSTEMSRW=`grep rw,seclabel /proc/self/mounts | awk '{ print $2 }'`
+FILESYSTEMSRO=`grep -v 'rw\|seclabel' /proc/self/mounts | awk '{ print $2 }'`
 FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
 SELINUXTYPE="targeted"
 if [ -e /etc/selinux/config ]; then
@@ -87,11 +87,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
                   esac; \
                fi; \
             done | \
-	while read pattern ; do sh -c "find $pattern \
-		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o \
-		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print0"; \
-		      done 2> /dev/null | \
-	 ${RESTORECON} $* -0 -f - 
+		      ${RESTORECON} -f - -R -p  -e /home -e /tmp -r /dev; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -126,13 +122,7 @@ if [ ! -z "$RPMFILES" ]; then
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
+    ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
     return
 fi
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
@@ -146,7 +136,7 @@ exit $?
 
 fullrelabel() {
     logit "Cleaning out /tmp"
-    find /tmp/ -mindepth 1 -print0 | xargs -0 /bin/rm -f
+    find /tmp/ -mindepth 1 -delete
     LogReadOnly
     restore
 }

--------------000504010704040903010201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
