Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MFn1Ns023929
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 11:49:01 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MFjNM0017956
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 15:45:23 GMT
Subject: Re: [gentoo-hardened] mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: gentoo-hardened@lists.gentoo.org
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <435A6E83.15754.A4A6C273@pageexec.freemail.hu>
References: <435A6E83.15754.A4A6C273@pageexec.freemail.hu>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 16:45:39 +0100
Message-Id: <1129995939.31615.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 16:53 +0200, pageexec@freemail.hu wrote:
> On 22 Oct 2005 at 15:15, Antoine Martin wrote:
> > I've upgraded a (gentoo x86 selinux) system from MySQL 4.0 to 4.1, and
> > since then some of the software that uses mysql-libs refuse to run
> > without 'shlib_t:file execmod'.
> > 
> > ie: when starting postfix (built and rebuilt with mysql support):
> > postfix: error while loading shared
> > libraries: /usr/lib/libmysqlclient.so.14: cannot restore segment prot
> > after reloc: Permission denied
> 
> the reason might be text relocations, even though they should have
> been fixed already upstream. see long story at
> 
>   http://bugs.gentoo.org/show_bug.cgi?id=42968
>   http://bugs.mysql.com/bug.php?id=11642
>From the two threads above it looks like the fix should have gone in
4.1.14 (which is what I am running now)

> 
> what does scanelf -T /usr/lib/libmysqlclient.so.14 report?
> if it's not text relocs, then post an strace please.
Is scanelf a PaX tool?

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
