MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: RE: [RFC]Kernel Built-in IDS extension (UPDATED)
Date: Wed, 6 Jul 2005 13:49:24 +0900
Message-ID: <E6ACF5196CB5AA4FB50C32559083A36901633F40@MAILSV12.msg.nttdata.co.jp>
From: <horietk@nttdata.co.jp>
To: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for comments.

> -----Original Message-----
> 
> - As before, I'm not convinced that you can't achieve the 
> same effect by
> extending auditd, using auditallow rules to generate notifications of
> events of interest to it, and letting it (or a helper it runs)
> manipulate booleans based on some other config.

Of-course, I know both merits and demerits of this implementation.
I'm interested in auditd based implementation too.

> - As before, you cannot safely call a blocking operation (like down)
> from any code that is called from avc_has_perm*, because it 
> is called at
> times during interrupt and at times while kernel locks are held, so it
> is not safe to sleep.  The sel_sem_trap workaround doesn't solve the
> basic problem.  You need to stop using the 
> bool_pending_values array and
> just use your own temporary private array there.

Policy reload operation has to be avoided during 
'sel_set_bools_by_trap()'. So the semaphore 'sel_sem' (in 
sel_write_load() @ security/selinux/selinuxfs.c) is used, which is 
needed to block that operation.
'sel_sem_trap' is a flag for specifying whether the semaphor can be 
achieved or not.
When boolean values are changed, temporary private array will be 
overwritten by bool_pending_values array. So it should be directly 
changed.

> - I don't understand the handling of the trap caches.  You 
> pre-allocate
> them during policydb_read, but defer filling them until compute_av?
> Why?  Better to fill them once during policydb_read than to do it on
> each compute_av call.  Also not sure what you are doing there with the
> cond avtab - why are you modifying the main avtab?

Suppose this kind of trap.

bool flag false;
trap user_t adjtime_t:file read:allow_execmem,;
if(flag) {
    trap user_t adjtime_t:file read:allow_execstack,;
}

When above 'flag' is true, both allow_execmem and allow_execstack have 
to be registered. If-section is determined within compute_av(), so, it 
should be defered to handle with conditional trap.

> - Why don't you call avc_update_node() in permissive mode if 
> a trap was
> detected?

When 'trap' detection caused boolean update, avc_ss_reset() clears AVC. 
Accordingly, there is no AVC node to be updated.

Regards,

-----
NTT DATA CORPORATION
Open Source Software Development Center
Takashi Horie
E-Mail: horie-t@users.sourceforge.net
E-Mail: horietk@nttdata.co.jp
https://sourceforge.net/projects/lk-ids

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
