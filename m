Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8IAk7Ns009999
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 06:46:07 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8IAgQ19001201
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 10:42:27 GMT
Date: Sun, 18 Sep 2005 11:42:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Dale Amon <amon@vnl.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050918104219.GW9092@lkcl.net>
References: <20050917233111.GA17916@vnl.com> <20050918001512.GR9092@lkcl.net> <20050918095806.GC25649@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050918095806.GC25649@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 18, 2005 at 10:58:07AM +0100, Dale Amon wrote:
> On Sun, Sep 18, 2005 at 01:15:12AM +0100, Luke Kenneth Casson Leighton wrote:
> > dale, hi,
> 
> And hello yourself. I've been a bit scarce on this list lately.
> Business has been good for a change... so no playtime. :-)
>  
> > i did manage to set up debian/selinux - back when 2.6.6 -> 2.6.9 was in
> > "unstable".
> > it was painful, took about four to five months, and it worked.
> 
> Ouch. Well, I'm only interested in getting it up on rack mount
> server class machines with no fancy workstation apps on them. 
> Nothing but LAMP's.
  
  then you would do well to consider gentoo/hardened instead!!

  
> > you will NOT get sarge to work [as-is].
> 
> But can you start from the sarge iso and upgrade? 

 always.
 
> > you WILL need libselinux1 for a start and because of the freeze
> > some 18 months ago libselinux1 did NOT make it into sarge.
> 
> I'm picking that up from Russel's repository during the upgrade
> and it does install okay.

 look for manoj's stuff.

> > you _will_ need the patched version of dpkg - the one that
> > sets selinux file contexts on files as it unpacks them - just
> > like rpm does.
> 
> Yeah, but that shouldn't matter yet: the problems are in the
> initial upgrade to SELinux packages so the file system isn't
> labeled yet and the kernel is still the base debian one. 

 ah, the "bootstrap" problem that i joyously encountered.  i found this
 to be a sticking point, too.

 okay, you need to reboot first with ... damn it's been a while...

 selinux=1 enabled=0

 _then_ you stand a good chance of being able to [build and] relabel.

 it's something to do with failures in the make process which i never
 got to the bottom of - probably some of the libselinux / sepol
 libraries detecting that selinux wasn't enabled, and not allowing
 the build process to proceed properly.

 most people only build and install selinux on already-useable
 selinux systems.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
