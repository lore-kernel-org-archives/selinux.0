Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0KDuNXf015564
	for <selinux@tycho.nsa.gov>; Fri, 20 Jan 2006 08:56:23 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0KDtDTl020559
	for <selinux@tycho.nsa.gov>; Fri, 20 Jan 2006 13:55:13 GMT
Message-ID: <43D0EC08.1000700@redhat.com>
Date: Fri, 20 Jan 2006 08:56:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest Diffs
References: <43CFE58A.40909@redhat.com> <1137712699.29815.402.camel@sgc>
In-Reply-To: <1137712699.29815.402.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Merged with a few notes:
>
> On Thu, 2006-01-19 at 14:16 -0500, Daniel J Walsh wrote:
>   
>> Fixes for wine and mono apps to be able to handle no execheap/execstack
>>     
>
> Added these, but if we get more apps like these, we might want to go to
> unconfined_execheap and unconfined_execstack.
>
> I haven't merged the users part, but I plan to.  I just want to make
> sure this change is what we really want to do for the strict policy:
>
>   
>> -gen_user(user_u, user_r, s0, s0 - s15:c0.c255, c0.c255)
>> +gen_user(user_u, user_r, s0, s0 - s0, c0)
>>     
>
> The MLS change seems ok, but do we really want to give user_u one
> arbitrary category (c0) for MCS?  It seems like it would be better for
> the default to be no categories.
>
>   
Yes I agree.  Never noticed that.  It should be s0.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
