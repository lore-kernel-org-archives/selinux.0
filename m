Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MF4lgA006194
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:04:48 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MExEKk003534
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:59:14 GMT
Subject: Re: [ libsepol 0/6] Context reorganization
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122041703.24847.20.camel@celtics.boston.redhat.com>
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
	 <42DFE2A7.9020200@tresys.com>
	 <1121969017.9844.50.camel@celtics.boston.redhat.com>
	 <42DFE4CA.1070707@tresys.com>
	 <1121969663.9844.63.camel@celtics.boston.redhat.com>
	 <1122040159.24847.10.camel@celtics.boston.redhat.com>
	 <42E0FC94.2060501@tresys.com>
	 <1122041079.24847.15.camel@celtics.boston.redhat.com>
	 <42E0FE98.20307@tresys.com>
	 <1122041703.24847.20.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 10:57:34 -0400
Message-Id: <1122044254.24847.39.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why is the cache expansion performed in index_others...
that function has to do with reconstructing reverse entry tables,
and I understand your function has to do with expanding * and ~ -
how is this related to maintaining the reverse entry tables?

Also, I think I'll move any code that has to do
with the users into users.c, and make index_others
call individual functions for roles, types, and users,
that all look like reindex_users (and then those functions
can be moved out of policydb.c)

Basically, I don't like how there is a big policydb.c file - 
this entire library is dedicated to maintaining the policydb
structure, so we should split up functionality into manageable
pieces.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
