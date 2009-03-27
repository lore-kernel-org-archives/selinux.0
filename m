Message-ID: <49CD1F74.9030906@rubix.com>
Date: Fri, 27 Mar 2009 19:48:20 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com>
In-Reply-To: <49CD1710.6000108@manicmethod.com>
Content-Type: multipart/alternative;
 boundary="------------050502030603020404000003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050502030603020404000003
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



Joshua Brindle wrote:
> Andy Warner wrote:
>   
>> Please don't take my lack of asking for new object classes as anything 
>> other than ignorance as to how things "work" in the open source 
>> community. All of our previous work has been on proprietary MLS systems. 
>> The idea of asking an OS vendor or community to add features for my 
>> needs was foreign to me. Plus, my time constraints on the project may 
>> not have allowed it. I have found this community to be very open and 
>> helpful and always planned to give some input as to the need for these 
>> object classes after my project was finished (which is now).
>>     
>>>   
>>>       
>
> Fair enough. I'm happy to see additional efforts in this arena, regardless.
>
>   
>>>> So, internally, the access checks on the database and catalog are 
>>>> performed when those objects are opened. During the actual create table 
>>>> operation we have two calls to avc_has_perm, the first checks the 
>>>> client's context, schema's context for dir {search add_name} and the 
>>>> second checks the client's context, table's context for db_table {create}
>>>>
>>>> Could you elaborate on what you mean by "I don't think it is a good idea 
>>>> to muddle the object
>>>> class ownership concept by doing checks for classes which are owned by 
>>>> another
>>>> object manager" ? In what way is an object class *owned* by an object 
>>>> manager? I'm a newbie in this area and would appreciate some 
>>>> constructive criticism.
>>>>
>>>>     
>>>>         
>>> So, overloading object classes leads to confusion and other issues. For example,
>>> if an actual directory got labeled what the internal catalog was labeled then
>>> the client would have access to that, even if that wasn't the intention. There
>>> also may be conflicting type_transition rules because you end up wanting one
>>> object label transition to be different from another when used on the different
>>> kinds of objects.
>>>   
>>>       
>> Yep, I can see that as an issue. Practically speaking, I would think the 
>> new object classes will be added before any such real issue arose. But, 
>> isn't there a similar issue, say, between a system with a sepostres 
>> policy and a Trusted RUBIX installation on the same platform? I have 
>> already bumped up against some of the type_transition rules for sepostgres.
>>     
>>> The flask architecture was originally implemented in a microkernel where object
>>> managers were services that enforced access per the security servers decision.
>>> In that architecture an object manager would be responsible for the object class
>>> it was enforcing access on. Stephen can correct me here if I'm wrong but I
>>> object to object class overloading based on these issues.
>>>   
>>>       
>
> You shouldn't really bump in to each other since the dbms domain and objects
> should all be labeled differently, what have you seen happen?
>   
KaiGai and I talked about this a bit already, and I'll preface my
response by saying that my memory of it is poor. Also, this issue was
one of my first practical introductions to selinux, so I'm sure I was
shooting in the dark. But, the main issue revolved around the type
transition rule for the database object. It seems to me, what makes it
special is that it has no parent object. It seems equivalent to writing
a type transition rule for creating the OS root directory, except in our
DBMS case we can have more than one type (each dbms has their own).

A rule for sepostgres is:

type_transition sepgsql_client_type sepgsql_client_type : db_database
sepgsql_db_t;

Where I believe the standard user_t and such had the sepgsql_client_type
attribute. So, with that rule in place I think it was impossible for
rubix to have a similar rule, if our client_type's overlapped. Which
seems likely, as the user_t is a likely candidate for a client. For
instance, if I did this:

type_transition rubix_client_type rubix_client_type : db_database
rubix_db_t; (where rubix_client_type contained user_t)

I think it would not compile because its ambiguous, right? So, what I
did was write a rule like this:

type_transition rubix_client_type rubix_t : db_database rubix_db_t;

and hard-coded the rubix_t into the avc_compute_create call. The rubix_t
is actually the type of our server process. Prior to doing that, I could
not find a way to not have a database be created with a sepgsql_t type.

I see (now) that the reference policy also has the rule:

type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;

