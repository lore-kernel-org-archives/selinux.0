Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6B0aXMt032559
 for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2018 20:36:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 41QKrH5RJbz1pJ8x
 for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2018 00:36:31 +0000 (UTC)
Received: from UPDC3CPA12_EEMSG_MP28.eemsg.mil (unknown [192.168.18.23])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 41QKrG5bF8z1pJ8t
 for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2018 00:36:30 +0000 (UTC)
Received: by mail-qk0-f178.google.com with SMTP id c131-v6so12604932qkb.0
 for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2018 17:36:29 -0700 (PDT)
To: SELinux <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss.tresys.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <5b4f3f88-46a2-9e86-55ce-112208cb1717@ieee.org>
Date: Tue, 10 Jul 2018 20:36:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: ANN: SETools 4.2.0-beta
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

An SETools 4.2.0-beta release is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.2.0-beta

Changes since v4.1.1:

* Replaced the Python/SWIG/static-linked-libsepol policyrep module with 
a Cython implementation. This will have performance and memory-usage 
improvements and breaks the static linking to libsepol.

* Significant memory usage reduction in sediff (approximately 60%, 
depending on the policies).

* Added support for SCTP portcons

* Updated permission maps

This release of SETools has changed dependencies since 4.1.1. See 
README.md for more details.

-- 
Chris PeBenito
