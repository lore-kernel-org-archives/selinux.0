From: Colin King <colin.king@canonical.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Oct 2017 13:46:55 +0100
Message-Id: <20171014124655.32438-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux: remove redundant assignment to str
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Colin Ian King <colin.king@canonical.com>

str is being assigned to an empty string but str is never being
read after that, so the assignment is redundant and can be removed.
Moving the declaration of str to a more localised block, cleans up
clang warning: "Value stored to 'str' is never read"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/selinux/hooks.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 07f35f3b4a13..3daf3369c3b4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3177,18 +3177,17 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 		if (!has_cap_mac_admin(true)) {
 			struct audit_buffer *ab;
 			size_t audit_size;
-			const char *str;
 
 			/* We strip a nul only if it is at the end, otherwise the
 			 * context contains a nul and we should audit that */
 			if (value) {
-				str = value;
+				const char *str = value;
+
 				if (str[size - 1] == '\0')
 					audit_size = size - 1;
 				else
 					audit_size = size;
 			} else {
-				str = "";
 				audit_size = 0;
 			}
 			ab = audit_log_start(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR);
-- 
2.14.1
