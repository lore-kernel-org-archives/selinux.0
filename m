Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11K0OTI014372
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 15:00:24 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o11K06YO017723
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 20:00:10 GMT
Message-Id: <201002011959.o11Jxxb5015275@vivaldi38.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 20:59:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

I have amended most changes to the patch, according to your feedback and here is a track:

The only function that has been made "standard" from "static inline" is mls_range_set which I am using in ss/services.c. Its return value is now being checked for robustness, an appropriate KERN_ERR is generated in case something goes wrong and the appropriate return code is fed back to the caller.

The new field of structure policydb has been named mls_enabled and a new function security_mls_enabled has been created (and declared in the main global header file security.h).

The comment style in services.c has been changed accordingly to the CodingStyle (checkpatch.pl no longer complains).

External declarations have been removed from .c files (selinuxfs.c) and moved to the global header file security.h.

Missing function declarations have been added to the global include files rather than importing header files from ss.

The unused variable config has been removed from ss/policydb.c.

The "n" problem is due to a problem in my mailer. The attached file does not have the missing control character "".

Issues:

- security.h now defines security_mls_enabled() and this function takes struct policydb * as parameter but this structure is not visible to security.h; I overcome this problem by declaring the parameter void *.

- when trying to build, I get the following compilation errors now:

  CC      security/selinux/ss/sidtab.o
In file included from security/selinux/ss/mls_types.h:20,
                 from security/selinux/ss/context.h:21,
                 from security/selinux/ss/sidtab.h:11,
                 from security/selinux/ss/sidtab.c:13:
security/selinux/ss/policydb.h:97: error: field 'range' has incomplete type
security/selinux/ss/policydb.h:98: error: field 'dfltlevel' has incomplete type
In file included from security/selinux/ss/mls_types.h:20,
                 from security/selinux/ss/context.h:21,
                 from security/selinux/ss/sidtab.h:11,
                 from security/selinux/ss/sidtab.c:13:
security/selinux/ss/policydb.h:156: error: array type has incomplete element type
In file included from security/selinux/ss/mls_types.h:20,
                 from security/selinux/ss/context.h:21,
                 from security/selinux/ss/sidtab.h:11,
                 from security/selinux/ss/sidtab.c:13:
security/selinux/ss/policydb.h:265: warning: 'struct sidtab' declared inside parameter list
security/selinux/ss/policydb.h:265: warning: its scope is only this definition or declaration, which is probably not what you want

Note that policydb.h includes symtab.h, avtab.h, sidtab.h, ebitmap.h, mls_types.h, context.h, constraint.h.

So there must be something wrong in mls_types.h, that's why I moved the inline functions to a separate .c file.

What do you say ?

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
