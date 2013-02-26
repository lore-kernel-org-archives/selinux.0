Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1Q1GV3K003396
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2013 20:16:31 -0500
Message-ID: <512C0CE0.2050407@manicmethod.com>
Date: Mon, 25 Feb 2013 20:16:16 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: SELinux-NSA <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss1.tresys.com>,
        Kevin Grittner <kgrittn@ymail.com>
Subject: Re: [PATCH] Add db_materialized_view object class
References: <CADyhKSX86k4BwPzZi4EGWBPbU9bHt=w0MEJAFfOu5jckb3ihng@mail.gmail.com>
In-Reply-To: <CADyhKSX86k4BwPzZi4EGWBPbU9bHt=w0MEJAFfOu5jckb3ihng@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei KaiGai wrote:
> Hello,
>
> Recent PostgreSQL development newly adds a new feature; materialized
> view.
> However, we have no relevant object class in selinux side, so I'd like
> to add
> a new db_materialized_view object class to support this object type.

Why not just use the db_table object class?

>
> Materialized-view allows to construct its result-set to be returned on
> references
> by user's query preliminarily, to improve performance to scan multiple
> tables
> being combined with complicated joins.
> In contradiction to its name, its behavior is almost identical with
> regular tables
> rather than traditional views. Line SELECT ... INTO command, it saves
> a snapshot when a particular user (with security label, of course)
> references
> the underlying tables onto a regular tables in behalf of MV.
>
> In perspective of SELinux, nothings are different from an operation
> that writes
> data being read from another tables to a regular table; it should check
> permission to write on the destination table and to read from the source
> tables, but materialized-view calls this operation as "refresh".
>

If a user has the ability to update a table backing an mv, but not the 
refresh permission on the mv, will the mv now be inconsistent?

> The attached patch adds db_materialized_view object class with select,
> insert, update, delete, lock, refresh and common database permissions.
> These permissions shall be checked on relevant accesses in manner of
> what regular table doing, and "refresh" shall be also checked when MV
> is refreshed.
>

It seems to me that MV's don't really need to be treated specially. If 
you have access to the backing table/row you'll see it, otherwise you 
won't. Running the query that builds an MV shouldn't yield a different 
result from querying the MV, should it?

> I didn't define new types for materialized-views, because its behavior is
> almost same as regular tables, thus I though it is a reasonable solution
> to utilize existing types for tables.
>
> Thanks,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
