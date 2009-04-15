Subject: access(2) vs. SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Apr 2009 11:51:50 -0400
Message-Id: <1239810710.27560.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Per [1], the fact that SELinux applies the same read/write/execute
checks in response to access(2) calls as it does for an actual open(2)
for read/write or execve(2) for execute leads to huge numbers of
spurious denials for applications such as nautilus that probe all files
being listed.  dontaudit'ing of these denials is viewed as unacceptable
as Dan wants to be able to see such denials upon the actual open(2) or
execve(2) attempts.

If access(2) only returned the result of the DAC access checks and e.g.
only checked getattr permission on access(2) calls (similar to stat(2)),
then the read/write/execute MAC denials would not happen, but that would
likely break the behavior of existing applications/libraries that use
access(2) to decide whether to follow a privileged code path or fall
back on an unprivileged code path (e.g. kerberos libraries).

Other suggested proposals included:
- Using the _noaudit interface to suppress auditing of the
read/write/execute checks when checking for access(2), although this
requires reworking the underlying implementation so that we can
distinguish access(2) from open(2) checking.  However, this could lead
to silent failure of applications with no way to obtain any audit
messages, and would provide an obvious way to probe for access without
triggering audit.

- Using a different class or set of permissions when checking for
access(2), likewise requiring reworking the underlying implementation so
that we can distinguish the checking from open(2).  Then one could
choose to use dontaudit rules to suppress the access(2) checking w/o
suppressing the open(2) checking.  However, this could present a major
consistency problem between what access(2) reports and what is actually
allowed upon open(2) or execve(2).

Thoughts?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=495211


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
