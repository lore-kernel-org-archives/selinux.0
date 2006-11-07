Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and
	permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <C1751E53.19473%csellers@tresys.com>
References: <C1751E53.19473%csellers@tresys.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 15:57:36 -0500
Message-Id: <1162933056.3009.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(re-added list to cc)

On Mon, 2006-11-06 at 17:16 -0500, Chad Sellers wrote:
> On 11/6/06 4:32 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> 
> > On Mon, 2006-11-06 at 12:38 -0500, Chad Sellers wrote:
> >> Index: linux-2.6-discovery/security/selinux/ss/services.c
> >> ===================================================================
> >> --- linux-2.6-discovery.orig/security/selinux/ss/services.c
> >> +++ linux-2.6-discovery/security/selinux/ss/services.c
> >> @@ -53,6 +57,11 @@
> >>  extern void selnl_notify_policyload(u32 seqno);
> >>  unsigned int policydb_loaded_version;
> >>  
> >> +/*
> >> + * This is declared in avc.c
> >> + */
> >> +extern const struct selinux_class_perm selinux_class_perm;
> > 
> > (nit) Belongs in avc_ss.h.
> > 
> OK, I guess that makes sense. Just seems weird since the struct is actually
> in avc.c, and avc.c includes avc_ss.h. I'll resend with that change if I end
> up needing to resend for other reasons. Is this a big enough deal to resend
> if not?

No.

> > What test cases have you applied?
> I've tested the following policies:
> base case - minimal policy that should work fine
> extra class - add an extra class on the end, which should load
> extra perm - add an extra perm to a class, which should load
> missing class - remove a class from the end, simulating a kernel with a new
> class that isn't in policy yes, which should load
> missing perm - remove a perm from the end of a class, which should load
> wrong class - class with wrong value, which should fail
> wrong perm - perm with wrong value, which should fail
> change class - load 2 policies back to back, each with extra classes. Change
> the values of those classes between reloads. Simulates semanage linking a
> new class and changing the value of an old class, which should load
> change perm - same as change class but with perms
> wrong common - switch the inherits for a class, which should fail
> missing common - delete the inheritance from a class (adding the same number
> of perms at the beginning of the class), which should fail
> bad common - common with an incorrect perm, which should fail
> extra common - add a common to a class that didn't have one, which should
> fail
> missing common perm - remove common perm from the end, also ensuring that
> any class inheriting it does not have perms as the offsets will be off,
> which should load
> 
> Let me know if those descriptions don't make sense. I can send the policies
> if you'd rather.
> 
> Thanks,
> Chad

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
