Subject: Re: [RFC]Kernel Built-in IDS extension
From: Stephen Smalley <sds@tycho.nsa.gov>
To: horietk@nttdata.co.jp
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
References: 
	 <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 09:02:31 -0400
Message-Id: <1119013351.12524.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-17 at 18:16 +0900, horietk@nttdata.co.jp wrote:
> I'm glad to announce the release of experimental kernel extensions to 
> SELinux access control, which enables intrusion detection and system 
> protection functionalities.

Thanks for making this available.

> The extensions have following features.
> 1. Detecting the access violation and can log that trial.
> 2. Operating booleans of 'Conditional Policy' when the access violation 
> is detected.
> 3. Kernel built-in implementation. All the detections and the operations 
> are performed within kernel.
> 4. To specify access contexts to be detected and boolean variables to be 
> turned on, extended policy notation was introduced, which resembles the 
> 'allow' statement.
> 
>    trap <subject> <object>:<class> <permissions> <booleans> ;

Did you consider a userspace implementation, e.g. extend auditd to match
against avc messages it receives from the kernel (likely using a
libsepol function to perform the matching), and then having auditd
adjust boolean settings in response to particular avc messages?
Naturally, that would yield a slower response time to events, and you
would have to ensure that avc messages were generated for all events of
interest (e.g. using appropriate auditallow rules if you wanted to trap
on an allowed permission, and being careful not to dontaudit a denied
permission if you wanted to trap it), but would avoid having to further
complicate the kernel code.  There has been quite a bit of work recently
on the kernel's audit framework and the userspace auditd, and a fair
amount of those enhancements are included in FC4.

Also, it appears that your trap syntax only allows you to enable
booleans upon events, whereas I could envision one wanting to disable
booleans as well.  Otherwise, people have to contort their boolean
definitions to correspond with this limitation.

> The patches and the documents are available at SourceForge site.
>   http://sourceforge.net/projects/lk-ids

Posting patches to the list is preferred for review and feedback.
Requiring people to separately download a tarball reduces the set of
people who are likely to bother commenting.

> There are three patches.
> [1] kernel patch (to version 2.6.11)
>  - Member correspoding to 'trap' vector is added to avtab and policydb 
> structures. (Mainly avc.h and avtab.h modifications)
>  - Requested permission is compared with 'trap' vector, separate from 
> SELinux's permission check. (Mainly avc.c modifications)
>  - Internal boolean operation by kernel itself. (Mainly conditional.c 
> and selinuxfs.c)
> [2] checkpolicy patch (to version 1.22)
> [3] libsetools patch (to version 1.4)
>  - Policy parser, compiler and related library are extended to meet 
> 'trap' notation.

When developing new SELinux functionality, it is preferable to work
against:
1) the latest upstream kernel for kernel code (presently 2.6.12-rc6 or
the latest git snapshot or the latest -mm patchset),
2) the selinux sourceforge CVS tree for checkpolicy, libsepol or other
userland components (presently up to 1.23.4 and 1.5.10 respectively).
Fedora Core CVS tree also tends to track this closely.

Otherwise, your patches may not apply very well.

> I hope I could have a lot of comments, suggestions and feedbacks.

A few quick comments based on a cursory read of the kernel patch:

- A transient memory failure could cause the trap information to be
dropped from an AVC node in avc_node_populate(), with not even a log
message warning about it - thus you could fail to properly trap an
access under memory pressure.  In contrast, allocation failure for the
node itself by avc_insert() does no harm - the existing
avc_has_perm_noaudit() code just falls back to using the temporary entry
on the stack that was filled by security_compute_av() to finish the
checking.

- Possibly should be storing your boolean value array as a pair of
bitmaps instead (one bitmap to indicate which booleans to enable, one
bitmap to indicate which booleans to disable) to reduce the need to
allocate and copy around potentially large integer arrays.

- avc_has_perm() cannot invoke any potentially blocking (sleeping)
operations, because it can be called from irq or while locks are held by
the kernel.  Hence, your code (e.g. sel_set_booles_by_trap) likewise
cannot invoke any potentially blocking operations, like down.  Of
course, taking that particular semaphore and using the shared
bool_pending_values is suspect anyway, and you already have a kludge to
avoid double locking in the load_policy case (and the setbool case would
also be a problem for you).  Why not just create and use your own
temporary value array so that you don't have any locking issue there?

- avc_detect_perm_noaudit() calls security_compute_av() and avc_insert()
after updating the booleans.  The boolean update will have flushed the
cache entirely (which is necessary, as the booleans may have affected
multiple entries), so you might as well just wait and let the cache
re-fill in the usual manner upon subsequent permission checks.  It also
doesn't make sense for it to change avd because it is only used by
avc_audit(), which has already been called, and you don't want to adjust
that result for the new booleans (because avc_has_perm made its
decisions based on the old boolean settings).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
