Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83M9srT011006
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 18:09:54 -0400 (EDT)
Message-Id: <200409032208.i83M8hBD022466@mms-r00.iijmio.jp>
Date: Fri, 03 Sep 2004 18:08:35 -0400
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: reiferfs in SUSE9.1
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1094219636.19206.135.camel@moss-spartans.epoch.ncsc.mil>
References: <1094219636.19206.135.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley  wrote:
> reiserfs is known to not work with SELinux.  There is a deadlock in the
> reiserfs xattr code when interacting with SELinux, and there is no way
> presently for reiserfs to inform SELinux that it shouldn't try to
> mediate access to the internal directories and files used to store the
> xattrs.  reiserfs maintainers know about the issues, but not clear that
> they care...

Thank you. I'll use ext3.


---
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
http://www.selinux.gr.jp/
The George Washington University



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
