Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2S007QR019485
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 20:00:07 -0400
Received: from mail2.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RNu7Ro000628
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 23:56:08 GMT
Message-ID: <49CD687C.9080401@kaigai.gr.jp>
Date: Sat, 28 Mar 2009 08:59:56 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Andy Warner <warner@rubix.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com>
In-Reply-To: <49CD2EB3.2000809@manicmethod.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Andy Warner wrote:
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
> 
> strange, I thought he/we decided to use the domain of the dbms as the target for
> that type_transition. That would solve this particular problem, I'd have to go
> back in archives to understand why this path was chosen, or perhaps KaiGai
> remembers.

It had been a headache what is the target of TYPE_TRANSITION for the root
object.
At the initial design, as you pointed out, I used the domain of server
process as the target to decide the security context of database itself.
Then, I got a suggestion that we can use the following notation to
represent the security context of new object is determined by only
the context of subject.

  TYPE_TRANSITION <subject context> <subject context> : <class> <new context>;

I could understand as an analogy of permission checks on the kernel
capability classes.

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
> 
> If you just used the dbms domain as the target you wouldn't need to hardcode
> anything.

I also think we should not hold any hardcode context inside the DBMS.

>> I see (now) that the reference policy also has the rule:
>>
>> type_transition postgresql_t postgresql_t : db_database sepgsql_db_t;
>>
>> Obviously, the above would never conflict with another dbms's rules. If 
>> that single type transition rule satisfied all of seposgresql's needs, 
>> then that would eliminate the need for the conflicting rule. Though, I 
>> assume thats dependent on  the internals of seposgresql.
> 
> This is for internally created db objects? Why are both this and the client ->
> client transitions needed?

It is the case of deterministration for the root object.
When we set up the initial database, PostgreSQL with bootstraping mode also
performs as a client concurrently.
Please consider the "postgresql_t" represents the case when it performs
as a client, not only a server.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
