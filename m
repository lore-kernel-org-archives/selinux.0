Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LF4egA026598
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 11:04:40 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LF04rg012811
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:00:04 GMT
Subject: Re: ainit
From: Colin Walters <walters@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>,
   fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1121957424.13068.53.camel@sgc.columbia.tresys.com>
References: <200507212142.28830.russell@coker.com.au>
	 <1121957424.13068.53.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 10:59:57 -0400
Message-Id: <1121957997.15247.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 10:50 -0400, Christopher J. PeBenito wrote:
> On Thu, 2005-07-21 at 21:42 +1000, Russell Coker wrote:
> > Is this really what we want?  Having a system process allocate shared memory 
> > that can be used by any user processes?  Also it seems likely that other 
> > sound programs will need to access the shared memory in question.
> > 
> > There are three possible assumptions that we could make:
> > 
> > 1)  Anyone who is serious about security doesn't use ALSA so such
> > access doesn't matter that much.
> 
> This isn't the case.  ALSA isn't any different then OSS from a SELinux
> viewpoint.  I don't have ainit on any of my Gentoo machines; after a few
> minutes on Google, it seems that this is a Redhat/Fedora specific
> program.

At the moment possibly, but I'm sure other systems will want to unbreak
their sound eventually too :)

> Probably the right answer if the shared memory doesn't have to be shared
> between all user domains.

It needs to be accessible to any program that wants to play sound.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
