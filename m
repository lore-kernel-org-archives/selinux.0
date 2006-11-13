Subject: Flask headers (Was: RE: [PATCH RFC] SELinux support for DCCP)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <XMMS.LNX.4.64.0611111302030.30219@d.namei>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
	 <XMMS.LNX.4.64.0611111302030.30219@d.namei>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 08:28:28 -0500
Message-Id: <1163424508.24635.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-11-11 at 13:03 -0500, James Morris wrote:
> On Sat, 11 Nov 2006, Joshua Brindle wrote:
> 
> > > From: James Morris [mailto:jmorris@namei.org] 
> > > 
> > > On Sat, 11 Nov 2006, Joshua Brindle wrote:
> > > 
> > > > James Morris wrote:
> > > > > The kernel patch is included below, please review.
> > > > > 
> > > > > Signed-off-by: James Morris <jmorris@namei.org>
> > > > >   +#define CONTEXT__TRANSLATE                        0x00000001UL
> > > > > +#define CONTEXT__CONTAINS                         0x00000002UL
> > > > >   +   S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
> > > > > +   S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
> > > > >   +    S_("context")
> > > > >   +#define SECCLASS_CONTEXT                                 59
> > > > >   
> > > > 
> > > > oops?
> > > 
> > > What?
> > > 
> > 
> > Did you mean to include context classes as part of the dccp patch?
> 
> The kernel headers have to match the flask headers in the userland tools, 
> as they share policy-related data structures.  Ideally, we'd have security 
> server namespaces, to keep these things separate.

Given the class/permission validation patches by Chad, we should modify
the policy scripts that generate the Flask headers to use the existing #
userspace annotations in security_classes to generate two sets of
headers, one for the kernel that only includes the kernel definitions
and one for libselinux that has them all.  The values will stay the
same, but the kernel doesn't need the userspace definitions and we don't
want the kernel imposing restrictions on the ability to modify those
userspace definitions later.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
