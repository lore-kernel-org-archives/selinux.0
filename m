Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA18027
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 16:12:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA19359
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 21:10:57 GMT
Received: from c001.snv.cp.net (c001-h001.c001.snv.cp.net [209.228.32.115])
        by jazzband.ncsc.mil  with SMTP id VAA19355 for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 21:10:56 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: SMP mode?
Date: Mon, 25 Mar 2002 16:12:23 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMIENFCAAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.GSO.4.33.0203250901130.1015-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen D. Smalley, NAI Labs wrote:

>You never responded to my earlier questions, sent on 3/20 to the list.  Is
>it failing on a sendto/sendmsg call or some other call?  Does the problem
>occur with a kernel built with the CONFIG_SECURITY_IP option disabled?

The EPERM is returned on a sendto call.
The program worked with CONFIG_SECURITY_IP disabled (just tested it).

Leslie
--
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
