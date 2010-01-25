Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0PJ68eB018189
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 14:06:12 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0PJ6Afr020497
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 19:06:11 GMT
Message-Id: <201001251905.o0PJ5m4V030845@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, cpebenito@tresys.com,
        manoj.srivastava@stdc.com
Subject: Re: bzip support in libsemanage and out of memory (userspace ticket 7)
Date: Mon, 25 Jan 2010 20:05:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

thanks for your message. The situation is now clear. A bug in glibc which is at version 2.7 on my Debian Lenny system.

The patch sounds great. Should I go ahead with testing it and then report ?

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
