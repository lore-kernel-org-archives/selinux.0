Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA20562
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 07:00:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA18043
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 10:59:34 GMT
Received: from jsmith.org (pool-141-158-42-213.phil.east.verizon.net [141.158.42.213])
        by jazzband.ncsc.mil  with ESMTP id KAA18039 for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 10:59:34 GMT
Subject: Re: [patch] Re: auditdeny is painful
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0206041520480.3949-200000@raven>
References: <Pine.GSO.4.33.0206041520480.3949-200000@raven>
Content-Type: text/plain
Date: 05 Jun 2002 07:00:49 -0400
Message-Id: <1023274849.2139.17.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'll jump into the thread and add my $.02:

The permission denied messages can be an excellent intrusion detection
system (like tripwire). If one eliminates denials that are innocent
(programs accessing files they don't need to), the remaining ones can
give a pretty good picture of what is going on in one's system. And this
approach is much more refined than tripwire: it doesn't scan huge chunks
of file systems to see what changes. Instead, it intercepts  system
calls that attempt to make the changes.

On several occasions, I've noticed illicit attempts to access my student
records database. Although (I think) these attempts would have failed
without SELinux (because of standard unix permissions), I also wouldn't
have gotten such clear indications of it.
-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
