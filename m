Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q71KmUjD019933
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2012 16:48:30 -0400
Received: by vbbfc26 with SMTP id fc26so8191448vbb.12
        for <selinux@tycho.nsa.gov>; Wed, 01 Aug 2012 13:48:29 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Aug 2012 13:48:29 -0700
Message-ID: <CAFftDdqABcoJbH+yEoe8dSRUuUxG2M72BCj0e27b=ZsWmYC6aA@mail.gmail.com>
Subject: init and /data/system policies
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the policy file is loaded early in init, before any
filesystems are mounted. This means that if their is a policy file in
data/system that should be used instead of the on in the rootdir
ramfs, and the data/system policy is ignored until you do a reload. I
was wondering what the security implications are of loading the policy
after the mount, or is it better just to do a setprop to reload policy
in an on fs section of init.rc?

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
