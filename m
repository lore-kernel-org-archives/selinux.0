Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PE49La024023
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 10:04:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7PE47fF024681
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 14:04:07 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
        by jazzband.ncsc.mil  with ESMTP id h7PE46Hd024636 for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 14:04:06 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PE45sE014886
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 10:04:05 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7PE45XP014884
	for selinux@tycho.nsa.gov; Mon, 25 Aug 2003 10:04:05 -0400
Date: Mon, 25 Aug 2003 09:51:14 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: initrd vs initramfs
Message-ID: <20030824235114.GA2962@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

According to README from selinux-doc:

4) The initial policy load has been moved into userspace, and is
performed from an initrd (see the BUILDING AND INSTALLING
instructions below).  We will likely migrate to using initramfs in the
future for the initial policy.

Can anybody tell me the difference between the initrd system
and the initramfs system?

So far the only answer I have got is that they are the same. The
above text would imply that they are not the same though.

Sorry if this appears to be off-topic for this mailing list.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
