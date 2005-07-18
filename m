Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IKN7gA001799
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 16:23:07 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6IKIwlV014131
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 20:18:59 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IKJJdD013229
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 16:19:19 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 16:19:22 -0400
Message-Id: <1121717962.3121.28.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.25.3 2005-07-18
* Merged patch from Dan Walsh.  Adds auth_bool attribute to allow
domains to have read access to shadow_t.  Creates pppd_can_insmod
boolean to control the loading of modem kernel modules.  Allows nfs to
export noexattrfile types.  Allows unix_chpwd to access cert files and
random devices for encryption purposes.  Other minor cleanups and fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
