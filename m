Message-ID: <4730E322.4020203@tycho.nsa.gov>
Date: Tue, 06 Nov 2007 16:56:50 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: introduce enforcing mode override option
References: <471F8F8D.3040606@tycho.nsa.gov> <1193935864.12018.107.camel@moss-spartans.epoch.ncsc.mil> <472F79D5.6020903@tycho.nsa.gov> <4730D9A6.6050306@manicmethod.com>
In-Reply-To: <4730D9A6.6050306@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Eamon Walsh wrote:
>> Introduces an enforcing mode override option, so the object manager
>> can bring up the AVC in permissive mode on an enforcing system, or
>> vice versa.
>>
> 
> This is probably more useful but we actually had something like this 
> with the userspace security server where you could run the USS in 
> permissive or enforcing independent of the kernel security server. 
> Ofcourse this would mean its still a global setting across all access 
> managers using the USS.
> 

Interesting, I would think that the USS would only serve up "raw" 
decisions like the kernel security server does.  The permissive setting 
is a construct of the AVC layer.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
