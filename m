Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l563tXHS009612
	for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2007 23:55:33 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l563tVxb023546
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 03:55:32 GMT
Message-ID: <46663085.8020304@ak.jp.nec.com>
Date: Wed, 06 Jun 2007 12:56:53 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: kaigai@kaigai.gr.jp, russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] permissions for conditional UPDATE statement
References: <200706040423.l544NU3H086014@www346.sakura.ne.jp> <6FE441CD9F0C0C479F2D88F959B01588BF045B@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF045B@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> kaigai@kaigai.gr.jp wrote:
>> It is a RFC in security design of SE-PostgreSQL.
>>
>> In the current version of SE-PostgreSQL, {select update} for
>> table, column and tuple classes are required when a client
>> execute a SQL query with conditional UPDATE query, for example.
>>
>> It means that the following SQL requires '{select update}'
>> permission, not only 'update', because the query tries to
>> refer 'z' column of 'tbl_1' table on WHERE clause.
>>
>>   UPDATE tbl_1 SET x = 10, y = 'aaa' WHERE z = true;
>>
>> The query indeed refers 'tbl_1', 'z' column and each targeted
>> tuples, so 'select' permission might be appropriate.
>> But there is a significant difference from general SELECT
>> statement from conditional UPDATE. It does not return its content.
>>
>> We have a matter in this approach. DBA have to allow SELECT
>> permission to enable conditional UPDATE statement, even if he
>> does not want to expose its contents.
>>
>> I have an idea to solve them. add 'reference' (or 'refer')
>> permission on table, column and tuple object classes.
>> It means references to those objects without returning their contents
>> to clients. 
>>
> 
> I agree to some extent. The where clause can be used to enumerate what
> data might be but doesn't tell you what it is explicitely (the boolean
> above is a bad example, something like an unknown string is a lot
> harder). I kind of like the 'use' permission more, it can be used
> anywhere this sort of thing happens where extra granularity doesn't
> help.

Thanks, I'll add 'use' permission.
Is there any more opinion?

> As an aside, I'm glad to see you are continuing this work dispite
> resistance upstream. Do you have a plan for inclusion? Have you talked
> to upstream offline or somewhere not public about what their problems
> are?

I don't think PostgreSQL people oppose to SE-PostgreSQL approach.
But the timing I posted RFC was not good, because it was just after
features freezed for PostgreSQL 8.3 beta. :(
Now, the discussions are suspended by PostgreSQL 8.3 beta is released.

By the way, I attended to PostgreSQL conference 2007/Tokyo yesterday,
to have my presentation and to talk a man of PostgreSQL global development
team. (He is a guy who introduced SE-PostgreSQL on the pgsql-hackers list)
In the short discussion, he recommended me to put SE-PostgreSQL on 8.4
merge line (planned to release at Oct 2008).
Maybe, there are several opinions in the PostgreSQL core developers.

Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
