Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IJNwrT022568
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 15:23:58 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IJNGho011899
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 19:23:17 GMT
Date: Wed, 18 Aug 2004 16:38:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Erich Schubert <erich@debian.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: mozilla 0.9.3-2 crashing with tunables read and write homedir OFF
Message-ID: <20040818153850.GG19646@lkcl.net>
References: <20040817193823.GU18321@lkcl.net> <1092780620.6531.3.camel@wintermute.xmldesign.de> <200408182023.02799.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408182023.02799.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 18, 2004 at 08:23:02PM +1000, Russell Coker wrote:
> On Wed, 18 Aug 2004 08:10, Erich Schubert <erich@debian.org> wrote:
> > > just in case anyone's curious about using mozilla with no read or write
> > > access to user-home: at present (policy 1.12-3 or 4 and mozilla 0.9.2-3)
> > > it don't work.
> > >
> > > debian bugreport raised.
> >
> > Waste of time. I guess that any mozilla developer will tell you they do
> > need write access to their profile directory.
> 
> Turning off read/write access to the main home directory does not stop access 
> to the mozilla profile directory.
 
 it would appear that mozilla 0.9.2-3 is using fuser to test whether it
 can write to the user's home directory.

 the policy having been set to ban that access, fuser either crashes or
 returns an answer that causes mozilla to crash.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
