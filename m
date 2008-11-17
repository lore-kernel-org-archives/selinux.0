Message-ID: <49211255.4030105@ak.jp.nec.com>
Date: Mon, 17 Nov 2008 15:42:29 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: This policy causes checkmodule to segfault.
References: <491DE60C.3040205@redhat.com> <4920B3C1.4000405@manicmethod.com>
In-Reply-To: <4920B3C1.4000405@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> policy_module(test, 1.0)
>>
>> gen_require(`
>>   type a_t;
>> ')
>> type b_t alias a_t;
>>   
> 
> Well, this doesn't look good. There are a couple issues here. The first 
> is that when we changed the symtab_insert behavior to allow require then 
> declare we missed the alias case, the patch below should fix that. The 
> second problem is that type_write now treats primary as a boolean value 
> (as of the typebounds patch). A while back we made primary not 
> necessarily a boolean in the module case where an alias had a value 
> already and we needed to keep track of what the primary value was. The 
> typebounds patch combined multiple fields into a 'properties' bitmap, 
> which includes primary, so the value is now lost.
> 
> We can change the module format to keep the primary field around, this 
> particular piece of code is getting increasingly more confusing though 
> (write.c:970)

Because the total number of types/aliases are (2^16-1) in maximum, we can
put the primary field into the property field (32bit width) on-disk format.
However, it seems to me an ad-hoc hack. It is a more straight forward solution
to separate cases between modular policy and kernel policy.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
