Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RMwhXQ025511
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 18:58:43 -0400
Received: by pbbrr13 with SMTP id rr13so5587511pbb.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 15:58:42 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 Jul 2012 15:58:41 -0700
Message-ID: <CAFftDdqvjCJY+EoxGN+0QcHPVTv7Gzpg8ykDaPVG2-R32TyzqA@mail.gmail.com>
Subject: Mirrors
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Recently, I used a SE Android mirror.

After the repository was initialized with --mirror I had a cron job
the updated us every night through script. The script would repo init
(on the appropriate branch) pull the local manifest over .repo and
sync again. This all worked until the projects moved to bitbucket, now
for some reason it dies, it literally hangs checking out the objects.

I then merged the local manifest project paths and branches into my
manifest to other people in my team can just do a checkout with repo
init -b seandroid (and others)

Did anyone else have something similar setup and did they have similar
issues? Does anyone possibly know the cause?

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
