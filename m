From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: dac.override@gmail.com, gary.tierney@gmx.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
Date: Fri, 14 Oct 2016 13:40:02 -0400
Message-Id: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a non-MLS policy was used with genhomedircon context_from_record()
in sepol would report an error because an MLS level was present when MLS
is disabled.  Based on a patch by Gary Tierney, amended to use
sepol_policydb_mls_enabled rather than semanage_mls_enabled because
we are testing the temporary working policy, not the active policy.

Reported-by: Jason Zaman <jason@perfinion.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/genhomedircon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 6991fff..5e9d722 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -638,7 +638,11 @@ static int write_contexts(genhomedircon_settings_t *s, FILE *out,
 			goto fail;
 		}
 
-		if (sepol_context_set_user(sepolh, context, user->sename) < 0 ||
+		if (sepol_context_set_user(sepolh, context, user->sename) < 0) {
+			goto fail;
+		}
+
+		if (sepol_policydb_mls_enabled(s->policydb) &&
 		    sepol_context_set_mls(sepolh, context, user->level) < 0) {
 			goto fail;
 		}
-- 
2.7.4
