Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0FKqKRb005444
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 15:52:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0FKqIiV012063
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 20:52:18 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
        by jazzband.ncsc.mil  with ESMTP id i0FKqH06012060 for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 20:52:17 GMT
Received: from rom.cip.informatik.uni-muenchen.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 0DA35435CC
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 21:52:16 +0100 (CET)
Date: Thu, 15 Jan 2004 21:51:36 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: run_init
Message-ID: <20040115205136.GG15738@rom.cip.informatik.uni-muenchen.de>
References: <4006E894.3040705@ipen.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <4006E894.3040705@ipen.br>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Carlos Anísio Monteiro <monteiro@ipen.br> [2004-01-15 21:21]:
> Helo.
> 
> I am with problems when running the run_init utility.
> 
> *# run_init /etc/init.d/apache start
> Authenticating root.
> Password:
> execvp: File or directory not found.
> #*

Most probably this is because you haven't installed expect which
is needed by run_init.
I think this should get a better error message.

HTH,
Thomas


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
