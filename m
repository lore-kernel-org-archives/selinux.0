Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i727r1rT010445
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 03:53:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i727qPXV008294
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 07:52:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: /etc/qt3/.qt*
Date: Mon, 2 Aug 2004 17:52:18 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040801194006.GF20103@lkcl.net> <1091391553.7861.17.camel@wintermute.xmldesign.de>
In-Reply-To: <1091391553.7861.17.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408021752.18794.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Aug 2004 06:19, Erich Schubert <erich@debian.org> wrote:
> > gawd only knows what kde (actually libqt) is doing needing to write
> > lock files to /etc/qt3 but there y'go.
>
> I don't have a /etc/qt3. And if i had it, it certainly would be mode
> 0755, so no user can write there (and i don't think running qt apps as
> root is a good idea) - something must be wrong with your setup.

I guess that would be kdm.  kdm calls lots of KDE library code, most of which 
assumes that it's doing stuff on behalf of a regular user.  Last time I ran 
kdm it wanted to write stuff under /root, /etc/qt3 is marginally better.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
