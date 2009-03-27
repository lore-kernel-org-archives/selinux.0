Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RK6LKx030012
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 16:06:21 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RK6Jfp028162
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 20:06:20 GMT
Message-ID: <49CD3169.3080302@rubix.com>
Date: Fri, 27 Mar 2009 21:04:57 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: selinux <selinux@tycho.nsa.gov>, KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com>
In-Reply-To: <49CD2EB3.2000809@manicmethod.com>
Content-Type: multipart/alternative;
 boundary="------------040001030409000700090306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040001030409000700090306
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



Joshua Brindle wrote:
> Andy Warner wrote:
>   
>>   
>> KaiGai and I talked about this a bit already, and I'll preface my 
>> response by saying that my memory of it is poor. Also, this issue was 
>> one of my first practical introductions to selinux, so I'm sure I was 
>> shooting in the dark. But, the main issue revolved around the type 
>> transition rule for the database object. It seems to me, what makes it 
>> special is that it has no parent object. It seems equivalent to writing 
>> a type transition rule for creating the OS root directory, except in our 
>> DBMS case we can have more than one type (each dbms has their own).
>>
>> A rule for sepostgres is:
>>
>> type_transition sepgsql_client_type sepgsql_client_type : db_database 
>> sepgsql_db_t;
>>
>> Where I believe the standard user_t and such had the sepgsql_client_type 
>> attribute. So, with that rule in place I think it was impossible for 
>> rubix to have a similar rule, if our client_type's overlapped. Which 
>> seems likely, as the user_t is a likely candidate for a client. For 
>> instance, if I did this:
>>     
>
> strange, I thought he/we decided to use the domain of the dbms as the target for
> that type_transition. That would solve this particular problem, I'd have to go
> back in archives to understand why this path was chosen, or perhaps KaiGai
> remembers.
>
>   
>> type_transition rubix_client_type rubix_client_type : db_database 
>> rubix_db_t; (where rubix_client_type contained user_t)
>>
>> I think it would not compile because its ambiguous, right? So, what I 
>> did was write a rule like this:
>>
>> type_transition rubix_client_type rubix_t : db_database rubix_db_t;
>>
>> and hard-coded the rubix_t into the avc_compute_create call. The rubix_t 
>> is actually the type of our server process. Prior to doing that, I could 
>> not find a way to not have a database be created with a sepgsql_t type.
>>
>>     
>
> If you just used the dbms domain as the target you wouldn't need to hardcode
> anything.
>   
Actually, thats what I did. My choice of words (hardcoding) wasn't the best
>   
>> I see (now) that the reference policy also has the rule:
>>
>> type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;
>>
>> Obviously, the above would never conflict with another dbms's rules. If 
>> that single type transition rule satisfied all of seposgresql's needs, 
>> then that would eliminate the need for the conflicting rule. Though, I 
>> assume thats dependent on  the internals of seposgresql.
>>     
>
> This is for internally created db objects? Why are both this and the client ->
> client transitions needed?
>
> <snip>
>   
>>> Yes, I don't mean they'd be using an identical policy but shared
>>> templates/interfaces that worked with both would certainly make it easier to
>>> target both systems without really needing to know the intricacies of each
>>> systems enforcement.
>>>   
>>>       
>> Sounds like a good goal.
>>
>>     
>
> It may be a pipe dream, like having a common policy for all MTA's. At least if
> there is some consensus on the internal object model, and since SQL is pretty
> much the same everywhere this may actually stand a chance.
>   
I like to be in that loop
>
>
>   

--------------040001030409000700090306
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
<blockquote cite="mid:49CD2EB3.2000809@manicmethod.com" type="cite">
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
  <pre wrap=""><!---->
strange, I thought he/we decided to use the domain of the dbms as the target for
that type_transition. That would solve this particular problem, I'd have to go
back in archives to understand why this path was chosen, or perhaps KaiGai
remembers.

  </pre>
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
  <pre wrap=""><!---->
If you just used the dbms domain as the target you wouldn't need to hardcode
anything.
  </pre>
</blockquote>
Actually, thats what I did. My choice of words (hardcoding) wasn't the
best<br>
<blockquote cite="mid:49CD2EB3.2000809@manicmethod.com" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">I see (now) that the reference policy also has the rule:

type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;

Obviously, the above would never conflict with another dbms's rules. If 
that single type transition rule satisfied all of seposgresql's needs, 
then that would eliminate the need for the conflicting rule. Though, I 
assume thats dependent on  the internals of seposgresql.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is for internally created db objects? Why are both this and the client -&gt;
client transitions needed?

&lt;snip&gt;
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Yes, I don't mean they'd be using an identical policy but shared
templates/interfaces that worked with both would certainly make it easier to
target both systems without really needing to know the intricacies of each
systems enforcement.
  
      </pre>
    </blockquote>
    <pre wrap="">Sounds like a good goal.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
It may be a pipe dream, like having a common policy for all MTA's. At least if
there is some consensus on the internal object model, and since SQL is pretty
much the same everywhere this may actually stand a chance.
  </pre>
</blockquote>
I like to be in that loop<br>
<blockquote cite="mid:49CD2EB3.2000809@manicmethod.com" type="cite">
  <pre wrap="">


  </pre>
</blockquote>
</body>
</html>

--------------040001030409000700090306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
