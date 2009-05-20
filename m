Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KJ2WHe012198
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:02:32 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4KJ2Swd014597
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 19:02:29 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4KJ2V0H012490
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:02:31 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4KJ2UPv021858
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:02:31 -0400
Received: from localhost.localdomain (vpn-10-93.bos.redhat.com [10.16.10.93])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4KJ2U9P023370
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 15:02:30 -0400
Message-ID: <4A1453C9.6040506@redhat.com>
Date: Wed, 20 May 2009 15:02:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Add btrfs to fixfiles.
Content-Type: multipart/mixed;
 boundary="------------040504090606050008030306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040504090606050008030306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hopefully the last time we will ever need to update.  Once patch gets 
out with kernel support to tell me which file systems support xattr, we 
can remove this hack.

--------------040504090606050008030306
Content-Type: text/plain;
 name="policycoreutils-fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2009-05-18 13:53:14.000000000 -0400
+++ policycoreutils-2.0.62/scripts/fixfiles	2009-05-05 10:47:08.000000000 -0400
@@ -89,7 +89,7 @@
                fi; \
             done | \
 	while read pattern ; do sh -c "find $pattern \
-		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs \) -prune  -o \
+		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o \
 		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print0"; \
 		      done 2> /dev/null | \
 	 ${RESTORECON} $* -0 -f - 
@@ -129,7 +129,7 @@
 if [ ! -z "$FILEPATH" ]; then
     if [ -x /usr/bin/find ]; then
 	/usr/bin/find "$FILEPATH" \
-	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs \) -prune  -o -print0 | \
+	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o fstype btrfs \) -prune  -o -print0 | \
 	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
     else
 	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE

--------------040504090606050008030306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
