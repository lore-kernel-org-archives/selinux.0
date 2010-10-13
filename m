From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/6] kernel: roundup should only reference arguments once
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 13 Oct 2010 17:50:08 -0400
Message-ID: <20101013215008.17293.52249.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the roundup macro references it's arguments more than one time.
This patch changes it so it will only use its arguments once.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/kernel.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c23a33d..edef168 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -58,7 +58,12 @@ extern const char linux_proc_banner[];
 
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
-#define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
+#define roundup(x, y) (					\
+{							\
+	typeof(y) __y = y;				\
+	(((x) + (__y - 1)) / __y) * __y;		\
+}							\
+)
 #define rounddown(x, y) (				\
 {							\
 	typeof(x) __x = (x);				\


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
