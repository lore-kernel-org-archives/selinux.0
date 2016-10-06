Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u96EgAPq018892
 for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2016 10:42:10 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Subject: ANN: SELinux userspace 2.6-rc2 release
Message-ID: <5c9e5333-9e5f-b16f-1572-c6ebbf3f030c@tycho.nsa.gov>
Date: Thu, 6 Oct 2016 10:44:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A second release candidate for the SELinux userspace is now available at:
https://github.com/SELinuxProject/selinux/wiki/Releases

This has been tagged as 20161006 in the git repository.

Please give it a test and let us know if there are any issues.

Below are some notes on this release for packagers of the SELinux
userspace.  Please see the individual ChangeLog files for a detailed
list of changes.

1) sepolicy converted to setools4:
- sepolicy and its users now depend on setools4 instead of setools3.

- Please convert any remaining users of setools3 to setools4 since
setools3 is no longer being developed.

2) genhomedircon enhancements and behavior changes:
- genhomedircon supports the %{USERID} template for substituting the
user's uid. %{USERNAME} has also been added as a new template for
substituting the user's username.  The USER template is still supported
for backward compatibility but is deprecated.

- genhomedircon supports generating home directory contexts for login
mappings using the %group syntax.  This may produce an error if the user
belongs to multiple groups specified in the login mapping, which can be
resolved by adding an explicit mapping for the user to override the
group-based mapping.

- genhomedircon will fully replace the SELinux user and range fields in
each templated security context rather than only substituting for the
hardcoded strings "system_u" and "s0".  As a side effect, genhomedircon
no longer has special handling of "system_u" and will therefore trigger
a warning if there is a "system_u" entry in seusers:
    libsemanage.add_user: user system_u not in password file
This warning is not fatal, but it would be preferable to remove system_u
from the seusers file.
See https://bugzilla.redhat.com/show_bug.cgi?id=1378204

- genhomedircon will replace the role field in each templated security
context with the user prefix for the user if the user prefix is the
identifier of a role valid for the given user, or if it is "object_r".
This enables configuring RBACSEP (i.e. role-based separation of user
home directories) in policy.  If the user prefix is not a valid role,
then genhomedircon will leave the role field unmodified as before.

- genhomedircon will generate entries for logins mapped to the default
user.  Previously no entries were generated for such logins, which could
lead to no matching file_contexts.homedirs entries for users with home
directories outside of LU_HOMEDIRECTORY in the absence of usepasswd=True.

3) libselinux pcre2 support:
- libselinux supports either pcre1 or pcre2 but not both at the same
time. The default remains pcre1.

- To use pcre2, build libselinux and sefcontext_compile with 'make
USE_PCRE2=y". You must also rebuild your file_contexts.bin files with
the rebuilt sefcontext_compile.

- With pcre2, file_contexts.bin is no longer architecture-neutral. The
relevant architecture properties are endianness, pointer width, and
PCRE2_SIZE type.  libselinux will automatically detect an architecture
mismatch and ignore the stored precompiled regexes in that case,
recompiling them instead at runtime.  sefcontext_compile -i will report
the pcre version and architecture strings that it will include in the
file_contexts.bin file.

- With pcre2, file_contexts.bin is substantially larger than for pcre1.
With the Fedora policy, we see the following sizes:
383165	file_contexts (text)
1507941 file_contexts.bin (binary with pcre1 regexes)
8304105 file_contexts.bin (binary with pcre2 regexes)

- If you know that you will be generating file_contexts.bin for a target
with a different architecture string or if you do not wish to pay the
additional storage cost, you can use the -r option to sefcontext_compile
to omit the compiled regexes.
With the Fedora policy, this yields a much smaller file:
540540 file_contexts.bin (binary omitting pcre2 regexes)
You can make this the default when libsemanage invokes
sefcontext_compile by adding the following stanza to semanage.conf:
[sefcontext_compile]
path = /usr/sbin/sefcontext_compile
args = -r $@
[end]
