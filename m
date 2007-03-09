Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29F7gYd023994
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 10:07:42 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l29F7fms019287
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 15:07:41 GMT
Message-ID: <45F177FC.3010301@redhat.com>
Date: Fri, 09 Mar 2007 10:06:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: modutils needs to talk to terminal
References: <200703081438.l28EcJTr008890@localhost.localdomain>	 <1173445831.23674.10.camel@sgc.columbia.tresys.com>	 <45F16DA6.40908@redhat.com> <1173452451.29664.0.camel@sgc.columbia.tresys.com>
In-Reply-To: <1173452451.29664.0.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-03-09 at 09:22 -0500, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> On Thu, 2007-03-08 at 09:38 -0500, dwalsh@redhat.com wrote:
>>>   
>>>       
>>>> --- nsaserefpolicy/policy/modules/system/modutils.te	2007-02-19 11:32:53.000000000 -0500
>>>> +++ serefpolicy-2.5.8/policy/modules/system/modutils.te	2007-03-08 09:34:35.000000000 -0500
>>>> @@ -118,7 +118,8 @@
>>>>  }
>>>>  
>>>>  ifdef(`targeted_policy',`
>>>> +	term_use_unallocated_ttys(insmod_t)
>>>>  	unconfined_domain(insmod_t)
>>>>  ')
>>>>     
>>>>         
>>> With the recent fixes to the terminal module, making ttys and ptys
>>> device nodes, this shouldn't be needed.
>>>
>>>   
>>>       
>> So are you saying all term_use_unallocated_ttys can go away?
>>     
>
> I'm only saying its not needed in this case, since insmod is unconfined.
>
>   
Ok, that is something I want to remove also.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
