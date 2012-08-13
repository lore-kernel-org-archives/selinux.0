Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7DMgxTa007610
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2012 18:42:59 -0400
Received: by vbbfc26 with SMTP id fc26so4639159vbb.12
        for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2012 15:42:58 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 13 Aug 2012 15:42:58 -0700
Message-ID: <CAFftDdqFwJFDjTaBnZ8wfORaVehmSdQw9X2K-Y+baVwgbvnH4w@mail.gmail.com>
Subject: SEAndroid policy question
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am still trying to fully understand sensitivity vs category with mls
constrains. I noticed that files are not labeled with a category, just
a sensitivity in all the example I looked at (s0). Are categories more
for "data in motion"?

ie 2 processes want to share data, they both have allow rules to
access their own files. App1 has a c0 and app2 is c0,c1 then based on
mls constraints data con be controlled between them?

Could you label files with categories too? or does that not make sense?

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
