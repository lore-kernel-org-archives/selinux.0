Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9BNDvjH007219
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 19:13:57 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9BNCe4J020086
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 23:12:40 GMT
Message-Id: <20061011231356.095058000@hp.com>
References: <20061011231046.825517000@hp.com>
Date: Wed, 11 Oct 2006 19:10:47 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, eparis@redhat.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/3] NetLabel: only deref the CIPSOv4 standard map fields when using standard mapping
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

Fix several places in the CIPSO code where it was dereferencing fields which
did not have valid pointers by moving those pointer dereferences into code
blocks where the pointers are valid.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

Index: net-2.6_bugfix_2/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6_bugfix_2.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6_bugfix_2/net/ipv4/cipso_ipv4.c
@@ -773,13 +773,15 @@ static int cipso_v4_map_cat_rbm_valid(co
 {
 	int cat = -1;
 	u32 bitmap_len_bits = bitmap_len * 8;
-	u32 cipso_cat_size = doi_def->map.std->cat.cipso_size;
-	u32 *cipso_array = doi_def->map.std->cat.cipso;
+	u32 cipso_cat_size;
+	u32 *cipso_array;
 
 	switch (doi_def->type) {
 	case CIPSO_V4_MAP_PASS:
 		return 0;
 	case CIPSO_V4_MAP_STD:
+		cipso_cat_size = doi_def->map.std->cat.cipso_size;
+		cipso_array = doi_def->map.std->cat.cipso;
 		for (;;) {
 			cat = cipso_v4_bitmap_walk(bitmap,
 						   bitmap_len_bits,
@@ -825,8 +827,8 @@ static int cipso_v4_map_cat_rbm_hton(con
 	u32 net_spot_max = 0;
 	u32 host_clen_bits = host_cat_len * 8;
 	u32 net_clen_bits = net_cat_len * 8;
-	u32 host_cat_size = doi_def->map.std->cat.local_size;
-	u32 *host_cat_array = doi_def->map.std->cat.local;
+	u32 host_cat_size;
+	u32 *host_cat_array;
 
 	switch (doi_def->type) {
 	case CIPSO_V4_MAP_PASS:
@@ -838,6 +840,8 @@ static int cipso_v4_map_cat_rbm_hton(con
 		memcpy(net_cat, host_cat, net_spot_max);
 		return net_spot_max;
 	case CIPSO_V4_MAP_STD:
+		host_cat_size = doi_def->map.std->cat.local_size;
+		host_cat_array = doi_def->map.std->cat.local;
 		for (;;) {
 			host_spot = cipso_v4_bitmap_walk(host_cat,
 							 host_clen_bits,
@@ -893,8 +897,8 @@ static int cipso_v4_map_cat_rbm_ntoh(con
 	int net_spot = -1;
 	u32 net_clen_bits = net_cat_len * 8;
 	u32 host_clen_bits = host_cat_len * 8;
-	u32 net_cat_size = doi_def->map.std->cat.cipso_size;
-	u32 *net_cat_array = doi_def->map.std->cat.cipso;
+	u32 net_cat_size;
+	u32 *net_cat_array;
 
 	switch (doi_def->type) {
 	case CIPSO_V4_MAP_PASS:
@@ -903,6 +907,8 @@ static int cipso_v4_map_cat_rbm_ntoh(con
 		memcpy(host_cat, net_cat, net_cat_len);
 		return net_cat_len;
 	case CIPSO_V4_MAP_STD:
+		net_cat_size = doi_def->map.std->cat.cipso_size;
+		net_cat_array = doi_def->map.std->cat.cipso;
 		for (;;) {
 			net_spot = cipso_v4_bitmap_walk(net_cat,
 							net_clen_bits,

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
