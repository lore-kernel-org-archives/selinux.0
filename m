Subject: Re: Is it time we removed the version number from
	policy.22/policy21?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1201279345.21288.239.camel@moss-spartans.epoch.ncsc.mil>
References: <479A0E7B.7000109@redhat.com>
	 <1201279345.21288.239.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 25 Jan 2008 11:44:46 -0500
Message-Id: <1201279486.21288.242.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-25 at 11:42 -0500, Stephen Smalley wrote:
> On Fri, 2008-01-25 at 11:29 -0500, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > I just got burned by the policy version bumping.  I blogged about how
> > cool audit2why is and then policycoreutils/libselinux had a bug.
> > 
> > They were hard coded to use the policy version of the kernel that was
> > running to look for policy.
> > 
> > They were both doing the equivalent of
> > /etc/selinux/targeted/policy/policy.`cat /selinux/policyvers`
> 
> i.e. audit2why is using security_policyvers() rather than
> sepol_policy_kern_vers_max().  That is easy to fix, although it should
> likely use the same logic as libselinux/src/load_policy.c for finding a
> policy file, i.e. start from sepol_policy_kern_vers_max() and scan
> downward if that doesn't exist.

One issue there though is that audit2why uses the static libsepol, not
the shared one, since we don't yet have the adequate shared interfaces
to provide the functionality it requires.  So a change to policy version
requires rebuilding audit2why still.

> > But I guess we just bumped the version of policy to 22 in libsepol.  (My
> > mistake for not noticing).  But the kernel still only supports 21.
> > 
> > So a freshly installed machine has 22 on it and audit2why blows up with
> > a missing policy because it is looking for 21.  On my test machine I
> > have a policy.21 and a policy.22 so I never noticed.  (this in my
> > opinion is a bug in semanage.  It should have cleaned up the old version.
> > 
> > I think this just points out the problem of adding the version number to
> > the policy file on disk.  This really serves no purpose other than to
> > create bugs every time we bump the version.
> > 
> > I would like to suggest that we switch to just building
> > /etc/selinux/TYPE/policy/policy
> > and have a symbolic link for backwards compatibility
> > /etc/selinux/TYPE/policy/policy.22 -> policy
> 
> I think we considered that when we switched over to managed policy and
> started always generating the latest policy version and loading it.
> However, it doesn't allow for the situation where we introduce a policy
> version that is not backward compatible and cannot be downgraded to
> older versions by the load_policy logic.
> 
> Simple fix for now is to just change audit2why to be like load_policy in
> how it searches for the policy file.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
