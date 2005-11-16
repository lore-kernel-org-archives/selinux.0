Message-ID: <437A84F6.9050804@redhat.com>
Date: Tue, 15 Nov 2005 20:01:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Stub pserver backend
References: <437907D7.8090002@cornell.edu> <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil> <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil> <437A04A5.10000@cornell.edu> <437A050E.70703@tresys.com>
In-Reply-To: <437A050E.70703@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
>>>
>>>> I'd prefer to wait until we have a basic working implementation and a
>>>> user ready for merging.  Posting stubs or function prototypes to the
>>>> list as examples is fine, but I don't see much value in merging them.
>>>> It was ok for early development of libsemanage in order to build up
>>>> infrastructure and allow early collaboration/feedback, but I'd 
>>>> prefer to
>>>> move to merging actual implementations now.  I'd especially like to 
>>>> see
>>>> sample users (even just dummy test programs) that allow the code to be
>>>> trivially exercised along with the submissions to help put it in
>>>> context.
>>>>     
>>
>> Ok, in that case disregard the last two patches - I will resend those 
>> with implementation.
>>
>>>
>>> Also, I think we need to think about priorities of tasks; policy server
>>> backend and runtime boolean manipulation via libsemanage seem fairly 
>>> low
>>> to me right now.  Of greater importance would be:
>>>   
>>
>> Sure, but stubs are easy to write - just wanted to point to where the 
>> functionality should go into.
>> The rest of the things you specified are important, but a bit harder 
>> to do... not disregarding the issues.
>>
>>> - Finishing the ports functionality and exporting those interfaces,
>>>   
>>
>> I think this is of particularly high importance to Dan - I'll have to 
>> work on that soon.
>
> Are you going to do this in python? If so we'll need to wrap all the 
> port types and also implement the write/transaction functionality, all 
> that has been done so far is querying of seusers, users, modules.
Yes we need a full semange command set written in python.

Something like

semanage --seuser --add -s user_u -r SystemLow-SystemHigh dwalsh
semanage --port --add -p 1234 httpd_port_t
semanage --seuser --delete dwalsh

>
> Have you looked at the swig wrappers? Do you feel comfortable wrapping 
> additional types?
You asking me or Ivan?
>>
>>> - Creating utilities for managing the other policy components via
>>> libsemanage.
>>>   
>>
>> What would all those utilities look like - shell? python with GUI? 
>> should I be working on those - Dan?
>>
>>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
