Message-ID: <46A57282.1090902@manicmethod.com>
Date: Mon, 23 Jul 2007 23:31:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Yuichi Nakamura <ynakam@hitachisoft.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] customizable AVTAB_HASH_BITS for embedded devices
References: <20070723124502.17C7.YNAKAM@hitachisoft.jp> <1185220711.4177.30.camel@moss-spartans.epoch.ncsc.mil> <46A56CBB.6020805@ak.jp.nec.com>
In-Reply-To: <46A56CBB.6020805@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> Stephen Smalley wrote:
>   
>> On Mon, 2007-07-23 at 16:03 +0900, Yuichi Nakamura wrote:
>>     
>>> Hi.
>>>
>>> I am working to reduce memory usage of SELinux for embedded devices.
>>> I would like to propose very small patch at first.
>>> Thanks for advice > KaiGai-san .
>>>
>>> 1. Background 
>>> * In avtab_init:
>>>  h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
>>> Number of hash table size is AVTAB_SIZE.
>>>
>>> * In avtab.h
>>> #define AVTAB_HASH_BITS 15
>>> #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
>>> #define AVTAB_SIZE AVTAB_HASH_BUCKETS
>>>
>>> AVTAB_SIZE is 2^15 = 32768
>>>
>>> So 32768 entries are allocated for avtab, 
>>> and 2 avtabs are used in policydb:
>>> struct avtab te_avtab;
>>> struct avtab te_cond_avtab;
>>>
>>> If te rules are fewer than 32768,
>>> unused entries are using memory.
>>>
>>> In embedded devices, the rules tend to be fewer.
>>> In my test system(SH architecture board), it is less than 10000 rules.
>>>
>>> 2. Patch
>>> I made AVTAB_HASH_BITS customizable by Kconfig.
>>> Allocated hash slots for avtab can be reduced by reducing AVTAB_HASH_BITS.
>>>
>>> Attached  patch is for 2.6.22.
>>> Then, I measured memory usage by /proc/memstat before/after tuning
>>>
>>> * Memory usage: SELinux before loading policy.
>>> 2720k is used.
>>>
>>> * Memory usage: SELinux after loading policy(about 8000 rules) before patch
>>> +1068k increase
>>>
>>> * Memory usage: SELinux after loading poilcy(about 8000 rules) after patch.
>>>   configured AVTAB_HASH_BITS as "13" 
>>> +876k increase
>>> -> improved 192k
>>>
>>> * Theoretical value:
>>> - Before tuning: 
>>>   Number of hashslot 2^15 * 2 
>>>   Size of hash slot: 4 (sizeof(*(h->htable)))
>>>   Memory usage = 2^15*2*4 = 262k
>>>
>>> - After tuning: 
>>>   Number of hash slot is 2^13 * 2, 
>>>   and size of hash slot is 4 (sizeof(*(h->htable)))
>>>   Memory usage = 2^13*2*4 = 65k 
>>>   -> 197k should improve, this value is almost the same as measured value.
>>>
>>> Following is a patch:
>>>
>>> diff -ur security/selinux.orig/Kconfig security/selinux/Kconfig
>>> --- security/selinux.orig/Kconfig	2007-07-20 17:29:30.000000000 +0900
>>> +++ security/selinux/Kconfig	2007-07-20 17:45:40.000000000 +0900
>>> @@ -11,6 +11,17 @@
>>>  	  from <http://www.nsa.gov/selinux/>.
>>>  	  If you are unsure how to answer this question, answer N.
>>>  
>>> +config SECURITY_SELINUX_AVTAB_HASH_BITS
>>> +	int "NSA SELinux default AVTAB_HASH_BITS value"
>>> +	depends on SECURITY_SELINUX && EMBEDDED
>>> +	range 1 15
>>> +	default 15
>>> +	help
>>> +	  This configures AVTAB_HASH_BITS in avtab.h. The size of avtab hashtable 
>>> +	  is 2^AVTAB_HASH_BITS. You can improve memory footprint of SELinux by 
>>> +	  configuring this value appropriately.
>>> +	  If you are unsure how to answer this question, answer 15.
>>> +
>>>  config SECURITY_SELINUX_BOOTPARAM
>>>  	bool "NSA SELinux boot parameter"
>>>  	depends on SECURITY_SELINUX
>>> diff -ur security/selinux.orig/ss/avtab.h security/selinux/ss/avtab.h
>>> --- security/selinux.orig/ss/avtab.h	2007-07-20 17:29:30.000000000 +0900
>>> +++ security/selinux/ss/avtab.h	2007-07-20 18:18:56.000000000 +0900
>>> @@ -74,7 +74,7 @@
>>>  void avtab_cache_init(void);
>>>  void avtab_cache_destroy(void);
>>>  
>>> -#define AVTAB_HASH_BITS 15
>>> +#define AVTAB_HASH_BITS CONFIG_SECURITY_SELINUX_AVTAB_HASH_BITS
>>>  #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
>>>  #define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
>>>       
>> I'm open to making this configurable, although I'm not sure whether it
>> should be a Kconfig setting or selinuxfs (or sysctl) setting.  Ideally,
>> of course, it would be runtime computed based on the actual policy size.
>> Rewriting the avtab and other security server data structures to more
>> kernel native would be fine with me too - they don't need to match the
>> userland ones.
>>
>> (please cc James, Eric, and me on selinux kernel patches)
>>     
>
> How do you think an idea that the values of AVTAB_HASH_BITS depends
> on CONFIG_EMBEDDED, more than adding a new Kconfig entry?
> I think SECURITY_SELINUX_AVTAB_HASH_BITS in Kconfig is too detailed.
>
> For example,
>
> #ifdef CONFIG_EMBEDDED
> /* to reduce memory footpoint in embedded devices */
> #define AVTAB_HASH_BITS (PAGE_SHIFT - 2)
> #else
> #define AVTAB_HASH_BITS 15
> #endif
>
> PAGE_SIZE is the minimum unit for vmalloc(), so it is nonsense
> to require a region less than 2^(PAGE_SHIFT - 2).
> In addition, CONFIG_EMBEDDED is already set 'y' in defconfig of
> some of SH, MIPS, ARM and so on. It will fit to your target.
>
>   
I think he was suggesting making it runtime configurable (or even
automatic based on the size of the loaded policy)

One should be able to dynamically choose the number of hash buckets
based off of how many rules are in the policy being loaded, keeping the
buckets balanced though could be a harder problem to solve.

> There is another background, although Nakamura-san didn't mentioned.
> The AVC hit rate is extremely high, so getting longer the chain of
> avtab hash list does not have maeningful difference in performance.
>   
We've had some issues lately with the speed of the avtab, specifically
around finding reachable user domains. They've been addressed for now
(my offloading some work to userspace) but there may be others lurking,
people are finally starting to profile some of this code though.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
