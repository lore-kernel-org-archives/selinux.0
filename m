Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2S7Iuf2013963
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 03:18:56 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2S7EvCR026734
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 07:14:57 GMT
Message-ID: <49CDCF07.1020900@rubix.com>
Date: Sat, 28 Mar 2009 08:17:27 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: Joshua Brindle <method@manicmethod.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp>
In-Reply-To: <49CD687C.9080401@kaigai.gr.jp>
Content-Type: multipart/alternative;
 boundary="------------040807050504050602090209"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040807050504050602090209
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



KaiGai Kohei wrote:
> Joshua Brindle wrote:
>   
>> Andy Warner wrote:
>>     
>>>   
>>> KaiGai and I talked about this a bit already, and I'll preface my 
>>> response by saying that my memory of it is poor. Also, this issue was 
>>> one of my first practical introductions to selinux, so I'm sure I was 
>>> shooting in the dark. But, the main issue revolved around the type 
>>> transition rule for the database object. It seems to me, what makes it 
>>> special is that it has no parent object. It seems equivalent to writing 
>>> a type transition rule for creating the OS root directory, except in our 
>>> DBMS case we can have more than one type (each dbms has their own).
>>>
>>> A rule for sepostgres is:
>>>
>>> type_transition sepgsql_client_type sepgsql_client_type : db_database 
>>> sepgsql_db_t;
>>>
>>> Where I believe the standard user_t and such had the sepgsql_client_type 
>>> attribute. So, with that rule in place I think it was impossible for 
>>> rubix to have a similar rule, if our client_type's overlapped. Which 
>>> seems likely, as the user_t is a likely candidate for a client. For 
>>> instance, if I did this:
>>>       
>> strange, I thought he/we decided to use the domain of the dbms as the target for
>> that type_transition. That would solve this particular problem, I'd have to go
>> back in archives to understand why this path was chosen, or perhaps KaiGai
>> remembers.
>>     
>
> It had been a headache what is the target of TYPE_TRANSITION for the root
> object.
> At the initial design, as you pointed out, I used the domain of server
> process as the target to decide the security context of database itself.
> Then, I got a suggestion that we can use the following notation to
> represent the security context of new object is determined by only
> the context of subject.
>
>   TYPE_TRANSITION <subject context> <subject context> : <class> <new context>;
>
> I could understand as an analogy of permission checks on the kernel
> capability classes.
>
>   
It seems if you decide the context of the database using only the
subject's attributes itself, there will always be potential conflict
with other DBMS's. There is nothing in the type transition that
identifies the rule as applying to a sepostgresql dbms as opposed to any
other. It seems a bad way to do it. I would propose either:

TYPE_TRANSITION <server context> <server context> : <class> <new context>;

or

TYPE_TRANSITION <subject context> <server context> : <class> <new context>;

Where the 1st has the potential to cover all permutations (but only one new context) and the latter opens the possibility to have different new contexts based upon the context of the subject, but could leave some permutations uncovered. I think the second case is more general and flexible and the first case could be viewed as a special case of the second.

>>> type_transition rubix_client_type rubix_client_type : db_database 
>>> rubix_db_t; (where rubix_client_type contained user_t)
>>>
>>> I think it would not compile because its ambiguous, right? So, what I 
>>> did was write a rule like this:
>>>
>>> type_transition rubix_client_type rubix_t : db_database rubix_db_t;
>>>
>>> and hard-coded the rubix_t into the avc_compute_create call. The rubix_t 
>>> is actually the type of our server process. Prior to doing that, I could 
>>> not find a way to not have a database be created with a sepgsql_t type.
>>>
>>>       
>> If you just used the dbms domain as the target you wouldn't need to hardcode
>> anything.
>>     
>
> I also think we should not hold any hardcode context inside the DBMS.
>
>   
>>> I see (now) that the reference policy also has the rule:
>>>
>>> type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;
>>>
>>> Obviously, the above would never conflict with another dbms's rules. If 
>>> that single type transition rule satisfied all of seposgresql's needs, 
>>> then that would eliminate the need for the conflicting rule. Though, I 
>>> assume thats dependent on  the internals of seposgresql.
>>>       
>> This is for internally created db objects? Why are both this and the client ->
>> client transitions needed?
>>     
>
> It is the case of deterministration for the root object.
> When we set up the initial database, PostgreSQL with bootstraping mode also
> performs as a client concurrently.
> Please consider the "postgresql_t" represents the case when it performs
> as a client, not only a server.
>
> Thanks,
>   

