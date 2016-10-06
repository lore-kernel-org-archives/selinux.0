From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, gary.tierney@gmx.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: genhomedircon: do not suppress logging from
 libsepol
Date: Thu,  6 Oct 2016 10:18:20 -0400
Message-Id: <1475763500-32441-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As reported by Gary Tierney, genhomedircon suppresses logging from
libsepol when validating contexts.  This can result in an
empty file_contexts.homedirs file without any warning to the user
if policy has been incorrectly configured.  Remove the code that
was suppressing the logging so that errors are reported to the user.

Reported-by: Gary Tierney <gary.tierney@gmx.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/genhomedircon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 0dd2b29..6991fff 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -573,11 +573,8 @@ static int check_line(genhomedircon_settings_t * s, Ustr *line)
 	result = sepol_context_from_string(s->h_semanage->sepolh,
 					   ctx_str, &ctx_record);
 	if (result == STATUS_SUCCESS && ctx_record != NULL) {
-		sepol_msg_set_callback(s->h_semanage->sepolh, NULL, NULL);
 		result = sepol_context_check(s->h_semanage->sepolh,
 					     s->policydb, ctx_record);
-		sepol_msg_set_callback(s->h_semanage->sepolh,
-				       semanage_msg_relay_handler, s->h_semanage);
 		sepol_context_free(ctx_record);
 	}
 	return result;
-- 
2.7.4
