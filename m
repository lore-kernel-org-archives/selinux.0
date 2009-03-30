Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2U0uQe4030323
	for <selinux@tycho.nsa.gov>; Sun, 29 Mar 2009 20:56:26 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2U0qO20021537
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 00:52:25 GMT
Message-ID: <49D018A3.2090304@ak.jp.nec.com>
Date: Mon, 30 Mar 2009 09:56:03 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Joshua Brindle <method@manicmethod.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Some ideas in SE-PostgreSQL enhancement (Re: The status of SE-PostgreSQL)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com> <49C9E101.1050400@rubix.com> <49CA6D24.3040007@manicmethod.com> <49CA8934.1040200@rubix.com> <49CCF41D.4090603@manicmethod.com> <49CCFDF6.9050603@rubix.com> <49CD0995.9050205@manicmethod.com> <49CD12CD.1000205@rubix.com> <49CD1710.6000108@manicmethod.com> <49CD1F74.9030906@rubix.com> <49CD2EB3.2000809@manicmethod.com> <49CD687C.9080401@kaigai.gr.jp> <49CDCF07.1020900@rubix.com>
In-Reply-To: <49CDCF07.1020900@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> It had been a headache what is the target of TYPE_TRANSITION for the root
>> object.
>> At the initial design, as you pointed out, I used the domain of server
>> process as the target to decide the security context of database itself.
>> Then, I got a suggestion that we can use the following notation to
>> represent the security context of new object is determined by only
>> the context of subject.
>>
>>   TYPE_TRANSITION <subject context> <subject context> : <class> <new context>;
>>
>> I could understand as an analogy of permission checks on the kernel
>> capability classes.
>>
>>   
> It seems if you decide the context of the database using only the 
> subject's attributes itself, there will always be potential conflict 
> with other DBMS's. There is nothing in the type transition that 
> identifies the rule as applying to a sepostgresql dbms as opposed to any 
> other. It seems a bad way to do it. I would propose either:
> 
> TYPE_TRANSITION <server context> <server context> : <class> <new context>;
> 
> or
> 
> TYPE_TRANSITION <subject context> <server context> : <class> <new context>;
> 
> Where the 1st has the potential to cover all permutations (but only one new context) and the latter opens the possibility to have different new contexts based upon the context of the subject, but could leave some permutations uncovered. I think the second case is more general and flexible and the first case could be viewed as a special case of the second.

I can understand your concern. Indeed, the combination of client context and
itself cannot handle the case when multiple DBMSs are installed.

My preference is the later one:
  TYPE_TRANSITION <subject context> <server context> : <class> <new context>;

In addition, an idea of configuration file can be considerable to set up
the default context of database objects, though I considered it is not
necessary in the past discussion.
If a user want to work the database server process as an unconfined domain,
like a legacy "disable_xxxx_trans" boolean doing, the <server context> as
the target of TYPE_TRANSITION breaks all the correct labeling.

If we have a /etc/selinux/$POLICYTYPE/contexts/db_{sepgsql|rubix}, as follows,
it can be used to specify the default context of special purpose database
object such as schemas to store temporary database objects, not only the
context of database as the root of type transition.
------------
database    *             system_u:object_r:sepgsql_db_t:s0
schema      pg_temp_*     system_u:object_r:sepgsql_temp_schema_t:s0
  :             :            :
------------

The libselinux has selabel_lookup(3) interface to implement them
for various kind of objects.

One concern is performance hit. If we need to open/lookup/close the file
for each INSERT statement, its pain will be unacceptable.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
