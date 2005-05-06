Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j46KqvgA020086
	for <selinux@tycho.nsa.gov>; Fri, 6 May 2005 16:52:58 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Fri, 06 May 2005 16:52:18 -0400
Message-Id: <1115412738.3271.1.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.23.15 2005-05-06
* Added tripwire and yam policy from David Hampton.
* Merged minor fixes to amavid and a clarification to the httpdcontent
attribute comments from David Hampton.
* Merged patch from Dan Walsh.  Includes fixes for restorecon, games,
and postfix from Russell Coker.  Adds support for debugfs.  Restores
support for reiserfs.  Allows udev to work with tmpfs_t before /dev is
labled.  Removes transition from sysadm_t (unconfined_t) to ifconfig_t
for the targeted policy.  Other minor cleanups and fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
