From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov
Subject: [PATCH] checkpolicy: fix double free on name-based type transitions
Date: Fri, 31 Jul 2015 09:03:11 -0400
Message-Id: <1438347791-20224-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

checkpolicy was directly assigning type sets rather than using
type_set_cpy() and therefore creating pointer aliases to the
same type set from multiple filename-based type transition rules
if they specified multiple classes.  This would then yield a double
free when destroying the rules afterward and a segmentation fault.
Fix it to use type_set_cpy().

Reported-by: William C Roberts <william.c.roberts@intel.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_define.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index da47566..7f32029 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3315,8 +3315,14 @@ int define_filename_trans(void)
 		append_filename_trans(ftr);
 
 		ftr->name = strdup(name);
-		ftr->stypes = stypes;
-		ftr->ttypes = ttypes;
+		if (type_set_cpy(&ftr->stypes, &stypes)) {
+			yyerror("out of memory");
+			goto bad;
+		}
+		if (type_set_cpy(&ftr->ttypes, &ttypes)) {
+			yyerror("out of memory");
+			goto bad;
+		}
 		ftr->tclass = c + 1;
 		ftr->otype = otype;
 	}
-- 
2.1.0
