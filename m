Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <352455.10817.qm@web36609.mail.mud.yahoo.com>
References: <352455.10817.qm@web36609.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 18 Jun 2007 13:03:17 -0400
Message-Id: <1182186197.7236.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-18 at 08:32 -0700, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
> > The mandatory security policy
> 
> Let's get our words strait. I believe that what you're talking
> about here is the SELinux mechanism for enforcing the policy
> provided from user space.
> 
> > doesn't depend on the mode bits / DAC, and
> > thus remains orthogonal to it.
> 
> You could certainly incorporate the mode bits and/or ACLs
> into the userland tools that generate policy. Why, for the
> time being you could even us restoreconfigd to keep the labels
> in sync with changing mode bits. I'm not saying that I want
> you to do this. In truth, I don't much care, but I can certainly
> see someone making a case for doing it, and once that gets
> through it's only a matter of time before it starts looking
> as if putting it in the kernel wouldn't be a bad idea.
> 
> > The mandatory security policy does
> > depend on controlling the use of capabilities (e.g. a process with
> > CAP_SYS_RAWIO can easily subvert the intent of the mandatory policy, and
> > a number of capability checks have no separate check/LSM hook so we need
> > the mandatory capability check for complete coverage), and already
> > controls their use (restrictively).  Extending SELinux to further grant
> > capabilities authoritatively isn't much of a stretch.  Doing the same
> > for mode bits would extend SELinux beyond what it needs for mandatory
> > protection and run into compatibility issues with the pervasive use of
> > mode bits by users and applications.  I don't think the analogy fits.
> > 
> > Let me ask you what your counter-proposal is.  The situation today is
> > that one must authorize a program for capabilities twice:
> > - in the filesystem state via setuid or file capabilities, and
> > - in SELinux policy.
> > 
> > Do you view that status quo as acceptable or desirable long term?
> 
> This is exactly how traditional Unix MLS systems with capabilities
> behave. To perform a chmod on a file you don't own on Irix you need
> CAP_FOWNER. To preform the same action on Trusted Irix you may also
> need CAP_MAC_READ, CAP_MAC_WRITE, or both. My counter proposal?
> 
> "Just" add the POSIX CAP_MAC_... capabilities to capability.h and
> have SELinux use them, using the existing capabilities mechanisms
> like everyone else. You've just made a pass through the SELinux
> code to switch to authoritative capability handling, so you should
> know all the places the you'd need to consider changing. Let me know
> if you need help figuring out how to cleanly apply capabilities to
> a mandatory access control facility. 
> 
> I wouldn't be too surprised if someone proposed those
> capabilities be introduced in the near future anyway.

First, such capabilities would be redundant.  We can already express MLS
overrides via policy today, without needing capabilities to be defined
for them at all.

Second, one of the motivations for Type Enforcement was to allow
exceptions/overrides to be expressed directly in the policy itself,
rather than requiring a separate orthogonal mechanism like
capabilities/privileges.  Along with using that same policy to protect
those privileged subjects from untrustworthy inputs, to bind them to
specific code, and to limit them to least privilege to contain the
damage that can come from them.

What you are proposing is in direct opposition to our goals and design.
You can certainly disagree with those goals and design, but it makes
arguing about how we are approaching the problem rather pointless.

So let's just agree to disagree.   Get file capabilities into mainline
and fully integrated so that people can use that mechanism for assigning
capabilities, and extend SELinux with this patch so that people can use
SELinux for assigning capabilities, and let the users decide.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
