Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6BIWZgA010130
	for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2005 14:32:36 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6BISwd6013122
	for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2005 18:28:58 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6BIU2Zf010739
	for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2005 14:30:02 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 14:30:07 -0400
Message-Id: <1121106607.3252.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.25.2 2005-07-11
* Merged patch from Dan Walsh.  Added allow_ptrace boolean to allow
sysadm_t to ptrace and debug apps.  Gives auth_chkpwd the audit_control
and audit_write capabilities.  Stops targeted policy from transitioning
from unconfined_t to netutils.  Allows cupsd to audit messages.  Gives
prelink the execheap, execmem, and execstack permissions by default.
Adds can_winbind boolean and functions to better handle samba and
winbind communications.  Eliminates allow_execmod checks around
texrel_shlib_t libraries.  Other minor cleanups and fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
