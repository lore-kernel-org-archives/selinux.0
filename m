Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08564
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 12:34:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA00687
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 16:32:54 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA00683
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 16:32:53 GMT
Date: Fri, 24 Aug 2001 12:33:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Selinux lsm and Free Swan
In-Reply-To: <Pine.SOL.3.95.1010824112248.1386C-300000@clipper.gw.tislabs.com>
Message-ID: <Pine.SOL.3.95.1010824123028.1386O-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I just looked briefly at the FreeSWAN KLIPS code, and I
think the problem is being caused by the call to 
sock_queue_rcv_skb by the PF_KEY socket code.  So the
patch to tcp_ipv4.c is probably unnecessary.  Just
try the patch to hooks.c and see if it works for you.
In that case, skipping the network access control checks 
in selinux_sock_rcv_skb is ok, because it is a 
kernel-daemon communication.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
