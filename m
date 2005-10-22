Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MHj2Ns024710
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 13:45:02 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MHfiK1008148
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 17:41:44 GMT
Subject: Re: [gentoo-hardened] mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: gentoo-hardened@lists.gentoo.org
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1130002276.8908.28.camel@alto>
References: <435A6E83.15754.A4A6C273@pageexec.freemail.hu>
	 <435A7CA9.4596.A4DE07A0@pageexec.freemail.hu>
	 <1129999068.31615.69.camel@localhost.localdomain>
	 <1130002276.8908.28.camel@alto>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 18:41:42 +0100
Message-Id: <1130002902.5415.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 13:31 -0400, solar wrote:
> On Sat, 2005-10-22 at 17:37 +0100, Antoine Martin wrote:
> > On Sat, 2005-10-22 at 17:53 +0200, pageexec@freemail.hu wrote:
> > > On 22 Oct 2005 at 16:45, Antoine Martin wrote:
> > > > > what does scanelf -T /usr/lib/libmysqlclient.so.14 report?
> > > > > if it's not text relocs, then post an strace please.
> > > > Is scanelf a PaX tool?
> > > 
> > > app-misc/pax-utils
> > Thanks,
> > 
> > scanelf -T /usr/lib/libmysqlclient.so.14
> > shows nothing at all.
> > (I also tried adding a -R, even -a shows nothing!)
> 
> 
> This should help pinpoint whats up. Post the results of the following
> commands.
> 
> 
> emerge portage-utils pax-utils ; # If you don't already have both.
I didn't.
> 
> #1
> qlist mysql | scanelf -qtf -
TEXTREL  /usr/lib/mysql/libmysqlclient.so
TEXTREL  /usr/lib/mysql/libmysqlclient_r.so
TEXTREL  /usr/lib/libmysqlclient.so
TEXTREL  /usr/lib/libmysqlclient.so.14.0.0
TEXTREL  /usr/lib/libmysqlclient_r.so
TEXTREL  /usr/lib/libmysqlclient_r.so.14.0.0

> 
> #2 
> scanelf -a /usr/lib/libmysqlclient.so.14
Nothing here
> 
> #3 
> scanelf -a $(qfile -C $(scanelf -BF%n /usr/lib/libmysqlclient.so.14 \
>   | awk '{print $1}'| tr , ' ' ) | cut -d '(' -f 2 | tr ')' ' ' )
scanelf: Unknown option

> 
> -- 
> solar <solar@gentoo.org>
> Gentoo Linux
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
