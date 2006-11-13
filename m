Subject: Re: Flask headers (Was: RE: [PATCH RFC] SELinux support for DCCP)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: James Morris <jmorris@namei.org>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1163435402.18181.121.camel@sgc.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
	 <XMMS.LNX.4.64.0611111302030.30219@d.namei>
	 <1163424508.24635.14.camel@moss-spartans.epoch.ncsc.mil>
	 <1163435402.18181.121.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 11:38:47 -0500
Message-Id: <1163435927.24635.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-13 at 11:30 -0500, Christopher J. PeBenito wrote:
> On Mon, 2006-11-13 at 08:28 -0500, Stephen Smalley wrote:
> > On Sat, 2006-11-11 at 13:03 -0500, James Morris wrote:
> > > The kernel headers have to match the flask headers in the userland tools, 
> > > as they share policy-related data structures.  Ideally, we'd have security 
> > > server namespaces, to keep these things separate.
> > 
> > Given the class/permission validation patches by Chad, we should modify
> > the policy scripts that generate the Flask headers to use the existing #
> > userspace annotations in security_classes to generate two sets of
> > headers, one for the kernel that only includes the kernel definitions
> > and one for libselinux that has them all.
> 
> Let me just clarify this:
> 
> > The values will stay the same, but the kernel doesn't need the
> > userspace definitions and we don't want the kernel imposing
> > restrictions on the ability to modify those userspace definitions
> > later.
> 
> So basically you're just suggesting we drop out the userspace permission
> definitions in av_permissions.h and in av_perm_to_string.h for the
> kernel?  All the class definitions will still have to stick around so
> the offsets for the classes to remain correct.

We have to keep the kernel class values the same, but I don't see why we
need to emit the #define's for the userspace classes in the kernel's
flask.h.  We would need a way of marking holes in the class_to_string.h
table for the kernel to tell the validation code to skip them, e.g. we
could use S_("null") for userspace classes, and have the validation code
skip all such entries.  The kernel policy loading validation code
shouldn't check userspace classes or permissions at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
