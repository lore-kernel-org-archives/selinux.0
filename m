Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MFCxgA016724
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 11:13:00 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 11:08:53 -0400
Message-Id: <1114182533.10476.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.23.13 2005-04-22
* Merged more changes from Dan Walsh to initrc_t for removal of
unconfined_domain.
* Merged Dan Walsh's split of auditd policy into auditd_t for the audit
daemon and auditctl_t for the autoctl program.
* Added use of name_connect to uncond_can_ypbind macro by Dan Walsh.
* Merged other cleanup and fixes by Dan Walsh.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
