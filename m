Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5E4IlrX023361
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 00:18:47 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5E4HuJ3023349
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 04:17:57 GMT
Message-ID: <4C15AD6B.9050300@ak.jp.nec.com>
Date: Mon, 14 Jun 2010 13:17:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Greg Smith <greg@2ndquadrant.com>
CC: SELinux <selinux@tycho.nsa.gov>, Stephen Frost <sfrost@snowman.net>,
        Robert Haas <robertmhaas@gmail.com>
Subject: Re: Report of PGcon2010
References: <4C11CE43.7000509@ak.jp.nec.com> <4C125496.1060107@2ndquadrant.com>
In-Reply-To: <4C125496.1060107@2ndquadrant.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me Greg's message was not distributed via SELinux list.

I'd like to send it again.

-------- Original Message --------
Subject: Re: Report of PGcon2010
Date: Fri, 11 Jun 2010 11:21:58 -0400
From: Greg Smith <greg@2ndquadrant.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: SELinux <selinux@tycho.nsa.gov>,    Stephen Frost <sfrost@snowman.net>,    Robert Haas <robertmhaas@gmail.com>

KaiGai Kohei wrote:
> I was suggested that refactoring of the existing PG security checks
> should be separated into more-and-more small unit to make its change
> set more obvious, and we should start up with minimum functionalities.
> I agreed with the approach. We decided to add a security hook to
> acquire control on DML permission checks at first, because DML checks
> are the hottest code in PgSQL rather than any other DDLs.
>

I wanted to expand on this so it's clear what direction this is going
now and why it went there. I've been working on this project on the
PostgreSQL side mainly as an advocate for its inclusion, rather than as
someone coding on it.

Much of the trouble trying to integrate previous SE-PostgreSQL versions
related to relatively underused portions of SQL. For example, the most
problematic and contentious code path was when ALTER TABLE was used to
modify a table, a statement which due to its structure acquires
permissions in multiple spots. The way earlier patches were structured,
committing anything at all related to SE-PostgreSQL was blocked behind
resolving every one of these problem areas in every command. That was
more than the PostgreSQL community could really absorb in one commit.
And it wasn't clear what simpler subset would by itself by useful,
having already removed row-level security out of the initial target
feature set.

Now that we've been doing regular brainstorming about how to find a
subset of SE-PostgreSQL that could be committed for over six months,
during periodic meetings on that topic here in the US, Stephen Frost
(original author of the PostgreSQL "roles" system used for user
authentication in the database) made an interesting observation. If
instead you limit the focus to DML statements such as SELECT, INSERT,
and UPDATE, the permissions checks for these are for the most part all
sitting in one place in the PostgreSQL code: the query executor. It's
possible to connect a simplified version of SE-PostgreSQL that only aims
to restrict that type of statement, inserting a much simpler security
check hook only at that point, and end up with a dramatically smaller patch.

This pushes off the problem of how to keep labels consistent in the face
of things like table changes to being a database superuser only task,
not one you can delegate to other users. If the security hook code can
get committed even in that limited form, it accomplishes two things.
First, it finally introduces the possibility that core PostgreSQL will
ship with some SE-PostgreSQL code integrated in, which I think will
considerably expand interest in this specific area. Second, it lets
further improvements that add additional features do so one at a time
with relatively small code drops; maybe CREATE TABLE support is added
one month, ALTER TABLE the next.

My personal opinion is that systems setup by a superuser with
appropriate labeling that work for SELECT/INSERT/UPDATE are actually
sufficient to support some interesting use cases, and the incremental
improvement provided by DDL such as CREATE/DROP/ALTER can be postponed
and still have a useful result. I'd even rather see row-level results
(which have broader problems beyond just security framework integration
to be sorted out) tackled second here, after DML but before DDL. They
can certainly be worked on in parallel once basic DML is committed.

The next meeting of our local Baltimore/Washington PostgreSQL working
group that will focus on issues around SE-PostgreSQL is tentatively
scheduled for August 11th in Columbia, MD. We welcome input there from
other members of the security community who'd like to see SELinux
support integrated into PostgreSQL.

-- 
Greg Smith  2ndQuadrant US  Baltimore, MD
PostgreSQL Training, Services and Support
greg@2ndQuadrant.com   www.2ndQuadrant.us

-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
