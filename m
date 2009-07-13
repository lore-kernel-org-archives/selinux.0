Cc: Joshua Brindle <jbrindle@tresys.com>, <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Paul Howarth <paul@city-fan.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-Id: <9DB3FF14-CCB5-445C-BE63-1EBE84125E6A@nall.com>
From: Joe Nall <joe@nall.com>
To: Chad Sellers <csellers@tresys.com>
In-Reply-To: <C680D5CD.A8AD7%csellers@tresys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [RFC] Install SELinux policies from rpm package header
Date: Mon, 13 Jul 2009 12:33:16 -0500
References: <C680D5CD.A8AD7%csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 13, 2009, at 11:15 AM, Chad Sellers wrote:

> On 7/10/09 4:26 PM, "Joshua Brindle" <jbrindle@tresys.com> wrote:
>
>>> From: James Carter [mailto:jwcart2@tycho.nsa.gov]
>>>
>>>> Its alot worse than that. What about files on backup
>>> drives? Offline drives?
>>>> transient files that will get relabeled to something inappropriate?
>>>> I'm not confortable relabeling databases with potentially sensitive
>>>> data to var_lib_t because mysql was uninstalled.
>>>>
>>>
>>> The argument seems to be for removing the ability to remove modules.
>>> It would be the roach motel style of policy management.
>>>
>>
>> I like it, policies check in but don't check out. I haven't heard an
>> argument about 1) how I'm crazy and wrong or 2) how to keep systems
>> running as expected otherwise though.
>
> There's certainly a case for leaving all policy installed. Policy is
> configuration data, which RPM also leaves installed when removing  
> packages.
> We could easily treat policy the same.

Our app has 140 rpms that install policy. They install in the %post  
and do a restorecon of the relevant installed files and /etc/selinux/ 
mls/modules. Daemons are stopped in the %preun. Policy is removed in  
the %postun and more restorecon occurs. The biggest annoyance with  
this approach is the 140 individual transactions are ssllooww.

I would really like to see policy batched up and installed early in  
the transaction. I think blindly leaving the policy behind on  
uninstall is configuration management insanity. When an rpm is  
removed, all of the unmodified installation should be removed with it.  
Files should be relabeled to match the post installation policy. That  
way a subsequent install behaves the way you would intuitively expect.

If the app developer is concerned about the post-uninstall type  
enforcement on application created files, a separate policy rpm solves  
the problem.

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
