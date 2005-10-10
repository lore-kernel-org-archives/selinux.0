Message-Id: <200510101950.j9AJoM83010842@mms-r00.iijmio.jp>
Date: Mon, 10 Oct 2005 15:50:05 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: swapon unsuppoted?
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

When I used swapon command, 
access vector "swapon" was not checked, 
only capability sys_admin was checked.
It seems that FILE__SWAPON does not exist in hooks.c

Is swapon unsupported in current version?

---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor:  http://seedit.sourceforge.net/



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
