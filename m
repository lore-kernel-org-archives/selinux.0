Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19719
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:24:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA17004
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:22:47 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA17000 for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:22:46 GMT
Date: Fri, 24 May 2002 11:22:57 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re:  Is this a module bug?
In-Reply-To: <20020522142425.D01493B0@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205241119570.23057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 22 May 2002, Russell Coker wrote:

> Hmm.  So we just have to give insmod_t and kmod_t all capabilities?

insmod_t and kmod_t will need all permissions necessary to initialize any
modules that you plan on inserting, as the initialization code is run in the
context of the inserting process.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
