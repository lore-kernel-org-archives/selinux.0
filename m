Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAUIfJMA028886
	for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2005 13:41:19 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAUIaQlQ012104
	for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2005 18:36:26 GMT
Subject: spamassasin_domain()
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 13:38:14 -0500
Message-Id: <1133375895.7775.69.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the spamassassin_domain() macro, there is the following block of
rules:

can_resolve($1_spamassassin_t)
# set tunable if you have spamassassin do DNS lookups
if (spamassasin_can_network) {
can_network($1_spamassassin_t)
allow $1_spamassassin_t port_type:tcp_socket name_connect;
} 

This is confusing as the comment says the conditional toggles ability to
do DNS lookups, but right outside it has can_resolve().  It seems to me
that the can_resolve() should be inside the conditional, instead of what
is there.  Does this seem reasonable?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
