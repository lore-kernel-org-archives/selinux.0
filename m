Message-ID: <54C1AB29.3050908@oracle.com>
Date: Fri, 23 Jan 2015 10:00:09 +0800
From: ethan zhao <ethan.zhao@oracle.com>
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] Selinux/hooks.c: Fix a NULL pointer dereference caused
 by semop()
References: <1421745518-18790-1-git-send-email-ethan.zhao@oracle.com>
 <54BE61F0.202@tycho.nsa.gov>
 <CABawtvPrhVWV3bC-=wygqfHJzctvrmd1WxDD1ciuLE7F7-_yaQ@mail.gmail.com>
 <54BF3971.2090003@colorfullife.com>
 <CABawtvO3PdKhmeH_H1v_tQxmgOBQrnLGNayTE1=EbcxJbtwAzQ@mail.gmail.com>
 <54C13E5B.3020208@colorfullife.com>
In-Reply-To: <54C13E5B.3020208@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Ethan Zhao <ethan.kernel@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Manfred,

On 2015/1/23 2:15, Manfred Spraul wrote:
> On 01/22/2015 03:44 AM, Ethan Zhao wrote:
>> On Wed, Jan 21, 2015 at 1:30 PM, Manfred Spraul
>> <manfred@colorfullife.com> wrote:
>>> On 01/21/2015 04:53 AM, Ethan Zhao wrote:
>>>> On Tue, Jan 20, 2015 at 10:10 PM, Stephen Smalley <sds@tycho.nsa.gov>
>>>> wrote:
>>>>> On 01/20/2015 04:18 AM, Ethan Zhao wrote:
>>>>>>        sys_semget()
>>>>>>        ->newary()
>>>>>>            ->security_sem_alloc()
>>>>>>              ->sem_alloc_security()
>>>>>>                    selinux_sem_alloc_security()
>>>>>>                    ->ipc_alloc_security() {
>>>>>>                      ->rc = avc_has_perm()
>>>>>>                                 if (rc) {
>>>>>>
>>>>>> ipc_free_security(&sma->sem_perm);
>>>>>>                                         return rc;
>>>>> We free the security structure here to avoid a memory leak on a
>>>>> failed/denied semaphore set creation.  In this situation, we 
>>>>> return an
>>>>> error to the caller (ultimately to newary), it does an
>>>>> ipc_rcu_putref(sma, ipc_rcu_free), and it returns an error to the
>>>>> caller.  Thus, it never calls ipc_addid() and the semaphore set is 
>>>>> not
>>>>> created.  So how then can you call semtimedop() on it?
>>>> Seems it wouldn't happen after commit
>>>> e8577d1f0329d4842e8302e289fb2c22156abef4 ?
>>> That was my first guess when I read the bug report - but it can't be 
>>> the
>>> fix, because security_sem_alloc() is before the ipc_addid(), with or 
>>> without
>>> the patch.
>>>
>>> thread A:
>>>              thread B:
>>>
>>> semtimedop()
>>> -> sem_obtain_object_check()
>>>              semctl(IPC_RMID)
>>>              -> freeary()
>>>              -> ipc_rcu_putref()
>>>              -> call_rcu()
>>> -> somehow a grace period
>>>              -> sem_rcu_free()
>>>              -> security_sem_free()
>>>
>>> Perhaps: modify ipc_free_security() to hexdump perm and a few more 
>>> bytes if
>>> the pointer is NULL?
>> I tried to ask for vmcore and do more analysis, basically, the race 
>> condition
>> still exists and open a hole to be DoS.
> Is the issue reproducable?
  It was hit on an user's VMware while running a process named "opcmon" 
maybe ported from HP_UX. I asked for the vmwcore, but not get it yet.

> If yes, can you try something like the attached patch?
  Yes, will.

  Thanks,
  Ethan
>
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -5129,6 +5129,8 @@ static int ipc_has_perm(struct kern_ipc_perm
>> *ipc_perms,
>>         u32 sid = current_sid();
>>
>>         isec = ipc_perms->security;
>> +     if (!isec)
>> +             return -EACCES;
>>
>>         ad.type = LSM_AUDIT_DATA_IPC;
>>         ad.u.ipc_id = ipc_perms->key;
> ipc_has_perm() runs without any spinlocks/semaphores, only 
> rcu_read_lock().
> Testing for ipc_perms->security!=NULL does solve the issue that 
> ipc_perm->key could be an access to kfree'd memory: Nothing prevents 
> that the kfree could happen just after the test.
>
> I.e.: The patch can't be the right solution.
>
> -- 
>     Manfred
