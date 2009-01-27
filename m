Message-ID: <497EC45D.7090100@ak.jp.nec.com>
Date: Tue, 27 Jan 2009 17:22:53 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: Stephen Frost <sfrost@snowman.net>
Subject: Re: (forw) [bruce@momjian.us: [ANNOUNCE] Need help on possible PG
 8.4	security features]
References: <20090127012436.GD8123@tamriel.snowman.net>
In-Reply-To: <20090127012436.GD8123@tamriel.snowman.net>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the recent days, we have a hot discussion about what features
should be included within the next PostgreSQL release (v8.4) in
the pgsql-hackers list.
SE-PostgreSQL is a candidate of new features in the v8.4, but
it has been left for unreviewed yet.

| Bruce Momjian wrote:
| OK, time for me to chime in.
|
| I think the outstanding commit-fest items can be broken down into four
| sections:
|
| 	o  Log streaming
| 	o  Hot standby
| 	o  SE-PostgreSQL
| 	o  Others

 - snip -

| SE-PostgreSQL has been in steady development for a year so this is the
| time to decide about it.  My feeling is if we don't accept it now, we
| are never going to have SE-Linux or row-level security.  The next week
| should show us the right direction when we start discussion on
| Wednesday, noon GMT.

It seems to me some of pgsql-hackers concerned about security experts
don't join to its review process (except for me :), so it is unclear
whether the SE-PostgreSQL feature is really desired, or not, and
whether its security design is really appropriate, or not.

I would like to want some your helps.

Please see,
  http://www.postgresql.org/community/lists/subscribe
    -> "pgsql-hackers"
  http://archives.postgresql.org/pgsql-hackers/2009-01/threads.php
    -> "8.4 release planning" thread (sorry, it's a quite long thread).

Thanks,

Stephen Frost wrote:
> Greetings,
> 
>   Hope the below hasn't already been sent here, if so, sorry, didn't
> see it in the archives though.  This is very important for PostgreSQL
> upstream addition of SE-Postgres.  I'm hopeful that there are some on
> this list who can help the PostgreSQL core members be comfortable that
> the patch does what is intended and properly implements the security it
> claims.
> 
> The top of the current thread on -hackers can be found here:
> http://archives.postgresql.org/pgsql-hackers/2009-01/msg01840.php
> in particular:
> http://archives.postgresql.org/pgsql-hackers/2009-01/msg01962.php
> and others around that timeframe help frame this discussion.
> 
> In particular, we're looking for security experts who are familiar
> with implementing SELinux (or similar..) in an RDBMS such as
> PostgreSQL to review the patch, documentation, etc.
> 
> Please see below, and thanks.
> 
> 	Stephen
> 
> ----- Forwarded message from Bruce Momjian <bruce@momjian.us> -----
> 
> Date: Sat, 24 Jan 2009 10:36:22 -0500 (EST)
> From: Bruce Momjian <bruce@momjian.us>
> To: PostgreSQL-announce <pgsql-announce@postgresql.org>
> X-Mailer: ELM [version 2.4ME+ PL124 (25)]
> X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham
> 	version=3.2.5
> Subject: [ANNOUNCE] Need help on possible PG 8.4 security features
> 
> The PostgreSQL community is considering including security enhancements
> in Postgres 8.4, e.g. row-level permissions and SE-Linux security. 
> However, to evaluate the patch and its usefulness, we need security
> experts who want to use this capability or have used it in other
> databases.
> 
> The most recent version of the patch is mentioned here:
> 
> 	http://archives.postgresql.org/pgsql-hackers/2009-01/msg01680.php
> 
> Particularly interesting is the documentation patch:
> 
> 	http://sepgsql.googlecode.com/files/sepostgresql-docs-8.4devel-3-r1460.patch
> 
> If you know someone who is interested in these features or can help in
> discussing them, please have them subscribe to pgsql-hackers here:
> 
> 	http://www.postgresql.org/community/lists/subscribe
> 
> Email discussion about this topic will start on Wednesday, January 28,
> at 12:00 GMT, and will include the subject text "SE-PostgreSQL".
> 
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
