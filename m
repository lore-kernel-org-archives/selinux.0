Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA24355
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 10:25:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA17808
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:25:17 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id PAA17804
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:25:16 GMT
Date: Mon, 3 Dec 2001 10:24:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lorenzo Rossi <lorrossi@tin.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SuSe 7.2
In-Reply-To: <5.1.0.14.2.20011203121005.035e1ab8@box1.tin.it>
Message-ID: <Pine.GSO.4.33.0112031017430.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 3 Dec 2001, Lorenzo Rossi wrote:

> Now I have a question:
> Does the "modified daemones/utilities" work on my SuSe 7.2 or they will
> work only on RedHat 7.1?
> What type of chenges should I do to make it running on SuSe 7.2?
> Is someone running Selinux on SuSe 7.2 or 7.3?

You'll need to adapt at least some of the modified daemons and utilities
for SuSE 7.2, since our distribution is based on RH7.1.  James Bishop has
previously worked through the issues in getting SELinux working on SuSE
7.2.  You should read his prior postings to the selinux list, e.g.:
http://marc.theaimsgroup.com/?l=selinux&m=100316127307483&w=2
http://marc.theaimsgroup.com/?l=selinux&m=100376902202400&w=2

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
