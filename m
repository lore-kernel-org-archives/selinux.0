Message-ID: <49CD1710.6000108@manicmethod.com>
Date: Fri, 27 Mar 2009 14:12:32 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com>
In-Reply-To: <49CD12CD.1000205@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> 
> Please don't take my lack of asking for new object classes as anything 
> other than ignorance as to how things "work" in the open source 
> community. All of our previous work has been on proprietary MLS systems. 
> The idea of asking an OS vendor or community to add features for my 
> needs was foreign to me. Plus, my time constraints on the project may 
> not have allowed it. I have found this community to be very open and 
> helpful and always planned to give some input as to the need for these 
> object classes after my project was finished (which is now).
>>   

Fair enough. I'm happy to see additional efforts in this arena, regardless.

>>> So, internally, the access checks on the database and catalog are 
>>> performed when those objects are opened. During the actual create table 
>>> operation we have two calls to avc_has_perm, the first checks the 
>>> client's context, schema's context for dir {search add_name} and the 
>>> second checks the client's context, table's context for db_table {create}
>>>
>>> Could you elaborate on what you mean by "I don't think it is a good idea 
>>> to muddle the object
>>> class ownership concept by doing checks for classes which are owned by 
>>> another
>>> object manager" ? In what way is an object class *owned* by an object 
>>> manager? I'm a newbie in this area and would appreciate some 
>>> constructive criticism.
>>>
>>>     
>>
>> So, overloading object classes leads to confusion and other issues. For example,
>> if an actual directory got labeled what the internal catalog was labeled then
>> the client would have access to that, even if that wasn't the intention. There
>> also may be conflicting type_transition rules because you end up wanting one
>> object label transition to be different from another when used on the different
>> kinds of objects.
>>   
> Yep, I can see that as an issue. Practically speaking, I would think the 
> new object classes will be added before any such real issue arose. But, 
> isn't there a similar issue, say, between a system with a sepostres 
> policy and a Trusted RUBIX installation on the same platform? I have 
> already bumped up against some of the type_transition rules for sepostgres.
>> The flask architecture was originally implemented in a microkernel where object
>> managers were services that enforced access per the security servers decision.
>> In that architecture an object manager would be responsible for the object class
>> it was enforcing access on. Stephen can correct me here if I'm wrong but I
>> object to object class overloading based on these issues.
>>   
> 

You shouldn't really bump in to each other since the dbms domain and objects
should all be labeled differently, what have you seen happen?

> In your terminology, because rubix is enforcing the policy, would it be 
> considered an object manager? And, if so, wouldn't seposgres also be 
> considered one? where they both enforce access to the same set of object 
> classes?

Yes, both rubix and sepostgres are object managers. abstract object classes
where there isn't a single owner are interesting, I'd expect different object
labeling in most cases so it doesn't matter. In the case of the data in both
being equivalent from a security POV maybe it actually does make sense for them
to share labels and object classes (especially true if the database is primarily
enforcing an MLS policy)

>>   
>>>> Were the db object classes incomplete for you so you needed to use filesystem
>>>> object classes? I'm trying to get a feeling for what the motivation was behind
>>>> these checks.
>>>>   
>>>>       
>>> Yes, if the db object classes supported schema and catalog I would not 
>>> use the dir. I'm not sure what to say for motivation, other than I felt 
>>> it important and useful to have security checks on our catalog and 
>>> schemata. And, since these objects function very closely to an OS 
>>> directory, and there was no support for the catalog and schema objects 
>>> in the selinux policy, and I decided not to modify the targeted/mls 
>>> policies as part of our release, I chose to use the dir object class. 
>>> Actually, I think I got the idea from an old post on this newsgroup. The 
>>> options presented in that post were to either modify the policy's object 
>>> class and permissions or overload a pre-existing object class. I chose 
>>> the latter. It was the lesser of two evils. I didn't  want to have to 
>>> keep up with updates to the targeted/mls policies.
>>>     
>>
>> See above, you brought up another issue here where permissions being overloaded
>> may not have the same read/write mappings and therefore may be difficult to work
>> around with respect to the MLS policy. Approaching the community to work on a
>> common set of object classes/perms and getting them merged in to upstream
>> refpolicy is definitely the right answer.
>>   
> I agree completely.
>>   
>>>> Is Trusted RUBIX with these SELinux checks actually released, are the access
>>>> checks set in stone? I'd like to see as much consistency between dbms object
>>>> models as possible so that policy won't be dramatically different between them.
>>>>   
>>>>       
>>> Yes, Trusted RUBIX with these security checks is released. But no, they 
>>> are not set in stone. The minute a new policy is released supporting the 
>>> db_schema and db_catalog object classes will be the time I change our 
>>> product to use them, and stop using the dir object class.
>>>
>>>     
>>
>> Good. Hopefully we can get this worked out between you guys and have a
>> consistent (and documented) set of permissions that make it easy to write policy
>> that works on both systems (as much as possible)
>>   
> I think that is well on its way. One question out of curiosity. Would 
> you anticipate that I should or would use the seposgres TE rules that 
> already exist in the targeted/mls policy? I ask that from your comment 
> about writing policy that that works on both systems. With current state 
> of things this seems very difficult, though, I think a higher level 
> interface set, like the one we created for the object set, could be made 
> that, for the most part, worked for both systems.
>>   

Yes, I don't mean they'd be using an identical policy but shared
templates/interfaces that worked with both would certainly make it easier to
target both systems without really needing to know the intricacies of each
systems enforcement.

>>> To my knowledge there are only two DBMS's that integrate SELinux into 
>>> its product, SEPostgresql and Trusted RUBIX. I'm not so sure I would say 
>>> our DBMS object models are dramatically different.  SEPostgresql does 
>>> not have a catalog object and chose not to have selinux control over 
>>> their schema object. From looking at KaiGai's work and posts I think in 
>>> the future they will support the schema object, in much the same way I 
>>> tried to in our current release.
>>>     
>>
>> They chose not to for now, the initial set of permissions used by SEPostgres
>> looks like it is going to be minimal, unfortunately, but should evolve into
>> something more comprehensive.
>>
>> I may be missing it but do you support 'domain-like' type_transitions for stored
>> procedures? This was one of the more interesting features in the initial
>> sepostgres patches IMHO because it allowed for trusted stored procedures that
>> can read tables the client couldn't necessarily read, and could do operations on
>> them before handing over the data (eg., fuzzing of coordinates)
>>   
> We do not implement stored procedures at all, though this is a near 
> future possibility. As I said before, our background is MLS and often in 
> the EAL-5+ type (old B3). The group-think was always that stored 
> procedures were too insecure for such assurance levels. But, I have been 
> pushing the possibility in a EAL-4 type mode, for exactly the reasons 
> you mentioned above. With the selinux domain transition concept a stored 
> procedure becomes very interesting.
>> --


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
