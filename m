Subject: RE: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 13:33:41 -0500
Message-Id: <1171564421.32574.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 14:22 -0500, Joshua Brindle wrote:
> > From: Eric Paris [mailto:eparis@redhat.com] 
> > 
> > On Wed, 2007-02-14 at 13:10 -0500, Chad Sellers wrote:
> > > On 2/13/07 2:36 PM, "Eric Paris" <eparis@redhat.com> wrote:
> > > 
> > > > On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
> > > >> On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
> > > > [snip snip]
> > > >>> This is a vestige of the original av padding where I had to be 
> > > >>> concerned that p->p_classes.nprim was larger than 
> > kdefs->cts_len.  
> > > >>> Since now I only use the array when making permission 
> > checks I can 
> > > >>> assume that I will never get a class from the check 
> > greater than 
> > > >>> the number of kernel classes defined.  So all that can be 
> > > >>> simplified to just
> > > >>> p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, 
> > > >>> p->GFP_KERNEL);
> > > >> 
> > > >> No - security_compute_av can also be called via 
> > selinuxfs to check 
> > > >> userland security classes (from libselinux for userspace object 
> > > >> managers).
> > > > 
> > > > I'm starting to wonder if the entire way I am 
> > constructing and using 
> > > > using my table might be wrong.  Right now I am finding the 
> > > > permissions which are defined in the kernel but are not 
> > defined in 
> > > > the policy, storing just those select permissions, and 
> > then adding 
> > > > those to the allow rules.  This works very well when I 
> > only consider 
> > > > the kernel and don't think about things in userspace.
> > > > 
> > > > But now I ask the question, do we/I want to extend this 
> > methodology 
> > > > to userspace classes and permissions?  Obviously I 
> > wouldn't be able 
> > > > to build the 'unknown perms' table for userspace since they are 
> > > > completely unknown!  Would it be better if I changed my 
> > approach to
> > > > 
> > > > Now:
> > > > avd.allowed |= p->undefined_perms[tclass-1]
> > > > 
> > > > Possible
> > > > avd.allowed |= (p->defined_perms[tclass-1]  ^ 0xffffffff)
> > > > 
> > > Don't you still have the same problem of needing to know 
> > what classes 
> > > and permissions are defined in the userspace object 
> > manager? You still 
> > > have to fill out defined_perms for these classes (or you'll just 
> > > return 0xffffffff for all userspace classes).
> > 
> > That is my point of question and lack of understanding.  Will 
> > the policy which is passed to the kernel have all of the 
> > policy for all of the system or only that for the kernel?  
> > The way I see both cases:
> > 
> 
> Only for the kernel.

Actually, I thought you had found that the userspace security server
isn't much of a win (and a definite cost) for current usage by e.g. the
X server.  Which would suggest that we aren't likely to evict userspace
policy from the kernel any time soon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
