From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Nov 2017 19:40:40 +0900
Message-Id: <1510569641-28179-1-git-send-email-yamada.masahiro@socionext.com>
Subject: [PATCH] selinux: remove unnecessary assignment to subdir-
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Makefile.clean descends into $(subdir-y).  Dummy assignment to subdir-
is meaningless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will pick this up for kbuild tree
since this is very trivial from the build system point of view.


 scripts/selinux/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/selinux/Makefile b/scripts/selinux/Makefile
index e8049da..b3048b8 100644
--- a/scripts/selinux/Makefile
+++ b/scripts/selinux/Makefile
@@ -1,2 +1 @@
 subdir-y := mdp genheaders
-subdir-	+= mdp genheaders
-- 
2.7.4
