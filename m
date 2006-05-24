Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremy Katz <katzj@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148491489.16558.38.camel@orodruin.boston.redhat.com>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
	 <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1148491489.16558.38.camel@orodruin.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 13:48:44 -0400
Message-Id: <1148492924.24463.478.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 13:24 -0400, Jeremy Katz wrote:
> On Tue, 2006-05-23 at 13:15 -0400, Stephen Smalley wrote:
> > Below is an updated version of the kernel patch to support rpm labeling
> > of files before policy load, with a couple of bug fixes and a re-base to
> > 2.6.17-rc4-mm3.  Note that before we can upstream this, we need to
> > resolve the issues of how rpm will check file label validity after
> > policy load (e.g. calling security_check_context(3) on each label from
> > the header), what corrective action rpm will take if a file label is
> > invalid (options suggested include relabeling to unlabeled_t, relabeling
> > to the context returned by the system policy via matchpathcon, or
> > reverting the install), and the issues raised by Karl above (as they
> > also affect the ability of rpm to perform such verification and
> > correction sanely).
> 
> Well, given that the only labels that will end up in a header will be
> from a policy in that package, I'm still not really convinced what
> adding a verification step _really_ accomplishes.
>   
> 
> Sure, it helps in the case of someone crafting a malicious package which
> has random things in the header (by hand, not from rpmbuild[1]) but if
> someone is crafting a malicious package and getting it signed by someone
> you trust, then you have far larger concerns.

One would like to be able to go beyond a simple binary decision on trust
and instead constrain what a package can do at finer granularity based
both on the trustworthiness of the source and the function/purpose of
the package (e.g. httpd has no business replacing the base policy
module, nor does it need to add a policy module that adds allow rules
giving access to the policy store to httpd_t or any other domain,
regardless of the fact that it comes from Red Hat with suitable
signature).

> [1] Maybe it's just the clarification on what ends up happening that is
> really needed.  In the case where a package contains no policy modules
> the behavior will be exactly what it is today.  If a package contains a
> policy module, at rpmbuild time, we'll map contexts into the header for
> *only* the files covered explicitly by that policy module.  So the only
> contexts that could end up in the header will be ones that will then be
> installed by the policy module.  For the other files, we'll continue to
> just set the file contexts based on the policy as today.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
