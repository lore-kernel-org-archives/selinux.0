Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBH2XPF013053
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 12:02:34 -0500
Received: from g1t0027.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBH2WDp009860
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:02:32 GMT
Received: from g1t0027.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 386FE381E5
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:02:28 +0000 (UTC)
Received: from mailstation.cce.hp.com (mailstation.zcce.gate.cpqcorp.net [16.104.192.124])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by g1t0027.austin.hp.com (Postfix) with ESMTP id 31AE3380D0
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:02:28 +0000 (UTC)
Received: from stuffed.lan (c-24-61-189-47.hsd1.nh.comcast.net [24.61.189.47])
	by mailstation.cce.hp.com (Postfix) with ESMTP id 134EFC05B
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 11:04:24 -0600 (CST)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Network flow controls and subj/obj ordering
Date: Tue, 11 Dec 2007 12:02:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712111202.20074.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everybody,

After a discussion with Venkat last week we decided that it was probably best 
if I took responsibility for the flow control patches and ported/cleaned them 
up for inclusion in the labeled networking patches for 2.6.25.  In the course 
of doing so I ran across the problem of subject/object "ordering" (probably 
not the best term, but it's all I can think of right now).  In both the "flow 
in" and "flow out" cases I'm tempted to use the packet's peer label as the 
object just for the sake of consistency and the ability to use the new "peer" 
object class for all network peer label access checks.  However, I wanted to 
make sure that is what everyone had in mind from a conceptual point of view.  
See the two simple policy examples below:

 * Packet "flows" into the system, peer label is the object

   allow netif_t peerlbl_t:peer flow_in;

 * Packet "flows" out of the system, peer label is the object

   allow netif_t peerlbl_t:peer flow_out;

Thoughts, opinions?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
