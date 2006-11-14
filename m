Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAELwccK002307
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 16:58:38 -0500
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAELvsWe005701
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 21:57:54 GMT
Message-ID: <455A3C1A.20209@hp.com>
Date: Tue, 14 Nov 2006 16:58:50 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Cc: vyekkirala@TrustedCS.com, jmorris@namei.org
Subject: Cleaning up selinux_socket_getpeersec_dgram()
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that IPsec labeling is using the sksec->peer_sid field too I'm working on a
patch to clean up the selinux_socket_getpeersec_{stream,dgram}() functions and I
was wondering if anyone had an objection to replacing
selinux_socket_getpeer_dgram() with selinux_skb_xfrm_sid()?

The actual work done is slightly different but I don't think it's different
enough to cause any problems.  The main issue that I see is that
selinux_socket_getpeer_dgram() checks to make sure that the packet is a UDP
packet but I don't think that should cause any problems.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
