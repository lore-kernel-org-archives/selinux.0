Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0H9HNIi014132
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 04:17:24 -0500 (EST)
Received: from sun1000.pwr.wroc.pl (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0H9HPA9001500
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 09:17:25 GMT
Received: from sun1000 (sun1000.pwr.wroc.pl [156.17.1.33])
 by sun1000.pwr.wroc.pl
 (Sun Java System Messaging Server 6.1 HotFix 0.06 (built Nov 11 2004))
 with ESMTP id <0IAG00BRIF52YPC0@sun1000.pwr.wroc.pl> for
 selinux@tycho.nsa.gov; Mon, 17 Jan 2005 10:17:27 +0100 (CET)
Received: from mail.pwr.wroc.pl ([156.17.5.174])
 by sun1000.pwr.wroc.pl (Sun Java System Messaging Server 6.1 HotFix 0.06
 (built Nov 11 2004)) with ESMTPS id <0IAG00M6HF51HS50@sun1000.pwr.wroc.pl> for
 selinux@tycho.nsa.gov; Mon, 17 Jan 2005 10:17:26 +0100 (CET)
Date: Mon, 17 Jan 2005 10:17:25 +0100 (CET)
From: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Subject: Getting default context
To: selinux@tycho.nsa.gov
Message-id: <Pine.GSO.4.44.0501170946330.16567-100000@sun1000.pwr.wroc.pl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

I try to use get_default_context() function.
There is in my code:  get_default_context(pw_name,NULL,&scontext),
pw_name is "bartol", and I have default context definied in
/etc/selinux/strict/contexts/default_contexts:
system_r:pbs_mom_t bartol_r:bartol_t
Role bartol_r is the only role allowed to bartol.
SELinux is in permissive mode.
As a result get_default_context() returns error.

What have I forgotten ?

regards,
Bartlomiej Balcerek




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
