Subject: Re: 'make policy' issues
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Laganowski <eric@laganowski.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4ADF3D2C.2030408@laganowski.net>
References: <4ADF2358.4050606@laganowski.net>
	 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
	 <4ADF2663.2030105@laganowski.net>
	 <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
	 <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
	 <4ADF3D2C.2030408@laganowski.net>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 13:02:47 -0400
Message-Id: <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-21 at 12:56 -0400, Eric Laganowski wrote:
> Manoj Srivastava wrote:
> > On Wed, Oct 21 2009, Stephen Smalley wrote:
> >   
> >>> Re flex: What is the requirement for flex from selinux perspective? Is 
> >>> it known what build of flex is "known good"?
> >>>       
> >> My impression is that one of the patches carried by the distributions
> >> for flex is needed for checkpolicy to work, but no one has ever fully
> >> investigated the precise dependency - people just grab the Fedora srpm
> >> and apply those patches to flex, and then rebuild checkpolicy and it
> >> works.  I haven't seen any complaints from Debian or Gentoo so I presume
> >> that they also carry the same patches for flex.
> >>
> >> flex -V here also shows 2.5.35.  But there are three patches in the
> >> Fedora package.  Attached.
> >>     
> >
> >         Debian currently carries 13 (though 3 of them need to be
> >  squashed together) patches against 2.5.35. I can make them available if
> >  there is interest.
> >
> >         manoj
> >   
> Yes please. Patches would be welcome.

Did you try the three patches that I attached to my email for flex?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
