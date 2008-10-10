Message-ID: <48EEA873.4000602@ak.jp.nec.com>
Date: Fri, 10 Oct 2008 09:57:23 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Stephen Smalley <sds@tycho.nsa.gov>,
        jmorris@namei.org, paul.moore@hp.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] Thread/Child-Domain Assignment (rev.6)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <4897EB6F.6080709@ak.jp.nec.com> <48B2A66D.7030608@ak.jp.nec.com> <48B6C966.7040006@tresys.com> <48B756C4.2090909@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3510@exchange2.columbia.tresys.com> <48BB8B1E.7010208@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E3A3609@exchange2.columbia.tresys.com> <48BC141F.2060802@kaigai.gr.jp> <48C5D9A7.7090909@ak.jp.nec.com> <48CAB248.6060701@tresys.com> <48CAF936.1090009@kaigai.gr.jp> <48E2310D.1080101@manicmethod.com> <48E32C7E.7020800@ak.jp.nec.com> <48E7FCA4.2070803@manicmethod.com> <48E9D816.8080405@ak.jp.nec.com> <48EA6357.1010300@manicmethod.com> <48EB0431.5090909@ak.jp.nec.com> <48EE2388.4020209@manicmethod.co
 m>
In-Reply-To: <48EE2388.4020209@manicmethod.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>>>> Hmm....
>>>> It seems to me what you pointed out is a bug of my patch. It prevents to deliver
>>>> actual number of type/attribute symbols to policy file, but it is unclear why does
>>>> it makes libsepol ignore the policyvers.
>>>> (I guess it may be a separated matter.)
>>>>
>>>>       
>>>>> Rather than trying to calculate the length without attributes I just removed
>>>>> the attribute check. This causes attributes to be written for all versions,
>>>>> but this should not cause any problems at all.
>>>>>         
>>>> The reason why I injected such an ad-hoc code is that we cannot decide the policy
>>>> version written when type_attr_remove() is invoked.
>>>> Is it impossible to move it to policydb_write()?
>>>> It is invoked after the policyvers is fixed by caller.
>>>>       
>>> It isn't impossible. You are going to have to make it walk to type
>>> symbol table to calculate the length without attributes, then write
>>> that length instead of the total symtab length.
>>>     
>> The attached patch enables to fixup the number of type/attribute entries
>> to be written. The type_attr_uncount() decrements the number of attribute
>> entries skipped at type_write().
>>
>> At first, I had a plan to invoke type_attr_remove() with
>> hashtab_map_remove_on_error(), but it means the given policydb structure
>> is modified at policydb_write() and implicit changes to external interface.
>>
>>   
> 
> This does not cause a hierarchy error, is this an expected limitation?
> 
> typebounds goodbye_world_t hello_world_t;
> 
> allow hello_world_t self: file ~{read };
> 
> allow goodbye_world_t self: file *;

This case should not cause a hierarchy error.

Please assume a domain "S" is a bounds of "S.sub" and a type "T" is a bounds of
"T.sub", and P(x,y) means permissions between "x" and "y".

As you know, the hierarchy constraint has the following rules.
 1. P(S.sub, T) is equal or smaller than P(S, T)
 2. P(S, T.sub) is equal or smaller than P(S, T)
 3. P(S.sub, T.sub) is equal or smaller than P(S, T)
 4. rest of permissions are violated.

Your case matches the third rule which should be allowed.

 P(hello_world_t, hello_world_t) = file : ~{ read }

  is equal or smaller than

 P(goodbye_world_t, goodbye_world_t) = file : *

It is an expected behavior, not a limitation.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
