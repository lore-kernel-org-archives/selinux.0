Cc: Stephen Smalley <sds@tycho.nsa.gov>
Message-Id: <BD1A2654-EA16-4D95-9A0C-405210896E37@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <1241784499.6452.175.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: does this picture reflect the basics of the current selinux architecture?
Date: Fri, 8 May 2009 15:30:56 +0200
References: <4D851E45-B2C0-4392-872A-CC329013FC73@gmail.com> <1241784499.6452.175.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> ...
>
> - Remove "user" as you suggest, as it incorrectly suggests that  
> SELinux
> operates at per-user granularity like DAC.
>
> - Yes, SELinux runs as a security module in the address space of the
> kernel.
>
> - The policy is simply configuration data loaded into the security
> server.


1st, tnx for your quick answer!

i have tried to improve the picture as you have suggested. what do you  
think about this the following one?

IMPROVED PICTURE:

http://3.bp.blogspot.com/_OR3mMHaW6Iw/SgQyRwblcRI/AAAAAAAAAAc/C9HOanHgINs/s1600-h/sel_1_1_eng.png

The policy is now located "within" the security server, i hope this  
one refelcts more the actual state.

--
Sebastian Pfaff



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