Obviously, the above would never conflict with another dbms's rules. If
that single type transition rule satisfied all of seposgresql's needs,
then that would eliminate the need for the conflicting rule. Though, I
assume thats dependent on the internals of seposgresql.
>   
>> In your terminology, because rubix is enforcing the policy, would it be 
>> considered an object manager? And, if so, wouldn't seposgres also be 
>> considered one? where they both enforce access to the same set of object 
>> classes?
>>     
>
> Yes, both rubix and sepostgres are object managers. abstract object classes
> where there isn't a single owner are interesting, I'd expect different object
> labeling in most cases so it doesn't matter. In the case of the data in both
> being equivalent from a security POV maybe it actually does make sense for them
> to share labels and object classes (especially true if the database is primarily
> enforcing an MLS policy)
>
>   
>>>   
>>>       
>>>>> Were the db object classes incomplete for you so you needed to use filesystem
>>>>> object classes? I'm trying to get a feeling for what the motivation was behind
>>>>> these checks.
>>>>>   
>>>>>       
>>>>>           
>>>> Yes, if the db object classes supported schema and catalog I would not 
>>>> use the dir. I'm not sure what to say for motivation, other than I felt 
>>>> it important and useful to have security checks on our catalog and 
>>>> schemata. And, since these objects function very closely to an OS 
>>>> directory, and there was no support for the catalog and schema objects 
>>>> in the selinux policy, and I decided not to modify the targeted/mls 
>>>> policies as part of our release, I chose to use the dir object class. 
>>>> Actually, I think I got the idea from an old post on this newsgroup. The 
>>>> options presented in that post were to either modify the policy's object 
>>>> class and permissions or overload a pre-existing object class. I chose 
>>>> the latter. It was the lesser of two evils. I didn't  want to have to 
>>>> keep up with updates to the targeted/mls policies.
>>>>     
>>>>         
>>> See above, you brought up another issue here where permissions being overloaded
>>> may not have the same read/write mappings and therefore may be difficult to work
>>> around with respect to the MLS policy. Approaching the community to work on a
>>> common set of object classes/perms and getting them merged in to upstream
>>> refpolicy is definitely the right answer.
>>>   
>>>       
>> I agree completely.
>>     
>>>   
>>>       
>>>>> Is Trusted RUBIX with these SELinux checks actually released, are the access
>>>>> checks set in stone? I'd like to see as much consistency between dbms object
>>>>> models as possible so that policy won't be dramatically different between them.
>>>>>   
>>>>>       
>>>>>           
>>>> Yes, Trusted RUBIX with these security checks is released. But no, they 
>>>> are not set in stone. The minute a new policy is released supporting the 
>>>> db_schema and db_catalog object classes will be the time I change our 
>>>> product to use them, and stop using the dir object class.
>>>>
>>>>     
>>>>         
>>> Good. Hopefully we can get this worked out between you guys and have a
>>> consistent (and documented) set of permissions that make it easy to write policy
>>> that works on both systems (as much as possible)
>>>   
>>>       
>> I think that is well on its way. One question out of curiosity. Would 
>> you anticipate that I should or would use the seposgres TE rules that 
>> already exist in the targeted/mls policy? I ask that from your comment 
>> about writing policy that that works on both systems. With current state 
>> of things this seems very difficult, though, I think a higher level 
>> interface set, like the one we created for the object set, could be made 
>> that, for the most part, worked for both systems.
>>     
>>>   
>>>       
>
> Yes, I don't mean they'd be using an identical policy but shared
> templates/interfaces that worked with both would certainly make it easier to
> target both systems without really needing to know the intricacies of each
> systems enforcement.
>   
Sounds like a good goal.
>   
>>>> To my knowledge there are only two DBMS's that integrate SELinux into 
>>>> its product, SEPostgresql and Trusted RUBIX. I'm not so sure I would say 
>>>> our DBMS object models are dramatically different.  SEPostgresql does 
>>>> not have a catalog object and chose not to have selinux control over 
>>>> their schema object. From looking at KaiGai's work and posts I think in 
>>>> the future they will support the schema object, in much the same way I 
>>>> tried to in our current release.
>>>>     
>>>>         
>>> They chose not to for now, the initial set of permissions used by SEPostgres
>>> looks like it is going to be minimal, unfortunately, but should evolve into
>>> something more comprehensive.
>>>
>>> I may be missing it but do you support 'domain-like' type_transitions for stored
>>> procedures? This was one of the more interesting features in the initial
>>> sepostgres patches IMHO because it allowed for trusted stored procedures that
>>> can read tables the client couldn't necessarily read, and could do operations on
>>> them before handing over the data (eg., fuzzing of coordinates)
>>>   
>>>       
>> We do not implement stored procedures at all, though this is a near 
>> future possibility. As I said before, our background is MLS and often in 
>> the EAL-5+ type (old B3). The group-think was always that stored 
>> procedures were too insecure for such assurance levels. But, I have been 
>> pushing the possibility in a EAL-4 type mode, for exactly the reasons 
>> you mentioned above. With the selinux domain transition concept a stored 
>> procedure becomes very interesting.
>>     
>>> --
>>>       
>
>
>   

