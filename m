Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9O2n0Ns002263
	for <selinux@tycho.nsa.gov>; Sun, 23 Oct 2005 22:49:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9O2jQ09009943
	for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2005 02:45:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Antoine Martin <antoine@nagafix.co.uk>
Subject: Re: [gentoo-hardened] mysql 4.1 requires shlib_t:file execmod?
Date: Mon, 24 Oct 2005 12:45:11 +1000
Cc: gentoo-hardened@lists.gentoo.org, SELinux <selinux@tycho.nsa.gov>
References: <435A7CA9.4596.A4DE07A0@pageexec.freemail.hu> <435A91E4.28438.A530F894@pageexec.freemail.hu> <1130002295.5415.1.camel@localhost.localdomain>
In-Reply-To: <1130002295.5415.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510241245.20120.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 23 October 2005 03:31, Antoine Martin <antoine@nagafix.co.uk> wrote:
> On Sat, 2005-10-22 at 19:24 +0200, pageexec@freemail.hu wrote:
> > On 22 Oct 2005 at 17:37, Antoine Martin wrote:
> > > scanelf -T /usr/lib/libmysqlclient.so.14
> > > shows nothing at all.
> > > (I also tried adding a -R, even -a shows nothing!)
> >
> > ok, so it's not textrels, can you post an strace output then?
>
> Ah, I thought I could, but strace won't run in enforcing mode (which is
> needed to make it break) strace: ptrace(PTRACE_TRACEME, ...): Permission
> denied

It's easy to modify policy to allow this:

can_ptrace(sysadm_t, mysqld_t)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
