Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DJHqbY032165
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 15:17:52 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol/cil: Fixed bug in cil_type_match_any()
Date: Wed, 13 Apr 2016 15:19:15 -0400
Message-Id: <1460575157-5846-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

An attribute that has no types associated with it should still match
with itself, but ebitmap_match_any() will return false if there are
no bits set in either bitmap. The solution is to check to see if the
two datums passed into cil_type_match_any() are the same. This has
the additional advantage of providing a quick match anytime the
attributes are the same.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_find.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index 75de886..8e0688c 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -69,7 +69,11 @@ static int cil_type_match_any(struct cil_symtab_datum *d1, struct cil_symtab_dat
 		/* Both are attributes */
 		struct cil_typeattribute *a1 = (struct cil_typeattribute *)d1;
 		struct cil_typeattribute *a2 = (struct cil_typeattribute *)d2;
-		return ebitmap_match_any(a1->types, a2->types);
+		if (d1 == d2) {
+			return CIL_TRUE;
+		} else if (ebitmap_match_any(a1->types, a2->types)) {
+			return CIL_TRUE;
+		}
 	}
 	return CIL_FALSE;
 }
-- 
2.5.5
