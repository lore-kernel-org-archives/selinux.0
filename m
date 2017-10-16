Date: Mon, 16 Oct 2017 17:44:03 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <alpine.LFD.2.20.1710161736340.9932@t440.gateway.2wire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH][RFC] selinuxns: mark init_selinux_ns as
 __ro_after_init
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a patch against the SELinux namespace work.

Mark the initial SELinux namespace pointer as __ro_after_init, to harden 
against malicious overwrite by an attacker.

Signed-off-by: James Morris <james.l.morris@oracle.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3daad14..98dbf57 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -97,7 +97,7 @@
 #include "audit.h"
 #include "avc_ss.h"
 
-struct selinux_ns *init_selinux_ns;
+struct selinux_ns *init_selinux_ns __ro_after_init;
 
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
-- 
1.8.3.1


-- 
James Morris
<james.l.morris@oracle.com>
