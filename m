Message-ID: <460A60D1.5030502@manicmethod.com>
Date: Wed, 28 Mar 2007 08:34:25 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, ynakam@hitachisoft.jp,
        busybox@kaigai.gr.jp, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: [busybox:00575] Re: Separating libselinux/libsepol (Was:  Re:
 BusyBox: load_policy applet)
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>	 <1174925566.28830.61.camel@sgc>	 <1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>	 <20070327095945.1c4245ec.ynakam@hitachisoft.jp>	 <1174997707.3864.261.camel@moss-spartans.epoch.ncsc.mil>	 <4609CB85.1060401@ak.jp.nec.com>	 <20070328174046.bb463392.ynakam@hitachisoft.jp>	 <460A3199.5030302@ak.jp.nec.com> <1175083457.3864.443.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1175083457.3864.443.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-03-28 at 18:12 +0900, KaiGai Kohei wrote:
>> Yuichi Nakamura wrote:
>>> On Wed, 28 Mar 2007 10:57:25 +0900
>>> KaiGai Kohei  wrote:
>>>> Currently, I don't have actual measurement of the minimum binary size of
>>>> libsepol needed to handle preserving boolean variables and so on.
>>>> Who can estimate it?
>>> It seems that "sepol_genbools_array" libsepol function 
>>> is necessary to preserve boolean.
>>>
>>> And sepol_genbools_array uses following:
>>> -From policydb.o
>>>  policydb_init
>>>  policydb_destroy
>>> - From policydb_convert.o
>>>  policydb_from_image
>>> - From policydb_public.o
>>>  policydb_write
>>> -From conditional.o
>>>  evaluate_conds
>>> -From  hashtab.o
>>>  hashtab_search
>>>
>>> Then:
>>> $ ls -l policydb.o hashtab.o conditional.o  policydb_convert.o policydb_public.o
>>> -rw-rw-r-- 1 ynakam ynakam  6856 Mar 27 05:10 conditional.o
>>> -rw-rw-r-- 1 ynakam ynakam  2540 Mar 27 05:10 hashtab.o
>>> -rw-rw-r-- 1 ynakam ynakam 29284 Mar 27 05:10 policydb.o
>>> -rw-rw-r-- 1 ynakam ynakam  2576 Mar 27 05:10 policydb_convert.o
>>> -rw-rw-r-- 1 ynakam ynakam  2396 Mar 27 05:10 policydb_public.o
>>> Above are compiled with -Os option.
>>>
>>> So, to preserve bool at least 43.6 k is necessary.
>> Nakamura, Isn't it a bit rough-grained measurement?
>>
>> For example, policydb_init() calls the following functions internally:
>>   - symtab_init() defined at symtab.c
>>   - avrule_block_create() defined at avrule_block.c
>>   - avrule_decl_create() defined at avrule_block.c
>>   - avtab_init() defined at avtab.c
>>   - roles_init() defined at policydb.c
>>   - cond_policydb_init() defined at conditional.c
>>   - avtab_destroy() defined at avtab.c
>>   - hashtab_destroy() defined at hashtab.c
>>   - avrule_block_list_destroy() defined at avrule_block.c
>>
>> So, we also have to include symtab.c, avrule_block.c, avtab.c, conditional.c,
>> hashtab.c and avrule_block.c additionally for only policydb_init().
> 
> You don't actually need any of the code for the policy module format
> (which is presently interwoven with the rest, since the policydb
> structure supports both module and kernel formats).  A lot of that will
> boil away from the new policy representation.
> 

Presumably all of the policy management will operate on the new 
representation rather than the kernel format so bringing in any 
management at all brings in all of the module format code.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
