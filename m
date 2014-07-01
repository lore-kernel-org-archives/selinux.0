Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s61MgKEn001191
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 18:42:20 -0400
Message-ID: <1404254542.75666.YahooMailNeo@web120704.mail.ne1.yahoo.com>
Date: Tue, 1 Jul 2014 15:42:22 -0700
From: Andy Ruch <adruch2002@yahoo.com>
Subject: semanage commit forces CPU to 100%
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

﻿Hello,

I'm experiencing a pretty serious issue when making changes with semanage. I'm running RHEL 6.5 with a custom SELinux policy. The semanage process will lockup and use 100% of the CPU. The only way to stop it is to hard reset the system. When I reset the system, the SELinux policy will sometimes become corrupt, forcing me to re-install the policy. This issue will occur roughly one third of the time I run semanage. I have seen this happen when performing several different actions, including doing an SELinux policy RPM update. For testing, however, I repeatedly run:

semanage user -a -R sysadm_r -R staff_r -r s0-s0:c0.c1023 myuser_u


I was able to trace it through the python code to where commit() is being called, but I haven't dug into the C code yet. Has anyone seen anything like this before? It could be a problem with my policy, but why doesn't it happen every time? Any thoughts on where to look in the C code?



Thanks,
Andy Ruch
