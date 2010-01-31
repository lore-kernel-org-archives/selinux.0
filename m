Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0VNKUpF005771
	for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2010 18:20:30 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0VNKKHE020437
	for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2010 23:20:20 GMT
Message-Id: <201001312320.o0VNKR5f022273@vivaldi37.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 00:20:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

I am writing again to include a few more notes about the patch that I just posted.

You might want to check a few duplicate function declarations in ss/services.h and include/security.h (I did not know the best place for them, but when trying to build, selinuxfs.c was complaining about not finding declarations for functions in services.c, so I decided to update and include services.h, not knowing that the global security.h was already including some declarations).

But I can well move the declarations to security.h if it is better...

Regards,

Guido Trentalancia 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
