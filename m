Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06671
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 10:29:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA28629
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 15:28:49 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA28625 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 15:28:48 GMT
Date: Fri, 22 Mar 2002 10:28:57 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: netscape
In-Reply-To: <20020322150149.1032A2F0@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203221025380.29643-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 22 Mar 2002, Russell Coker wrote:

> Why does netscape need the capabilities setuid, setgid, and dac_override?

If netscape/mozilla runs any setuid or setgid programs as helpers, then
you either need to grant these capabilities to the netscape domain or you
need to transition to a separate domain for those programs and grant that
domain the appropriate capabilities.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
