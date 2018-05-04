Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44D8AY9026518
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 09:08:10 -0400
To: selinux@tycho.nsa.gov
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504121915.GA3263@julius.enp8s0.d30>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4b96edef-b5cd-c547-b57f-64e13564bd4c@tycho.nsa.gov>
Date: Fri, 4 May 2018 09:09:20 -0400
MIME-Version: 1.0
In-Reply-To: <20180504121915.GA3263@julius.enp8s0.d30>
Content-Type: text/plain; charset=utf-8
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2018 08:19 AM, Dominick Grift wrote:
> On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
>> Hi,
>>
>> If you have encountered any unreported problems with the 2.8-rcX releases or have any
>> pending patches you believe should be included in the 2.8 release, please post them soon.
>> Also, let us know of any additions or changes that should be made to the release notes;
>> the current draft is as follows.
>>
>> User-visible changes:
> 
> One might see processes "validate_context" where they didnt before
> 
> Generally processes that use lgetfilecon/lsetfilecon i suspect (like lvm, various systemd components etc)

That should no longer be true as of -rc2 since I reverted the libselinux: verify file_contexts when using restorecon change.

> 
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
>>
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