--------------050502030603020404000003
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-2022-JP"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Joshua Brindle wrote:
<blockquote cite="mid:49CD1710.6000108@manicmethod.com" type="cite">
  <pre wrap="">Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">
Please don't take my lack of asking for new object classes as anything 
other than ignorance as to how things "work" in the open source 
community. All of our previous work has been on proprietary MLS systems. 
The idea of asking an OS vendor or community to add features for my 
needs was foreign to me. Plus, my time constraints on the project may 
not have allowed it. I have found this community to be very open and 
helpful and always planned to give some input as to the need for these 
object classes after my project was finished (which is now).
    </pre>
    <blockquote type="cite">
      <pre wrap="">  
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
Fair enough. I'm happy to see additional efforts in this arena, regardless.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">So, internally, the access checks on the database and catalog are 
performed when those objects are opened. During the actual create table 
operation we have two calls to avc_has_perm, the first checks the 
client's context, schema's context for dir {search add_name} and the 
second checks the client's context, table's context for db_table {create}

Could you elaborate on what you mean by "I don't think it is a good idea 
to muddle the object
class ownership concept by doing checks for classes which are owned by 
another
object manager" ? In what way is an object class *owned* by an object 
manager? I'm a newbie in this area and would appreciate some 
constructive criticism.

    
        </pre>
      </blockquote>
      <pre wrap="">So, overloading object classes leads to confusion and other issues. For example,
if an actual directory got labeled what the internal catalog was labeled then
the client would have access to that, even if that wasn't the intention. There
also may be conflicting type_transition rules because you end up wanting one
object label transition to be different from another when used on the different
kinds of objects.
  
      </pre>
    </blockquote>
    <pre wrap="">Yep, I can see that as an issue. Practically speaking, I would think the 
new object classes will be added before any such real issue arose. But, 
isn't there a similar issue, say, between a system with a sepostres 
policy and a Trusted RUBIX installation on the same platform? I have 
already bumped up against some of the type_transition rules for sepostgres.
    </pre>
    <blockquote type="cite">
      <pre wrap="">The flask architecture was originally implemented in a microkernel where object
managers were services that enforced access per the security servers decision.
In that architecture an object manager would be responsible for the object class
it was enforcing access on. Stephen can correct me here if I'm wrong but I
object to object class overloading based on these issues.
  
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
You shouldn't really bump in to each other since the dbms domain and objects
should all be labeled differently, what have you seen happen?
  </pre>
</blockquote>
KaiGai and I talked about this a bit already, and I'll preface my
response by saying that my memory of it is poor. Also, this issue was
one of my first practical introductions to selinux, so I'm sure I was
shooting in the dark. But, the main issue revolved around the type
transition rule for the database object. It seems to me, what makes it
special is that it has no parent object. It seems equivalent to writing
a type transition rule for creating the OS root directory, except in
our DBMS case we can have more than one type (each dbms has their own).
<br>
<br>
A rule for sepostgres is:<br>
<br>
type_transition sepgsql_client_type sepgsql_client_type : db_database
sepgsql_db_t;<br>
<br>
Where I believe the standard user_t and such had the
sepgsql_client_type attribute. So, with that rule in place I think it
was impossible for rubix to have a similar rule, if our client_type's
overlapped. Which seems likely, as the user_t is a likely candidate for
a client. For instance, if I did this:<br>
<br>
type_transition rubix_client_type rubix_client_type : db_database
rubix_db_t; (where rubix_client_type contained user_t)<br>
<br>
I think it would not compile because its ambiguous, right? So, what I
did was write a rule like this:<br>
<br>
type_transition rubix_client_type rubix_t : db_database rubix_db_t;<br>
<br>
and hard-coded the rubix_t into the avc_compute_create call. The
rubix_t is actually the type of our server process. Prior to doing
that, I could not find a way to not have a database be created with a
sepgsql_t type.<br>
<br>
I see (now) that the reference policy also has the rule:<br>
<br>
type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;<br>
<br>
Obviously, the above would never conflict with another dbms's rules. If
that single type transition rule satisfied all of seposgresql's needs,
then that would eliminate the need for the conflicting rule. Though, I
assume thats dependent on&nbsp; the internals of seposgresql. <br>
<blockquote cite="mid:49CD1710.6000108@manicmethod.com" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">In your terminology, because rubix is enforcing the policy, would it be 
considered an object manager? And, if so, wouldn't seposgres also be 
considered one? where they both enforce access to the same set of object 
classes?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, both rubix and sepostgres are object managers. abstract object classes
where there isn't a single owner are interesting, I'd expect different object
labeling in most cases so it doesn't matter. In the case of the data in both
being equivalent from a security POV maybe it actually does make sense for them
to share labels and object classes (especially true if the database is primarily
enforcing an MLS policy)

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">  
      </pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">Were the db object classes incomplete for you so you needed to use filesystem
