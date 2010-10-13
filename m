From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/6] kernel: rounddown helper function
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 13 Oct 2010 17:50:02 -0400
Message-ID: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The roundup() helper function will round a given value up to a multiple of
another given value.  aka  roundup(11, 7) would give 14 = 7 * 2.  This new
function does the opposite.  It will round a given number down to the
nearest multiple of the second number: rounddown(11, 7) would give 7.

I need this in some future SELinux code and can carry the macro myself, but
figured I would put it in the core kernel so others might find and use it
if need be.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/kernel.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f5df2f4..c23a33d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -59,6 +59,12 @@ extern const char linux_proc_banner[];
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
+#define rounddown(x, y) (				\
+{							\
+	typeof(x) __x = (x);				\
+	__x - (__x % (y));				\
+}							\
+)
 #define DIV_ROUND_CLOSEST(x, divisor)(			\
 {							\
 	typeof(divisor) __divisor = divisor;		\


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
