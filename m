Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9NJADNs000630
	for <selinux@tycho.nsa.gov>; Sun, 23 Oct 2005 15:10:14 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9NJ6MGg025411
	for <selinux@tycho.nsa.gov>; Sun, 23 Oct 2005 19:06:23 GMT
Subject: Re: [gentoo-hardened] mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: gentoo-hardened@lists.gentoo.org
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1130004616.8908.38.camel@alto>
References: <435A6E83.15754.A4A6C273@pageexec.freemail.hu>
	 <435A7CA9.4596.A4DE07A0@pageexec.freemail.hu>
	 <1129999068.31615.69.camel@localhost.localdomain>
	 <1130002276.8908.28.camel@alto>
	 <1130002902.5415.5.camel@localhost.localdomain>
	 <1130004616.8908.38.camel@alto>
Content-Type: text/plain
Date: Sun, 23 Oct 2005 20:06:39 +0100
Message-Id: <1130094399.22489.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > #1
> > > qlist mysql | scanelf -qtf -
> > TEXTREL  /usr/lib/mysql/libmysqlclient.so
> > TEXTREL  /usr/lib/mysql/libmysqlclient_r.so
> > TEXTREL  /usr/lib/libmysqlclient.so
> > TEXTREL  /usr/lib/libmysqlclient.so.14.0.0
> > TEXTREL  /usr/lib/libmysqlclient_r.so
> > TEXTREL  /usr/lib/libmysqlclient_r.so.14.0.0
> 
> Looks like you do infact have textrels in your mysql. 
> I've seen this happen before when linked with a miscompiled
> libcrypto.so 
I've rebuilt openssl, but this hasn't helped...

> > > #2 
> > > scanelf -a /usr/lib/libmysqlclient.so.14
> > Nothing here
> 
> If nothing here then chances are your running scanelf while trying to
> enforce and no such policy exists for scanelf.
I must have done it wrong (it works even in enforcing mode now):

 TYPE    PAX   STK/REL/PTL TEXTREL RPATH BIND FILE
ET_DYN ---xe- RW- --- RW- TEXTREL   -
LAZY /usr/lib/libmysqlclient.so.14

> > > 
> > > #3 
 TYPE    PAX   STK/REL/PTL TEXTREL RPATH BIND FILE
ET_DYN ---xe- RW- R-- RW-    -      -   LAZY /lib/libcrypt.so.1
ET_DYN ---xe- RW- R-- RW-    -      -   LAZY /lib/libnsl.so.1
ET_DYN ---xe- RW- R-- RW-    -      -   LAZY /lib/libm.so.6
ET_DYN ---xe- RW- --- RW-    -      -   LAZY /lib/libz.so.1
ET_DYN ---xe- RW- R-- RW-    -      -   NOW /lib/libc.so.6



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
