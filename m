Message-ID: <435025EB.2060203@cornell.edu>
Date: Fri, 14 Oct 2005 17:40:59 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com> <435017B2.7040107@cornell.edu> <435018F7.6070706@cornell.edu> <4350177F.7010600@tresys.com> <43501C38.5040907@cornell.edu> <43501DD9.4010803@tresys.com>
In-Reply-To: <43501DD9.4010803@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> You don't seem to realize that those databases need to exist, whether 
>> or not you're using the policy server, or the direct api.
>> This is just another way to switch between the two.
>>
> The policy server can't fill in these databases since there are 
> permission checks it would need to do for the queries.
That sounds like an implementation detail, and I don't understand why 
it's a problem. Maybe you can be more specific?

I've defined a database-like interface for users and other objects for 
files. You can look at users.h or ports.h, to see an example. I would 
like to support the same interface for the same objects in policy. I 
plan on exposing at least the query part of it to libsemanage clients. 
I'm not sure whether the modification part of it should be exposed 
(since you want modules only...no primitive changes), but I think it 
should be implemented internally in any case.

I can support the direct-case implementation. I am hoping you can 
support the policy server case, because otherwise this interface will 
not work for the server. If you dislike the interface, please give 
concrete reasons why, and I'll try to correct it.

>>>>
>>>> In fact, I want to convert your modules functions into a database 
>>>> too, but
>>>> I haven't gotten to it yet, and this isn't high priority.
>>>>
>>> Why? This doesn't solve any problem.
>>
>> For consistency, if nothing else... I think there are benefits to 
>> hiding data collections under a uniform interface, but I don't want 
>> to get into that right now - I sent Karl a long email some time ago. 
>> I know he's not convinced, but it's just my pet project.
>>
> this is a library being used by many people, I don't know that adding 
> things for the sake of adding them is appropriate.
I don't waste my time adding things "for the sake of adding them". I try 
to design things so that they are extensible. For example, one concrete 
reason why I want to see the modules look like a database, is that the 
dbase interface has more functions than you currently provide, and 
provides better encapsulation. I think that having a similar modules 
interface could be beneficial.

That said, Dan Walsh has not specified this as part of my current 
project, so it's just something that I would like to do.
The handle does not contain anything backend specific currently. Please 
give an example of something backend specific.
> The subject of this email is "Add a few direct dbases to handle". Does 
> direct mean something different from a direct connection?
You're right...the subject is misleading. It should say:
"Add a few policy databases to the handle, and stub their direct 
implementations".

> Also:
>
> +
> +#define DBASE_BASE_USERS      5
> +#define DBASE_BASE_PORTS      6
> +#if 0
> +#define DBASE_BASE_INTERFACES 7
> +#define DBASE_BASE_BOOLEANS   8
> +#endif
>
> What are these? How are they different from the other user, ports, 
> interfaces, booleans. Why isn't this described in the code or even email?
These are the users/ports/interfaces, and booleans that are currently 
part of the binary policy.
This was described in an email, to which you replied IIRC. It has also 
been described multiple times when I submitted patches that talk about a 
"direct database" to the list.

I agree that the code is not commented, but I've tried to at least name 
things proplerly.
I can add more comments later on, since a lot of this functionality 
isn't quite working yet - this is work in-progress.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
