Message-ID: <499516FB.7090805@ak.jp.nec.com>
Date: Fri, 13 Feb 2009 15:45:15 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@namei.org
Subject: Re: [PATCH 1/5] SELinux: remove the unused ae.used
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com>	 <200902121515.32476.paul.moore@hp.com> <1234470416.24008.3.camel@localhost.localdomain>
In-Reply-To: <1234470416.24008.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Thu, 2009-02-12 at 15:15 -0500, Paul Moore wrote:
>> On Thursday 12 February 2009 02:50:43 pm Eric Paris wrote:
>>> Currently SELinux code has an atomic which was intended to track how many
>>> times an avc entry was used and to evict entries when they haven't been
>>> used recently.  Instead we never let this atomic get above 1 and evict when
>>> it is first checked for eviction since it hits zero.  This is a total waste
>>> of time so I'm completely dropping ae.used.
>>>
>>> This change resulted in about a 3% faster avc_has_perm_noaudit when running
>>> oprofile against a tbench benchmark.
>>>
>>> Signed-off-by: Eric Paris <eparis@redhat.com>
>> Looks okay to me, I did notice another optimization (see below) that might be 
>> worth including if you respin the patch.
>>
>> Reviewed by: Paul Moore <paul.moore@hp.com>
>>
>>>  struct avc_node {
>>> @@ -321,16 +320,13 @@ static inline int avc_reclaim_node(void)
>>>
>>>  		rcu_read_lock();
>>>  		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
>>> -			if (atomic_dec_and_test(&node->ae.used)) {
>>> -				/* Recently Unused */
>>> -				avc_node_delete(node);
>>> -				avc_cache_stats_incr(reclaims);
>>> -				ecx++;
>>> -				if (ecx >= AVC_CACHE_RECLAIM) {
>>> -					rcu_read_unlock();
>>> -					spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
>>> -					goto out;
>>> -				}
>>> +			avc_node_delete(node);
>>> +			avc_cache_stats_incr(reclaims);
>>> +			ecx++;
>>> +			if (ecx >= AVC_CACHE_RECLAIM) {
>>> +				rcu_read_unlock();
>>> +				spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
>>> +				goto out;
>>>  			}
>>>  		}
>>>  		rcu_read_unlock();
>> Not your fault, but in reviewing this code I realized we aren't really using 
>> the avc_cache.lru_hint atomic either; it looks like it is initialized to zero 
>> and never changes.  With that in mind we could remove the lru_hint field from 
>> the avc_cache and simplify the above function a tiny bit (no need for hvalue, 
>> just use zero).
> 
> My look says the the hvalue there is computed as:
> 
> hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
> 
> Which means it is changed....

This is an aside:

The purpose of avc_cache.lru_hint and AVC_CACHE_SLOTS (512) of spinlocks is
to reduce lock contention during avc_reclaim_node() and avc_insert().

In the reader side (more than 99.99%), we can refer avc_node without locks.
However, RCU requires to acquire locks when we modify linked objects, so
it is necessary to consider the possibility of scalability issue by lock
contention on writer side.
In this case, the purpose of avc_reclaim_node() is to reduce the number
of active avc_node, not to drop a specific one, so it is not necessary
to serialize all the threads which invokes avc_reclaim_node().

Any avc_cache.slots[] has its own spinlock. This design enables to insert
or reclaim independent avc_node in parallel as far as possible. For example,
CPU-1 can insert a new avc_node into the slot[5], even if CPU-2 holds a lock
on the slot[7] in same time.

The selinux/avc.c was rewritten at the kernel-2.6.11 using RCU, because
there was a scalability issue which protects all the reader/writer by a
single spinlock at that time, so we revised this code so carefully on
the viewpoint of scalability.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
