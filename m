From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: selinux@tycho.nsa.gov, serge@hallyn.com, james.l.morris@oracle.com,
 eparis@parisplace.org, sds@tycho.nsa.gov, paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Sat, 26 Aug 2017 16:17:35 +0530
Message-Id: <0cf3cc3fd48c3b0b9d1766c73ac4faea2a733bf3.1503744266.git.arvind.yadav.cs@gmail.com>
Subject: [PATCH] selinux: constify nf_hook_ops
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

nf_hook_ops are not supposed to change at runtime. nf_register_net_hooks
and nf_unregister_net_hooks are working with const nf_hook_ops.
So mark the non-const nf_hook_ops structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 33fd061..2f2e133 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6530,7 +6530,7 @@ security_initcall(selinux_init);
 
 #if defined(CONFIG_NETFILTER)
 
-static struct nf_hook_ops selinux_nf_ops[] = {
+static const struct nf_hook_ops selinux_nf_ops[] = {
 	{
 		.hook =		selinux_ipv4_postroute,
 		.pf =		NFPROTO_IPV4,
-- 
2.7.4
