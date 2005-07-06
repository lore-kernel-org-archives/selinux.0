Subject: RE: [RFC]Kernel Built-in IDS extension (UPDATED)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: horietk@nttdata.co.jp
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6ACF5196CB5AA4FB50C32559083A36901633F40@MAILSV12.msg.nttdata.co.jp>
References: 
	 <E6ACF5196CB5AA4FB50C32559083A36901633F40@MAILSV12.msg.nttdata.co.jp>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 09:15:45 -0400
Message-Id: <1120655745.18855.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-07-06 at 13:49 +0900, horietk@nttdata.co.jp wrote:
> Policy reload operation has to be avoided during 
> 'sel_set_bools_by_trap()'. So the semaphore 'sel_sem' (in 
> sel_write_load() @ security/selinux/selinuxfs.c) is used, which is 
> needed to block that operation.
> 'sel_sem_trap' is a flag for specifying whether the semaphor can be 
> achieved or not.

That flag doesn't help you.  Think about it:
a) process P1 writes to /selinux/booleans/x, takes the semaphore, but
has not yet set the flag.  process P2 triggers a trap, so
sel_set_booles_by_trap is called.  The flag is not yet set, so it
attempts to take the semaphore, and blocks.
b) process P1 writes to /selinux/booleans/x, takes the semaphore, sets
the flag, performs the operation, clears the flag, but has not yet
released the semaphore.  process P2 triggers a trap, and
sel_set_booles_by_trap tries to take the semaphore and blocks.
c) process P1 writes to /selinux/booleans/x, takes the semaphore, and
sets the flag.  process P2 triggers a trap, sel_set_booles_by_trap sees
that the flag is set, and doesn't try taking the semaphore, incorrectly
assuming that it is held by the same thread.  This avoids the deadlock,
but means that you have two processes accessing the pending value array
simultaneously.
d) process P1 triggers a trap, sel_set_booles_by_trap takes the
semaphore. process P2 triggers a trap, sel_set_booles_by_trap takes the
semaphore and blocks.

The flag is useless.  If you just wanted a non-blocking form of down,
you would use down_trylock.  But that just avoids the blocking; you
still have to figure out what to do if the semaphore is already held,
and proceeding to modify the pending value array in that case is not
safe, as noted in (c) above.

> When boolean values are changed, temporary private array will be 
> overwritten by bool_pending_values array. So it should be directly 
> changed.

Yes, if you are performing both userspace modification of the booleans
(e.g. via setsebool) and kernel-implemented traps, then you have this
problem.  If you re-implement in auditd, then you can synchronize such
changes in userspace.

> > - I don't understand the handling of the trap caches.  You 
> > pre-allocate
> > them during policydb_read, but defer filling them until compute_av?
> > Why?  Better to fill them once during policydb_read than to do it on
> > each compute_av call.  Also not sure what you are doing there with the
> > cond avtab - why are you modifying the main avtab?
> 
> Suppose this kind of trap.
> 
> bool flag false;
> trap user_t adjtime_t:file read:allow_execmem,;
> if(flag) {
>     trap user_t adjtime_t:file read:allow_execstack,;
> }
> 
> When above 'flag' is true, both allow_execmem and allow_execstack have 
> to be registered. If-section is determined within compute_av(), so, it 
> should be defered to handle with conditional trap.

The enabling/disabling of cond avtab entries occurs when booleans are
set via evaluate_cond_node, so it shouldn't have to be deferred to each
compute_av.

In any event, I'd suggest that you not even try to support conditional
traps presently; it is definitely complicating your code.

> When 'trap' detection caused boolean update, avc_ss_reset() clears AVC. 
> Accordingly, there is no AVC node to be updated.

Ok, but in that case, the call is harmless.  Not much point in
optimizing for the permissive case.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
