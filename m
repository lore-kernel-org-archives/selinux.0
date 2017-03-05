From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] selinux: include sys/socket.h in host programs to have
 PF_MAX
Date: Sun,  5 Mar 2017 15:01:52 +0100
Message-Id: <20170305140152.12728-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Compiling with clang and -Wundef makes the compiler report a usage of
undefined PF_MAX macro in security/selinux/include/classmap.h:

    In file included from scripts/selinux/mdp/mdp.c:48:
    security/selinux/include/classmap.h:37:31: warning: no previous
    extern declaration for non-static variable 'secclass_map'
    [-Wmissing-variable-declarations]
    struct security_class_mapping secclass_map[] = {
                                  ^
    security/selinux/include/classmap.h:235:5: error: 'PF_MAX' is not
    defined, evaluates to 0 [-Werror,-Wundef]
    #if PF_MAX > 43
        ^
    In file included from scripts/selinux/genheaders/genheaders.c:17:
    security/selinux/include/classmap.h:37:31: warning: no previous
    extern declaration for non-static variable 'secclass_map'
    [-Wmissing-variable-declarations]
    struct security_class_mapping secclass_map[] = {
                                  ^
    security/selinux/include/classmap.h:235:5: error: 'PF_MAX' is not
    defined, evaluates to 0 [-Werror,-Wundef]
    #if PF_MAX > 43
        ^

PF_MAX is defined in include/linux/socket.h but not in
include/uapi/linux/socket.h. Therefore host programs have to rely on the
definition from libc's /usr/include/bits/socket.h, included by
<sys/socket.h>.

Fix the issue by using sys/socket.h in mdp and genheaders. When
classmap.h is included by security/selinux/avc.c, it uses the kernel
definition of PF_MAX, which makes the test consistent.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 scripts/selinux/genheaders/genheaders.c | 1 +
 scripts/selinux/mdp/mdp.c               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index f4dd41f900d5..6a24569c3578 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <errno.h>
 #include <ctype.h>
+#include <sys/socket.h>
 
 struct security_class_mapping {
 	const char *name;
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index c29fa4a6228d..ffe8179f5d41 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -32,6 +32,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
+#include <sys/socket.h>
 
 static void usage(char *name)
 {
-- 
2.11.1
