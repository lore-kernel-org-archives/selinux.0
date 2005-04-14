Subject: Re: dcache_lock deadlock due to auditing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Serge Hallyn <serue@us.ibm.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <1113413781.25428.31.camel@serge>
References: <1113413781.25428.31.camel@serge>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 10:30:17 -0400
Message-Id: <1113489017.373.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-13 at 12:36 -0500, Serge Hallyn wrote:
> a team running some tcp benchmarks on new hardware found a recursive
> spinlock(dcache_lock) deadlock.  It seems to always be caused by:
> 
>  A process is doing a d_alloc() which does a spin_lock(dcache_lock).
>  It is interrupted to receive a packet
>  selinux_sock_rcv_skb gets called
>  it calls avc_has_perm
>  this calls avc_audit
>  this calls audit_log_d_path
>  this calls d_path which does spin_lock(dcache_lock)
> 
> Deferring the actual audit work to the audit subsystem in a manner
> similar to what Stephen's recent audit_log_exit() patch did seems one
> possible way to solve this problem.  Another might be to determine our
> context before the audit_log_d_path( vma->vm_file->f_dentry ), and, if
> we can determine that we were called from interrupt, simply print out
> the f_dentry->d_name.name itself.

I think that in_softirq can have false positive, so I don't think we
want to try to test for it in avc_audit.  We could add a flag to the
avc_audit_data structure so that the caller of avc_has_perm* could
specify that avc_audit should not attempt to take the dcache lock, but
that seems ugly.

The cleanest solution in my mind is to remove all logging of pid, exe,
and comm from avc_audit as per my patch and handle that entirely in
audit_log_exit.  But that requires people to enable syscall auditing to
still get that information for avc denials, and will break compatibility
for seaudit, requiring it to be modified to acquire that information
from the subsequent syscall audit record.  One side benefit of this
solution is that it eliminates the confusion about bogus pid and exe
information on permission checks that are not performed in process
context like the socket receive checks and sigio delivery.

A less clean solution that preserves compatibility would be to still
include the pid=, exe=, and comm= information in avc_audit but only
include the last d_name component of the exe, as you suggest above.

One item to note is that the current avc_audit code includes support for
logging information about another task rather than current by having the
caller set the tsk field of the avc_audit_data structure prior to
calling avc_has_perm*.  That was originally included for replacing the
hardcoded capability checks by the OOM killer on possible target tasks
with calls to the LSM capable hook, but is not presently used as that
part of the LSM patch was never mainstreamed into 2.6.  I could also see
that potentially being useful for the task_kill hook, in order to get
information about the target task other than just its security context,
although in that case I would want information on both current and the
target task, which we presently don't allow for.

> Are there other solutions?
> 
> Currently the team is testing Stephen's patch (from march 31) to see
> whether it is sufficient.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
