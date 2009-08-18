Message-ID: <4A8AC959.9000505@redhat.com>
Date: Tue, 18 Aug 2009 11:31:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Larry Ross <selinux.larry@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: checking user status
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com> <81092d890908170754h76b5b3d7rab139e7759dce09d@mail.gmail.com>
In-Reply-To: <81092d890908170754h76b5b3d7rab139e7759dce09d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/17/2009 10:54 AM, Larry Ross wrote:
> On Mon, Aug 17, 2009 at 7:47 AM, Larry Ross <selinux.larry@gmail.com> wrote:
> 
>>  On Mon, Aug 17, 2009 at 5:29 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>>
>>> On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:
>>>> Using the RHEL5.3 strict policy I am trying to allow a custom selinux
>>>> user permission to use the passwd and chage commands to get the status
>>>> of a local user.
>>>>
>>>> With selinux in permissive it works as expected, with selinux in
>>>> enforcing, all I get are cryptic error messages.  I installed the
>>>> enableaudit.pp base policy module, still no denials.
>>>>
>>>> Does anyone know what permissions I need to add or what I could
>>>> be doing wrong?  Is this even possible?
>>>
>>
>>  Stephen,
>> Thank you for your response.
>>
>>
>>
>>> Did you allow the :passwd permission to the custom selinux user's
>>> domain?
>>
>>
>>> allow <userdomain> self:passwd { passwd };
>>
>>
>>  I would have if I had know about it, is this documented somewhere?.
>>
>> That worked for "passwd -S", is there something similar to allow a user to
>> use the chage command?
>>
> 
> Stephen,
>   Sorry for the off list reply.  I think I found it: "rootok".  It works,
> but I'm not sure what it means.  Could you explain what the rootok
> permission means?  Is it intended for this use?
> 
>   Thank you,
>   Larry
> 
> 
> 
>>
>>    Thank you,
>>    Larry
>>
>>
>>
>>>
>>>
>>> --
>>> Stephen Smalley
>>> National Security Agency
>>>
>>>
>>
> 
rootok is a check within the password command to see if the administrator who is running the password command override password accounts other then its own.

The idea is to stop applications that are running as root, from changing password data without providing the old password.
If the type does not have rootok, the password utility will ask for a password before changing any password data.

This prevents a confined administrator from becoming root and changing the root other other passwords.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
