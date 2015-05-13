Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4D2BE9O027874
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 22:11:14 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t4D2BBE2028240
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 19:11:11 -0700 (PDT)
From: <wenzong.fan@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] mcstransd: fix reload issue
Date: Wed, 13 May 2015 10:11:09 +0800
Message-ID: <1431483069-16408-1-git-send-email-wenzong.fan@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Wenzong Fan <wenzong.fan@windriver.com>

Generally mcstransd works well on MLS enabled system, but if "Reload
Translations" triggered, it will fail to translate any MLS level.

* Why it fails:

Check process_trans() in mcstrans.c:

 723 process_trans(char *buffer) {
 724         static domain_t *domain;
 [snip] ...
 784         if (!domain) {
 785                 domain = create_domain("Default");

While reloading translations, the struct of domain will be destroyed
but the static pointer will be kept, it becomes wild and prevents the
create_domain() from running; Then invalid domain will be used for
initializing hashtable that stores translations data.

* Fix to it:

Define local *domain to get the struct of domain always be initialized;
Use static hashtable to store all translations data.

Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
---
 policycoreutils/mcstrans/src/mcstrans.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/mcstrans/src/mcstrans.c b/policycoreutils/mcstrans/src/mcstrans.c
index 4d31857..e8eda32 100644
--- a/policycoreutils/mcstrans/src/mcstrans.c
+++ b/policycoreutils/mcstrans/src/mcstrans.c
@@ -100,11 +100,14 @@ typedef struct base_classification {
 	struct base_classification *next;
 } base_classification_t;
 
+static context_map_node_t *table_raw_to_trans[N_BUCKETS];
+static context_map_node_t *table_trans_to_raw[N_BUCKETS];
+
 typedef struct domain {
 	char *name;
 
-	context_map_node_t *raw_to_trans[N_BUCKETS];
-	context_map_node_t *trans_to_raw[N_BUCKETS];
+	context_map_node_t **raw_to_trans;
+	context_map_node_t **trans_to_raw;
 
 	base_classification_t *base_classifications;
 	word_group_t *groups;
@@ -643,9 +646,11 @@ add_cache(domain_t *domain, char *raw, char *trans) {
 	}
 
 	log_debug(" add_cache (%s,%s)\n", raw, trans);
+	domain->raw_to_trans = table_raw_to_trans;
 	if (add_to_hashtable(domain->raw_to_trans, map->raw, map) < 0)
 		goto err;
 
+	domain->trans_to_raw = table_trans_to_raw;
 	if (add_to_hashtable(domain->trans_to_raw, map->trans, map) < 0)
 		goto err;
 
@@ -721,7 +726,7 @@ static int read_translations(const char *filename);
  */
 static int
 process_trans(char *buffer) {
-	static domain_t *domain;
+	domain_t *domain;
 	static word_group_t *group;
 	static int base_classification;
 	static int lineno = 0;
-- 
1.9.1
