Message-ID: <48EC0B3E.5010405@ak.jp.nec.com>
Date: Wed, 08 Oct 2008 10:22:06 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: typebounds lookup from userspace
References: <48D3B220.1060903@manicmethod.com> <48EB0B75.1030108@ak.jp.nec.com> <48EB9B57.5090304@tycho.nsa.gov> <48EBB8EE.7040906@tycho.nsa.gov>
In-Reply-To: <48EBB8EE.7040906@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Eamon Walsh wrote:
>> KaiGai Kohei wrote:
>>   
>>> Joshua Brindle wrote:
>>>   
>>>     
>>>> For symbol labeling purposes for policy access control we need to be able
>>>>     
>>>>       
>>>  > to look up symbol hierarchy relationships. I expect we'll do this by exporting
>>>  > the symbol hierarchy via selinuxfs. Does anyone have suggestions on what that
>>>  > should look like? Do we want to export additional information on the symbols
>>>  > at the same time?
>>>
>>> I noticed that userspace object manager also need an interface to get metadata
>>> of types to support permissive domain. Currently, we don't have any interface
>>> to know what domain should be handled as permissive domain.
>>>
>>> If "/selinux/access" can return the 6th value to show whether the given query
>>> should be handled as permissive domain or not, it helps userspace object managers.
>>>   
>>>     
>> Why does a userspace object manager need to know if a domain is marked
>> permissive?  That should be hidden behind security_compute_av().
>>   
> 
> Whoops, nevermind.
> 
> I looked at the patches and they seem reasonable, but there may be a
> compatibility issue with the extra flags thing.  What happens if
> libselinux expects it but it's not there?

If a binary with libselinux assumes the current av_decision structure
without "flags" member, the newer libselinux set flag bits out of the
current av_decision. It may receive -SIGSEGV. Oops.

One idea is to add a new interface without modification of av_decision, like:

   security_compute_av_flags(....,
                             struct av_decision *avd,
                             unsigned long flags);

> Also minor nit, making the flags structure field into a bitmap would
> eliminate the need for a #define, i.e.   "unsigned long permissive:1"

If we keep the definition of av_decision, the #define is also necessary.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
