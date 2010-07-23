Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6NHEwng012696
	for <selinux@tycho.nsa.gov>; Fri, 23 Jul 2010 13:14:58 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6NHF0b9024024
	for <selinux@tycho.nsa.gov>; Fri, 23 Jul 2010 17:15:00 GMT
Received: by gwb1 with SMTP id 1so928044gwb.12
        for <selinux@tycho.nsa.gov>; Fri, 23 Jul 2010 10:14:57 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 23 Jul 2010 12:14:57 -0500
Message-ID: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
Subject: fuse and selinux don't seem to work well together
From: Xavier Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm looking at building a fuse filesystem for polyinstantiated
directories which could be used as a alternative to pam_namespace.
I've noticed that my filesystem is never queried for the xattr
security.selinux and that the file contexts are defaulting to a fuse
file type. I've seen some list posting from 2004 related to this
subject but not much else. Is this a bug or a feature?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
