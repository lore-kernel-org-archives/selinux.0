Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Jeremy Katz <katzj@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
        SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146591753.13611.193.camel@moss-spartans.epoch.ncsc.mil>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1146583639.32102.20.camel@orodruin.boston.redhat.com>
	 <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
	 <1146591753.13611.193.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 May 2006 13:53:40 -0400
Message-Id: <1146592420.32102.78.camel@orodruin.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 13:42 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-02 at 12:26 -0400, Stephen Smalley wrote:
> > Ok, let's assume that we implement kernel mechanism for
> > revalidating/updating the incore inode SIDs upon policy reload.  But
> > where does this leave us with regard to being able to meaningfully
> > confine rpm in the future, e.g. by moving the real processing into a
> > helper and running it in different domains based on package
> > trustworthiness and purpose?  If rpm (and potentially other programs, as
> > this becomes a tempting way to deal with e.g. dump/restore) can set down
> > arbitrary values as file contexts, then can they be meaningfully
> > restricted in any way?  To me that is the larger concern.
> 
> Ok, it has been pointed out to me that rpm and friends can still be
> meaningfully restricted if:

Whoever pointed it out, thank them for making the point I was trying to
make :-)

> In which case I have a couple of other questions:
> 1) Are there any implications of having these files exist temporarily
> with the unlabeled_t type, as that type is generally inaccessible except
> to privileged domains?  Seems like we could end up with spurious denials
> on running processes, e.g. upon glibc upgrade or similar.

Well, on an upgrade one would hope that the type is already known.  So
it should only be an issue in the case of:
a) Fresh installation of a package with associated policy -- hence,
there won't be things running for it while the files are being put down
and the first thing done in the scriptlets should be loading the policy 
b) Adding new policy for a package but I would expect the running
process would keep running unconfined as previously, then in the
post-install, the (new) policy gets loaded and the service gets
restarted

So I can't really forsee problems with these cases

> 2) What kind of error checking will rpm do to deal with the fact that
> the kernel won't know that the context is invalid at setxattr() time, so
> if rpm feeds it one that ends up being invalid even under the new
> policy, that won't be known until the policy load occurs?  I suppose rpm
> could call lgetxattr()/lgetfilecon() on the files after the policy load
> and recheck that they have the expected values.  But does that fit with
> your proposed approach?

The plan is that rpmbuild would only be setting a context in the header
if it's set in the policy module at build time.  So you could only
really end up here if you have a package built via a bad rpmbuild.  And
realistically, once you get there, you're going to have other things to
worry about (hence why signature checking of packages is important to
know that a package is from a trusted(tm) source). 

So while checking could be done after the package install, I'm not sure
how much it buys us.  Especially as a policy change could (potentially,
though this would want to be avoided by ensuring that policy is broken
down into the right "chunks") invalidate contexts for files from other
packages.  rpm --verify should certainly check for this case.

Jeremy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
