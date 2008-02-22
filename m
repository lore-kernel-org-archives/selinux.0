Message-ID: <47BE1DDA.4040203@manicmethod.com>
Date: Thu, 21 Feb 2008 19:56:58 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: How would I go about figuring out if two SELinux MLS	Levels	intersect?
References: <47BB5488.1070008@redhat.com>	 <1203528302.9902.226.camel@moss-spartans.epoch.ncsc.mil>	 <1203528489.9902.230.camel@moss-spartans.epoch.ncsc.mil>	 <47BC6DCE.4040203@manicmethod.com> <1203531592.9902.234.camel@moss-spartans.epoch.ncsc.mil> <47BDE410.1020205@trustedcs.com>
In-Reply-To: <47BDE410.1020205@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Stephen Smalley wrote:
>> On Wed, 2008-02-20 at 13:13 -0500, Joshua Brindle wrote:
>>> Stephen Smalley wrote:
>>>> On Wed, 2008-02-20 at 12:25 -0500, Stephen Smalley wrote:
>>>>  
>>>>> On Tue, 2008-02-19 at 17:13 -0500, Daniel J Walsh wrote:
>>>>>    
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA1
>>>>>>
>>>>>> s2:c0-s2:c0.c10 and s2:c9.c10
>>>>>>
>>>>>>
>>>>>> IE How do I do the arbitration/dominance math in Code?
>>>>>>       
>>>>> (cc'ing the list)
>>>>>
>>>>> You can model it as a permission check between the two contexts, and
>>>>> then write a MLS constraint in policy that requires dominance or
>>>>> whatever relationship you want.  Then it is just an avc_has_perm 
>>>>> call.
>>>>> Same thing that we did for permission check in the pam_selinux 
>>>>> code to
>>>>> verify that the user's level is within his range.  Or what we talked
>>>>> about for applying a permission check in mcstransd to see if the
>>>>> requestor is allowed to translate the context.  Not sure that ever 
>>>>> got
>>>>> implemented in mcstransd though?
>>>>>     
>
> I think this is what you are referring to:
>
> http://marc.info/?l=selinux&m=116110364714182&w=2
>
> It doesn't look like that ever got incorporated into mcstransd.  
> However, the
> policy support is there.
>
>>>> Also, just to note:  the MLS dominance logic already exists within
>>>> libsepol and within the kernel security server.  We just have to 
>>>> expose
>>>> it via an interface.  One way to do that is to express it as a
>>>> permission check, where we already have an interface.  Another way 
>>>> would
>>>> be to introduce a new interface specifically for that purpose.
>>>>   
>>> I strongly disagree with exporting the security server logic in this 
>>> way, that will just encourage people to implement blp in their 
>>> application instead of using the security server interface to do 
>>> permission checking. This is based off what I've seen people trying 
>>> to do, even within the SELinux community, with respect to MLS.
>>
>> Well, as I said, one way to do it is via a permission checking
>> interface, and that is what we've done for the user level validation in
>> pam_selinux and what we proposed for mcstransd.
>>
>> Where that may break down is when you want to actually order a set of
>> contexts.  Dave Quigley ran into that in his work to provide a union
>> view of a polyinstantiated directory and wanted to be able to decide
>> which instance should be the default when there is a conflict in names.
>> There you may need an actual MLS dominance interface.  Which is
>> MLS-specific, yes, but there will be such applications even if we keep
>> them minimized.
>
> The domination check can be faked just like it is in the mcstransd patch.
> The big problem is that TE complicates the process.
>
> Let's say we have an "mls" security class with the permissions "dom",
> "domby", "eq", and "incomp" along with the following mls constraints:
>
> mlsconstrain mls dom
>     (l1 dom l2);
>
> mlsconstrain mls domby
>     (l1 domby l2);
>
> mlsconstrain mls eq
>     (l1 eq l2);
>
> mlsconstrain mls incomp
>     (l1 incomp l2);
>
> You can implement a routine in you app that will create fake contexts
> like know_user:known_role:known_type:LEVEL1 and
> know_user:known_role:known_type:LEVEL2 where LEVEL1 and LEVEL2 are the
> levels you want to compare and make the appropriate avc call to determine
> the relationship.  The the non-mls portions of the context must be set up
> so that the contexts are valid and TE will never fail for the operations
> on the mls class.  The mcstrand patch did such faking.  This works, but
> it is not a very elegant solution to the problem.  You can probably
> find existing mlsconstraints on various classes to meet your needs 
> without
> the "mls" class.  Note that this is policy dependent and does not work
> in permissive mode (they will all pass then and your levels will be
> incomparable and equal at the same time).
>
> Ordering can be done with a whole lot of comparisons if your set of 
> levels
> does not contain disjoint categories (no incomparables)...
>
> You can also take advantage of the format of the raw mls context to 
> create
> mls structures and write a function to do the comparisons on those, 
> but that
> would be *very* dependent on the mls definitions in the policy and 
> therefore
> risky.  It completely blows away the abstraction.  I actually feel bad 
> for
> even mentioning that, but there it is.
>
:) I feel bad for you mentioning it too..

I guess from what you and Steve have said something like this is 
necessary and if its necessary I'd rather us not hack around it. It 
sounds like the interface that is required is something to order 
contexts based on sensitivity. This, ofcourse, would not be suitable for 
the mcstransd patch. The mcstransd patch should use the full subject 
context so that mls overrides still work correctly (or am thinking about 
this incorrectly).




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
