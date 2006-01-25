Message-ID: <43D7E4BE.5060506@redhat.com>
Date: Wed, 25 Jan 2006 15:51:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Valeriev Gyurdiev <ivg2@cornell.edu>,
   SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEMANAGE] Rename seuser -> seuser_local
References: <43D1737F.6010002@cornell.edu>	 <1138020746.20815.21.camel@moss-spartans.epoch.ncsc.mil>	 <1338.128.253.53.144.1138205270.squirrel@webmail.cornell.edu>	 <1138206508.13075.9.camel@moss-spartans.epoch.ncsc.mil>	 <3595.128.253.53.165.1138210295.squirrel@webmail.cornell.edu>	 <43D7BB74.30300@redhat.com> <1138212699.13075.27.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138212699.13075.27.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-01-25 at 12:55 -0500, Daniel J Walsh wrote:
>   
>> No, and if they did we could do it via semanage.
>>     
>
> Yes, that was my expectation.
>
>   
>>> It seems to me that this could be a desirable capability in the future.
>>> Also, remember that this means that the user can apply non-additive
>>> changes to the seuser file - in other words, the delete function will
>>> clear not only local changes, but will completely remove the __default__,
>>> or root user if requested, reverting back to libselinux defaults (not
>>> post-script defaults). Not sure if this is a good idea...
>>>
>>>   
>>>       
>> Yes this would be bad.
>>     
>
> It wouldn't be a good idea for them to do that, but I'm not sure we need
> to introduce this additional baggage just to idiot-proof semanage.
>
>   
How about I idiotproof seobject.py?
>>> The current naming scheme seemed inconsistent, which is why I sent a patch
>>> for it. Whether or not a .system file is added, the rename improves
>>> consistency with current usage - places seusers function in the _local
>>> namespace where they belong.
>>>       
>
> I don't want API changes without adequate justification.  Yes, we still
> have flexibility in this arena since we control all users of the
> library, but we still don't want arbitrary changes.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
