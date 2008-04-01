Subject: Re: Need to break or reduce the dependency on a static libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Sugar <dsugar@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1207074444.9987.0.camel@localhost.localdomain>
References: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>
	 <1207074444.9987.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 15:01:36 -0400
Message-Id: <1207076496.5610.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-01 at 14:27 -0400, David Sugar wrote:
> Steve,
> 
> SLIDE does not have any dependency on libsepol.  But in what we are
> working on for CDS Framework we have recently introduced dependencies on
> the static libsepol.  We need to be able to query the policy to verify
> that any particular allow rules have been put in place.  This is
> specifically important when MLS is enabled to verify that MLS
> constraints are not denying an access.
> 
> I don't remember off the top of my head exactly which functions are
> being used from the static libsepol but I know there were a few things
> that were not exported in the shared object and Josh said to use the
> static version.

Don't know if this helps, but audit2why will tell you whether or not a
denial is due to a constraint violation (not specifically MLS, but any
constraint).  And libselinux now provides a python binding to audit2why.
If you can use that or extend it, then we at least don't add one more
copy of the static libsepol on the system.

> Dave
> 
> On Tue, 2008-04-01 at 08:07 -0400, Stephen Smalley wrote:
> > This is likely my fault, but we're encountering increasing problems from
> > growth in the set of things that depend on the static libsepol whenever
> > we make a change to libsepol, particularly a policy version change.  We
> > now have (at least) the following dependencies on it:
> > checkpolicy (always true, not likely to go away)
> > libselinux (for the audit2why python binding module, which used to be
> > its own utility in policycoreutils)
> > setools
> > 
> > Does slide also have this dependency or is it clean?  Anything else to
> > worry about?
> > 
> > The result is that when a newer libsepol gets incorporated and
> > libselinux or setools does not, we encounter breakage (unable to find a
> > policy file they can read or unable to read the policy file at which
> > they are pointed) or confusion (reading an older policy file left around
> > from before the libsepol update) upon trying to use audit2why or
> > setools.
> > 
> > We ran into this problem twice in rawhide / F9, once upon the policy
> > capability support (policy.22) and now for permissive types (policy.23).
> > 
> > Only real way forward that I can see it to actually encapsulate the
> > interfaces required by audit2why and setools so that they can use the
> > shared libsepol.
> > 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
