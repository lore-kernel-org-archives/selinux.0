To: Jason Zaman <jason@perfinion.com>
Cc: SELinux <selinux@tycho.nsa.gov>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504075510.GB5101@baraddur.perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3c51abc9-2d3a-3cef-2ba1-d976dee651c5@tycho.nsa.gov>
Date: Fri, 4 May 2018 09:08:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180504075510.GB5101@baraddur.perfinion.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2018 03:55 AM, Jason Zaman wrote:
> On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
>> Hi,
>>
>> If you have encountered any unreported problems with the 2.8-rcX releases or have any
>> pending patches you believe should be included in the 2.8 release, please post them soon.
> 
> the rc2 release has been fine for me for several days now. And I havent
> heard any issues from any gentoo users either so we're probably good to
> go. -rc1 failed to boot properly for me because some important things in
> /run or /dev didnt get labeled but that was fixed in rc2.

Hmm...I'd like to understand that better. The change was verifying file_contexts when using restorecon,
which was reverted in -rc2.  But the fact that it prevented labeling files in -rc1 means that either
you have a bug in your file_contexts configuration or there is some other bug there.

> 
>> Also, let us know of any additions or changes that should be made to the release notes;
>> the current draft is as follows.
>>
>> User-visible changes:
>>
>> * semanage fcontext -l now also lists home directory entries from
>> file_contexts.homedirs.
>>
>> * semodule can now enable or disable multiple modules in the same
>> operation by specifying a list of modules after -e or -d, making them
>> consistent with the -i/u/r/E options.
>>
>> * CIL now supports multiple declarations of types, attributes, and
>> (non-conflicting) object contexts (e.g. genfscon), enabled via the -m
>> or --multiple-decls option to secilc.
>>
>> * libsemanage no longer deletes the tmp directory if there is an error
>> while committing the policy transaction, so that any temporary files
>> can be further inspected for debugging purposes (e.g. to examine a
>> particular line of the generated CIL module).  The tmp directory will
>> be deleted upon the next transaction, so no manual removal is needed.
>>
>> * Support was added for SCTP portcon statements. The corresponding
>> kernel support was introduced in Linux 4.17, and is only active if the
>> extended_socket_class policy capability is enabled in the policy.
> 
> Perhaps also note that the sctp stuff is in refpolicy and this 2.8
> release is required to compile it.
> 
> I tried doing a release of the gentoo policy (we merge from HEAD fairly
> frequently not only the big releases) and it fails to compile. I will
> add the sctp stuff back into gentoo's policy later then make the
> policies require >=2.8.
> 
> -- Jason
> 
>> * sepol_polcap_getnum/name() were exported as part of the shared libsepol
>> interface, initially for use by setools4.
>>
>> * semodule_deps was removed since it has long been broken and is not useful
>> for CIL modules.
>>
>> Packaging-relevant changes:
>>
>> * When overriding PREFIX, BINDIR, SBINDIR, SHLIBDIR, LIBEXECDIR, etc.,
>> DESTDIR has to be removed from the definition. For example on Arch
>> Linux, SBINDIR="${pkgdir}/usr/bin" was changed to SBINDIR="/usr/bin".
>>
>> * Defining variable LIBSEPOLA (to /usr/lib/libsepol.a, for example) is
>> no longer mandatory (thanks to the switch to "-l:libsepol.a" in
>> Makefiles).
>>
>> * PYSITEDIR has been renamed PYTHONLIBDIR (and its definition changed).
>>
>> * selinux-gui (i.e. system-config-selinux GUI application) is now
>> compatible with Python 3. Doing this required migrating away from
>> PyGTK to the supported PyGI library. This means that selinux-gui now
>> depends on python-gobject, Gtk+ 3 and selinux-python. It no longer
>> requires PyGtk or Python 2.
> 
