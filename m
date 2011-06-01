Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p51NhKrj009846
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 19:43:20 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p51NhJmi020412
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 23:43:19 GMT
Received: by iyb26 with SMTP id 26so341941iyb.12
        for <selinux@tycho.nsa.gov>; Wed, 01 Jun 2011 16:43:18 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Jun 2011 16:43:18 -0700
Message-ID: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
Subject: Is there way to set some specific domain to have all permissions?
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I want to set permission for say program in myprog_t to allow all
the permissions, is there way to do this in SELinux.

Example I have program myprog and rule to set it domain correctly,
what I want to do is this domain myprog_t should be able to do
anything.

How would one write such a policy rule? I have done search on mailing
list archive and see there was a long thread in 2007 called 'concept
of a permissive domain' but I am not able figure out what the
conclusion of that thread was...

-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
