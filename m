Message-ID: <1348154318.13835.28.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: clean up in android.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 20 Sep 2012 11:18:38 -0400
In-Reply-To: <1348085999.12435.1.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
	 <1347975644.29192.15.camel@moss-pluto.epoch.ncsc.mil>
	 <1348083729.11612.4.camel@moss-pluto.epoch.ncsc.mil>
	 <1348085999.12435.1.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-09-19 at 16:19 -0400, Stephen Smalley wrote:
> On Wed, 2012-09-19 at 15:42 -0400, Stephen Smalley wrote:
> > On Tue, 2012-09-18 at 09:40 -0400, Stephen Smalley wrote:
> > > I think the setcon and setfilecon2 code could be further unified so that
> > > the entire logic for matching an entry is encapsulated in a single
> > > helper function that takes a bool argument indicating whether it is
> > > looking for a domain or type entry.
> > 
> > So the attached patch does the first part above - unify the seapp
> > context lookup logic from setcon and setfilecon2, without making any
> > changes to how the username mapping is performed.
> > 
> > > We might also want to reconsider how we map the app usernames to a
> > > string for seapp_contexts.  I just remapped the new format to the app_
> > > prefix so that there would be no breakage going from ICS to JB, but it
> > > is a bit misleading.
> 
> And attached is a second patch on top of the first that reworks the
> mapping of UIDs to avoid the use of getpwuid() and name parsing
> altogether.

For those following on the list, these two patches were combined and
uploaded as:
https://android-review.googlesource.com/#/c/43210/

And a separate patch for sepolicy to handle isolated services:
https://android-review.googlesource.com/#/c/43221/

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
