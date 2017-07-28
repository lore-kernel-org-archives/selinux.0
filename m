Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6SKR40t024306
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 16:27:05 -0400
Received: by mail-lf0-f41.google.com with SMTP id o85so36083975lff.3
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 13:26:50 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Jul 2017 16:26:49 -0400
Message-ID: <CAHC9VhQfHjnxrnZ2ecd7VY4dJ71vcLOGeRa-T4eUL3ZyP8bmGg@mail.gmail.com>
To: selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: SELinux kernel repository moving to kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

A quick note that I'm moving the SELinux kernel repository from
infradead.org to kernel.org, please update your trees accordingly
(hint: "git remote set-url ...").

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

-- 
paul moore
www.paul-moore.com
