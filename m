Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AE44Rb014948
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 10:04:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4AE42YW008255
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 14:04:02 GMT
Received: from ensi-bourges.fr (ldap.ensi-bourges.fr [194.206.83.68])
        by jazzband.ncsc.mil  with ESMTP id i4AE41Bf008246 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 14:04:01 GMT
Received: from unknown (HELO virus.ensi-bourges.fr) ([172.20.128.204])
          (envelope-sender <amine.baina@ensi-bourges.fr>)
          by ldap.ensi-bourges.fr (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 10 May 2004 14:56:48 -0000
Message-ID: <35767.172.20.128.112.1084201008.squirrel@ldap.ensi-bourges.fr>
In-Reply-To: <1084191012.23757.19.camel@moss-spartans.epoch.ncsc.mil>
References: <20040510092141.GB2092@jmh.mhn.de>
     <1084191012.23757.19.camel@moss-spartans.epoch.ncsc.mil>
Date: Mon, 10 May 2004 14:56:48 -0000 (UTC)
Subject: patches
From: amine.baina@ensi-bourges.fr
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "Thomas Bleher" <bleher@informatik.uni-muenchen.de>,
   "SELinux ML " <selinux@tycho.nsa.gov>, "James Morris " <jmorris@redhat.com>,
   "Rik Faith" <faith@redhat.com>
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
