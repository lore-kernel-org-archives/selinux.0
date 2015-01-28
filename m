Date: Wed, 28 Jan 2015 09:42:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Paul Moore <paul@paul-moore.com>
Subject: [patch] SELinux: fix error code in policydb_init()
Message-ID: <20150128064239.GB30893@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: selinux@tycho.nsa.gov, kernel-janitors@vger.kernel.org,
 linux-security-module@vger.kernel.org, Himangi Saraogi <himangi774@gmail.com>,
 James Morris <james.l.morris@oracle.com>, Namhyung Kim <namhyung@kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If hashtab_create() returns a NULL pointer then we should return -ENOMEM
but instead the current code returns success.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index bc2a586..74aa224 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -289,12 +289,16 @@ static int policydb_init(struct policydb *p)
 		goto out;
 
 	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
-	if (!p->filename_trans)
+	if (!p->filename_trans) {
+		rc = -ENOMEM;
 		goto out;
+	}
 
 	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
-	if (!p->range_tr)
+	if (!p->range_tr) {
+		rc = -ENOMEM;
 		goto out;
+	}
 
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
