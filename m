From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: inline selinux_is_enabled in !CONFIG_SECURITY_SELINUX
To: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Cc: torvalds@linux-foundation.org, jmorris@namei.org, sds@tycho.nsa.gov
Date: Mon, 14 Sep 2009 20:59:48 -0400
Message-ID: <20090915005948.12692.40854.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Without this patch building a kernel emits millions of warning like:

include/linux/selinux.h:92: warning: ‘selinux_is_enabled’ defined but not used

When it is build without CONFIG_SECURITY_SELINUX.  This is harmless, but
the function should be inlined, so it gets compiled out.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/selinux.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 223d06a..82e0f26 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -89,7 +89,7 @@ static inline void selinux_secmark_refcount_dec(void)
 	return;
 }
 
-static bool selinux_is_enabled(void)
+static inline bool selinux_is_enabled(void)
 {
 	return false;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
