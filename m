Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2BDSW7C022692
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 09:28:32 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2BDSTwB002784
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 13:28:30 GMT
Message-ID: <47D6830E.4000406@kaigai.gr.jp>
Date: Tue, 11 Mar 2008 22:03:10 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Kohei KaiGai <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
References: <47B2B885.4070300@ak.jp.nec.com>	 <1203957028.32061.69.camel@gorn> <47C38287.4080302@ak.jp.nec.com>	 <47C5189B.9070500@ak.jp.nec.com>	 <1204817238.3994.59.camel@gorn.columbia.tresys.com>	 <47D09FEB.3030005@ak.jp.nec.com>  <47D4E8B6.8000405@ak.jp.nec.com> <1205238628.25555.40.camel@gorn>
In-Reply-To: <1205238628.25555.40.camel@gorn>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2008-03-10 at 16:52 +0900, Kohei KaiGai wrote:
>>>>> * Tunables to turn on/off audit are remained now, because database
>>>>>    folks told me fine-grained logs are worthwhile feature.
>>>> I'm still not very compelled by this, as I doubt people who do want more
>>>> auditing will want to to enable it so coarsely.
>>> Hmm...
>>> OK, I'll remove these tunable, and add a documentation to collect
>>> fine-grained database access logs.
>> When we apply tuple-level access control, access denied logs of filtered
>> tuples are noisy, and it gives adversed effect for performance.
>> For example, if a table contains 1,000,000 tuples and half of them are
>> labeled as ":s0:c0", unclassified users will look a flood of logs
>> on every accesses.
>>
>> At least, is it necessary to be controlable on tuples?
> [...]
>> [kaigai@saba ~]$ runcon -l s0 psql postgres -q
>> postgres=# SELECT * FROM drink;
>> NOTICE:  SELinux: denied { select } scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:sepgsql_table_t:s0:c0 tclass=db_tuple name=relid:16482,oid:16490
>> NOTICE:  SELinux: denied { select } scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:sepgsql_table_t:s0:c0 tclass=db_tuple name=relid:16482,oid:16491
>> NOTICE:  SELinux: denied { select } scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:sepgsql_table_t:s0:c0 tclass=db_tuple name=relid:16482,oid:16492
>>  id | name  | price | alcohol
>> ----+-------+-------+---------
>>   1 | water |   100 | f
>>   2 | coke  |   120 | f
>>   3 | juice |   130 | f
>> (3 rows)
> 
> I would just unconditionally dontaudit it.

OK, I'll add it.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
