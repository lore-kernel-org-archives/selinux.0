Message-ID: <4367DAE9.50303@cornell.edu>
Date: Tue, 01 Nov 2005 16:15:21 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu>	 <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>	 <4367D13A.1050305@cornell.edu> <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil> <4367DA3C.3020308@cornell.edu>
In-Reply-To: <4367DA3C.3020308@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> I think moving the local files into the sandbox upon policy update (via
>> %post scriptlet in the policy package) is reasonable, as this is only
>> needed for migration and will not be done subsequently.
> I guess at that point we also want to migrate booleans.local, 
> local.users, and install the base module?
> Dan, can you add such a script?
>
> - copy /etc/selinux/?/seusers into /etc/selinux/?/modules/active/seusers
> - copy /etc/selinux/?/local.users into 
> /etc/selinux/?/modules/active/users.local [ renamed ]
> - copy /etc/selinux/?/booleans.local into 
> /etc/selinux/?/modules/active/booleans.local
> - install base module into /etc/selinux/?/modules/active/base.pp (is 
> this managed by rpm?)
Actually that reminds me that I just changed the user parser to disallow 
whitespace and multiple lines in the MLS portion of local.users  
(unfortunate).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
