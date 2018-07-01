Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61HeMsP011778
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 13:40:22 -0400
Received: by mail-qt0-f170.google.com with SMTP id h5-v6so12082496qtm.13
 for <selinux@tycho.nsa.gov>; Sun, 01 Jul 2018 10:40:15 -0700 (PDT)
To: SELinux <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss.tresys.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <19f54ef9-4741-e5e0-5e6a-cac0576c8aa6@ieee.org>
Date: Sun, 1 Jul 2018 13:40:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: ANN: Reference Policy release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In this release, the refpolicy and refpolicy-contrib repositories were 
remerged; the modules were moved out of the contrib layer. It also 
includes a large update for the X Desktop Group base directory 
specification and SCTP support, among various other fixes.

Refpolicy now requires SELinux userspace v2.8 to compile.

<https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20180701>

-- 
Chris PeBenito
