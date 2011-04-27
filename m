Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RMxu5F022323
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 18:59:56 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3RMxtfH006362
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 22:59:55 GMT
Received: by iwn2 with SMTP id 2so2167277iwn.12
        for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 15:59:55 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Apr 2011 15:59:55 -0700
Message-ID: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
Subject: Is there difference betweek sefiles and restorecon in terms of labels
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looking at man pages of sefiles and restorecon , both mention that
they initialize security context database ( extended attributes) on
one or more filesystems.

There are certainly differences between command line arguments, but
can these programs be used interchangeably as far as extended
attributes they assign to files?

-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
