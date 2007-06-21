Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LKff8s027310
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 16:41:41 -0400
Received: from web36603.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5LKfcjl005923
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 20:41:39 GMT
Date: Thu, 21 Jun 2007 13:41:23 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1182186197.7236.131.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <950717.2625.qm@web36603.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2007-06-18 at 08:32 -0700, Casey Schaufler wrote:
> > --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > 
> > > The mandatory security policy
> > 
> > Let's get our words strait. I believe that what you're talking
> > about here is the SELinux mechanism for enforcing the policy
> > provided from user space.
> > 
> > > doesn't depend on the mode bits / DAC, and
> > > thus remains orthogonal to it.
> > 
> > You could certainly incorporate the mode bits and/or ACLs
> > into the userland tools that generate policy. Why, for the
> > time being you could even us restoreconfigd to keep the labels
> > in sync with changing mode bits. I'm not saying that I want
> > you to do this. In truth, I don't much care, but I can certainly
> > see someone making a case for doing it, and once that gets
> > through it's only a matter of time before it starts looking
> > as if putting it in the kernel wouldn't be a bad idea.
> > 
> > > The mandatory security policy does
> > > depend on controlling the use of capabilities (e.g. a process with
> > > CAP_SYS_RAWIO can easily subvert the intent of the mandatory policy, and
> > > a number of capability checks have no separate check/LSM hook so we need
> > > the mandatory capability check for complete coverage), and already
> > > controls their use (restrictively).  Extending SELinux to further grant
> > > capabilities authoritatively isn't much of a stretch.  Doing the same
> > > for mode bits would extend SELinux beyond what it needs for mandatory
> > > protection and run into compatibility issues with the pervasive use of
> > > mode bits by users and applications.  I don't think the analogy fits.
> > > 
> > > Let me ask you what your counter-proposal is.  The situation today is
> > > that one must authorize a program for capabilities twice:
> > > - in the filesystem state via setuid or file capabilities, and
> > > - in SELinux policy.
> > > 
> > > Do you view that status quo as acceptable or desirable long term?
> > 
> > This is exactly how traditional Unix MLS systems with capabilities
> > behave. To perform a chmod on a file you don't own on Irix you need
> > CAP_FOWNER. To preform the same action on Trusted Irix you may also
> > need CAP_MAC_READ, CAP_MAC_WRITE, or both. My counter proposal?
> > 
> > "Just" add the POSIX CAP_MAC_... capabilities to capability.h and
> > have SELinux use them, using the existing capabilities mechanisms
> > like everyone else. You've just made a pass through the SELinux
> > code to switch to authoritative capability handling, so you should
> > know all the places the you'd need to consider changing. Let me know
> > if you need help figuring out how to cleanly apply capabilities to
> > a mandatory access control facility. 
> > 
> > I wouldn't be too surprised if someone proposed those
> > capabilities be introduced in the near future anyway.
> 
> First, such capabilities would be redundant.  We can already express MLS
> overrides via policy today, without needing capabilities to be defined
> for them at all.

Nosir, that is not what CAP_MAC_READ should do in the SELinux case.
That capability would override the SELinux policy in completely,
not just the MLS component. On Trusted Irix CAP_MAC_READ overrides
both the sensitivity policy (Bell & LaPadula) and the integrity
policy (Biba). That is why it is CAP_MAC_READ not CAP_MLS_READ,
to allow for cases where policies beyond MLS are desired.

I expect that the counter to this is that SELinux policy can be
configured so as to allow SELinux policy to be overridden. I can
accept that.

> Second, one of the motivations for Type Enforcement was to allow
> exceptions/overrides to be expressed directly in the policy itself,
> rather than requiring a separate orthogonal mechanism like
> capabilities/privileges.

There is an argument to be made for the grand unified access control
scheme. The POSIX group felt (back in the stone age, I'll admit) that
the flexibiliy of distinct mechanisms would be more conducive to
their adoption. In fact, one of the biggest reasons cited for the
eventual withdrawl of the 1e/2c draft was that you had to approve of
the whole thing. Some of the individual sections, it was generally
agreed, could have been approved without the baggage of some of the
others. 

> Along with using that same policy to protect
> those privileged subjects from untrustworthy inputs, to bind them to
> specific code, and to limit them to least privilege to contain the
> damage that can come from them.
> 
> What you are proposing is in direct opposition to our goals and design.
> You can certainly disagree with those goals and design, but it makes
> arguing about how we are approaching the problem rather pointless.

Well, there it is.

> So let's just agree to disagree.   Get file capabilities into mainline
> and fully integrated so that people can use that mechanism for assigning
> capabilities, and extend SELinux with this patch so that people can use
> SELinux for assigning capabilities, and let the users decide.

So long as we're all accepting of that, sure.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
