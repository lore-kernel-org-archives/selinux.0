Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F24C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687C2084A
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 19:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="KzT2juPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfEJTCs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 15:02:48 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:56178 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfEJTCs (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 15:02:48 -0400
X-Greylist: delayed 2765 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2019 15:02:40 EDT
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4AIGTtC013583
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 21:16:30 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4AIGTtC013583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1557512190;
        bh=INCNAEaXqXslTYGLGVdtSjhNE0bbWQ2j0JRy5SB4dCs=;
        h=Date:From:To:Subject:From;
        b=KzT2juPXR/Lp4mtaWeI6f+3Caei829YA1plavlZQHtScJrhbvrbybDdHmktMJndST
         uKirZDmC9fJ1nXAZro8LDUS/E7Ukl5/8neFP3+Jzn5MM7YuWxNNexV9VQRIHIIJufF
         hnKn96wiNWyrSv2Fn3DHen/AQpj8xYsqDmZlTfRhv7LV3pH1YAKIIEke7T5P5ucmyc
         Y3ot83WDEjvr1YaQpuZq30cOePaiicun2C/BRusW+36Sr7YeGkccu9D8p2TKFm/+eV
         kz0YODM8QfQxj2P2qonQZwaMPPs4sx2lcHHltOppSNmVfQDS4su9dH6HZULNXZ5po6
         SG4agCgAiWDhA==
Date:   Fri, 10 May 2019 21:16:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: Subject: [PATCH 1/2] Unify code style to preserve my sanity
Message-ID: <alpine.LFD.2.21.1905102114490.16225@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



---
 libselinux/src/audit2why.c    | 10 +++++-----
 libselinux/src/booleans.c     |  4 ++--
 libselinux/src/init.c         |  4 ++--
 libselinux/src/label_file.c   |  8 ++++----
 libselinux/src/mapping.c      |  6 +++---
 libselinux/src/matchpathcon.c |  2 +-
 libselinux/src/seusers.c      |  2 +-
 libselinux/src/sha1.c         | 24 ++++++++++++------------
 libselinux/src/stringrep.c    |  6 +++---
 9 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 5a1e69a8..d56b56eb 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -291,7 +291,7 @@ static int __policy_init(const char *init_path)
 
 static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
   int result;
