Message-ID: <54B522A7.2080109@tycho.nsa.gov>
Date: Tue, 13 Jan 2015 08:50:31 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Brooks <john.brooks@jolla.com>
Subject: Re: [PATCH 3/3] Tweak avtab hash table parameters for better
 performance
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-4-git-send-email-john.brooks@jolla.com>
 <54B408A9.4020702@tycho.nsa.gov>
 <A906E10A-6726-4208-993B-4D6AB21B202E@jolla.com>
In-Reply-To: <A906E10A-6726-4208-993B-4D6AB21B202E@jolla.com>
Content-Type: text/plain; charset=windows-1252
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/12/2015 08:25 PM, John Brooks wrote:
> On Jan 12, 2015, at 10:47 AM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>>
>> On 01/07/2015 05:03 PM, John Brooks wrote:
>>> @@ -341,8 +341,6 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)
>>> work  = work >> 1;
>>> shift++;
>>> }
>>> -if (shift > 2)
>>> -shift = shift - 2;
>>> nslot = 1 << shift;
>>> if (nslot > MAX_AVTAB_SIZE)
>>> nslot = MAX_AVTAB_SIZE;
>>>
>>
>> tweakavtab.txt:rules:  101401 entries and 68460/131072 buckets used,
>> longest chain length 7
>>
>> Seems like we're wasting a large number of buckets in that scenario.
> 
> Good catch. It looks like this is caused by the segment I highlighted
> above, removing the shift adjustment.
> 
> changed-nslot.txt:rules:  100967 entries and 68321/131072 buckets used,
> longest chain length 8
> original-nslot.txt:rules:  100967 entries and 31017/32768 buckets used,
> longest chain length 13
> 
> So, one bucket is allocated per 2-4 elements. The change I actually
> wanted to make is to the definition of MAX_AVTAB_SIZE: it should be 2x
> MAX_AVTAB_HASH_BUCKETS to allow allocating a hash with maximum buckets,
> and that nslot bounding should use MAX_AVTAB_HASH_BUCKETS.
> 
>>
>> Also, in the corresponding kernel code (security/selinux/ss/avtab.[hc]),
>> we've actually shrunk the hash bits from 13 to 11,
> 
> Interesting. I wonder what the kernel hash eval looks like - it might
> benefit from a better hash function as well.

Permission checks in the kernel are usually handled by the AVC (access
vector cache), so the looking it up in the avtab is the slow path already.

> 
>>
>> I've also considered reworking the libsepol check_assertions() code to
>> not expand the avtab in order to provide better traceback to the
>> original source allow rule that violated the neverallow.  This would
>> require more work by check_assertion_helper to check each attribute
>> associated with the source and target, just as with
>> context_struct_compute_av.
> 
> Yeah; I expect there is a lot of room for algorithmic improvement here.
> I wish I had time to understand and fix it. We could probably get this
> running on the order of seconds instead of minutes, and using _much_
> less memory.
> 
> Even after these patches, expand_module spends 60% in avtab_search_node
> (and 13% malloc_consolidate, the rest is trivial). Next step would be to
> reduce the number of elements or lookups.
> 
> One interesting note: this fully expanded table is built twice under
> expand_module, for hierarchy_check_constraints and check_assertions. We
> could cut runtime almost in half by reusing the table.

Yes, they were originally written to permit running them independently,
so certainly when they are both run, we could avoid that duplication.
