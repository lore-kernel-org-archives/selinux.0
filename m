Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7115pOE032605
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 21:05:51 -0400
Received: by vcbfl17 with SMTP id fl17so7082769vcb.12
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2012 18:05:50 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 31 Jul 2012 18:05:50 -0700
Message-ID: <CAFftDdp7C3tR7NHBfYrHRn2-y9fRNJAPHnXurOb3y4jJEUkKBQ@mail.gmail.com>
Subject: SE Android ZoneInfo Errors
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is anyone else getting these when building the newest master for Maguro?

E/Zygote  (  821): 	at libcore.util.ZoneInfoDB.mapData(ZoneInfoDB.java:109)
E/Zygote  (  821): 	at libcore.util.ZoneInfoDB.<clinit>(ZoneInfoDB.java:75)
E/Zygote  (  821): 	... 12 more
E/Zygote  (  821): Caused by: libcore.io.ErrnoException: open failed:
ENOENT (No such file or directory)

It was originally bawking about other files not being there, and I
pushed them from another device, but the list keeps growing...

I looked at libcore and everything looks up to date...
-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
