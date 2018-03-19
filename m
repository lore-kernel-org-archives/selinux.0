Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2JIndY8010370
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 14:49:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 404lV76Qp8z2SlcB
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 18:49:35 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 404lV75Rn3z2Slc0
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 18:49:35 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id r82so7151923wme.0
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 11:49:35 -0700 (PDT)
Sender: Pierre-Hugues Husson <phhusson@gmail.com>
From: Pierre-Hugues Husson <phh@phh.me>
To: selinux@tycho.nsa.gov
Cc: phh@phh.me, Tri Vo <trong@android.com>,
 Pierre-Hugues Husson <phhusson@gmail.com>
Date: Mon, 19 Mar 2018 19:47:56 +0100
Message-Id: <20180319184756.12561-2-phh@phh.me>
In-Reply-To: <20180319184756.12561-1-phh@phh.me>
References: <20180319184756.12561-1-phh@phh.me>
Subject: [PATCH 1/1] Delete identical genfscon-s
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Pierre-Hugues Husson <phhusson@gmail.com>

secilc has a multiple_decls option to allow for multiple type
declarations.
The next step is to allow multiple samples of the same rules.
This commit does this on genfscon

One usecase is Android/Project Treble:
With Project Treble, vendor might include rules included in later
in framework.
In order to be able to update the framework in this case, we need
to remove identical rules.
---
 libsepol/cil/src/cil_post.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index a2122454..8446158e 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -53,6 +53,16 @@
 static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
 static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
 
+static int compact(void* array, int count, int len, int (*compar)(const void *, const void *)) {
+	char *a = (char*)array;
+	int i, j = 0;
+	for(i=1; i<count; i++) {
+		if(compar(a+i*len, a+j*len) != 0) j++;
+		if(i != j) memcpy(a+j*len, a+i*len, len);
+	}
+	return j;
+}
+
 static int cil_verify_is_list(struct cil_list *list, enum cil_flavor flavor)
 {
 	struct cil_list_item *curr;
@@ -2118,6 +2128,7 @@ static int cil_post_db(struct cil_db *db)
 
 	qsort(db->netifcon->array, db->netifcon->count, sizeof(db->netifcon->array), cil_post_netifcon_compare);
 	qsort(db->genfscon->array, db->genfscon->count, sizeof(db->genfscon->array), cil_post_genfscon_compare);
+	db->genfscon->count = compact(db->genfscon->array, db->genfscon->count, sizeof(db->genfscon->array), cil_post_genfscon_compare);
 	qsort(db->ibpkeycon->array, db->ibpkeycon->count, sizeof(db->ibpkeycon->array), cil_post_ibpkeycon_compare);
 	qsort(db->ibendportcon->array, db->ibendportcon->count, sizeof(db->ibendportcon->array), cil_post_ibendportcon_compare);
 	qsort(db->portcon->array, db->portcon->count, sizeof(db->portcon->array), cil_post_portcon_compare);
-- 
2.15.1
