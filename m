Message-ID: <47F4EB6F.3040605@tresys.com>
Date: Thu, 03 Apr 2008 10:36:31 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Need to break or reduce the dependency on a static libsepol
References: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B0158801CD201C@exchange.columbia.tresys.com>	 <47F3E4FE.10607@tresys.com>	 <1207230951.27710.164.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B0158801CD2280@exchange.columbia.tresys.com> <1207232115.27710.177.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207232115.27710.177.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-04-03 at 10:06 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Wed, 2008-04-02 at 15:56 -0400, Joshua Brindle wrote:
>>>> Joshua Brindle wrote:
>>>>> Stephen Smalley wrote:
>>>>>> This is likely my fault, but we're encountering increasing problems
>>>>>> from growth in the set of things that depend on the static libsepol
>>>>>> whenever we make a change to libsepol, particularly a policy
>>>>>> version change.  We now have (at least) the following dependencies
>>>>>> on it: checkpolicy (always true, not likely to go away) libselinux
>>>>>> (for the audit2why python binding module, which used to be its own
>>>>>> utility in policycoreutils) setools
>>>>>>
>>>>>> Does slide also have this dependency or is it clean? Anything else
>>>>>> to worry about? 
>>>>>>
>>>>>> The result is that when a newer libsepol gets incorporated and
>>>>>> libselinux or setools does not, we encounter breakage (unable to
>>>>>> find a policy file they can read or unable to read the policy file
>>>>>> at which they are pointed) or confusion (reading an older policy
>>>>>> file left around from before the libsepol update) upon trying to
>>>>>> use audit2why or setools. 
>>>>>>
>>>>>> We ran into this problem twice in rawhide / F9, once upon the
>>>>>> policy capability support (policy.22) and now for permissive types
>>>>>> (policy.23). 
>>>>>>
>>>>>> Only real way forward that I can see it to actually encapsulate the
>>>>>> interfaces required by audit2why and setools so that they can use
>>>>>> the shared libsepol.
>>>>> One thing that we are doing for policyrep is encapsulating all the
>>>>> "add this kind of thing to a policydb" functionality because we
>>>>> didn't want policyrep users to be static libsepol users.
>>>>>
>>>>> This has multiple disadvantages including its huge, it is slow (7
>>>>> hash lookups to add an av rule currently, since its string based)
>>>>> and doesn't include the other functionality like the security
>>>>> server, query functions that would be required for audit2why and
>>>>> setools. 
>>>>>
>>>>> After going through that effort and seeing the pain first hand I
>>>>> honestly think it is a better alternative to forgo encapsulation and
>>>>> just make the policydb public. Not yet though, since we ripped out
>>>>> all the module stuff in it for policyrep. Since it is returning to a
>>>>> more pristine state that can't realistically change much in the
>>>>> future maybe it would be better for everyone to rip out the
>>>>> encapsulation as well. 
>>>>>
>>>> What are your thoughts on this Steve? Karl agrees with me, the
>>>> encapsulation we have is pretty fake in some places (eg., the
>>>> interface between libsemanage and libsepol) and doesn't help in most
>>>> others. The shared interfaces for everything in libsepol will be
>>>> _huge_, the ones we wrote for policyrep were huge by themselves.
>>>>
>>>> I think libsepol should be the library that knows how to read and
>>>> write a policydb, maybe has a security server implementation but
>>>> otherwise lets people manipulate the policydb however they wish. It
>>>> would make the library much smaller, get rid of the need to
>>>> statically build and be much less work in the long run.
>>>>
>>>> I still think we need to wait until the wide sweeping policyrep
>>>> changes since they remove all the module junk from policydb but after
>>>> that (or perhaps at the same time?) we should just make policydb
>>>> public and slowly remove the unneeded encapsulation.
>>> Well, you know how I feel about encapsulation in general ;)
>>>
>>> But what I am not clear about is how we would maintain a
>>> stable ABI for libsepol if we exposed the policydb and its
>>> child data structures directly to the users.  Think back to recent
>>> changes (or any of the changes) we've made to the policydb over time,
>>> such as the permissive type changes, the policy capabilities changes,
>>> the pending user transition changes, etc.  How would we have done
>>> that in a way that preserved a stable libsepol ABI if the policydb
>>> had been exposed? 
>>>
>> Adding these things to the bottom of the struct (which we did) ensures
>> no offsets change and the ABI continues to work as expected, no problems
>> there..
> 
> Not so clear to me.  If the policydb and its sub-structures were public,
> and an application or another library directly allocated one itself on
> the stack or on the heap, and passed it in as an argument to a libsepol
> function, then if we later add fields to the end of the structure and
> libsepol tries to access those fields on an input argument, things will
> go boom.  I think we'd have to version the data structures themselves,
> and on all of them, not just the policydb.  And not all changes are
> purely additive, e.g. the optimization of the avtab comes to mind.
> 

So the policydb that can be put on the stack would just have a pointer 
to the real policydb struct and problem solved. I'm thinking about the 
need to version all the sub structs.. This has got to be doable, how do 
people do it elsewhere?

>> OTOH, maintaining legacy interfaces whose usefulness has passed is much
>> worse.
> 
> Yes, that is certainly a problem we have presently, as shown in the
> legacy setlocaldefs support for booleans and users.
> 
>>> I guess I need to go back and read Ulrich's paper again.

Fair enough, maybe I'll take a look as well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
