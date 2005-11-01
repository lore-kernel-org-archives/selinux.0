Message-ID: <4367D88F.1080309@tresys.com>
Date: Tue, 01 Nov 2005 16:05:19 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu> <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil> <4367D13A.1050305@cornell.edu> <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil> <4367DA3C.3020308@cornell.edu>
In-Reply-To: <4367DA3C.3020308@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>>
>> I think moving the local files into the sandbox upon policy update (via
>> %post scriptlet in the policy package) is reasonable, as this is only
>> needed for migration and will not be done subsequently.
> 
> I guess at that point we also want to migrate booleans.local, 
> local.users, and install the base module?
> Dan, can you add such a script?
> 
> - copy /etc/selinux/?/seusers into /etc/selinux/?/modules/active/seusers
fine

> - copy /etc/selinux/?/local.users into 
> /etc/selinux/?/modules/active/users.local [ renamed ]
this could potentially be done the same way as booleans below, except 
that there isn't a user of the user api in libsemanage yet, so that 
would be written; with seuser handling the vast majority of users now 
this isn't very high priority.

> - copy /etc/selinux/?/booleans.local into 
> /etc/selinux/?/modules/active/booleans.local
not sure about this. It would not be difficult to read the old booleans 
file and pipe the info through setsebool -p.

> - install base module into /etc/selinux/?/modules/active/base.pp (is 
> this managed by rpm?)
> 
the base.pp will be placed in /usr/share/selinux and then be installed 
via semodule -b.


>> Yes.  But we need to avoid breaking use of semodule -b now via this
>> patch until such a time as the seusers support is in place, so possibly
>> I should just change the error handling here to just WARN and proceed
>> with the reload.
> 
> Hmm... that sounds reasonable... I think.
> 
Not even sure a warn is necessary IMO, read other response.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
