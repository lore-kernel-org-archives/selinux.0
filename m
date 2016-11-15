Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFN7aYZ015669
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 18:07:37 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E5C4A564CBF
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 00:07:35 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol: make parsing symbol table headers more robust
Date: Wed, 16 Nov 2016 00:07:23 +0100
Message-Id: <20161115230723.20043-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161115230723.20043-1-nicolas.iooss@m4x.org>
References: <20161115230723.20043-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When hll/pp loads a policy file which has been modified so that the
nprim field of one of its non-empty symbol table was changed to zero, it
crashes with a segmentation fault. A quick analysis leads to
"p->sym_val_to_name[i] = (char **)alloc(p->symtab[i].nprim, sizeof(char
*));" in policydb_index_others(), which is not executed when
p->symtab[i].nprim is zero even though there are items in
p->symtab[i].table.

Detect such an oddity in the policy file early to exit with a clean
error message.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b112fd5465b5..d1019e42de16 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3510,6 +3510,10 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 			return -1;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
+		if (nel && !nprim) {
+			ERR(fp->handle, "unexpected items in decl symbol table with no symbol");
+			return -1;
+		}
 		for (j = 0; j < nel; j++) {
 			if (read_f[i] (p, decl->symtab[i].table, fp)) {
 				return -1;
@@ -3881,6 +3885,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
+		if (nel && !nprim) {
+			ERR(fp->handle, "unexpected items in symbol table with no symbol");
+			goto bad;
+		}
 		for (j = 0; j < nel; j++) {
 			if (read_f[i] (p, p->symtab[i].table, fp))
 				goto bad;
-- 
2.10.2
