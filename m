Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0PJV0pP019785
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 14:31:00 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0PJUwfr003827
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 19:30:59 GMT
Message-Id: <201001251930.o0PJUuK8029078@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, cpebenito@tresys.com,
        srivasta@golden-gryphon.com
Subject: Re: bzip support in libsemanage and out of memory (userspace ticket 7)
Date: Mon, 25 Jan 2010 20:30:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

I have tested the patch that you created for libsemanage and it now works fine even without disabling bzip with bzip-blocksize=0 in semanage.conf (as it should normally be).

Excellent !

Perhaps, the patch should be committed. I think this is the best solution, as it is independent on whether fmemopen_seek() in glibc has been fixed or not.

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
