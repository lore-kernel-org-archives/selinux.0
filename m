Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ADrqRb014827
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 09:53:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4ADpW5b026931
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 13:51:32 GMT
Received: from ensi-bourges.fr (ldap.ensi-bourges.fr [194.206.83.68])
	by jazzswing.ncsc.mil  with ESMTP id i4ADpVql026907
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 13:51:32 GMT
Received: from unknown (HELO virus.ensi-bourges.fr) ([172.20.128.204])
          (envelope-sender <amine.baina@ensi-bourges.fr>)
          by ldap.ensi-bourges.fr (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 10 May 2004 14:46:26 -0000
Message-ID: <35687.172.20.128.112.1084200386.squirrel@ldap.ensi-bourges.fr>
Date: Mon, 10 May 2004 14:46:26 -0000 (UTC)
Subject: patches
From: amine.baina@ensi-bourges.fr
To: "SELinux ML" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

I want to include a coreutils-selinux.patch into the file coreutils.spec,
but I don't know how to do. however I've tried to do it, but I think it
had created errors.

Next, Is it normal to have an empty coreutils-selinux.patch file ?

In addition, when doing :
rpm -ivh  coreutils.rpm, I have a conflict  with file-utils, sh-utils, and
text-utils.

Is it necessary to upgrade text-utils, sh-utils and file-utils to cope
with this confilcts or to delete the installed ones?

I think I'm near the solution but I've a lack of details

may day may day ...
A.B



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
