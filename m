Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0JH8TXe030011
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 12:08:30 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Paul Moore <paul@paul-moore.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] selinux: use absolute path to include directory
Date: Tue, 19 Jan 2016 19:07:52 +0200
Message-Id: <1453223272-120888-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Compiler warns us a lot that it can't find include folder because it's provided
in relative form.

  CC      security/selinux/netlabel.o
cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]

Add $(srctree) prefix to the path.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2:
- apply change for all -I occurences
 security/selinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ad5cd76..b850811 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -13,7 +13,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
 selinux-$(CONFIG_NETLABEL) += netlabel.o
 
-ccflags-y := -Isecurity/selinux -Isecurity/selinux/include
+ccflags-y := -I$(srctree)security/selinux -I$(srctree)/security/selinux/include
 
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
-- 
2.7.0.rc3
