Subject: RE: [rfc][patch] setfiles:  validate all
	file_contextsfileswhenusing -c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880246AFA3@exchange.columbia.tresys.com>
References: <4880CFD1.1040102@redhat.com>
	 <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>
	 <4880D585.9000405@redhat.com>
	 <1216403646.17602.339.camel@moss-spartans.epoch.ncsc.mil>
	 <1216406083.17602.352.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880246AF91@exchange.columbia.tresys.com>
	 <1216406827.17602.360.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880246AFA1@exchange.columbia.tresys.com>
	 <1216408256.17602.372.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B015880246AFA3@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 15:23:13 -0400
Message-Id: <1216408993.17602.383.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-07-18 at 15:12 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2008-07-18 at 15:09 -0400, Joshua Brindle wrote:
> >> Stephen Smalley wrote:
> >>> On Fri, 2008-07-18 at 14:37 -0400, Joshua Brindle wrote:
> >>>> Stephen Smalley wrote:
> >>>>> In ancient days of yore, setfiles could only validate the base
> >>>>> file_contexts configuration because the .homedirs or .local
> >>>>> configurations might include local users that weren't defined by
> >>>>> the base policy since those definitions were brought in at policy
> >>>>> load time. These days the policy.N file contains all of the
> >>>>> definitions required to validate all file_contexts files and thus
> >>>>> setfiles can and should validate them.
> >>>>> 
> >>>> 
> >>>> I don't think that was the motivation. We want to explicitely
> >>>> support a user overriding a context specified in the policy with
> >>>> semanage and I think giving this cryptic warning is going to
> >>>> confuse people. For all other semanage objects we allow overriding
> >>>> the main policy with no warning, why would this be different?
> >>> 
> >>> I actually went back through the mailing list archives, and the
> >>> reason I stated (inability to validate entries using
> >>> localusers) was the the motivation for baseonly validation in
> >>> setfiles -c. 
> >>> 
> >>> We've never supported users creating conflicting file contexts
> >>> entries with the base policy as far as I know.
> >>> We've always warned on this condition.
> >>> 
> >>> I suppose we could alter that behavior but I'm not sure it will work
> >>> as expected at present; the logic in libselinux to move all exact
> >>> specs to the end could for example interfere with it.  Or if we did
> >>> a full fcsort of file_contexts.local as has been suggested
> >>> elsewhere.  And one could have dups within file_contexts.local
> >>> itself, which we can't presently distinguish from dups between base
> >>> and .local with the current logic.
> >>> 
> >> 
> >> All the same I think that a user overriding a policy file context
> >> should be explicitely supported.
> > 
> > Patches accepted ;)
> 
> So, your current patch is disabling this support altogether, right?

There is no support for duplicate pathname regexes presently (although
obviously you can always add more specific ones that overlap), and
letting the user add duplicates via semanage just means constant spew
from rpm, udev, restorecon, etc.

If we want to support duplicates in file_contexts.local that take
precedence over file_contexts, then we still want nodups checking within
the base file_contexts at least, and likely within file_contexts.local
(i.e. no duplication among the local customizations).  We just want to
support duplication between file_contexts and file_contexts.local, with
guaranteed precedence/ordering.

I'm not taking any functionality away with these patches.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
