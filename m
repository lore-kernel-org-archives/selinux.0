Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94EG8rT017942
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 10:16:08 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94EF0YE013721
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 14:15:00 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 7B94ABFA4
	for <selinux@tycho.nsa.gov>; Mon,  4 Oct 2004 15:15:58 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CETo0-0005X9-3V
	for selinux@tycho.nsa.gov; Mon, 04 Oct 2004 15:27:12 +0100
Date: Mon, 4 Oct 2004 15:27:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: bug in 2.6.8.1 scsi_block.c for CDROM "get configuration" ioctl
Message-ID: <20041004142712.GF20930@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

the following patch needs to be added in order for k3b to operate
correctly as a non-root user (there's a linux capability check in
scsi_ioctl.c's verify_command() function)

apparently this is fixed for 2.6.9-rcsomething.

l.


Index: drivers/block/scsi_ioctl.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/drivers/block/scsi_ioctl.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 scsi_ioctl.c
--- drivers/block/scsi_ioctl.c	19 Aug 2004 14:25:16 -0000	1.1.1.9
+++ drivers/block/scsi_ioctl.c	4 Oct 2004 14:07:25 -0000
@@ -146,6 +146,7 @@
 		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
 		safe_for_read(GPCMD_REPORT_KEY),
 		safe_for_read(GPCMD_SCAN),
+		safe_for_read(GPCMD_GET_CONFIGURATION),
 
 		/* Basic writing commands */
 		safe_for_write(WRITE_6),
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
