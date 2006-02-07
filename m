Message-ID: <43E8B1F0.5030208@cornell.edu>
Date: Tue, 07 Feb 2006 09:42:56 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why cron doesn't work in strict policy
References: <43E7C52E.601@cornell.edu> <43E7C804.3040507@cornell.edu>	 <43E8B013.8000000@redhat.com> <1139323414.2872.46.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139323414.2872.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Which causes cron jobs on strict policy and I would guess MLS to run at 
>> user_u since system_u is not defined and would run at level s0. 
>>     
>
> We should add system_u to seusers.
>   
Why? There's no such Linux user...
This will cause problems with genhomedircon.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
