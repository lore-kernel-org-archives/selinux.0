Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA19070
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 07:36:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA19564
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 11:35:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA19558 for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 11:35:06 GMT
Date: Wed, 17 Jul 2002 07:35:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: inetd and tcpd services
In-Reply-To: <Pine.LNX.4.44.0207170904280.559-100000@coffeesaur>
Message-ID: <Pine.GSO.4.33.0207170734161.18645-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 17 Jul 2002, Rogelio M. Serrano Jr. wrote:

> im running imapd as an inetd service. in enforcing mode i cant access the
> mail spool directory because tcpd_t does not have permissions to lock the
> directory. should i create a new impadd_t or give tcpd_t permissions?

You typically want a separate domain for each service started by tcpd,
unless the service happens to require the same permissions as some other
service and you do not care about separating them.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
