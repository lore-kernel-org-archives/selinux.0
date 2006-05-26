Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Jeremy Katz <katzj@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148570910.20976.126.camel@moss-spartans.epoch.ncsc.mil>
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
Content-Type: text/plain
Date: Fri, 26 May 2006 14:54:19 -0400
Message-Id: <1148669659.2558.26.camel@aglarond.local>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 11:28 -0400, Stephen Smalley wrote:
> On Thu, 2006-05-25 at 11:19 -0400, Stephen Smalley wrote:
> > The alternative model to post checking after policy load would be to
> > either:
> > 1) Precheck the file contexts from the header against the .pp file in
> > some manner at install time (in which case rpm can abort early), or
> 
> And as I suspect that you'll say that since those contexts were
> generated from the .pp file in the first place, no such checking is
> required, let me note that:
> a) the contexts will have been generated from the file contexts part of
> the .pp, not from the policy module itself, so there could be an
> inconsistency between the two that leaves the context invalid under the
> new policy, and

I still think that it's somewhat important to try to ensure that this
doesn't happen before you get to installing the package, just because at
that point, you're basically putting the user in the "you're hosed, do
not pass go, do not collect $200" position.  So I still hope that we
don't end up with this being a common occurrence :-)

> b) having rpm recheck at install time provides us with both greater
> robustness (in the event of a bug in rpmbuild or a package corrupted in
> some manner along the way) and security (in the event of a maliciously
> constructed package).

But I'm willing to concede that adding some form of checking here may
well make sense.  But I'm not convinced it will necessarily belong in
rpm itself -- it may make more sense to have it in the
policy_module_loader_helper which is going to end up being needed to
avoid stupid scriptlet errors.  But that's in the realm of it not really
mattering who's checking in that it's being checked.  Does that seem
reasonable?

Jeremy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
