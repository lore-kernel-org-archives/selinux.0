Subject: Re: Flask headers (Was: RE: [PATCH RFC] SELinux support for DCCP)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>
In-Reply-To: <1163424508.24635.14.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C76FB@exchange.columbia.tresys.com>
	 <XMMS.LNX.4.64.0611111302030.30219@d.namei>
	 <1163424508.24635.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 11:30:02 -0500
Message-Id: <1163435402.18181.121.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-13 at 08:28 -0500, Stephen Smalley wrote:
> On Sat, 2006-11-11 at 13:03 -0500, James Morris wrote:
> > The kernel headers have to match the flask headers in the userland tools, 
> > as they share policy-related data structures.  Ideally, we'd have security 
> > server namespaces, to keep these things separate.
> 
> Given the class/permission validation patches by Chad, we should modify
> the policy scripts that generate the Flask headers to use the existing #
> userspace annotations in security_classes to generate two sets of
> headers, one for the kernel that only includes the kernel definitions
> and one for libselinux that has them all.

Let me just clarify this:

> The values will stay the same, but the kernel doesn't need the
> userspace definitions and we don't want the kernel imposing
> restrictions on the ability to modify those userspace definitions
> later.

So basically you're just suggesting we drop out the userspace permission
definitions in av_permissions.h and in av_perm_to_string.h for the
kernel?  All the class definitions will still have to stick around so
the offsets for the classes to remain correct.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
