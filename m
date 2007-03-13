Subject: Re: Getting Security Identifier (SID) for newly created process
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pravin <shindepravin@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <9d1b82480703130901s767720eex709936ac66485cfb@mail.gmail.com>
References: <9d1b82480703130901s767720eex709936ac66485cfb@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 12:55:16 -0400
Message-Id: <1173804916.2068.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 21:31 +0530, Pravin wrote:
> Hi,
> I have some doubts in how the security context of newly created
> process is decided.
> I think that there are some policies written by user, which will
> decides the security context of new process depending on the security
> context of the parent process and the executable from which process
> has been created.
> 
> If this is the case, Can I know which is the interface function
> provided by selinux, that will tell the SID of new process created.
> 
> This also raises the question that How first process is getting its
> security context?
> is it from selinux policy or is it being constant?

There are a set of initial SIDs, and the initial task is assigned one of
those initial SIDs, SECINITSID_KERNEL, by selinux_init().  The initial
SIDs are later mapped to security contexts defined in the policy
configuration when policy is first loaded.  When a task forks, the child
inherits the SID of the parent.  When a task execs a program, a SID for
the transformed process is computed by selinux_bprm_set_security and set
by selinux_bprm_apply_creds if all checks pass.  The SID for the
transformed process may be specified by the calling process via
setexeccon(3) if allowed by policy, or it will default to calling the
security server's security_transition_sid() interface.  That interface
will check the policy for rules in the policy and use them if present,
or default to staying in the same context in their absence.

But this is all internal to SELinux; you should not be calling any of
those functions from outside of SELinux directly.  Some SELinux
functions are exported to the rest of the kernel via
include/linux/selinux.h.  Some SELinux functions are exported to
userspace via selinuxfs.

Why do you ask?
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
