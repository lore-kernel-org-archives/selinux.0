Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA12977
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 05:45:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA10398
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 09:45:30 GMT
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com [194.25.134.21])
	by jazzswing.ncsc.mil  with ESMTP id JAA10394
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 09:45:29 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id 94E6E1B59C
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 11:32:06 +0200 (CEST)
Message-ID: <3D047478.87AD2BD1@dr-baldeweg.de>
Date: Mon, 10 Jun 2002 11:42:16 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: mingetty on SuSE
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I use mingetty on my SuSE 7.1. Mingetty needs read access to many
different types in the proc directory to run correct. 
Now me question: Is it possible to limit the access to the different
types only to the proc directory? I think no, but I hope anyone has an
solution. In the other case I can not get mingetty the permissions,
because it can read to much files. What getty programs do you use?

Thanks 

  Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
