Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IANArT019192
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 06:23:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IAN8Rq013992
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 10:23:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: mozilla 0.9.3-2 crashing with tunables read and write homedir OFF
Date: Wed, 18 Aug 2004 20:23:02 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040817193823.GU18321@lkcl.net> <1092780620.6531.3.camel@wintermute.xmldesign.de>
In-Reply-To: <1092780620.6531.3.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408182023.02799.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Aug 2004 08:10, Erich Schubert <erich@debian.org> wrote:
> > just in case anyone's curious about using mozilla with no read or write
> > access to user-home: at present (policy 1.12-3 or 4 and mozilla 0.9.2-3)
> > it don't work.
> >
> > debian bugreport raised.
>
> Waste of time. I guess that any mozilla developer will tell you they do
> need write access to their profile directory.

Turning off read/write access to the main home directory does not stop access 
to the mozilla profile directory.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
