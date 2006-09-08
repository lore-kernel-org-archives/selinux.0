Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8823iVF000703
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 22:03:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8823K7M012038
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 02:03:20 GMT
Message-ID: <4500CFBD.7010100@tresys.com>
Date: Thu, 07 Sep 2006 22:04:45 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <6FE441CD9F0C0C479F2D88F959B015883C1638@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015883C1638@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Russell Coker [mailto:russell@coker.com.au] 
>>
>> On Friday 08 September 2006 00:28, KaiGai Kohei 
>> <kaigai@kaigai.gr.jp> wrote:
>>     
>>> The reason of this decision is that we cannot enforce 
>>>       
>> SELinux's access 
>>     
>>> controls to any tables, columns and rows, even if the proxy server 
>>> rewrite SQL statement.
>>>       
>> You want to label columns AND rows?
>>
>> How is that going to work?  I can understand the desire for 
>> this (EG have a password column in the user table), but the 
>> mechanism of enforcing this will be tricky to say the least.  
>> Will you perform two access checks on each cell, one for 
>> column and one for row?
> Columns are part of the schema, rows are data, they are different
> objects.
>
> You label columns because an entire column might contain important data
> (eg., a password). The rows are labeled because some domain X is putting
> data in them and you still want to be able to use policy to enforce
> information flow goals with the policy whether you are using kernel
> objects or userspace objects. In other words, if user X is topsecret and
> writes a row to a table you don't want user Y who is just secret to read
> it. 
>
> The latter can be accomplished in many ways including virtual databases
> (eg., views) or by modifying queries (like KaiGai mentioned in his first
> email) or filtering results or course grained labeling on tables so that
> each table is only 1 context. Some are better approaches than others, I
> won't go into that at this point..
>
> The answer is yes, there may be multiple security queries per database
> query, due to the data model of relational databases this is optimal and
> necessary IMO. This isn't abnormal either. Creating a file, for example,
> requires dir { add_name search}, file { create } and filesystem {
> associate } (for the object). The policy server has similar multiple
> checks in its current state. I don't think there is a problem if they
> overlap some as long as one isn't necessarilly a superset of another
> (which would just be redundant) which is not the case here since we are
> talking about different objects that can be labeled differently for any
> given query.
>
>   

Also note that this isn't very different from the way databases 
currently work. There are already permissions on databases, tables and 
columns and we'd (hopefully) be putting our access control hooks in the 
same places those checks are currently done. In addition to those checks 
we could implement row level access control using one of the above 
models or something else altogether. This is really about taking what 
the databases already have, making it mandatory and extending it, very 
much like what SELinux did for Linux.

There are also many very interesting and difficult problems like how one 
would label a result set that has rows from multiple tables with 
multiple rows of different contexts joined together. The approach taken 
above will guide one to the answers to questions like these. I'd be very 
interested in KaiGai's ultimate goals and how to best obtain those, both 
for himself and the greater community.

One other totally off topic comment.. MySQL already has much more of a 
'mandatory' policy than postgres. MySQL has no ownership of tables, 
databases and so on like postgres and doesn't allow discretionary 
permission changes. Not that its a problem but MySQL seems alot closer 
to the goal than postgres from an, admittedly superficial, security pov. 
I understand there are other issues like licensing, etc that makes 
postgres more friendly to this work though, depending on your motivation 
it may be worth it to shop around, in a manner of speaking.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
