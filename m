Subject: Re: I have spit out my current diffs in policy on fedoraproject.org
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200802011107.29538.paul.moore@hp.com>
References: <47A33458.505@redhat.com>
	 <1201878327.4568.158.camel@moss-spartans.epoch.ncsc.mil>
	 <200802011107.29538.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 01 Feb 2008 14:39:28 -0500
Message-Id: <1201894768.21440.10.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-01 at 11:07 -0500, Paul Moore wrote:
> On Friday 01 February 2008 10:05:27 am Stephen Smalley wrote:
> > On Fri, 2008-02-01 at 10:01 -0500, Daniel J Walsh wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > http://people.fedoraproject.org/~dwalsh/Policy/
> > >
> > > Patch is now up to 28000 lines.
> > >
> > > {snip}
> > >
> > > Going forward this is going to get more difficult.  I think we need
> > > more people with the ability to update the reference policy.  Even
> > > if they just cherry pick through the differences in my patches and
> > > upstream.  I don't believe one person can keep up with the volume
> > > of changes.
> >
> > Maybe create a fedora branch of refpolicy?
> 
> Does this actually solve the problem, or just move the patch problem 
> from outside refpolicy SVN into a branch within refpolicy?  The changes 
> still need to get merged into the trunk and I'm not sure a branch helps 
> that any (maybe it does, I guess it all depends on how Chris works).

That doesn't help me; on many things I need more information on the
change, so a patch format works.  Some of the problems are that the
patches are divided by module, not by changeset.  Its better than one
big mega patch, but still suboptimal, especially if a changeset crosses
modules.  I still suggest using quilt.

I'd suggest using trac's bug system on the refpolicy site so we can have
tracking of patches without flooding the mail list, however I'm sure Dan
isn't interesting in entering in 147 bugs (unless there is a nice
command line tool that can do this that I don't know of).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
