Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54Kw9w5021387
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 16:58:09 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 9DE3035C104
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 20:58:07 +0000 (UTC)
Subject: [PATCH v3 2/6] selinux-testsuite: add some default CFLAGS
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 16:58:06 -0400
Message-ID: <20150604205806.19614.30244.stgit@localhost>
In-Reply-To: <20150604205708.19614.64746.stgit@localhost>
References: <20150604205708.19614.64746.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 8100b8f..b679137 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,5 +1,5 @@
 
-export CFLAGS+=-D_GNU_SOURCE
+export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 
