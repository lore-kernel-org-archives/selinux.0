Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7DIxk49025482
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 14:59:47 -0400
Received: from rv-out-0708.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7DIxFIS009719
	for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 18:59:15 GMT
Received: by rv-out-0708.google.com with SMTP id c5so267434rvf.54
        for <selinux@tycho.nsa.gov>; Thu, 13 Aug 2009 11:59:45 -0700 (PDT)
Message-ID: <4A8462B6.7020503@gmail.com>
Date: Thu, 13 Aug 2009 12:00:06 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: error: too many arguments to function 'security_getenforce'
References: <dd18b0c30908122030l3e950054r1f3907a6dcde8db0@mail.gmail.com> <4A844EFD.7030000@redhat.com> <4A845612.1070907@gmail.com> <4A8457D9.60908@redhat.com>
In-Reply-To: <4A8457D9.60908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 08/13/2009 02:06 PM, Justin P. Mattock wrote:
>    
>> Daniel J Walsh wrote:
>>      
>>> Does
>>>
>>> selinux_mkload_policy(1);
>>>
>>> Work for you?
>>>
>>>
>>>        
>> I clipped part of the message to keep
>> things clean.
>>
>> I'm going to be honest, I'm not that yet skilled
>> in fixing something like this.
>>
>> with selinux_mkload_policy(1)
>> were would I put this?
>>
>> Justin P. Mattock
>>
>>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>      
>
> Actually the function you probably want
> selinux_init_load_policy
>
> I attached the patch we used to use for sysvinit, before we moved to loading policy in the initrd.
>
>
>
>    
you are the renaissance man...

finally after racking my brain around this one
init finally loads the policy, of course  with your assistance.

I owe you a nice cold one, just let me know if your
ever in the ventura county area.
(or if I head up to silicon valley just name your location of choice).

Thank you for this.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
