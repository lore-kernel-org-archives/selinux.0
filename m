Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA15360
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 00:12:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA24954
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 05:12:13 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzswing.ncsc.mil  with ESMTP id FAA24948
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 05:12:12 GMT
Received: from avsrv1.mitre.org (avsrv1.mitre.org [129.83.20.58])
	by smtpproxy1.mitre.org (8.9.3/8.9.3) with ESMTP id AAA13276
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 00:12:27 -0500 (EST)
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1])
	by smtpsrv1.mitre.org (8.9.3/8.9.3) with ESMTP id AAA28723
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 00:12:26 -0500 (EST)
Received: from idiot-savant.mitre.org (idiot-savant.mitre.org [129.83.9.208])
	by linus.mitre.org (8.9.3/8.9.3) with ESMTP id AAA19939
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2001 00:12:26 -0500 (EST)
Date: Tue, 20 Feb 2001 00:12:26 -0500 (EST)
From: bede@mitre.org (Bede McCall)
Message-Id: <200102200512.AAA29801@idiot-savant.mitre.org>
To: selinux@tycho.nsa.gov
In-reply-to: <3A91639D.3BD5A0E6@iastate.edu> (message from Mark Slagell on Mon, 19 Feb 2001 12:19:09 -0600)
Subject: RE: scontext/tcontext/tclass
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

   Date: Mon, 19 Feb 2001 12:19:09 -0600
   From: Mark Slagell <ms@iastate.edu>

   [ . . . ] I wonder if someone would point out to me the difference
   between scontext and tcontext and make just one little light bulb
   come on here. I've been rtfm'ing for a while here and must be
   looking right at it, but it's not getting through.


Jen's explained it nicely already, but you'll find the usage "ssid",
"tsid", "scontext", etc., described starting around p. 7 in the paper
by Loscocco and Smalley:

                doc/kernel/slinux.{pdf,ps}    or
		doc/kernel/slinux/index.html

There's a companion paper by Smalley and Fraser about the policy
configuration:

		doc/policy/policy.{pdf,ps}    or
		doc/policy/policy/index.html

-- 
  Bede McCall   <bede@mitre.org>
  MITRE Corporation
  202 Burlington Road
  Bedford, Massachusetts  01730-1420

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
