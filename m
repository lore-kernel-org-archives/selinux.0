Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Jeremy Katz <katzj@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148674418.20976.284.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
	 <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1148491489.16558.38.camel@orodruin.boston.redhat.com>
	 <1148570386.20976.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1148570910.20976.126.camel@moss-spartans.epoch.ncsc.mil>
	 <1148669659.2558.26.camel@aglarond.local>
	 <1148674418.20976.284.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:16:45 -0400
Message-Id: <1148674605.2716.2.camel@aglarond.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-26 at 16:13 -0400, Stephen Smalley wrote:
> On Fri, 2006-05-26 at 14:54 -0400, Jeremy Katz wrote:
> > On Thu, 2006-05-25 at 11:28 -0400, Stephen Smalley wrote:
> > > On Thu, 2006-05-25 at 11:19 -0400, Stephen Smalley wrote:
> > > b) having rpm recheck at install time provides us with both greater
> > > robustness (in the event of a bug in rpmbuild or a package corrupted in
> > > some manner along the way) and security (in the event of a maliciously
> > > constructed package).
> > 
> > But I'm willing to concede that adding some form of checking here may
> > well make sense.  But I'm not convinced it will necessarily belong in
> > rpm itself -- it may make more sense to have it in the
> > policy_module_loader_helper which is going to end up being needed to
> > avoid stupid scriptlet errors.  But that's in the realm of it not really
> > mattering who's checking in that it's being checked.  Does that seem
> > reasonable?
> 
> Only issue here is the error path in rpm if that helper fails (or
> whether the helper gets enough information from rpm to take corrective
> action itself).

We'll make sure that the helper has enough information to fallback to
relabeling as unlabeled (it might even make sense for it to be able to
fall back to what the loaded policy would give so that, eg, shared libs
at least end up as lib_t)

Jeremy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
