Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <201002011959.o11Jxxb5015275@vivaldi38.register.it>
References: <201002011959.o11Jxxb5015275@vivaldi38.register.it>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 15:22:21 -0500
Message-Id: <1265055741.12435.298.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-01 at 20:59 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> I have amended most changes to the patch, according to your feedback and here is a track:
> 
> The only function that has been made "standard" from "static inline"
> is mls_range_set which I am using in ss/services.c. Its return value
> is now being checked for robustness, an appropriate KERN_ERR is
> generated in case something goes wrong and the appropriate return code
> is fed back to the caller.

No, out of memory doesn't warrant a KERN_ERR.  Just handle it like other
errors in the same function and we'll get an out of memory error passed
back to userspace.

> The new field of structure policydb has been named mls_enabled and a
> new function security_mls_enabled has been created (and declared in
> the main global header file security.h).
> 
> The comment style in services.c has been changed accordingly to the
> CodingStyle (checkpatch.pl no longer complains).
> 
> External declarations have been removed from .c files (selinuxfs.c)
> and moved to the global header file security.h.
> 
> Missing function declarations have been added to the global include
> files rather than importing header files from ss.
> 
> The unused variable config has been removed from ss/policydb.c.
> 
> The "n" problem is due to a problem in my mailer. The attached file
> does not have the missing control character "".

No attachment was present.

> Issues:
> 
> - security.h now defines security_mls_enabled() and this function
> takes struct policydb * as parameter but this structure is not visible
> to security.h; I overcome this problem by declaring the parameter void
> *.

You shouldn't pass any argument to the function.  It is just:
	int security_mls_enabled(void)
	{
		return policydb.mls_enabled;
	}

The policydb structure is never used outside of the security server
(ss/).

> - when trying to build, I get the following compilation errors now:
> 
>   CC      security/selinux/ss/sidtab.o
> In file included from security/selinux/ss/mls_types.h:20,
>                  from security/selinux/ss/context.h:21,
>                  from security/selinux/ss/sidtab.h:11,
>                  from security/selinux/ss/sidtab.c:13:
> security/selinux/ss/policydb.h:97: error: field 'range' has incomplete type
> security/selinux/ss/policydb.h:98: error: field 'dfltlevel' has incomplete type
> In file included from security/selinux/ss/mls_types.h:20,
>                  from security/selinux/ss/context.h:21,
>                  from security/selinux/ss/sidtab.h:11,
>                  from security/selinux/ss/sidtab.c:13:
> security/selinux/ss/policydb.h:156: error: array type has incomplete element type
> In file included from security/selinux/ss/mls_types.h:20,
>                  from security/selinux/ss/context.h:21,
>                  from security/selinux/ss/sidtab.h:11,
>                  from security/selinux/ss/sidtab.c:13:
> security/selinux/ss/policydb.h:265: warning: 'struct sidtab' declared inside parameter list
> security/selinux/ss/policydb.h:265: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> Note that policydb.h includes symtab.h, avtab.h, sidtab.h, ebitmap.h, mls_types.h, context.h, constraint.h.
> 
> So there must be something wrong in mls_types.h, that's why I moved the inline functions to a separate .c file.
> 
> What do you say ?

You must have introduced a dependency cycle in the headers through your
patch.  I'd have to see it to know for sure.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
