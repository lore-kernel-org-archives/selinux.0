From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070228202028.854889454@hp.com>
References: <20070228201419.115784233@hp.com>
Date: Wed, 28 Feb 2007 15:14:20 -0500
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [RFC 1/4] NetLabel: cleanup and document CIPSO constants
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch collects all of the CIPSO constants and puts them in one place; it
also documents each value explaining how the value is derived.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |   37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

Index: net-2.6_future/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6_future.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6_future/net/ipv4/cipso_ipv4.c
@@ -92,6 +92,33 @@ int cipso_v4_rbm_optfmt = 0;
 int cipso_v4_rbm_strictvalid = 1;
 
 /*
+ * Protocol Constants
+ */
+
+/* Maximum size of the CIPSO IP option, derived from the fact that the maximum
+ * IPv4 header size is 60 bytes and the base IPv4 header is 20 bytes long. */
+#define CIPSO_V4_OPT_LEN_MAX          40
+
+/* Length of the base CIPSO option, this includes the option type (1 byte), the
+ * option length (1 byte), and the DOI (4 bytes). */
+#define CIPSO_V4_HDR_LEN              6
+
+/* Base length of the restrictive category bitmap tag (tag #1). */
+#define CIPSO_V4_TAG_RBM_BLEN         4
+
+/* Base length of the enumerated category tag (tag #2). */
+#define CIPSO_V4_TAG_ENUM_BLEN        4
+
+/* Base length of the ranged categories bitmap tag (tag #5). */
+#define CIPSO_V4_TAG_RNG_BLEN         4
+/* The maximum number of category ranges permitted in the ranged category tag
+ * (tag #5).  You may note that the IETF draft states that the maximum number
+ * of category ranges is 7, but if the low end of the last category range is
+ * zero then it is possibile to fit 8 category ranges because the zero should
+ * be omitted. */
+#define CIPSO_V4_TAG_RNG_CAT_MAX      8
+
+/*
  * Helper Functions
  */
 
@@ -1108,15 +1135,12 @@ static int cipso_v4_map_cat_rng_hton(con
 				     unsigned char *net_cat,
 				     u32 net_cat_len)
 {
-	/* The constant '16' is not random, it is the maximum number of
-	 * high/low category range pairs as permitted by the CIPSO draft based
-	 * on a maximum IPv4 header length of 60 bytes - the BUG_ON() assertion
-	 * does a sanity check to make sure we don't overflow the array. */
 	int iter = -1;
-	u16 array[16];
+	u16 array[CIPSO_V4_TAG_RNG_CAT_MAX * 2];
 	u32 array_cnt = 0;
 	u32 cat_size = 0;
 
+	/* make sure we don't overflow the 'array[]' variable */
 	BUG_ON(net_cat_len > 30);
 
 	for (;;) {
@@ -1195,9 +1219,6 @@ static int cipso_v4_map_cat_rng_ntoh(con
  * Protocol Handling Functions
  */
 
-#define CIPSO_V4_OPT_LEN_MAX          40
-#define CIPSO_V4_HDR_LEN              6
-
 /**
  * cipso_v4_gentag_hdr - Generate a CIPSO option header
  * @doi_def: the DOI definition

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
