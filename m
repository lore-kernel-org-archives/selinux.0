Message-ID: <43D7BB74.30300@redhat.com>
Date: Wed, 25 Jan 2006 12:55:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Valeriev Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEMANAGE] Rename seuser -> seuser_local
References: <43D1737F.6010002@cornell.edu>     <1138020746.20815.21.camel@moss-spartans.epoch.ncsc.mil>     <1338.128.253.53.144.1138205270.squirrel@webmail.cornell.edu>    <1138206508.13075.9.camel@moss-spartans.epoch.ncsc.mil> <3595.128.253.53.165.1138210295.squirrel@webmail.cornell.edu>
In-Reply-To: <3595.128.253.53.165.1138210295.squirrel@webmail.cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Valeriev Gyurdiev wrote:
>> On Wed, 2006-01-25 at 11:07 -0500, Ivan Valeriev Gyurdiev wrote:
>>     
>>>> On Fri, 2006-01-20 at 16:34 -0700, Ivan Gyurdiev wrote:
>>>>         
>>>>> Seuser functions and dbase have incorrect names, since originally I
>>>>>           
>>> did
>>>       
>>>>> not think we'd have seusers.system. I must have asked about this, but
>>>>> regardless, I now think that a systems file will likely be necessary,
>>>>>           
>>> so
>>>       
>>>>> this patch renames all seuser-related things to _local, which leaves
>>>>> space for a _policy set of functions. It updates dependencies and
>>>>> manpages. This is an API change.
>>>>>
>>>>> I think we should add users_extra.system and seusers.system into the
>>>>> package format.
>>>>>           
>>>> Sorry, what is the motivation for this change, i.e. what is the system
>>>> seusers file for?
>>>>         
>>> That will allow us to configure per-policy defaults for certain users
>>> like
>>> root, __default__. We could also configure more restricted SELinux users
>>> for certain "system" users like daemon users,or things like a guest
>>> account. It seems wrong to hardcode those defaults into the libselinux
>>> library rather than policy.
>>>       
>> That doesn't really seem consistent with the intended usage of seusers,
>> IIUC.  The policy package just needs to set up the initial state for
>> seusers upon the initial install (which it does from %post presently,
>> installing a seusers file from the policy package into the store, with
>> separate ones for targeted, mls, and strict), and then all subsequent
>> changes should occur via semanage.  Do we expect updated policy packages
>> to ship updates to that initial state that should take precedence over
>> local configuration done via semanage?
>>
>>     
>
> Well, I guess Dan would be the one to ask that question.
>   
No, and if they did we could do it via semanage.
> It seems to me that this could be a desirable capability in the future.
> Also, remember that this means that the user can apply non-additive
> changes to the seuser file - in other words, the delete function will
> clear not only local changes, but will completely remove the __default__,
> or root user if requested, reverting back to libselinux defaults (not
> post-script defaults). Not sure if this is a good idea...
>
>   
Yes this would be bad.
> The current naming scheme seemed inconsistent, which is why I sent a patch
> for it. Whether or not a .system file is added, the rename improves
> consistency with current usage - places seusers function in the _local
> namespace where they belong.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
