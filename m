Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Eric Paris <eparis@redhat.com>
To: Chad Sellers <csellers@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jbrindle@tresys.com
In-Reply-To: <C1F8BACA.1D17E%csellers@tresys.com>
References: <C1F8BACA.1D17E%csellers@tresys.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 13:49:38 -0500
Message-Id: <1171478978.10871.62.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 13:10 -0500, Chad Sellers wrote:
> On 2/13/07 2:36 PM, "Eric Paris" <eparis@redhat.com> wrote:
> 
> > On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
> >> On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
> > [snip snip]
> >>> This is a vestige of the original av padding where I had to be concerned
> >>> that p->p_classes.nprim was larger than kdefs->cts_len.  Since now I
> >>> only use the array when making permission checks I can assume that I
> >>> will never get a class from the check greater than the number of kernel
> >>> classes defined.  So all that can be simplified to just
> >>> p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, GFP_KERNEL);
> >> 
> >> No - security_compute_av can also be called via selinuxfs to check
> >> userland security classes (from libselinux for userspace object
> >> managers).
> > 
> > I'm starting to wonder if the entire way I am constructing and using
> > using my table might be wrong.  Right now I am finding the permissions
> > which are defined in the kernel but are not defined in the policy,
> > storing just those select permissions, and then adding those to the
> > allow rules.  This works very well when I only consider the kernel and
> > don't think about things in userspace.
> > 
> > But now I ask the question, do we/I want to extend this methodology to
> > userspace classes and permissions?  Obviously I wouldn't be able to
> > build the 'unknown perms' table for userspace since they are completely
> > unknown!  Would it be better if I changed my approach to
> > 
> > Now:
> > avd.allowed |= p->undefined_perms[tclass-1]
> > 
> > Possible
> > avd.allowed |= (p->defined_perms[tclass-1]  ^ 0xffffffff)
> > 
> Don't you still have the same problem of needing to know what classes and
> permissions are defined in the userspace object manager? You still have to
> fill out defined_perms for these classes (or you'll just return 0xffffffff
> for all userspace classes).

That is my point of question and lack of understanding.  Will the policy
which is passed to the kernel have all of the policy for all of the
system or only that for the kernel?  The way I see both cases:

All of the policy for the whole system:
- My ^ 0xffffffff method will work just fine since the policy knows what
is defined by policy and we can simply allow everything else.
- This would be the only reasonable way the kernel could answer
through /selinux for userapace objects.  If the kernel doesn't know
about the userspace objects or permissions how can it answer yes or no
with any meaning?

Only the kernel policy is loaded into the kernel:
- Either method works fine although the more directed method might help
to catch accidental bugs in the kernel which would be missed by the
shotgun method.
- Obviously userspace can't ask the kernel to make decisions since it
doesn't know, so it seems I can be directed or just allow everything.

So really I just need some ejumakashun on the mythic userspace security
server and just what information will be available to the kernel when it
is passed the policy.  And just what decision context_struct_compute_av
might be ask to decide.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
