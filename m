MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: RE: [RFC]Kernel Built-in IDS extension
Date: Tue, 21 Jun 2005 19:24:19 +0900
Message-ID: <E6ACF5196CB5AA4FB50C32559083A36901633F0F@MAILSV12.msg.nttdata.co.jp>
From: <horietk@nttdata.co.jp>
To: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks a lot.
I appreciate helpful comments, especially, about in-depth AVC 
implementations.

> -----Original Message-----
> 
> Did you consider a userspace implementation, e.g. extend 
> auditd to match
> against avc messages it receives from the kernel (likely using a
> libsepol function to perform the matching), and then having auditd
> adjust boolean settings in response to particular avc messages?

Certainly, I agree that the logging daemon based implementation is much 
simpler than kernel based one. But I think syslogd may not be reliable 
enough for this kind of purpose, i.e. printk() loses some of messages 
under very high load. So this is one of benefits which kernel based 
implementation gives.

> Also, it appears that your trap syntax only allows you to enable
> booleans upon events, whereas I could envision one wanting to disable
> booleans as well.  Otherwise, people have to contort their boolean
> definitions to correspond with this limitation.

I should have considered impacts on boolean definition. TRAP notation, 
as well as data structure, will be modified in next release, such like 
this,
example) 
   trap <subject> <object>:<class> <permissions> <bools_operations> ;

> A few quick comments based on a cursory read of the kernel patch:
> 
> - A transient memory failure could cause the trap information to be
> dropped from an AVC node in avc_node_populate(), with not even a log
> message warning about it - thus you could fail to properly trap an
> access under memory pressure.  In contrast, allocation failure for the
> node itself by avc_insert() does no harm - the existing
> avc_has_perm_noaudit() code just falls back to using the 
> temporary entry
> on the stack that was filled by security_compute_av() to finish the
> checking.

Current implementation resulted from booleans management data structure 
used by trap. It may be changed in next release and also some codes will 
be added to handle memory allocation failures properly.

> - avc_has_perm() cannot invoke any potentially blocking (sleeping)
> operations, because it can be called from irq or while locks 
> are held by
> the kernel.  Hence, your code (e.g. sel_set_booles_by_trap) likewise
> cannot invoke any potentially blocking operations, like down.  Of
> course, taking that particular semaphore and using the shared
> bool_pending_values is suspect anyway, and you already have a 
> kludge to
> avoid double locking in the load_policy case (and the setbool 
> case would
> also be a problem for you).  Why not just create and use your own
> temporary value array so that you don't have any locking issue there?

I checked out the issue you pointed out. load_policy problem seems 
resolved by changing blocking operation.

> - avc_detect_perm_noaudit() calls security_compute_av() and 
> avc_insert()
> after updating the booleans.  The boolean update will have flushed the
> cache entirely (which is necessary, as the booleans may have affected
> multiple entries), so you might as well just wait and let the cache
> re-fill in the usual manner upon subsequent permission 
> checks.  It also
> doesn't make sense for it to change avd because it is only used by
> avc_audit(), which has already been called, and you don't 
> want to adjust
> that result for the new booleans (because avc_has_perm made its
> decisions based on the old boolean settings).

I misread kernel codes related to avd handling. Of-course, it's 
unnecessary operation. Thanks for pointing out!

> Note that self:process execmem makes a good candidate for a trap, as
> that reflects an attempt to make anonymous memory executable, e.g. an
> attempt to make the stack executable.

I agree that execmem is more robust/generic target to detect suspicious 
operations. It's more difficult to choose appropriate access context to 
trap than configuring policy.


Currently, I have a plan for integrating IDS functionality with MLS 
instead of boolean. This implementation will make trap description more 
flexible and stateful. The following usage is intended.

example) Progressive access policy
By means of detecting symbolic access context which indicates transition 
to the next processing phase, the privileges of running daemon can be 
changed according to its progress. 

It provides similar functionality to domain trasition. But no execve() 
is needed. I think it's more secure way because the daemon's privileges 
can be configured such that the process is only allowed the privileges 
which are needed exactly at that point.

How about this plan?

Regards,

-----
NTT DATA CORPORATION
Open Source Software Development Center
Takashi Horie
E-Mail: horie-t@users.sourceforge.net
E-Mail: horietk@nttdata.co.jp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
