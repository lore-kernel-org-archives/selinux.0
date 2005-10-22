Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MGf8Ns024210
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 12:41:08 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MGbTM0022135
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 16:37:29 GMT
Subject: Re: [gentoo-hardened] mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: gentoo-hardened@lists.gentoo.org
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <435A7CA9.4596.A4DE07A0@pageexec.freemail.hu>
References: <435A6E83.15754.A4A6C273@pageexec.freemail.hu>
	 <435A7CA9.4596.A4DE07A0@pageexec.freemail.hu>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 17:37:48 +0100
Message-Id: <1129999068.31615.69.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 17:53 +0200, pageexec@freemail.hu wrote:
> On 22 Oct 2005 at 16:45, Antoine Martin wrote:
> > > what does scanelf -T /usr/lib/libmysqlclient.so.14 report?
> > > if it's not text relocs, then post an strace please.
> > Is scanelf a PaX tool?
> 
> app-misc/pax-utils
Thanks,

scanelf -T /usr/lib/libmysqlclient.so.14
shows nothing at all.
(I also tried adding a -R, even -a shows nothing!)

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
