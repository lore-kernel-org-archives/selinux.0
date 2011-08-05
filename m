Subject: Re: checkpolicy is broken (which is not)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <201108060130.49464.russell@coker.com.au>
References: <4E3AEA75.3090602@redhat.com>
	 <1312550851.19283.35.camel@moss-pluto> <4E3C0152.7000105@redhat.com>
	 <201108060130.49464.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 12:20:59 -0400
Message-ID: <1312561259.19283.76.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2011-08-06 at 01:30 +1000, Russell Coker wrote:
> I think that the ideal situation for a Debian upgrade (which can and usually 
> is done in stages unlike a RHEL upgrade) is to support either the old policy 
> with new user-space or the new policy with the old user-space.  Ideally this 
> would also include the ability to rebuild the policy packages from source.

I'm not sure how you could support the latter, as newer policy sources
will use the language features supported by the latest checkpolicy, and
thus often won't be compilable by an older checkpolicy.  The former is
possible, but requires us to preserve the present ambiguity between
declaring a role and adding types to an existing role.

> In regard to the "role httpd_t types httpd_t;" corner case, aren't there a 
> heap of other corner cases where someone can accidentally write policy that 
> doesn't do what they expect?

Certainly, but I think the notion was to provide the same level of
compile-time checking of roles as we presently get for types.  Users
would be the last remaining holdout at that point; like roles, we
allowed multiple declarations when we decomposed the policy into
per-domain source modules, introducing ambiguity between declaration and
use.  We had a somewhat similar issue for type attributes, where they
were originally defined implicitly on first use in a type declaration,
and then later we added explicit attribute declarations and required
their use to avoid similar mistakes.

> What about the macros for things like r_file_perms?  How long are we going to 
> keep that around?  We've already had a couple of releases with the new 
> version.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
