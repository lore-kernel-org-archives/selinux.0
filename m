Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nALK9PeL003525
	for <selinux@tycho.nsa.gov>; Sat, 21 Nov 2009 15:09:25 -0500
Received: from ensi-bourges.fr (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nALKBUSS022748
	for <selinux@tycho.nsa.gov>; Sat, 21 Nov 2009 20:11:31 GMT
Received: from unknown (HELO webmail.ensi-bourges.fr) ([127.0.0.1])
          (envelope-sender <zaina.afoulki@ensi-bourges.fr>)
          by mail.ensi-bourges.fr (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 21 Nov 2009 20:09:22 -0000
Message-ID: <c6b26494ec7bae98008a7c19678b83bf.squirrel@webmail.ensi-bourges.fr>
Date: Sat, 21 Nov 2009 21:09:22 +0100 (CET)
Subject: List of all alert types
From: "Zaina AFOULKI" <zaina.afoulki@ensi-bourges.fr>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I'm quite new to using SELinux, I noticed that each alert in
/var/log/audit/audit.log starts with the type, examples :

type=USER_ROLE_CHANGE
type=USER_START
type=USER_AUTH

I'm trying to develop a graphical interface for SELinux alerts...
Is there a way I can get the list of all types ?
I searched for a while and couldn't find it, your help will be greatly
appreciated.

Thanks in advance,





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
