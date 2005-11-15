Message-ID: <437A0D1E.6020604@cornell.edu>
Date: Tue, 15 Nov 2005 11:30:22 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub pserver backend
References: <437907D7.8090002@cornell.edu> <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil> <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil> <437A04A5.10000@cornell.edu> <437A050E.70703@tresys.com>
In-Reply-To: <437A050E.70703@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

J
>>> - Finishing the ports functionality and exporting those interfaces,
>>>   
>>
>> I think this is of particularly high importance to Dan - I'll have to 
>> work on that soon.
>
> Are you going to do this in python? 
Well, the ports code will be written in C, but the interface will 
probably be exported via python.
> If so we'll need to wrap all the port types and also implement the 
> write/transaction functionality, all that has been done so far is 
> querying of seusers, users, modules.
Yes..
> Have you looked at the swig wrappers? Do you feel comfortable wrapping 
> additional types?
Not yet, but I can investigate..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
