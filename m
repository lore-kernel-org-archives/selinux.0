Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LKsv6N028152
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 16:54:57 -0400
Message-ID: <467AE59E.2050501@tycho.nsa.gov>
Date: Thu, 21 Jun 2007 16:54:54 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Mark Goldman <mgoldman@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
References: <20070521095414.832619201@tresys.com>	 <20070521095518.515998898@tresys.com>	 <1179868119.9092.38.camel@localhost.localdomain>	 <1180015458.3930.173.camel@tresys-winxppro>	 <1180017921.2940.24.camel@localhost.localdomain>	 <1180034401.3930.203.camel@tresys-winxppro>	 <1180108369.6331.18.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>	 <1180137749.10334.18.camel@localhost.localdomain>	 <4677F1BC.2000201@tresys.com>	 <1182443353.11527.50.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>	 <1182449086.11527.80.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>	 <1182449898.11527.83.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com> <1182450900.11527.88.camel@localhost.localdomain>
In-Reply-To: <1182450900.11527.88.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Thu, 2007-06-21 at 14:25 -0400, Joshua Brindle wrote:
>> Karl MacMillan wrote:
>>> On Thu, 2007-06-21 at 14:09 -0400, Joshua Brindle wrote:
>>>> Karl MacMillan wrote:
>>>>> On Thu, 2007-06-21 at 12:49 -0400, Joshua Brindle wrote:
>>>>>> Karl MacMillan wrote:
>>>>>>> On Tue, 2007-06-19 at 11:09 -0400, Joshua Brindle wrote:
>>>>>>>> Karl MacMillan wrote:
>>>>>>>>> On Fri, 2007-05-25 at 13:06 -0400, Joshua Brindle wrote:
>>>>>>>>>> Karl MacMillan wrote:
>>>>>>>>>>>> If you would like to move the list types out of policyrep and
>>>>>>>>>>>> into trunk, I'll be happy to use it.  Otherwise it is out of
>>>>>>>>>>>> the scope of this patch. 
>>>>>>>>>>>>
>>>>>>>>>>> Please rebase against the policyrep branch - we can then
>>>>>>>>>>> consider merging the list types and this patch to trunk if
>>>>>>>>>>> desired. I will NACK this patch if it contains the
>>>>> additional list types.
>>>>>>>>>> There aren't additional list types because there aren't any in
>>>>>>>>>> trunk. This has nothing to do with policyrep and doesn't break
>>>>>>>>>> ABI compatibility and should be in trunk. I hate this idea of
>>>>>>>>>> pushing everything into policyrep because its going to make it
>>>>>>>>>> that much harder to get good testing done and the source of
>>>>>>>>>> bugs will be harder to track down.
>>>>>>>>>>
>>>>>>>>> Ok.
>>>>>>>>>
>>>>>>>>>> If you are so insistent on using the list types in policyrep
>>>>>>>>>> why not port them to trunk so we can use them?
>>>>>>>>> That option is fine with me (and was one of my suggestions),
>>>>>>>>> though I don't have time to do the port right now. Can you or
>>>>>>>>> Mark send a patch pulling over the iterators and list?
>>>>>>>> I'm going to bring this back up because I think this patch is
>>>>>>>> important to get into upstream as a first step toward generic
>>>>>>>> label generation. 
>>>>>>>>
>>>>>>> Can you tell me a little more about what you are thinking with
>>>>>>> this? 
>>>>>>>
>>>>> ??
>>>>>
>>>> We need labels for various object managers (like policy server)
>>>> generated per user. For example, if you look back at the PoC apache
>>>> metapolicy you'll see some hardcoded labels like user_apache_types_t
>>>> and so on, these need to be generated for each user.
>>>>
>>>>
>>>>>>>> Since we aren't using the policyrep branch anymore and
>>>>>>>> libpolicyrep is going to be in c++ do you still have
>>>>>>>> reservations against this patch? 
>>>>>>>>
>>>>>>> I'm still convinced about the maintenance long term and potential
>>>>>>> for errors. Have all of the implementation issues that James
>>>>>>> brought up been resolved? Remind me why this is better in C than
>>>>>>> in an external Python helper. 
>>>>>>>
>>>>>> Its very hacky, we have to close the current transaction (from
>>>>>> within the library) so that genhomedircon can connect and get a
>>>>>> read lock on the newly created active store and then it modifies
>>>>>> the files outside of the module store, non-ideal in almost every
>>>>>> way. 
>>>>>>
>>>>> Why does it need to get the read lock - why can't it be changed to
>>>>> take the sandbox location and work on that directly? Fixing that
>>>>> might be better long term as it seems advantageous to allow helper
>>>>> programs in general (for separation and least-privilege).
>>>>>
>>>> Work directly on the module store? The module store is a private
>>>> resource of libsemanage, applications should not modify it directly
>>>> outside of libsemanage.
>>> genhomedircon is part of libsemanage - it just runs in a
>>> separate process. IOW it is just an implementation detail.
>>>
>> Not to mention running a python interpreter from a library is pretty
>> lame.
> 
> Why? It's less lame than doing this string manipulation in C if you ask
> me. Not to mention safer - the kind of string manipulation done for this
> is perhaps the biggest source of exploitable flaws in software.

I'm going to do the unthinkable and agree with Josh, I think the 
solution to this is to write correct code, not to give up and use a 
scripting language.  I'm not a fan of the Python dependencies.

> 
> [...]
> 
>>> Think about a process to verify untrusted data (like modules)
>>> - it would be helpful to allow a separate process to examine
>>> that data. Yes things like semodule will have full access but
>>> allowing a lower-privileged process to handle some parts is desirable
>>> in my opinion. 
>> We already have a facility to run external apps that can do that. In
>> semanage.conf just do:
>>
>> [verify module]
>> path=/some/path/to/checker
>> [end]
>>
>> Which has nothing to do with genhomedircon, genhomedircon is mutating
>> the store, we should not be providing a facility to let random programs
>> mutate the store arbitrarilly.
> 
> My point (that seems to be getting lost) is that genhomedircon is not an
> arbitrary program. It's just part of libsemanage. Why shouldn't we allow
> separate processes to mutate the store if they are built-in to
> libsemanage?

Running helpers from a library is IMO a bad idea, because it's not easy 
to completely insulate helper processes from the caller.  Caller could 
get unexpected results from an ill-timed wait(2) call for example, or 
not be expecting strange things in its process tree.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
