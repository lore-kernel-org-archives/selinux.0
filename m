From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, jwcart2@tycho.ns.gov, brindle@quarksecurity.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] libsepol: fix type bounds checking for attributes
Date: Thu, 28 Apr 2016 16:02:39 -0400
Message-Id: <1461873759-29136-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1461873759-29136-1-git-send-email-sds@tycho.nsa.gov>
References: <1461873759-29136-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The type bounds / hierarchy checker was incorrectly handling
rules with attributes as the target type, causing it to trigger
violations if the parent type lacked a rule directly to the same
attribute even if the parent had all the permissions to the
types associated with that attribute.  Skip the degenerate
case and only check for the individual types.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/hierarchy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index ba65978..79db3a6 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -318,6 +318,8 @@ static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
 					       &avtab_key, data);
 			if (!d) continue;
 			td = p->type_val_to_struct[i];
+			if (!td || td->flavor == TYPE_ATTRIB)
+				continue;
 			if (td && td->bounds) {
 				avtab_key.target_type = td->bounds;
 				d = bounds_not_covered(global_avtab, cur_avtab,
-- 
2.5.5
