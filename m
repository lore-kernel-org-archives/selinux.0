Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8KG1PoO012972
 for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2017 12:01:27 -0400
Received: by mail-lf0-f48.google.com with SMTP id u21so3155844lfk.12
 for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2017 09:01:07 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Sep 2017 12:01:03 -0400
Message-ID: <CAHC9VhRwuN15zRtKPF_sF=H9h7J4qzqFuB7okY-EAXOqaSzXeg@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: FYI: selinux/next rebase to v4.14-rc1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If you've been following the SELinux and LSM mailing lists over the
past couple of weeks you know that there has been a shift in how the
SELinux kernel tree feeds into Linus' tree: we are now sending pull
request directly to Linus.  As part of this change I'm now going to be
basing the selinux/next branch on Linus' tree instead of the
linux-security/next; other than this change the process should be
pretty much the same.

The only immediate effect you may notice is that selinux/next is now
currently based on v4.14-rc1.  This is a side-effect of the
changeover, future rebases will aim to be based on major releases when
possible.

I've updated my blog post from earlier in the year for those who may
not be familiar on the process:

* http://www.paul-moore.com/blog/d/2017/07/kernel-repo-process.html

-- 
paul moore
www.paul-moore.com
