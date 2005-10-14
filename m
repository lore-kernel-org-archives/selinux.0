Message-ID: <43501DD9.4010803@tresys.com>
Date: Fri, 14 Oct 2005 17:06:33 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com> <435017B2.7040107@cornell.edu> <435018F7.6070706@cornell.edu> <4350177F.7010600@tresys.com> <43501C38.5040907@cornell.edu>
In-Reply-To: <43501C38.5040907@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>> To put it another way.. this "direct-only" part does exist, but it's 
>>> hidden away.
>>> (into dbase_config_t -> dbase), which is an interface type. Then the 
>>> method table
>>> (dbase_config_t->dtable) specifies how to access it, which is 
>>> equivalent to your
>>> function table for modules.
>>
>>
>> The direct-only part needs to exist. The handle is becoming very 
>> cluttered with stuff that should not be there.
> 
> You don't seem to realize that those databases need to exist, whether or 
> not you're using the policy server, or the direct api.
> This is just another way to switch between the two.
> 
The policy server can't fill in these databases since there are 
permission checks it would need to do for the queries.

>>>
>>> In fact, I want to convert your modules functions into a database 
>>> too, but
>>> I haven't gotten to it yet, and this isn't high priority.
>>>
>> Why? This doesn't solve any problem.
> 
> For consistency, if nothing else... I think there are benefits to hiding 
> data collections under a uniform interface, but I don't want to get into 
> that right now - I sent Karl a long email some time ago. I know he's not 
> convinced, but it's just my pet project.
> 
this is a library being used by many people, I don't know that adding 
things for the sake of adding them is appropriate.

> Like I said, I won't be doing that yet.
> 
>>> So...basically I have multiple backend-specific portions, distributed 
>>> by functionality,
>>> rather than putting it all into one big table of function pointers 
>>> that aren't related.
>>
>>
>> the backend-specific portions should be hidden in a backend specific 
>> handle. This means that semanage_handle_t does *not* contain *any* 
>> backend specific information, all backend specific information would 
>> be in semanage_direct_handle, semanage_ps_handle, and so on.
> 
> The handle does not contain anything backend specific currently. Please 
> give an example of something backend specific.

The subject of this email is "Add a few direct dbases to handle". Does 
direct mean something different from a direct connection?

Also:

+
+#define DBASE_BASE_USERS      5
+#define DBASE_BASE_PORTS      6
+#if 0
+#define DBASE_BASE_INTERFACES 7
+#define DBASE_BASE_BOOLEANS   8
+#endif

What are these? How are they different from the other user, ports, 
interfaces, booleans. Why isn't this described in the code or even email?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
