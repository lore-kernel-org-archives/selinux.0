Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6THQsrT020735
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:26:54 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6THQNbB004801
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 17:26:23 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1091121776.21971.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 13:22:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 13:06, James Morris wrote:
> This could be done by simply allowing context= to override any other 
> behavior, right?

context= only lets you map all inodes in the filesystem to a single
security context and prohibits getxattr/setxattr/setfscreatecon.  For
tmpfs, we want to allow individual inode labeling and
getxattr/setxattr/setfscreatecon, so that tmpfs can be used for /tmp or
/dev or shmem in differing ways.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
