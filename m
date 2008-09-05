Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48C0C7C3.3050304@redhat.com>
References: <48B4FA3E.3000602@redhat.com>
	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB93D2.8090909@redhat.com>  <48BCB564.4010404@redhat.com>
	 <1220360985.26711.43.camel@moss-spartans.epoch.ncsc.mil>
	 <48BE28D5.1080902@redhat.com>
	 <1220446886.6034.33.camel@moss-spartans.epoch.ncsc.mil>
	 <48C0C7C3.3050304@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 07:27:27 -0400
Message-Id: <1220614047.17197.277.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-09-05 at 15:46 +1000, Murray McAllister wrote:
> Stephen Smalley wrote:
> > On Wed, 2008-09-03 at 16:04 +1000, Murray McAllister wrote:
> >> How about:
> >>
> >> The level is an attribute of MLS and Multi-Category Security (MCS). The 
> >> first part of the level, s0-s0, is the sensitivity.
> > 
> > Actually, s0-s0 is a MLS range where the low level has sensitivity s0
> > and no categories and the high level has sensitivity s0 and no
> > categories.
> > 
> >>  The s0 sensitivity 
> >> is the only sensitivity used for MCS. Since the format of the level is 
> >> the same for MLS and MCS, and MLS supports ranges of sensitivities, a 
> >> sensitivity such as s0-s0 is the same as s0 when using MCS.
> > 
> > No, s0-s0 is always the same as just s0, regardless of MCS or MLS.  Just
> > like s1-s1 is the same as just s1.  Versus a non-trivial range like
> > s0-s1 or s0-s3.
> > 
> >>  Optionally, 
> >> the level can have a list of categories.
> 
> I hope this is correct soon ;)
> 
> The level is an attribute of MLS and Multi-Category Security (MCS). The 
> first part of the level, s0-s0, is an MLS range.

s0-s0 is a range.  It is not a level.  A MLS range is a pair of levels
(lowlevel, highlevel) written as "lowlevel-highlevel" if they differ or
as just "lowlevel" if they are the identical.  Each level is a
(sensitivity, categoryset) pair written as "sensitivity:categoryset" or
just "sensitivity" if the category set is empty.  A categoryset is a
list of categories written as "category1,category2,...".  If a category
set contains a contiguous series of categories (e.g.
"c1,c2,c3,c4,c5,c6,c7,c8,c9,c10") this can be abbreviated as the first
category in the series followed by a dot (".") followed by the last
category in the series, e.g. "c1.c10".

s0-s0 is a range where the lowlevel == highlevel == (sensitivity s0,
emptycategoryset).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
