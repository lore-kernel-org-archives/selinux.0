Message-ID: <47312173.8050000@manicmethod.com>
Date: Tue, 06 Nov 2007 21:22:43 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: introduce enforcing mode override option
References: <471F8F8D.3040606@tycho.nsa.gov> <1193935864.12018.107.camel@moss-spartans.epoch.ncsc.mil> <472F79D5.6020903@tycho.nsa.gov> <4730D9A6.6050306@manicmethod.com> <4730E322.4020203@tycho.nsa.gov>
In-Reply-To: <4730E322.4020203@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Joshua Brindle wrote:
>> Eamon Walsh wrote:
>>> Introduces an enforcing mode override option, so the object manager
>>> can bring up the AVC in permissive mode on an enforcing system, or
>>> vice versa.
>>>
>>
>> This is probably more useful but we actually had something like this 
>> with the userspace security server where you could run the USS in 
>> permissive or enforcing independent of the kernel security server. 
>> Ofcourse this would mean its still a global setting across all access 
>> managers using the USS.
>>
>
> Interesting, I would think that the USS would only serve up "raw" 
> decisions like the kernel security server does.  The permissive 
> setting is a construct of the AVC layer.

The avc gets the enforcing mode from the security server, in this case 
the USS was delivering its own enforcing mode independent of the kss.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
