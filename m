Message-ID: <4367E142.1030502@cornell.edu>
Date: Tue, 01 Nov 2005 16:42:26 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu> <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil> <4367D13A.1050305@cornell.edu> <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil> <4367DA3C.3020308@cornell.edu> <4367D88F.1080309@tresys.com>
In-Reply-To: <4367D88F.1080309@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> - copy /etc/selinux/?/local.users into 
>> /etc/selinux/?/modules/active/users.local [ renamed ]
> this could potentially be done the same way as booleans below, except 
> that there isn't a user of the user api in libsemanage yet, so that 
> would be written; with seuser handling the vast majority of users now 
> this isn't very high priority.
>
>> - copy /etc/selinux/?/booleans.local into 
>> /etc/selinux/?/modules/active/booleans.local
> not sure about this. It would not be difficult to read the old 
> booleans file and pipe the info through setsebool -p.
setsebool -p does not go through libsemanage as of right now...
I haven't written any users of libsemanage - I've been focusing on the 
library so far..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
