Message-ID: <4384E1B2.4090605@tresys.com>
Date: Wed, 23 Nov 2005 16:40:02 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL] Remove defrole from sepol
References: <437EBD3A.7090606@cornell.edu> <43848B72.1010603@cornell.edu> <43849B20.3090500@tresys.com> <4384C873.20904@cornell.edu> <4384C70B.8000405@tresys.com> <4384CF88.4090303@cornell.edu> <4384D7C7.2020102@cornell.edu>
In-Reply-To: <4384D7C7.2020102@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>
>>>>>> I'm starting to question the need for this interface at all... 
>>>>>> it's an interface for a very narrow user base - genhomedircon... 
>>>>>> which is probably a mistake. I would prefer genhomedircon to find 
>>>>>> its way into libsemanage, which is its only user (does it have 
>>>>>> another one?). 
>>>>>
>>>>>
>>>>> the semanage tool Dan is writing could use it, to determine if a 
>>>>> level should be set, or it could just rely on getting an error back 
>>>>> if you try to set a level and it is a non mls system.
>>>>
>>>>
>>>> I'm confused... it needs genhomedircon, and not the library?
>>>>
>>> which interface were you refering to? the semanage tool will need to 
>>> modify most entry types.
>>
>> I was referring to the interface to export a default role for 
>> genhomedircon. It's broken right now, but I'm re-writing it as a 
>> general "Auxiliary Data" object... but if there is no other auxiliary 
>> data than the labeling prefix/defrole, and the only user is 
>> genhomedircon, it's not clear whether a new interface should be written.
> 
> Well I guess we'll need some kind of interface to configure labeling... 
> whether genhomedircon is inside or outside libsemanage. I just don't 
> like how I'm forced into adding another record which shouldn't be 
> necessary (because the alternative of adding info to the user record, 
> and having it backed by both policy and file is worse)... and now have 
> to add code to merge a pair of files in the list() and iterate() functions.
> 
> 
This is what databases are all about, relational ones anyway...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
