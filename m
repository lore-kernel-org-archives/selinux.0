Message-ID: <54B42988.3030705@tycho.nsa.gov>
Date: Mon, 12 Jan 2015 15:07:36 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Brooks <john.brooks@jolla.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Tweak avtab hash table parameters for better
 performance
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-4-git-send-email-john.brooks@jolla.com>
 <54B408A9.4020702@tycho.nsa.gov>
In-Reply-To: <54B408A9.4020702@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/12/2015 12:47 PM, Stephen Smalley wrote:
> On 01/07/2015 05:03 PM, John Brooks wrote:
>> Using the Fedora 20 targeted policy, running check_assertions requires
>> an avtab with around 22 million elements. With the default limit of 4096
>> buckets, performance is abysmal: it takes more than an hour to populate
>> the hash. Profiling shows most of that time under avtab_search_node.
>>
>> This patch increases the hash from 13 to 20 bits and to a maximum of
>> 1048576 buckets. The time for check_assertions on that policy is reduced
>> to about 3 minutes, which is enough to re-enable those checks as part of
>> the build process.
>>
>> A full size table will allocate 4-8 MB of memory, up from 16-32 KB. In a
>> cursory review, these tables are usually short-lived and only 1-3 are
>> allocated together. Compared to the cost of entries in this table (up to
>> 1 GB using the same policy), this isn't a significant increase.
>> ---
>>  libsepol/include/sepol/policydb/avtab.h | 4 ++--
>>  libsepol/src/avtab.c                    | 4 +---
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
>> index 6955ecf..158112f 100644
>> --- a/libsepol/include/sepol/policydb/avtab.h
>> +++ b/libsepol/include/sepol/policydb/avtab.h
>> @@ -81,7 +81,7 @@ typedef struct avtab {
>>  	avtab_ptr_t *htable;
>>  	uint32_t nel;		/* number of elements */
>>  	uint32_t nslot;         /* number of hash slots */
>> -	uint16_t mask;          /* mask to compute hash func */
>> +	uint32_t mask;          /* mask to compute hash func */
>>  } avtab_t;
>>  
>>  extern int avtab_init(avtab_t *);
>> @@ -117,7 +117,7 @@ extern avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key);
>>  
>>  extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
>>  
>> -#define MAX_AVTAB_HASH_BITS 13
>> +#define MAX_AVTAB_HASH_BITS 20
>>  #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
>>  #define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
>>  #define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
>> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
>> index 9c01a8d..65b3c48 100644
>> --- a/libsepol/src/avtab.c
>> +++ b/libsepol/src/avtab.c
>> @@ -329,7 +329,7 @@ int avtab_init(avtab_t * h)
>>  
>>  int avtab_alloc(avtab_t *h, uint32_t nrules)
>>  {
>> -	uint16_t mask = 0;
>> +	uint32_t mask = 0;
>>  	uint32_t shift = 0;
>>  	uint32_t work = nrules;
>>  	uint32_t nslot = 0;
>> @@ -341,8 +341,6 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)
>>  		work  = work >> 1;
>>  		shift++;
>>  	}
>> -	if (shift > 2)
>> -		shift = shift - 2;
>>  	nslot = 1 << shift;
>>  	if (nslot > MAX_AVTAB_SIZE)
>>  		nslot = MAX_AVTAB_SIZE;
>>
> 
> Here again, looking at impact on regular usage of the avtab (without
> full expansion of all attributes), running checkpolicy -Mb
> /etc/selinux/targeted/policy/policy.29 on Fedora 20 before and after
> this patch, I see:
> 
> before.txt:rules:  101401 entries and 8169/8192 buckets used, longest
> chain length 84
> 
> betterhash.txt:rules:  101401 entries and 8192/8192 buckets used,
> longest chain length 27
> 
> tweakavtab.txt:rules:  101401 entries and 68460/131072 buckets used,
> longest chain length 7

Trying this on the Android policy, I get:
before.txt:rules:  6033 entries and 1811/2048 buckets used, longest
chain length 25

betterhash.txt:rules:  6033 entries and 1923/2048 buckets used, longest
chain length 11

tweakavtab.txt:rules:  6033 entries and 4232/8192 buckets used, longest
chain length 6

Also makes sepolicy-analyze neverallow feasible on Fedora policy;
previously I could only run it on Android policy and expect it to
complete in a sane amount of time.
