Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0PGtPZI008745
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 11:55:33 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0PGtPJn010480
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 16:55:26 GMT
Message-Id: <201001251655.o0PGtN7O021880@vivaldi37.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sds@tycho.nsa.gov
Cc: jbrindle@tresys.com, cpebenito@tresys.com, selinux@tycho.nsa.gov,
        refpolicy@oss1.tresys.com
Subject: Nessun oggetto
Date: Mon, 25 Jan 2010 17:55:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

And yes, I actually went trough that same problem at line 243 of the Makefile, replace with:

seusers := config/appconfig-mls/seusers

and then it should build. I don't know why it doesn't expand properly...

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
