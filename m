Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Jim Meyering <meyering@redhat.com>
In-Reply-To: <1168636513.13080.227.camel@code.and.org>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org>
	 <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
	 <1168636513.13080.227.camel@code.and.org>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 16:19:47 -0500
Message-Id: <1168636787.7993.592.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-01-12 at 16:15 -0500, James Antill wrote:
> On Fri, 2007-01-12 at 15:24 -0500, Stephen Smalley wrote:
> > On Fri, 2007-01-12 at 15:10 -0500, James Antill wrote:
> 
> > Hmm...I'm not sure about the precise history of the coreutils selinux
> > patch, but I had thought it was using setfscreatecon() as much as
> > possible to ensure that the file was labeled correctly at creation time.
> > Otherwise, the file can exist in the wrong label temporarily, which can
> > produce "false" denials (e.g. another process tries to access the file
> > before it is in the expected label and gets a denial) as well as "false"
> > grantings (e.g. another process tries to open the file before it is in
> > the right label and gets a descriptor - which is mitigated in part by
> > the revalidation of access on read/write/... calls and fd
> > inheritance/transfer but revocation support is incomplete). Note also
> > that the permission checks are different for creating vs. relabeling, so
> > the behavior affects policy.
> > Also, I'm not sure what you mean by the above, as I would expect that it
> > would do one of two things for preserving context:
> 
>  Ok, I can see why we'd use setfscreatecon() but atm. cp does:
> 
> newcon = getfilecon("old")
> setfscreatecon(newcon);
> [...]
> fd = open("new");
> con = getfscreatecon();
> fsetfilecon(fd, con);
> 
> ...the later of which, I think, does nothing useful atm.

Yes, that appears to be completely redundant.  Please post proposed
changes to the selinux userland functionality to the list for
discussion.  vixie cron selinux support was completely rewritten without
ever being discussed here, yielding broken support, and it looks like
the openssh selinux support has been significantly reworked for LSPP
without ever appearing here.  We aren't gatekeepers for them anymore,
but we can provide useful feedback...

> > I seem to recall earlier discussions where people found that
> > automatically enabling preservation of contexts upon -p and -a produced
> > a fair amount of breakage in practice, particularly under -strict
> > policy, because processes could very well be allowed to preserve DAC
> > information but not alter their own default MAC labeling behaviors.
> 
>  That seems likely, although I think apart from a few corner cases (like
> isos and nfs) the labels should be preserved in targeted.

Then you need graceful fallback if denied so that it still works sanely
under -strict or -mls.

> > >  So if we moved coreutils to just using fsetfilecon() for -p/-a, could
> > > we do something?
> > 
> > You don't have to do that; it just makes it clearer as to what failed.
> > But it does have other implications as well, as above.
> 
>  Right, but if we did this for targeted then I think it's safe to ignore
> the EPERM error (maybe with a single warning). This should then do the
> right thing all the time for targeted, AIUI.

Ignoring it is fine if the user didn't request preservation of contexts
specifically, but if the user did specify that, it should be fatal.

> > If the user/caller specifies to cp that it wants the security context
> > preserved, then any failure there should be fatal to the copy.  But if
> > the user/caller just specified -p or -a, which used to not include
> > security contexts, then it seems that an inability to preserve the
> > context shouldn't be fatal to the copy.
> 
>  This implies that --preserve=context is "different" from
> --preserve=all, -p or -a. I don't think upstream coreutils will accept
> that, and it seems pretty magic to me.

-p is documented as "same as --preserve=mode,ownership,timestamps".
-a is documented as "same as -dpR"
So _not_ preserving context is completely consistent with the
documentation for those options.  --preserve=all might be reasonable to
enable context preservation; I don't know how often it is used.

>  Maybe if we had --preserve=context-open and --preserve=context-post[1]
> (usable names pending), we could have -a/-p/--preserve=all use
> context-post (and that not error out). But specifying context-open would
> error out.
>  We could even change -p/-a if is_selinux_mls_enabled() is true?
> 
>  Of course, I'm not 100% upstream coreutils will accept that either :)
> 
> [1] context-open == use setfscreatecon and context-post = just use
> fsetfilecon().

I'd prefer just a single mechanism and policy-independent behavior.
And _stable_ behavior.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
