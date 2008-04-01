MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Need to break or reduce the dependency on a static libsepol
Date: Tue, 1 Apr 2008 14:27:24 -0400
Message-ID: <1207074444.9987.0.camel@localhost.localdomain>
In-Reply-To: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>
References: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>
From: "David Sugar" <dsugar@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve,

SLIDE does not have any dependency on libsepol.  But in what we are
working on for CDS Framework we have recently introduced dependencies on
the static libsepol.  We need to be able to query the policy to verify
that any particular allow rules have been put in place.  This is
specifically important when MLS is enabled to verify that MLS
constraints are not denying an access.

I don't remember off the top of my head exactly which functions are
being used from the static libsepol but I know there were a few things
that were not exported in the shared object and Josh said to use the
static version.

Dave

On Tue, 2008-04-01 at 08:07 -0400, Stephen Smalley wrote:
> This is likely my fault, but we're encountering increasing problems from
> growth in the set of things that depend on the static libsepol whenever
> we make a change to libsepol, particularly a policy version change.  We
> now have (at least) the following dependencies on it:
> checkpolicy (always true, not likely to go away)
> libselinux (for the audit2why python binding module, which used to be
> its own utility in policycoreutils)
> setools
> 
> Does slide also have this dependency or is it clean?  Anything else to
> worry about?
> 
> The result is that when a newer libsepol gets incorporated and
> libselinux or setools does not, we encounter breakage (unable to find a
> policy file they can read or unable to read the policy file at which
> they are pointed) or confusion (reading an older policy file left around
> from before the libsepol update) upon trying to use audit2why or
> setools.
> 
> We ran into this problem twice in rawhide / F9, once upon the policy
> capability support (policy.22) and now for permissive types (policy.23).
> 
> Only real way forward that I can see it to actually encapsulate the
> interfaces required by audit2why and setools so that they can use the
> shared libsepol.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
