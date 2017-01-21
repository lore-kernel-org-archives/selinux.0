Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0LEQOog012692
 for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2017 09:26:24 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A1B1E5647DE
 for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2017 15:26:22 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] checkpolicy: fix memory leaks in define_filename_trans()
Date: Sat, 21 Jan 2017 15:26:11 +0100
Message-Id: <20170121142613.12375-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170121142613.12375-1-nicolas.iooss@m4x.org>
References: <20170121142613.12375-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When parsing type_transition statements with names, the memory allocated
by the type set bitmaps of variable stypes and ttypes was never freed.

Call type_set_destroy() to free this memory and, while at it, make the
function exits without leaking memory when exiting with an error.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 03a0c18a9686..eab940878ad1 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3256,22 +3256,24 @@ int define_filename_trans(void)
 		return 0;
 	}
 
+	type_set_init(&stypes);
+	type_set_init(&ttypes);
+	ebitmap_init(&e_stypes);
+	ebitmap_init(&e_ttypes);
+	ebitmap_init(&e_tclasses);
 
 	add = 1;
-	type_set_init(&stypes);
 	while ((id = queue_remove(id_queue))) {
 		if (set_types(&stypes, id, &add, 0))
 			goto bad;
 	}
 
 	add =1;
-	type_set_init(&ttypes);
 	while ((id = queue_remove(id_queue))) {
 		if (set_types(&ttypes, id, &add, 0))
 			goto bad;
 	}
 
-	ebitmap_init(&e_tclasses);
 	if (read_classes(&e_tclasses))
 		goto bad;
 
@@ -3288,6 +3290,7 @@ int define_filename_trans(void)
 	typdatum = hashtab_search(policydbp->p_types.table, id);
 	if (!typdatum) {
 		yyerror2("unknown type %s used in transition definition", id);
+		free(id);
 		goto bad;
 	}
 	free(id);
@@ -3302,11 +3305,9 @@ int define_filename_trans(void)
 	/* We expand the class set into seperate rules.  We expand the types
 	 * just to make sure there are not duplicates.  They will get turned
 	 * into seperate rules later */
-	ebitmap_init(&e_stypes);
 	if (type_set_expand(&stypes, &e_stypes, policydbp, 1))
 		goto bad;
 
-	ebitmap_init(&e_ttypes);
 	if (type_set_expand(&ttypes, &e_ttypes, policydbp, 1))
 		goto bad;
 
@@ -3386,11 +3387,18 @@ int define_filename_trans(void)
 	ebitmap_destroy(&e_stypes);
 	ebitmap_destroy(&e_ttypes);
 	ebitmap_destroy(&e_tclasses);
+	type_set_destroy(&stypes);
+	type_set_destroy(&ttypes);
 
 	return 0;
 
 bad:
 	free(name);
+	ebitmap_destroy(&e_stypes);
+	ebitmap_destroy(&e_ttypes);
+	ebitmap_destroy(&e_tclasses);
+	type_set_destroy(&stypes);
+	type_set_destroy(&ttypes);
 	return -1;
 }
 
-- 
2.11.0
