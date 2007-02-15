Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1171395416.10871.37.camel@localhost.localdomain>
References: <1171309430.10871.2.camel@localhost.localdomain>
	 <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1171387714.10871.22.camel@localhost.localdomain>
	 <1171388407.3242.87.camel@moss-spartans.epoch.ncsc.mil>
	 <1171395416.10871.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 13:05:35 -0500
Message-Id: <1171562735.32574.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-13 at 14:36 -0500, Eric Paris wrote:
> On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
> > On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
> [snip snip]
> > > This is a vestige of the original av padding where I had to be concerned
> > > that p->p_classes.nprim was larger than kdefs->cts_len.  Since now I
> > > only use the array when making permission checks I can assume that I
> > > will never get a class from the check greater than the number of kernel
> > > classes defined.  So all that can be simplified to just
> > > p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, GFP_KERNEL);
> > 
> > No - security_compute_av can also be called via selinuxfs to check
> > userland security classes (from libselinux for userspace object
> > managers).
> 
> I'm starting to wonder if the entire way I am constructing and using
> using my table might be wrong.  Right now I am finding the permissions
> which are defined in the kernel but are not defined in the policy,
> storing just those select permissions, and then adding those to the
> allow rules.  This works very well when I only consider the kernel and
> don't think about things in userspace.
> 
> But now I ask the question, do we/I want to extend this methodology to
> userspace classes and permissions?  Obviously I wouldn't be able to
> build the 'unknown perms' table for userspace since they are completely
> unknown!  Would it be better if I changed my approach to
> 
> Now:
> avd.allowed |= p->undefined_perms[tclass-1]
> 
> Possible
> avd.allowed |= (p->defined_perms[tclass-1]  ^ 0xffffffff)
> 
> It's not quite as directed.  Instead of only allowing the select
> permissions which we know are missing from policy we instead shotgun
> approach and allow everything not explicitly defined.  Maybe this allows
> buggy code to get allows which would have been caught and things like
> that, but at least it could work for userspace classes and perms.  Seems
> to me like this undefined perms problem will be worse in userspace than
> it is in the kernel.
> 
> Thoughts?  Or should I just stick with the ideas behind the patch below?

Keep it simple and directed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
