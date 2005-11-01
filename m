Message-ID: <4367DEB1.6080005@cornell.edu>
Date: Tue, 01 Nov 2005 16:31:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, SELinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu>	 <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>	 <4367D13A.1050305@cornell.edu>	 <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil>	 <4367DA3C.3020308@cornell.edu> <1130879489.22731.321.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130879489.22731.321.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I guess at that point we also want to migrate booleans.local, 
>> local.users, and install the base module?
>> Dan, can you add such a script?
>>
>> - copy /etc/selinux/?/seusers into /etc/selinux/?/modules/active/seusers
>> - copy /etc/selinux/?/local.users into 
>> /etc/selinux/?/modules/active/users.local [ renamed ]
>> - copy /etc/selinux/?/booleans.local into 
>> /etc/selinux/?/modules/active/booleans.local
>> - install base module into /etc/selinux/?/modules/active/base.pp (is 
>> this managed by rpm?)
>>     
>
> BTW, on the "is this managed by rpm?" question:  The copying into the
> sandbox would be handled by %post scriptlet, so the sandbox file paths
> would not be "owned" by the package as far as rpm is concerned (IIUC).
> So it shouldn't be a problem.
>   
Right, but it seems we need Makefile support for installing the base 
module in /usr/share/selinux.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