-  char *init_path=NULL;
+  char *init_path = NULL;
   if (avc) {
 	  PyErr_SetString( PyExc_RuntimeError, "init called multiple times");
 	  return NULL;
@@ -322,7 +322,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 	sepol_access_vector_t perm, av;
 	struct sepol_av_decision avd;
 	int rc;
-	int i=0;
+	int i = 0;
 
 	if (!PyArg_ParseTuple(args,(char *)"sssO!:audit2why",&scon,&tcon,&tclassstr,&PyList_Type, &listObj)) 
 		return NULL;
@@ -353,7 +353,7 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 
 	/* iterate over items of the list, grabbing strings, and parsing
 	   for numbers */
-	for (i=0; i<numlines; i++){
+	for (i = 0; i < numlines; i++){
 		const char *permstr;
 
 		/* grab the string object from the next element of the list */
@@ -395,13 +395,13 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 		} else {
 			PyObject *outboollist;
 			struct boolean_t *b = bools;
-			int len=0;
+			int len = 0;
 			while (b->name) {
 				len++; b++;
 			}
 			b = bools;
 			outboollist = PyList_New(len);
-			len=0;
+			len = 0;
 			while(b->name) {
 				PyObject *bool_ = Py_BuildValue("(si)", b->name, b->active);
 				PyList_SetItem(outboollist, len++, bool_);
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index a6d46fea..ab1e0754 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -125,10 +125,10 @@ char *selinux_boolean_sub(const char *name)
 			dst++;
 		if (!*dst)
 			continue;
-		ptr=dst;
+		ptr = dst;
 		while (*ptr && !isspace(*ptr))
 			ptr++;
-		*ptr='\0';
+		*ptr = '\0';
 
 		sub = strdup(dst);
 
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 2690a72f..083638c4 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -83,8 +83,8 @@ hidden_def(selinuxfs_exists)
 
 static void init_selinuxmnt(void)
 {
-	char *buf=NULL, *p;
-	FILE *fp=NULL;
+	char *buf = NULL, *p;
+	FILE *fp = NULL;
 	size_t len;
 	ssize_t num;
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b81fd552..45317619 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -635,10 +635,10 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		dst = ptr;
 		while (*dst && isspace(*dst))
 			dst++;
-		ptr=dst;
+		ptr = dst;
 		while (*ptr && ! isspace(*ptr))
 			ptr++;
-		*ptr='\0';
+		*ptr = '\0';
 		if (! *dst)
 			continue;
 
@@ -647,11 +647,11 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 			goto err;
 		memset(sub, 0, sizeof(*sub));
 
-		sub->src=strdup(src);
+		sub->src = strdup(src);
 		if (! sub->src)
 			goto err;
 
-		sub->dst=strdup(dst);
+		sub->dst = strdup(dst);
 		if (! sub->dst)
 			goto err;
 
diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index 33cea5ae..96395fd4 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -143,7 +143,7 @@ unmap_perm(security_class_t tclass, access_vector_t tperm)
 		unsigned i;
 		access_vector_t kperm = 0;
 
-		for (i=0; i<current_mapping[tclass].num_perms; i++)
+		for (i = 0; i < current_mapping[tclass].num_perms; i++)
 			if (tperm & (1<<i)) {
 				kperm |= current_mapping[tclass].perms[i];
 				tperm &= ~(1<<i);
@@ -169,7 +169,7 @@ map_class(security_class_t kclass)
 {
 	security_class_t i;
 
-	for (i=0; i<current_mapping_size; i++)
+	for (i = 0; i < current_mapping_size; i++)
 		if (current_mapping[i].value == kclass)
 			return i;
 
@@ -189,7 +189,7 @@ map_perm(security_class_t tclass, access_vector_t kperm)
 		unsigned i;
 		access_vector_t tperm = 0;
 
-		for (i=0; i<current_mapping[tclass].num_perms; i++)
+		for (i = 0; i < current_mapping[tclass].num_perms; i++)
 			if (kperm & current_mapping[tclass].perms[i]) {
 				tperm |= 1<<i;
 				kperm &= ~current_mapping[tclass].perms[i];
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 58b4144a..05a5cfa4 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -414,7 +414,7 @@ int realpath_not_final(const char *name, char *resolved_path)
 	if (len + strlen(last_component) + 2 > PATH_MAX) {
 		myprintf("symlink_realpath(%s) failed: Filename too long \n",
 			name);
-		errno=ENAMETOOLONG;
+		errno = ENAMETOOLONG;
 		rc = -1;
 		goto out;
 	}
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index 572a7b01..7ec7d12c 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -274,7 +274,7 @@ int getseuser(const char *username, const char *service,
 	char *buffer = NULL;
 	size_t size = 0;
 	char *rec = NULL;
-	char *path=NULL;
+	char *path = NULL;
 	FILE *fp = NULL;
 	if (asprintf(&path,"%s/logins/%s", selinux_policy_root(), username) <  0)
 		goto err;
diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 9bcbb6ee..d671044d 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -78,7 +78,7 @@ void
     CHAR64LONG16        workspace;
     CHAR64LONG16*       block = &workspace;
 
-    memcpy( block, buffer, 64 );
+    memcpy(block, buffer, 64);
 
     // Copy context->state[] to working vars
     a = state[0];
@@ -160,18 +160,18 @@ void hidden
     uint32_t    j;
 
     j = (Context->Count[0] >> 3) & 63;
-    if( (Context->Count[0] += BufferSize << 3) < (BufferSize << 3) )
+    if ((Context->Count[0] += BufferSize << 3) < (BufferSize << 3))
     {
         Context->Count[1]++;
     }
 
     Context->Count[1] += (BufferSize >> 29);
-    if( (j + BufferSize) > 63 )
+    if ((j + BufferSize) > 63)
     {
         i = 64 - j;
-        memcpy( &Context->Buffer[j], Buffer, i );
+        memcpy(&Context->Buffer[j], Buffer, i);
         TransformFunction(Context->State, Context->Buffer);
-        for( ; i + 63 < BufferSize; i += 64 )
+        for (; i + 63 < BufferSize; i += 64)
         {
             TransformFunction(Context->State, (uint8_t*)Buffer + i);
         }
@@ -182,7 +182,7 @@ void hidden
         i = 0;
     }
 
-    memcpy( &Context->Buffer[j], &((uint8_t*)Buffer)[i], BufferSize - i );
+    memcpy(&Context->Buffer[j], &((uint8_t*)Buffer)[i], BufferSize - i);
 }
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -201,19 +201,19 @@ void hidden
     uint32_t    i;
     uint8_t     finalcount[8];
 
-    for( i=0; i<8; i++ )
+    for (i = 0; i < 8; i++)
     {
         finalcount[i] = (unsigned char)((Context->Count[(i >= 4 ? 0 : 1)]
          >> ((3-(i & 3)) * 8) ) & 255);  // Endian independent
     }
-    Sha1Update( Context, (uint8_t*)"\x80", 1 );
-    while( (Context->Count[0] & 504) != 448 )
+    Sha1Update(Context, (uint8_t*)"\x80", 1);
+    while ((Context->Count[0] & 504) != 448)
     {
-        Sha1Update( Context, (uint8_t*)"\0", 1 );
+        Sha1Update(Context, (uint8_t*)"\0", 1);
     }
 
-    Sha1Update( Context, finalcount, 8 );  // Should cause a Sha1TransformFunction()
-    for( i=0; i<SHA1_HASH_SIZE; i++ )
+    Sha1Update(Context, finalcount, 8);  // Should cause a Sha1TransformFunction()
+    for (i = 0; i < SHA1_HASH_SIZE; i++)
     {
         Digest->bytes[i] = (uint8_t)((Context->State[i>>2] >> ((3-(i & 3)) * 8) ) & 255);
     }
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 2d83f960..ad29f76d 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -147,7 +147,7 @@ static struct discover_class_node * discover_class(const char *s)
 
 err4:
 	closedir(dir);
-	for (i=0; i<MAXVECTORS; i++)
+	for (i = 0; i < MAXVECTORS; i++)
 		free(node->perms[i]);
 err3:
 	free(node->name);
@@ -214,7 +214,7 @@ security_class_t mode_to_security_class(mode_t m) {
 	if (S_ISSOCK(m))
 		return string_to_security_class("sock_file");
 
-	errno=EINVAL;
+	errno = EINVAL;
 	return 0;
 }
 
@@ -226,7 +226,7 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 	node = get_class_cache_entry_value(kclass);
 	if (node != NULL) {
 		size_t i;
-		for (i=0; i<MAXVECTORS && node->perms[i] != NULL; i++)
+		for (i = 0; i < MAXVECTORS && node->perms[i] != NULL; i++)
 			if (strcmp(node->perms[i],s) == 0)
 				return map_perm(tclass, 1<<i);
 	}
-- 
2.21.0

