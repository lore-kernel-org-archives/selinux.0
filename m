Subject: Re: [RFC]Kernel Built-in IDS extension (UPDATED)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: horietk@nttdata.co.jp
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6ACF5196CB5AA4FB50C32559083A36901633F37@MAILSV12.msg.nttdata.co.jp>
References: 
	 <E6ACF5196CB5AA4FB50C32559083A36901633F37@MAILSV12.msg.nttdata.co.jp>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 14:14:12 -0400
Message-Id: <1120587252.2644.192.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-07-04 at 19:14 +0900, horietk@nttdata.co.jp wrote:
> The attached patches are updated edition.
> They are applicable to kernel 2.6.13-git5, libsepol-1.6 and 
> checkpolicy-1.25.1
> 
> <<Changes>>
> - Some bug fixes.
> - Modification on 'trap' notation. 
> 
>    trap <subject> <object>:<class> 
>          <perms>:<bools_to_enable>,<bools_to_disable> ;
> 
>    "<bools_to_disable>" is added.
> 
> I hope I could have comments, suggestions and feedbacks.

- As before, I'm not convinced that you can't achieve the same effect by
extending auditd, using auditallow rules to generate notifications of
events of interest to it, and letting it (or a helper it runs)
manipulate booleans based on some other config.

- As before, you cannot safely call a blocking operation (like down)
from any code that is called from avc_has_perm*, because it is called at
times during interrupt and at times while kernel locks are held, so it
is not safe to sleep.  The sel_sem_trap workaround doesn't solve the
basic problem.  You need to stop using the bool_pending_values array and
just use your own temporary private array there.

- I don't understand the handling of the trap caches.  You pre-allocate
them during policydb_read, but defer filling them until compute_av?
Why?  Better to fill them once during policydb_read than to do it on
each compute_av call.  Also not sure what you are doing there with the
cond avtab - why are you modifying the main avtab?

- Why don't you call avc_update_node() in permissive mode if a trap was
detected?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
