Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IL5xnq019725
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 17:06:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 418kCV08Gzz1pJ9G
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 21:05:58 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 418kCS30Mnz1pJ99
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 21:05:56 +0000 (UTC)
Received: by mail-lf0-f50.google.com with SMTP id z207-v6so5430550lff.9
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 14:05:54 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Jun 2018 17:05:42 -0400
Message-ID: <CAHC9VhSN-Yw2ZLL7waym1kQ5Eoc=fE1ZAEBYpTiXTkYBe-Vzag@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: selinux/next rebased to v4.18-rc1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A quick note to let you know that I've rebased selinux/next on top of
v4.18-rc1, and now that merge window is closed I'm going to be working
my way through the patch backlog this week.

You may also notice that there is now a README.md in the
selinux/master branch with some basic information and links.
Eventually I'm going to add administrative information, e.g. the
SELinux kernel process[1], to this file so we have it in a central
location, but if there is anything else you can think of that should
be in this file let me know.

[1] http://www.paul-moore.com/blog/d/2017/07/kernel_repo_process.html

-- 
paul moore
www.paul-moore.com
