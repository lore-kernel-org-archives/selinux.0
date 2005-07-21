Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LI2AgA028338
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:02:10 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LHukBa027987
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:56:46 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LHvYP4024075
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:57:34 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LHvXV03499
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:57:33 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LHvXll029045
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:57:33 -0400
Subject: [ libsepol 6/6] Summary
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 21 Jul 2005 13:55:08 -0400
Message-Id: <1121968509.9844.47.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is no 6/6.. i started counting at 0.
Just wanted to mention some things:

- Note that no new functions are exposed
via the shared interface, following the plan
to make this library static.

- Hopefully internal data structures can
eventually be removed from headers, and
we can rely on external data structures.

- If you have complaints about the API,
please let me know, and I'll fix it - I
received no comments on my users patch
when I posted it last time, so I followed
the same approach.

- Checkpolicy code should be routed to those new
functions, and so should libsemanage.

- I haven't put in a scope check (is_id_in_scope),
which checkpolicy currently does -
I didn't understand quite how that works. 
If it is necessary, please let me know.

- manpages still need to be written


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
