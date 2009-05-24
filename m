Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4OGVqIj032580
	for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 12:31:52 -0400
Received: from mail-gx0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4OGViAq014046
	for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 16:31:58 GMT
Received: by gxk7 with SMTP id 7so2319057gxk.18
        for <selinux@tycho.nsa.gov>; Sun, 24 May 2009 09:31:30 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 24 May 2009 09:31:04 -0700
Message-ID: <dd18b0c30905240931u49912081o88fc47ec1599187a@mail.gmail.com>
Subject: SELinux acl's options
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been freaking out for a few weeks at looking
at ls -Z and seeing a dot at the end of the permissions.
(then after gogling I found)
http://www.linux-archive.org/fedora-development/285498-dot-end-permissions-something-new.html

relieving me of thinking I have a hole in the ACL's.

Anyways how would one go about changing
the "." to a "+" at the end of the permission?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
