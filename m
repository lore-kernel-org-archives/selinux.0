Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5GDMFuL024472
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 09:22:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID12.oob.disa.mil (Postfix) with SMTP id 417J1K4WVxz39Zxv
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 13:22:13 +0000 (UTC)
Received: from USFB19PA19_EEMSG_MP21.eemsg.mil (unknown [192.168.16.12])
 by USFBF3ID12.oob.disa.mil (Postfix) with ESMTP id 417J1K2ZC6z39Zxr
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 13:22:13 +0000 (UTC)
Received: by mail-qk0-f193.google.com with SMTP id k86-v6so7125869qkh.13
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 06:22:11 -0700 (PDT)
To: SELinux <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss.tresys.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <9dca3429-8c41-9ae6-a244-7286e10f376f@ieee.org>
Date: Sat, 16 Jun 2018 09:20:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: ANN: SETools repo move
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The SETools repository moved.  It is now available on the SELinuxProject 
GitHub project:

https://github.com/SELinuxProject/setools


If you are following the master branch, there are significant changes:

* Replaced the Python/SWIG/static-linked-libsepol policyrep module with 
a Cython implementation.  This will have performance and memory-usage 
improvements and breaks the static linking to libsepol.
* Significant memory usage reduction in sediff (approximately 60%, 
depending on the policies).

These will be the main changes for the next SETools release.

-- 
Chris PeBenito
