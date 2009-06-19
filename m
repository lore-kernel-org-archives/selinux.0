Message-ID: <4A3BEC4B.5080504@redhat.com>
Date: Fri, 19 Jun 2009 15:51:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: This patch add seusers support to SELinux
References: <4A11A6EE.3070903@redhat.com> <4A3A4366.3010606@manicmethod.com>	 <4A3A45B0.4070803@manicmethod.com> <4A3A97B0.6030407@redhat.com>	 <4A3AA03E.4010208@manicmethod.com> <4A3B6110.8010308@redhat.com>	 <4A3BA9DC.2060406@manicmethod.com> <4A3BACE9.6000403@redhat.com>	 <4A3BD53A.5050908@manicmethod.com>  <4A3BD905.3030401@redhat.com> <1245439846.3574.12.camel@defiant.pebenito.net>
In-Reply-To: <1245439846.3574.12.camel@defiant.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/19/2009 03:30 PM, Chris PeBenito wrote:
> On Fri, 2009-06-19 at 14:29 -0400, Daniel J Walsh wrote:
>> Basically this is the exact same file as the seusers file except it one
>> per Linux User where is the seusers file is one record per Linux User.
>>
>> If I have a distributed environment, I need to say stuff like
>>
>> engineers logging into people.redhat.com get guest_t:s0
>> Admins logging in get unconfined_t:SystemLow-SystemHigh
>>
>> In addition on some machines dwalsh is an admin and on others he is a
>> peon.  So using IPA we generate a mapping from MACHINE to User
>>
>> dwalsh on dwalsh_laptop gets unconfined_t
>> dwalsh on desktop gets user_t
>> dwalsh on people gets guest_t
>>
>> There is a potential use for service but it will probably default to *
>> for now.
>
> I don't have a problem with this idea, but I do have a problem with this
> not replacing the current seuser behavior.  Having two ways to map linux
> users to selinux users is an administration nightmare.  People will be
> confused about which one to use and you'll need to know precedence.
> What you describe above with the contents of each file just having a *
> service would be the same as the current seuser behavior.
>
Well I don't see administrators editing the new format, we have not even 
used it yet, since IPA has not shipped this functionality yet.

But there is precedence for this in the default_context versus the 
context/users files.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
