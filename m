Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAC9b6Sf012116
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 04:37:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAC9b5qY014515
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 09:37:05 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAC9b40o014512 for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 09:37:04 GMT
Date: Wed, 12 Nov 2003 09:37:02 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Authentication failure
Message-ID: <20031112093702.GB23277@vnl.com>
References: <20031112010929.GY23277@vnl.com> <200311121340.20835.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311121340.20835.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 12, 2003 at 01:40:20PM +1100, Russell Coker wrote:
> On Wed, 12 Nov 2003 12:09, Dale Amon wrote:
> > I'm getting 'Authentication Failure' when I go to login.
> > This is a freshly installed system (disk image built
> > elsewhere and rolled in). I can log in if I boot
> > single user; that way I was able to label the file
> > system and then reboot via the initrd... but the
> > full selinux boot also gives 'Authentication failure'.
> >
> > Could it be there is still some conflict in packages
> > between Coker, Walters and sid?
> 
> Recently I have been working on changes to pam and policy to lock down access 
> to /etc/shadow.  These changes are inter-dependent, so if you change one 
> without the other then the result is a broken system.
> 
> I guess that you are either not running my pam packages or you are not running 
> the latest policy.

I've built with this sources.list:

deb http://www.coker.com.au/newselinux/ ./
deb http://web.verbum.org/debian/ ./experimental/
deb http://ftp.de.debian.org/debian/ sid main non-free contrib
deb http://non-us.debian.org/debian-non-US sid/non-US main contrib non-free

and this preferences:

Package: *
Pin: release l=coker
Pin-Priority: 1100

and looking at your Release file, it appears you are 'etbe' rather than
'coker' so I'll be that's where I got screwed.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
