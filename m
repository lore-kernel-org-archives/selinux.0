Subject: Re: Deprecate freecon and freeconary
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <44037A30.2040406@cornell.edu>
References: <44037A30.2040406@cornell.edu>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 08:00:54 -0500
Message-Id: <1141131654.22297.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-27 at 17:16 -0500, Ivan Gyurdiev wrote:
> This patch marks freecon and freeconary as deprecated.
> All uses of freecon() are changed to free().
> Uses of freeconary() remain within the library, since this is a useful 
> function.

Given that freeconary() is a useful helper, should we retain it in the
non-deprecated API but just convert its argument to char** going
forward?
 
> stdlib.h has been included where appropriate.
> stddef.h has been included where size_t was needed
> Manpages and comments have been edited appropriately.
> 
> The next logical patch is to remove security_context_t, and replace it 
> with char*, although I'm not sure whether that should be done throughout 
> the library, or just in the API.

We'll likely need to retain the type definition in the API for
compatibility with externally maintained code (e.g. SELinux userland
patches that have migrated into other distributions and in some cases
into the upstream packages).  We will also need to introduce a map file
for libselinux, version it, and provide backward compatibility for
freecon/freeconary APIs in the "old" version, only dropping them as
exported symbols for code linked against the latest version. 

> 1. Freecon and freeconary are not in a proper namespace. All such 
> functions should be deprecated and replaced in general.

Not sure if this is truly justified for all such functions, e.g.
getfilecon, setfilecon, setexeccon, etc are basic primitives that could
easily have been implemented as system calls (and were originally) if
that had been an option.  The core API (wrappers of kernel APIs) can
likely be left alone aside from security_context_t -> char* conversion.

> 2. The security_context_t type has the wrong namespace, which should be 
> replaced with selinux.

As above, not sure if this is truly justified, as long as we have some
reasonably distinguishing prefix (security_, avc_), unless we know of a
real conflict.

> 3. The security_context_t type is not opaque - it is externally defined 
> as a char*. This means it provides no encapsulation of any kind. A 
> context can be treated as a char*. Therefore freecon() offers no 
> benefits over free(), and just adds an additional layer of overhead. It 
> was pointed out that the string might not be allocated with malloc() [ 
> in the future ], so freecon() might need to do special handling on it. 
> This scenario doesn't seem probable at all. Also, such a string would 
> most likely be cloned by the client immediately into a regular string, 
> since we don't have a proper API for working with security_context_t - 
> how do I clone one into another for example?
>
> 4. The security_context_t type has a drawback over char*. Since selinux 
> is an optional integration feature in most other code, 
> security_context_t must be placed in an ifdef block. char* doesn't 
> require that, so it is easier to use.
> 
> 5. security_context_t is unclear... since the pointer is hidden, it is 
> not immediately obvious what its data size is when looking at the code.

These latter three reasons are the real justification for this change,
IMHO.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
