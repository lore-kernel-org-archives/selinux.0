Message-ID: <442882F5.5010506@cornell.edu>
Date: Mon, 27 Mar 2006 19:27:33 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Kevin Carr <kcarr@tresys.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov, SELinux-dev@tresys.com
Subject: Re: [RFC][PATCH] extending the libsepol API
References: <200603241724.k2OHOlNq024142@gotham.columbia.tresys.com>
In-Reply-To: <200603241724.k2OHOlNq024142@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> imagine a user
> down the line wants a swig wrapper for libsepol.  Function pointers are a
> bad idea to have in the API.
Is it fundamentally impossible to write a swig wrapper for a function 
pointer?
I'm not so sure about that...

>> But that doesn't mean that no user of the library will want to use
>> key-based interfaces for lookups, ala an encapsulated form of the
>> avtab_search interface, or that we shouldn't provide such interfaces.
>>     
>
> A key cannot be constructed for a rule that will return a single record.
> The key would contain all parts of the rule. 
That depends on your record representation and what you're trying to 
accomplish. Why can't a key be a (src_type, target_type, target_class) 
triple, with the different access vectors being part of the data? What 
do you imagine a "rule record" will look like?

The point of the key is to uniquely identify an object, for the purpose 
of add/remove/modify -type management interface. Maybe such an interface 
doesn't make sense in the case of rules - I'm not sure of what 
higher-level goals you have. When I was thinking about writing a "rule 
record" my goal was to support small changes to policy that users might 
want to do - that was later superceded by loadable modules, so I didn't 
have to worry about rule records - the module became the record instead, 
as the unit of management.

> As I said, reimplementing these functions with new ones will allow these
> functions to continue working.
Which functions exactly are being discussed for deprecation? You want to 
replace the _iterate functions with an explicit iterator object?
Does it really matter which one is chosen - they do pretty much the same 
thing, don't they?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
