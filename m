Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tALGRGRp011234
 for <selinux@tycho.nsa.gov>; Sat, 21 Nov 2015 11:27:17 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Fully expand neverallowxperm rules
Date: Sat, 21 Nov 2015 16:26:48 +0000
Message-Id: <1448123208-5557-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently neverallowxperm rules will be resolved correctly when
building policy, however they are not detectable when using tools
such as an updated version of setools. This patch will allow
these to be viewed in the same way as neverallow rules are in a
text based kernel policy file (e.g. policy.conf).

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/src/expand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 9047c6d..9cb7965 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1811,6 +1811,8 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		if (handle && handle->disable_dontaudit)
 			return EXPAND_RULE_SUCCESS;
 		spec = AVTAB_XPERMS_DONTAUDIT;
+	} else if (specified & AVRULE_XPERMS_NEVERALLOW) {
+		spec = AVTAB_XPERMS_NEVERALLOW;
 	} else {
 		assert(0);	/* unreachable */
 	}
@@ -1948,7 +1950,7 @@ static int convert_and_expand_rule(sepol_handle_t * handle,
 
 	if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
 		return EXPAND_RULE_SUCCESS;
-	if (source_rule->specified & AVRULE_XPERMS_NEVERALLOW)
+	if (!do_neverallow && source_rule->specified & AVRULE_XPERMS_NEVERALLOW)
 		return EXPAND_RULE_SUCCESS;
 
 	ebitmap_init(&stypes);
-- 
2.5.0
