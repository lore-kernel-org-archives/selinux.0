Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MHYuNs024618
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 13:34:56 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MHVcK1007302
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 17:31:38 GMT
Subject: Re: [gentoo-hardened] mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: gentoo-hardened@lists.gentoo.org
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <435A91E4.28438.A530F894@pageexec.freemail.hu>
References: <435A7CA9.4596.A4DE07A0@pageexec.freemail.hu>
	 <435A91E4.28438.A530F894@pageexec.freemail.hu>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 18:31:35 +0100
Message-Id: <1130002295.5415.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 19:24 +0200, pageexec@freemail.hu wrote:
> On 22 Oct 2005 at 17:37, Antoine Martin wrote:
> > scanelf -T /usr/lib/libmysqlclient.so.14
> > shows nothing at all.
> > (I also tried adding a -R, even -a shows nothing!)
> 
> ok, so it's not textrels, can you post an strace output then?
Ah, I thought I could, but strace won't run in enforcing mode (which is needed to make it break)
strace: ptrace(PTRACE_TRACEME, ...): Permission denied

And since there is no audit message, I don't know how to allow it.

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
