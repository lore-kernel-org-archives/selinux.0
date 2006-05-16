Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>
In-Reply-To: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 16 May 2006 08:15:43 -0400
Message-Id: <1147781743.30789.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-15 at 12:35 -0400, Stephen Smalley wrote:
> # touch foo
> # chcon -t foo_exec_t foo
> # ls -Z foo
> -rw-r--r--  root root system_u:object_r:unlabeled_t    foo

Note that an alternative would be to modify security_sid_to_context() to
return the unmapped string representation if it exists rather than just
falling through to the unlabeled SID's context.  In that case,
getxattr() would return the unmapped string, and userspace would see
user_u:object_r:foo_exec_t throughout the example even though the kernel
would internally be applying access checks based on the unlabeled SID's
context.  That seems useful for programs that want to check the
attributes (e.g. restore), but prevents rpm from easily checking whether
the attribute has been validated by a subsequent policy load (although
it could use security_check_context(3) for that purpose).  Likewise, if
an audit message is generated for a SID that has been invalidated,
having security_sid_to_context() return the unmapped string
representation would preserve the original string label in the audit
message rather than degenerating to the unlabeled SID's context.
Thoughts?

> # semodule -i foo.pp # defines foo_exec_t
> # ls -Z foo
> -rw-r--r--  root root user_u:object_r:foo_exec_t       foo
> # semodule -r foo
> # ls -Z foo
> -rw-r--r--  root root system_u:object_r:unlabeled_t    foo
> # semodule -i foo.pp
> # ls -Z foo
> -rw-r--r--  root root user_u:object_r:foo_exec_t       foo
> 
> Logically, there are two separate changes here.  The first logical
> change is to support deferred mapping of security contexts in the SID
> table, storing their string representations when they cannot be mapped
> under the current policy, and treating them the same as the unlabeled
> SID while they are in this state.  Upon policy reloads, if a valid
> context becomes invalid under the new policy, rather than removing it
> from the SID table, we convert it to its string representation under the
> old policy and store that in the SID table until such a time as it
> becomes valid again, and if an invalid context becomes valid, we map it
> to its internal structure representation.  This change alone is
> worthwhile irrespective of the second change, as it addresses the
> longstanding issue with removing and re-adding types to policy when they
> are assigned to inodes.  The second logical change introduces the
> support for setting invalid contexts by privileged processes, both via
> setxattr() and via /proc/self/attr/fscreate, which is the more
> controversial aspect.  Note that contrary to my earlier expectations, no
> walking of the inode security structs is required, as the SIDs
> themselves remain invariant under such changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
