From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/6] SELinux: skip filename trans rules if ttype does not
	match parent dir
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Tue, 26 Apr 2011 14:07:51 -0400
Message-ID: <20110426180751.20636.83434.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Right now we walk to filename trans rule list for every inode that is
created.  First passes at policy using this facility creates around 5000
filename trans rules.  Running a list of 5000 entries every time is a bad
idea.  This patch adds a new ebitmap to policy which has a bit set for each
ttype that has at least 1 filename trans rule.  Thus when an inode is
created we can quickly determine if any rules exist for this parent
directory type and can skip the list if we know there is definitely no
relevant entry.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |    6 ++++++
 security/selinux/ss/policydb.h |    2 ++
 security/selinux/ss/services.c |    9 +++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5591e42..4c18119 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -240,6 +240,7 @@ static int policydb_init(struct policydb *p)
 	if (!p->range_tr)
 		goto out;
 
+	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
@@ -801,6 +802,7 @@ void policydb_destroy(struct policydb *p)
 		ft = nft;
 	}
 
+	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
 
@@ -1868,6 +1870,10 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		ft->ttype = le32_to_cpu(buf[1]);
 		ft->tclass = le32_to_cpu(buf[2]);
 		ft->otype = le32_to_cpu(buf[3]);
+
+		rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
+		if (rc)
+			goto out;
 	}
 	rc = 0;
 out:
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 801175f..f054a9d 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -227,6 +227,8 @@ struct policydb {
 	/* role transitions */
 	struct role_trans *role_tr;
 
+	/* quickly exclude lookups when parent ttype has no rules */
+	struct ebitmap filename_trans_ttypes;
 	/* file transitions with the last path component */
 	struct filename_trans *filename_trans;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 40aa930..0d55071 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1363,6 +1363,15 @@ static void filename_compute_type(struct policydb *p, struct context *newcontext
 				  const char *objname)
 {
 	struct filename_trans *ft;
+
+	/*
+	 * Most filename trans rules are going to live in specific directories
+	 * like /dev or /var/run.  This bitmap will quickly skip rule searches
+	 * if the ttype does not contain any rules.
+	 */
+	if (!ebitmap_get_bit(&p->filename_trans_ttypes, ttype))
+		return;
+
 	for (ft = p->filename_trans; ft; ft = ft->next) {
 		if (ft->stype == stype &&
 		    ft->ttype == ttype &&


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
