Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61EwrX5008350
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 10:58:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 41JYRv5jzRz2Sj4B
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 14:58:51 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 41JYRv21L3z2Sj45
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0E636561228
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 16:56:46 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Jul 2018 16:56:26 +0200
Message-Id: <20180701145626.12307-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] Travis-CI: use new location of refpolicy
 repository
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

refpolicy moved from github.com/TresysTechnology to
github.com/SELinuxProject. It is still used in sepolgen tests (they
build modules using Makefile.devel and build.conf) so update the
location of the repository.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 823af7ece532..0612eb5480e5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -65,10 +65,10 @@ addons:
 install:
   # Download refpolicy Makefile for sepolgen tests
   - sudo mkdir -p /usr/share/selinux/default
-  - sudo curl --retry 10 -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/support/Makefile.devel'
+  - sudo curl --retry 10 -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/SELinuxProject/refpolicy/RELEASE_2_20180114/support/Makefile.devel'
   - sudo sed "s,^PREFIX :=.*,PREFIX := $TRAVIS_BUILD_DIR/installdir/usr," -i /usr/share/selinux/default/Makefile
   - sudo mkdir -p /usr/share/selinux/refpolicy/include
-  - sudo curl --retry 10 -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/build.conf'
+  - sudo curl --retry 10 -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/SELinuxProject/refpolicy/RELEASE_2_20180114/build.conf'
   - sudo mkdir -p /etc/selinux
   - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
 
-- 
2.17.1