object classes? I'm trying to get a feeling for what the motivation was behind
these checks.
  
      
          </pre>
        </blockquote>
        <pre wrap="">Yes, if the db object classes supported schema and catalog I would not 
use the dir. I'm not sure what to say for motivation, other than I felt 
it important and useful to have security checks on our catalog and 
schemata. And, since these objects function very closely to an OS 
directory, and there was no support for the catalog and schema objects 
in the selinux policy, and I decided not to modify the targeted/mls 
policies as part of our release, I chose to use the dir object class. 
Actually, I think I got the idea from an old post on this newsgroup. The 
options presented in that post were to either modify the policy's object 
class and permissions or overload a pre-existing object class. I chose 
the latter. It was the lesser of two evils. I didn't  want to have to 
keep up with updates to the targeted/mls policies.
    
        </pre>
      </blockquote>
      <pre wrap="">See above, you brought up another issue here where permissions being overloaded
may not have the same read/write mappings and therefore may be difficult to work
around with respect to the MLS policy. Approaching the community to work on a
common set of object classes/perms and getting them merged in to upstream
refpolicy is definitely the right answer.
  
      </pre>
    </blockquote>
    <pre wrap="">I agree completely.
    </pre>
    <blockquote type="cite">
      <pre wrap="">  
      </pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">Is Trusted RUBIX with these SELinux checks actually released, are the access
checks set in stone? I'd like to see as much consistency between dbms object
models as possible so that policy won't be dramatically different between them.
  
      
          </pre>
        </blockquote>
        <pre wrap="">Yes, Trusted RUBIX with these security checks is released. But no, they 
are not set in stone. The minute a new policy is released supporting the 
db_schema and db_catalog object classes will be the time I change our 
product to use them, and stop using the dir object class.

    
        </pre>
      </blockquote>
      <pre wrap="">Good. Hopefully we can get this worked out between you guys and have a
consistent (and documented) set of permissions that make it easy to write policy
that works on both systems (as much as possible)
  
      </pre>
    </blockquote>
    <pre wrap="">I think that is well on its way. One question out of curiosity. Would 
you anticipate that I should or would use the seposgres TE rules that 
already exist in the targeted/mls policy? I ask that from your comment 
about writing policy that that works on both systems. With current state 
of things this seems very difficult, though, I think a higher level 
interface set, like the one we created for the object set, could be made 
that, for the most part, worked for both systems.
    </pre>
    <blockquote type="cite">
      <pre wrap="">  
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
Yes, I don't mean they'd be using an identical policy but shared
templates/interfaces that worked with both would certainly make it easier to
target both systems without really needing to know the intricacies of each
systems enforcement.
  </pre>
</blockquote>
Sounds like a good goal. <br>
<blockquote cite="mid:49CD1710.6000108@manicmethod.com" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">To my knowledge there are only two DBMS's that integrate SELinux into 
its product, SEPostgresql and Trusted RUBIX. I'm not so sure I would say 
our DBMS object models are dramatically different.  SEPostgresql does 
not have a catalog object and chose not to have selinux control over 
their schema object. From looking at KaiGai's work and posts I think in 
the future they will support the schema object, in much the same way I 
tried to in our current release.
    
        </pre>
      </blockquote>
      <pre wrap="">They chose not to for now, the initial set of permissions used by SEPostgres
looks like it is going to be minimal, unfortunately, but should evolve into
something more comprehensive.

I may be missing it but do you support 'domain-like' type_transitions for stored
procedures? This was one of the more interesting features in the initial
sepostgres patches IMHO because it allowed for trusted stored procedures that
can read tables the client couldn't necessarily read, and could do operations on
them before handing over the data (eg., fuzzing of coordinates)
  
      </pre>
    </blockquote>
    <pre wrap="">We do not implement stored procedures at all, though this is a near 
future possibility. As I said before, our background is MLS and often in 
the EAL-5+ type (old B3). The group-think was always that stored 
procedures were too insecure for such assurance levels. But, I have been 
pushing the possibility in a EAL-4 type mode, for exactly the reasons 
you mentioned above. With the selinux domain transition concept a stored 
procedure becomes very interesting.
    </pre>
    <blockquote type="cite">
      <pre wrap="">--
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------050502030603020404000003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
