Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB84Bdgt027509
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2010 23:11:40 -0500
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oB84BbLU023089
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2010 04:11:38 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id oB84BZM9010461
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2010 13:11:35 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id oB84BZ007483 for selinux@tycho.nsa.gov; Wed, 8 Dec 2010 13:11:35 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id oB84BYeu016540
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2010 13:11:34 +0900 (JST)
Message-ID: <4CFF0564.1080107@ak.jp.nec.com>
Date: Wed, 08 Dec 2010 13:11:16 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Recent status of SE-PostgreSQL
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd like to report the recent status of SE-PostgreSQL development,
since I guess few number of people subscribing pgsql-hackers list.

Now, the pgsql community is working on new features to the upcoming
v9.1 releases. Although we don't come up the feature freeze yet,
several fundamental features to support selinux are already merged,
and these shall be released within the v9.1 release.

The v9.1 of pgsql shall support label based mandatory access control
by external security providers.
The external security provider is a similar concept to LSM.
It allows plugin modules to make access control decision based on
its access control model such as SELinux, and the core pgsql calls
the modules via security hooks.

So, SE-PostgreSQL is now implemented as a plugin module of pgsql.

Anyway, the upcoming v9.1 shall provide a mechanism to assign
security label of database objects and security hooks on various
strategic points (but not comprehensive yet).

We will be able to assign security label using SECURITY LABEL
statement in SQL (original enhancement of pgsql) by hand.
It allows us to assign a certain label on a certain database
objects. The given label is validated by plugin modules, then
stored within system catalogs.
In addition, post-object-creation hook enables to assign a default
security label of the new database object on the creation time.

Here are other new hooks; 'ExecutorCheckPerms' hook enables to
make access control decision on DML statements (SELECT, UPDATE,
INSERT and DELETE), 'ClientAuthentication' hook enables to
obtain security label of the peer process using getpeercon(3)
at beginning of the session, 'object_access' hook will enable
to handle DDL permissions but not comprehensive yet.

I expect a limited functionalities will be available in the
v9.1 of PostgreSQL. It will be far from production level,
but a great step towards the full features.

The v9.1 will have feature freeze at the 15-Jun, then it may be
released half years later. At the same time, merge window to the
v9.2 will be open. So, I'll upstream rest of features; such as
comprehensive DDL permissions, row-level access controls and so on.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
