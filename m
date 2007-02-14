MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Ability to allow undefined permissions and classes -v2
Date: Wed, 14 Feb 2007 14:22:11 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
In-Reply-To: <1171478978.10871.62.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Eric Paris" <eparis@redhat.com>, "Chad Sellers" <csellers@tresys.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Eric Paris [mailto:eparis@redhat.com] 
> 
> On Wed, 2007-02-14 at 13:10 -0500, Chad Sellers wrote:
> > On 2/13/07 2:36 PM, "Eric Paris" <eparis@redhat.com> wrote:
> > 
> > > On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
> > >> On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
> > > [snip snip]
> > >>> This is a vestige of the original av padding where I had to be 
> > >>> concerned that p->p_classes.nprim was larger than 
> kdefs->cts_len.  
> > >>> Since now I only use the array when making permission 
> checks I can 
> > >>> assume that I will never get a class from the check 
> greater than 
> > >>> the number of kernel classes defined.  So all that can be 
> > >>> simplified to just
> > >>> p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, 
> > >>> p->GFP_KERNEL);
> > >> 
> > >> No - security_compute_av can also be called via 
> selinuxfs to check 
> > >> userland security classes (from libselinux for userspace object 
> > >> managers).
> > > 
> > > I'm starting to wonder if the entire way I am 
> constructing and using 
> > > using my table might be wrong.  Right now I am finding the 
> > > permissions which are defined in the kernel but are not 
> defined in 
> > > the policy, storing just those select permissions, and 
> then adding 
> > > those to the allow rules.  This works very well when I 
> only consider 
> > > the kernel and don't think about things in userspace.
> > > 
> > > But now I ask the question, do we/I want to extend this 
> methodology 
> > > to userspace classes and permissions?  Obviously I 
> wouldn't be able 
> > > to build the 'unknown perms' table for userspace since they are 
> > > completely unknown!  Would it be better if I changed my 
> approach to
> > > 
> > > Now:
> > > avd.allowed |= p->undefined_perms[tclass-1]
> > > 
> > > Possible
> > > avd.allowed |= (p->defined_perms[tclass-1]  ^ 0xffffffff)
> > > 
> > Don't you still have the same problem of needing to know 
> what classes 
> > and permissions are defined in the userspace object 
> manager? You still 
> > have to fill out defined_perms for these classes (or you'll just 
> > return 0xffffffff for all userspace classes).
> 
> That is my point of question and lack of understanding.  Will 
> the policy which is passed to the kernel have all of the 
> policy for all of the system or only that for the kernel?  
> The way I see both cases:
> 

Only for the kernel.

> All of the policy for the whole system:
> - My ^ 0xffffffff method will work just fine since the policy 
> knows what is defined by policy and we can simply allow 
> everything else.
> - This would be the only reasonable way the kernel could 
> answer through /selinux for userapace objects.  If the kernel 
> doesn't know about the userspace objects or permissions how 
> can it answer yes or no with any meaning?
> 

It answers no if it doesn't know about it because selinux is deny by
default, no means it isn't allowed.

> Only the kernel policy is loaded into the kernel:
> - Either method works fine although the more directed method 
> might help to catch accidental bugs in the kernel which would 
> be missed by the shotgun method.
> - Obviously userspace can't ask the kernel to make decisions 
> since it doesn't know, so it seems I can be directed or just 
> allow everything.
> 

No, if userspace does manage to ask the kernel about something (on
accident or otherwise) it must be denied by default, SELinux is a deny
by default mechanism. The routing mechanism is in userland (in
libselinux) so the kernel doesn't know to point the requester somewhere
else for an answer, it must simply answer denied.

> So really I just need some ejumakashun on the mythic 
> userspace security server and just what information will be 
> available to the kernel when it is passed the policy.  And 
> just what decision context_struct_compute_av might be ask to decide.
> 

We haven't totally decided but I think its safe to assume that the
kernel won't have policy for userspace object classes at all and may not
even know of the existance of said classes. The userspace requests would
be routed to a userspace security server and the kernel would only
answer questions for object classes it controls (or maybe not even
those).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
