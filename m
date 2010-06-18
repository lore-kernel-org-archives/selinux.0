Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org
In-Reply-To: <1276538131.2749.18.camel@localhost>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
	 <1276527447.8863.25.camel@moss-pluto.epoch.ncsc.mil>
	 <1276529041.2749.14.camel@localhost>
	 <1276532095.8863.32.camel@moss-pluto.epoch.ncsc.mil>
	 <1276538131.2749.18.camel@localhost>
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 18 Jun 2010 08:01:27 -0400
Message-ID: <1276862487.2929.294.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-06-14 at 13:55 -0400, Eric Paris wrote:
> On Mon, 2010-06-14 at 12:14 -0400, Stephen Smalley wrote:
> > On Mon, 2010-06-14 at 11:24 -0400, Eric Paris wrote:
> > > On Mon, 2010-06-14 at 10:57 -0400, Stephen Smalley wrote:
> > > > On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> > > > > There is interest in being able to see what the actual policy is that was
> > > > > loaded into the kernel.  The patch creates a new selinuxfs file
> > > > > /selinux/policy which can be read by userspace.  The actual policy that is
> > > > > loaded into the kernel will be written back out to userspace.
> > > > 
> > > > How do you expect this to be used?  As with /selinux/load, we can't use
> > > > coreutils utilities to manipulate it unfortunately.  Nor can we do
> > > > things like checkpolicy -b /selinux/policy since it doesn't support
> > > > mmap.
> > > 
> > > I used my own program to pull it out to a file and poke it after it was
> > > out.  I can certainly take a look at generating the policy on open()
> > > which would allow us to support ppos easily (and maybe mmap, but I've
> > > never written an mmap handler)
> > 
> > Hmm...the resulting policy.from.kern doesn't match the binary policy
> > file that was loaded, nor is it a well-formed policy.
> 
> It won't be a binary perfect match since we switched range transition
> rules to a hashtab and we lose ordering in the kernel.  (although the
> second load and resulting read should be the same binary policy)
> 
> What is not well-formed about your result?  I got back the same policy
> (according to sediff) but I was using selinux-policy-minimum....

I'm just catching up, but a word of warning: sediff does not diff
constraints yet.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
