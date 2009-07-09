Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n69K7EYJ028622
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:07:14 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n69K7s1f013946
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 20:07:54 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n69K7CtB008741
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:07:12 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n69K7BAU030935
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:07:12 -0400
Received: from localhost.localdomain (vpn-12-24.rdu.redhat.com [10.11.12.24])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n69K76PF022820
	for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2009 16:07:06 -0400
Message-ID: <4A564DE2.30200@redhat.com>
Date: Thu, 09 Jul 2009 16:06:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fixfiles has a bug when looking at btrfs file systems.
Content-Type: multipart/mixed;
 boundary="------------060507010503000302050805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060507010503000302050805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060507010503000302050805
Content-Type: text/plain;
 name="policycoreutils-fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2009-06-23 15:36:07.000000000 -0400
+++ policycoreutils-2.0.67/scripts/fixfiles	2009-07-07 16:47:35.000000000 -0400
@@ -129,7 +129,7 @@
 if [ ! -z "$FILEPATH" ]; then
     if [ -x /usr/bin/find ]; then
 	/usr/bin/find "$FILEPATH" \
-	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o fstype btrfs \) -prune  -o -print0 | \
+	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o -print0 | \
 	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
     else
 	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE

--------------060507010503000302050805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
