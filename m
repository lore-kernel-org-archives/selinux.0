Subject: [patch 0/2] libselinux: add support for getting contexts for
	kernel initial SIDs from selinuxfs
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 06 Apr 2007 15:37:13 -0400
Message-Id: <1175888233.25329.83.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patches add support to libselinux to get either the context or
userspace SID for a kernel initial security identifier specified by name
from the selinuxfs interface.

They are different from KaiGai's patch in that the kernel initial SID is
specified by name rather than by an integer.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