--------------040807050504050602090209
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-2022-JP"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
KaiGai Kohei wrote:
<blockquote cite="mid:49CD687C.9080401@kaigai.gr.jp" type="cite">
  <pre wrap="">Joshua Brindle wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Andy Warner wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">  
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
      </pre>
    </blockquote>
    <pre wrap="">strange, I thought he/we decided to use the domain of the dbms as the target for
that type_transition. That would solve this particular problem, I'd have to go
back in archives to understand why this path was chosen, or perhaps KaiGai
remembers.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It had been a headache what is the target of TYPE_TRANSITION for the root
object.
At the initial design, as you pointed out, I used the domain of server
process as the target to decide the security context of database itself.
Then, I got a suggestion that we can use the following notation to
represent the security context of new object is determined by only
the context of subject.

  TYPE_TRANSITION &lt;subject context&gt; &lt;subject context&gt; : &lt;class&gt; &lt;new context&gt;;

I could understand as an analogy of permission checks on the kernel
capability classes.

  </pre>
</blockquote>
It seems if you decide the context of the database using only the
subject's attributes itself, there will always be potential conflict
with other DBMS's. There is nothing in the type transition that
identifies the rule as applying to a sepostgresql dbms as opposed to
any other. It seems a bad way to do it. I would propose either:<br>
<br>
<pre wrap="">TYPE_TRANSITION &lt;server context&gt; &lt;server context&gt; : &lt;class&gt; &lt;new context&gt;;</pre>
or<br>
<br>
<pre wrap="">TYPE_TRANSITION &lt;subject context&gt; &lt;server context&gt; : &lt;class&gt; &lt;new context&gt;;

Where the 1st has the potential to cover all permutations (but only one new context) and the latter opens the possibility to have different new contexts based upon the context of the subject, but could leave some permutations uncovered. I think the second case is more general and flexible and the first case could be viewed as a special case of the second.
</pre>
<blockquote cite="mid:49CD687C.9080401@kaigai.gr.jp" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">type_transition rubix_client_type rubix_client_type : db_database 
rubix_db_t; (where rubix_client_type contained user_t)

I think it would not compile because its ambiguous, right? So, what I 
did was write a rule like this:

type_transition rubix_client_type rubix_t : db_database rubix_db_t;

and hard-coded the rubix_t into the avc_compute_create call. The rubix_t 
is actually the type of our server process. Prior to doing that, I could 
not find a way to not have a database be created with a sepgsql_t type.

      </pre>
    </blockquote>
    <pre wrap="">If you just used the dbms domain as the target you wouldn't need to hardcode
anything.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I also think we should not hold any hardcode context inside the DBMS.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">I see (now) that the reference policy also has the rule:

type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;

Obviously, the above would never conflict with another dbms's rules. If 
that single type transition rule satisfied all of seposgresql's needs, 
then that would eliminate the need for the conflicting rule. Though, I 
assume thats dependent on  the internals of seposgresql.
      </pre>
    </blockquote>
    <pre wrap="">This is for internally created db objects? Why are both this and the client -&gt;
client transitions needed?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It is the case of deterministration for the root object.
When we set up the initial database, PostgreSQL with bootstraping mode also
performs as a client concurrently.
Please consider the "postgresql_t" represents the case when it performs
as a client, not only a server.

Thanks,
  </pre>
</blockquote>
</body>
</html>

--------------040807050504050602090209--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
