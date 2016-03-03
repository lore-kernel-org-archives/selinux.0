Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u23JtN4K018868
 for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2016 14:55:23 -0500
Received: by mail-qk0-f170.google.com with SMTP id o6so12692733qkc.2
 for <selinux@tycho.nsa.gov>; Thu, 03 Mar 2016 11:55:21 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, linux-audit@redhat.com
Subject: Slight changes to the SELinux and audit kernel repository process
Date: Thu, 03 Mar 2016 14:55:19 -0500
Message-ID: <1668280.yoEPKDfd9Y@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello all,

Starting with this merge window I'm making some slight changes to the kernel 
repository process.  The short version is that I'm doing away with the 
'upstream' branch, and sending pull requests directly from the 'next' and 
'stable-X.YY' branches.  I expect this shouldn't have much impact on anyone 
and it should get back the commit ID consistency we lost with the most recent 
changes.

You can find more detail at the link below if you are interested:

 * http://www.paul-moore.com/blog/d/2016/03/kernel-repo-process.html

-Paul

-- 
paul moore
www.paul-moore.com
