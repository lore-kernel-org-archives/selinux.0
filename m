Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5QMuE0S010716
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 18:56:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5QMuD5e007709
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 22:56:13 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h5QMuC92007706 for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 22:56:13 GMT
Received: from vista.av8.net (vista.av8.net [130.105.36.10])
	by citation.av8.net (8.9.3/8.9.3) with ESMTP id SAA15144
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 18:54:48 -0400
Date: Thu, 26 Jun 2003 18:54:52 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: selinux@tycho.nsa.gov
Subject: abusive dnsbl's
Message-ID: <Pine.LNX.4.44.0306261850530.14586-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, I have to send this to the list....

Russell,

You are using a revenge list for spam blocking.  There is no need to ever
block open relays.  First, only anti-spammer zealots abuse open relays
sending commercial-looking but non-commercial abuse (type 3 abuse, by my
taxonomy). And second, you can easilly block this abuse (and abuse of
closed relays)  by looking at the IP addreses in the headers added by the
relay. There is no way for the spammer to alter these headers (despite the
myth promoted by the open relay abusers that you can't "trust" headers
outside your own servers. You don't need to trust them--You only need to
detect the IP addresses of the abusers. These IP addresses can't be
removed by the abusers.

It is in your interest to block abuse of closed relays as well. Once you
setup proper filters, the use of a relay (open or closed) doesn't have any
benefit for the abuser.

You should be aware that the people running the so-called "open relay"
blacklists have almost nothing to do with spam (except by sending it
themselves).  These "blacklists" are the only sources of open relay
scanning (as determined by logs tracing scanners and their deposit
mailboxes), and their lists make it into commercial free relay and free
proxy lists such as run by helllabs.com.ua and ghostsender.com.

You would be much better off to block their sites, and prevent their
scanning. However, you should also be aware that if you stop using their
services, you will be spammed at a higher rate in revenge. So, you have to
be prepared to deal with abuse detection and prevention.

		--Dean

---------- Forwarded message ----------
Date: Tue, 24 Jun 2003 19:21:26 -0400
From: Mail Delivery Subsystem <MAILER-DAEMON@citation.av8.net>
To: dean@av8.com
Subject: Returned mail: Service unavailable

The original message was received at Tue, 24 Jun 2003 19:18:10 -0400
from vista.av8.net [130.105.36.10]

   ----- The following addresses had permanent fatal errors -----
<russell@coker.com.au>

   ----- Transcript of session follows -----
... while talking to ns.sws.net.au.:
>>> RCPT To:<russell@coker.com.au>
<<< 554 Service unavailable; [130.105.12.4] blocked using dnsbl.njabl.org, reason: relay tested -- 1021527005
554 <russell@coker.com.au>... Service unavailable


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
