Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08658
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 12:49:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA15503
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 16:49:02 GMT
Received: from csoc-fire05.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzband.ncsc.mil  with SMTP id QAA15499
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2001 16:49:02 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015241C5@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Selinux lsm and Free Swan
Date: Fri, 24 Aug 2001 11:49:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The hooks.patch work great no problem with 
starting the Freeswan, I have yet to test it
out, I don't foresee any problems yet

Thanks
Mark Westerman

PS. Now I am trying to intergrate the international patch
for crypto file system



-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Friday, August 24, 2001 11:33 AM
To: Westerman, Mark
Cc: 'selinux@tycho.nsa.gov'
Subject: Re: Selinux lsm and Free Swan



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
