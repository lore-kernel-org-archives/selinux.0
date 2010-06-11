Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5B5nOIs030839
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 01:49:25 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5B5ossv019069
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2010 05:50:55 GMT
Message-ID: <4C11CE43.7000509@ak.jp.nec.com>
Date: Fri, 11 Jun 2010 14:48:51 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Stephen Frost <sfrost@snowman.net>, Robert Haas <robertmhaas@gmail.com>,
        Greg Smith <greg@2ndquadrant.com>
Subject: Report of PGcon2010
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At May 19-21, PostgreSQL community held an annual conference called
PGcon2010 at Ottawa, Canada.
  http://www.pgcon.org/2010/

I also attended the conference and developer meeting (invitation only)
to have a talk about development of SE-PostgreSQL. So, I'd like to
report what we discussed here for SELinux community also.

Background
-----------
Last two years, I've joined to the development cycle of PostgreSQL to
integrate features to support SELinux. But it had not been progressed
due to some reasons; patch size is too large to commit at once, no
person (except for me) familiar with both of SELinux and PostgreSQL,
and so on.

At last winter, Stephen Frost suggested me to refactor existing PG's
security checks look like LSM/XACE, prior to SELinux code.
In another day, they invited Joshua Brindle and David P.Quigley to
BWPUG (Baltimore/Washington PostgreSQL Users Group) meeting to talk
with SELinux folks, although I didn't here.
  http://wiki.postgresql.org/wiki/SEPostgreSQL_Review_at_the_BWPUG
It seems to me they consented the design like LSM/XACE works well.
Then, I also agreed to develop it with this approach in the next
development cycle.

Discussion in PGcon2010
-----------------------
All major contributors were here, such as developer summit.

I introduced my idea at the developer meeting.

It tries to refactor the existing PG security check routines into
an separate function (E.g, check_relation_create(...)) which also
performs as an entry point of an external security provider.

In addition, it also tries PostgreSQL to support a feature to assign
a certain text label on database objects. It shall be available for
all the label based MAC, not only SELinux.

As long as PostgreSQL provides security hooks and security labeling,
it is not necessary SE-PostgreSQL feature is statically linked.
So, I also proposed it is an option that SELinux specific logic shall
be installed using a loadable module. It enables to reduce the burden
to review unfamiliar code from PostgreSQL community, and it also
means SELinux community (mainly, I and NEC, of course) takes on the
duty of maintenance of the module.

I was suggested that refactoring of the existing PG security checks
should be separated into more-and-more small unit to make its change
set more obvious, and we should start up with minimum functionalities.
I agreed with the approach. We decided to add a security hook to
acquire control on DML permission checks at first, because DML checks
are the hottest code in PgSQL rather than any other DDLs.

In addition, we agreed it is necessary to support security labeling
features for various kind of label based MAC features. Apart from
the security hooks, it shall be developed.

Development plan
-----------------
Now I'm tackling to add the first security hook at the routine which
applies the existing PG permissions checks on DML statements.
If and when it will be available, the upcoming SE-PgSQL module will
be able to provide a minimum demonstration.

In parallel, I'm also working to develop the SE-PgSQL module being
suitable for the security hooks in the upstream PostgreSQL.

The architecture of SE-PgSQL feature was significantly changed,
but I believe we are on the best way. It will make happy not only
SELinux users, but Smack or others also.

Stephen Frost also noticed me yesterday that BWPUG plans to have
a meeting about "SE-PostgreSQL Status and Review" at the Augast,
so they want to invite some of SELinux folks.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
