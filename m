From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: header generation may hit infinite loop
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Fri, 20 Nov 2009 11:00:12 -0500
Message-ID: <20091120160012.9892.90998.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If a permission name is long enough the selinux class definition generation
tool will go into a infinite loop.  This is because it's macro max() is
fooled into thinking it is dealing with unsigned numbers.  This patch makes
sure the macro always uses signed number so 1 > -1.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 scripts/selinux/genheaders/genheaders.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index 771b86f..2462696 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -13,7 +13,7 @@ struct security_class_mapping {
 #include "classmap.h"
 #include "initial_sid_to_string.h"
 
-#define max(x, y) ((x > y) ? x : y)
+#define max(x, y) (((int)(x) > (int)(y)) ? x : y)
 
 const char *progname;
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
