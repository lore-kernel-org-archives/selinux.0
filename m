Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAELvVpP027952
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 16:57:33 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5E65F5649B9
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 22:57:31 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux,
 libsemanage: swig: use SWIG_fail when an error occurs
Date: Mon, 14 Nov 2016 22:57:12 +0100
Message-Id: <20161114215712.18962-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161114215712.18962-1-nicolas.iooss@m4x.org>
References: <20161114215712.18962-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Using SWIG_fail in the Python SWIG wrappers makes the wrapping function
destroy/free the memory which could have been dynamically allocated
before calling the wrapped function. This thus prevents possible memory
leaks in the wrappers of set*con(), set*con_raw(), security_compute_*(),
etc.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/exception.sh  | 2 +-
 libsemanage/src/exception.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
index a3ff83235ced..d6c8c71713ad 100755
--- a/libselinux/src/exception.sh
+++ b/libselinux/src/exception.sh
@@ -8,7 +8,7 @@ echo "
   \$action 
   if (result < 0) {
      PyErr_SetFromErrno(PyExc_OSError);
-     return NULL;
+     SWIG_fail;
   }
 }
 "
diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
index a4095f4f8ba6..97bc2ae879f2 100644
--- a/libsemanage/src/exception.sh
+++ b/libsemanage/src/exception.sh
@@ -4,7 +4,7 @@ echo "
   \$action
   if (result < 0) {
      PyErr_SetFromErrno(PyExc_OSError);
-     return NULL;
+     SWIG_fail;
   }
 }
 "
-- 
2.10.2
