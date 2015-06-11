Message-ID: <5579FAE0.9040201@hp.com>
Date: Thu, 11 Jun 2015 17:17:20 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: reduce locking overhead in inode_free_security()
References: <1433967446-44555-1-git-send-email-Waiman.Long@hp.com>
 <55798149.5070404@tycho.nsa.gov>
In-Reply-To: <55798149.5070404@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: James Morris <james.l.morris@oracle.com>,
 Scott J Norton <scott.norton@hp.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Douglas Hatch <doug.hatch@hp.com>,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/11/2015 08:38 AM, Stephen Smalley wrote:
> On 06/10/2015 04:17 PM, Waiman Long wrote:
>> The inode_free_security() function just took the superblock's isec_lock
>> before checking and trying to remove the inode security struct from the
>> linked list. In many cases, the list was empty and so the lock taking
>> is wasteful as no useful work is done. On multi-socket systems with
>> a large number of CPUs, there can also be a fair amount of spinlock
>> contention on the isec_lock if many tasks are exiting at the same time.
>>
>> This patch changes the code to check the state of the list first
>> before taking the lock and attempting to dequeue it. We still need
>> to do the empty list test inside the lock for safety reason, but it
>> minimizes the chance of unnecessary spinlock contention.
>>
>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
>> ---
>>   security/selinux/hooks.c |   17 +++++++++++++----
>>   1 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 7dade28..cd736c3 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -254,10 +254,19 @@ static void inode_free_security(struct inode *inode)
>>   	struct inode_security_struct *isec = inode->i_security;
>>   	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
>>
>> -	spin_lock(&sbsec->isec_lock);
>> -	if (!list_empty(&isec->list))
>> -		list_del_init(&isec->list);
>> -	spin_unlock(&sbsec->isec_lock);
>> +	/*
>> +	 * As not all inode security structures are in a list, we check for
>> +	 * empty list outside of the lock to make sure that we won't waste
>> +	 * time taking a lock doing nothing. Lock taking can be slow
>> +	 * especially if the lock is being contended. We do, however, need
>> +	 * to recheck the list again before deleting it for safety.
>> +	 */
>> +	if (!list_empty(&isec->list)) {
>> +		spin_lock(&sbsec->isec_lock);
>> +		if (!list_empty(&isec->list))
>> +			list_del_init(&isec->list);
>> +		spin_unlock(&sbsec->isec_lock);
>> +	}
>>
>>   	/*
>>   	 * The inode may still be referenced in a path walk and
>>
> Do we really need the second list_empty() test at all?
> Once removed, inode security structures are never re-added to the list.
> For comparison, inode_sb_list_del() only tests list_empty() outside the
> lock.
>

Yes, I think we can remove the second list_empty() test. I will update 
the patch to do that.

Cheers,
Longman
