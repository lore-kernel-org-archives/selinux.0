Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06084
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 09:20:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA09961
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:19:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA09957 for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:19:30 GMT
Date: Thu, 13 Jun 2002 09:20:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Emge <emger@norwich.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: XFS and LSM
In-Reply-To: <20030708180754.1bc130f8.emger@norwich.edu>
Message-ID: <Pine.GSO.4.33.0206130911470.23212-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 8 Jul 2003, Ryan Emge wrote:

> ext2 and ext3 would be optimum filesystems that would not "break" SE Linux?

SELinux works fine with ext2 and ext3.  It has also been reported to work
with reiserfs, although we have not tested it ourselves.

With regard to XFS in general, see my prior message on the topic at
http://marc.theaimsgroup.com/?l=selinux&m=101300861319394&w=2.  With
regard to the quota changes, these can be easily addressed by backporting
the corresponding changes to SELinux from the 2.5 SELinux module.
Likewise, the LSM and SELinux changes related to the *xattr operations can
be backported from the 2.5 SELinux module.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
