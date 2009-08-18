Message-ID: <4A8AC975.3020204@redhat.com>
Date: Tue, 18 Aug 2009 11:32:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Larry Ross <selinux.larry@gmail.com>,
        selinux@tycho.nsa.gov
Subject: Re: checking user status
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil> <1250512929.27712.92.camel@gorn.columbia.tresys.com>
In-Reply-To: <1250512929.27712.92.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/17/2009 08:42 AM, Christopher J. PeBenito wrote:
> On Mon, 2009-08-17 at 08:29 -0400, Stephen Smalley wrote:
>> On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:
>>> Using the RHEL5.3 strict policy I am trying to allow a custom selinux
>>> user permission to use the passwd and chage commands to get the status
>>> of a local user.
>>>  
>>> With selinux in permissive it works as expected, with selinux in
>>> enforcing, all I get are cryptic error messages.  I installed the
>>> enableaudit.pp base policy module, still no denials.
>>>  
>>> Does anyone know what permissions I need to add or what I could
>>> be doing wrong?  Is this even possible?
>>
>> Did you allow the :passwd permission to the custom selinux user's
>> domain?
>>
>> allow <userdomain> self:passwd { passwd };
> 
> Perhaps a denial message should be emitted from
> selinux_check_passwd_access() so people know when this perm check is
> denied.
> 
Please open a bugzilla on the passwd command.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
