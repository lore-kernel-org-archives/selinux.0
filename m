Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2BGTfBY010703
	for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2013 12:29:42 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so3488202obb.37
        for <selinux@tycho.nsa.gov>; Mon, 11 Mar 2013 09:29:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <512C0CE0.2050407@manicmethod.com>
References: <CADyhKSX86k4BwPzZi4EGWBPbU9bHt=w0MEJAFfOu5jckb3ihng@mail.gmail.com>
	<512C0CE0.2050407@manicmethod.com>
Date: Mon, 11 Mar 2013 17:29:39 +0100
Message-ID: <CADyhKSUcL7JEZ6_xJ2QxGprffYK8LWp=8Mc6xpc0Z_YsWXbUmA@mail.gmail.com>
Subject: Re: [PATCH] Add db_materialized_view object class
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Joshua Brindle <method@manicmethod.com>
Cc: SELinux-NSA <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss1.tresys.com>,
        Kevin Grittner <kgrittn@ymail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for my response being late.

2013/2/26 Joshua Brindle <method@manicmethod.com>:
> Kohei KaiGai wrote:
>>
>> Hello,
>>
>> Recent PostgreSQL development newly adds a new feature; materialized
>> view.
>> However, we have no relevant object class in selinux side, so I'd like
>> to add
>> a new db_materialized_view object class to support this object type.
>
>
> Why not just use the db_table object class?
>
Even though the behavior of MV is almost common with table's one,
we will confuse how to control the "refresh" operation.
If we try to adopt "db_table" object class here, we have no relevant
permissions here. I initially thought to abuse "update" permission for
this purpose, however, it was short-sighted solution because it will
make another problem once MV got updatable feature in future
version.

>> Materialized-view allows to construct its result-set to be returned on
>> references
>> by user's query preliminarily, to improve performance to scan multiple
>> tables
>> being combined with complicated joins.
>> In contradiction to its name, its behavior is almost identical with
>> regular tables
>> rather than traditional views. Line SELECT ... INTO command, it saves
>> a snapshot when a particular user (with security label, of course)
>> references
>> the underlying tables onto a regular tables in behalf of MV.
>>
>> In perspective of SELinux, nothings are different from an operation
>> that writes
>> data being read from another tables to a regular table; it should check
>> permission to write on the destination table and to read from the source
>> tables, but materialized-view calls this operation as "refresh".
>>
>
> If a user has the ability to update a table backing an mv, but not the
> refresh permission on the mv, will the mv now be inconsistent?
>
Yes. But MV is originally designed to refresh itself asynchronously
because of performance perspective.

>> The attached patch adds db_materialized_view object class with select,
>> insert, update, delete, lock, refresh and common database permissions.
>> These permissions shall be checked on relevant accesses in manner of
>> what regular table doing, and "refresh" shall be also checked when MV
>> is refreshed.
>>
>
> It seems to me that MV's don't really need to be treated specially. If you
> have access to the backing table/row you'll see it, otherwise you won't.
> Running the query that builds an MV shouldn't yield a different result from
> querying the MV, should it?
>
Even though backing table/row are the only source for the relevant MV,
it may cause a problem when MV and backing tables have different
security label. For example, when MV has "unclassified" and backing
table has "classified" label, is a user with "classified" able to refresh
the MV with source of classified tables. It will allow unclassified users to
reference classified data via MV.
One other problematic scenario is interaction with row-level security
that generates different view depending on user's credential who
refresh the MV. Then, another one may reference the MV being
refreshed with inconsistent credential.

So, these are the reason why I consider MV should has its own
object class to control "refresh" as writer operation, in addition
to insert, update or delete that may be used for the purpose as
literal in the future version.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
