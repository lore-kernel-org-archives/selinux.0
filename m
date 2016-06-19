Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5JFFht4005721
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 11:15:44 -0400
Sender: sven.vermeulen@siphos.be
Received: by mail-oi0-f52.google.com with SMTP id p204so179380700oih.3
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 08:15:35 -0700 (PDT)
MIME-Version: 1.0
From: Sven Vermeulen <sven.vermeulen@siphos.be>
Date: Sun, 19 Jun 2016 17:15:34 +0200
Message-ID: <CAPzO=NzdEVwf+BZKopVjoi2z2L4=VOnbeGGrbum0Uxe=D_W8qQ@mail.gmail.com>
Subject: When/how to use "delete" in CIL?
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all

I'm going through the information at
https://github.com/SELinuxProject/cil/wiki to try some new things that
CIL offers. One of the documented "features" is to delete rules from
the final policy using the "(delete ...)" statement.

However, when I try to use that, I always get the failure "Error:
Unknown keyword delete".

The test.cil file is pretty simple:
(delete (allow sysadm_t rsync_etc_t (file (read))))

~# semodule -i test.cil
Error: Unknown keyword delete
semodule:  Failed!

I considered that it might only work when it builds everything
together with secilc, so I tried that as well:

~$ secilc -c 29 /var/lib/selinux/mcs/active/modules/400/*/cil test.cil
Error: Unknown keyword delete
Failed to compile cildb: -1

Perhaps this keyword is not part of the final CIL construction? That
wiki page above is from before it got merged in the main userspace,
but I didn't find a more up-to-date version of that information.

Wkr,
  Sven Vermeulen
