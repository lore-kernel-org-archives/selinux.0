From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: I have spit out my current diffs in policy on fedoraproject.org
Date: Fri, 1 Feb 2008 11:07:29 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <47A33458.505@redhat.com> <1201878327.4568.158.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1201878327.4568.158.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802011107.29538.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 01 February 2008 10:05:27 am Stephen Smalley wrote:
> On Fri, 2008-02-01 at 10:01 -0500, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > http://people.fedoraproject.org/~dwalsh/Policy/
> >
> > Patch is now up to 28000 lines.
> >
> > {snip}
> >
> > Going forward this is going to get more difficult.  I think we need
> > more people with the ability to update the reference policy.  Even
> > if they just cherry pick through the differences in my patches and
> > upstream.  I don't believe one person can keep up with the volume
> > of changes.
>
> Maybe create a fedora branch of refpolicy?

Does this actually solve the problem, or just move the patch problem 
from outside refpolicy SVN into a branch within refpolicy?  The changes 
still need to get merged into the trunk and I'm not sure a branch helps 
that any (maybe it does, I guess it all depends on how Chris works).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
