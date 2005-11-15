Message-ID: <437A01F2.1020402@cornell.edu>
Date: Tue, 15 Nov 2005 10:42:42 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub kernel booleans API
References: <437903B8.4040701@cornell.edu> <1132053942.5415.277.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132053942.5415.277.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I'm not sure if I'll be layering those on top of dbase... maybe..
>>     
>
> I don't think "kernel" is what you want here, as the real distinction is
> between persistent local modifications to booleans and
> runtime/active/current modifications to booleans.  The booleans
> themselves may be kernel or userspace policy constructs in either case.
>   
I like "runtime" or "active" - pick one... will resend patch.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
