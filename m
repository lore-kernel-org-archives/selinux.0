Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03ItGXf022675
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 13:55:16 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03IsDqa021732
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 18:54:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6CB5361B0F
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:55:11 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19805-06 for <selinux@tycho.nsa.gov>;
	Wed, 4 Jan 2006 05:55:10 +1100 (EST)
Received: from temp.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C73AA61B04
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:55:10 +1100 (EST)
Received: from temp (temp [127.0.0.1])
	by temp.coker.com.au (Postfix) with ESMTP id C5D92C7F9A
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:55:09 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libsetrans performance patch
Date: Wed, 4 Jan 2006 05:54:57 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MisuDphRKKHBXD1"
Message-Id: <200601040555.08511.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_MisuDphRKKHBXD1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have optimised the libsetrans library a bit.  Changed locking of a FILE *, 
removed some needless strdup/strlen operations, and fixed a bug whereby 
strtrim could potentially copy random data from the heap (ended up removing 
strtrim).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_MisuDphRKKHBXD1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="libsetrans.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libsetrans.diff"

diff -rup libsetrans-0.1.11.orig/src/setrans.c libsetrans-0.1.11/src/setrans.c
--- libsetrans-0.1.11.orig/src/setrans.c	2005-12-08 00:50:31.000000000 +1100
+++ libsetrans-0.1.11/src/setrans.c	2006-01-02 20:28:36.000000000 +1100
@@ -3,7 +3,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <ctype.h>
+#include <alloca.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include "dso.h"
@@ -22,23 +24,6 @@ typedef struct labels {
 
 static labels_t *labellist=NULL;
 
-/* Remove excess white space */
-static char * strtrim(char *dest, char *source, int size) {
-	int i=0;
-	char *ptr=source;
-	i=0;
-	while(isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest,ptr,size);
-	for(i=strlen(dest)-1; i> 0; i--) {
-		if (!isspace(dest[i])) break;
-	}
-	dest[i+1]='\0';
-	return dest;
-}
-
 void finish_context_translations(void) {
 	labels_t *ptr=NULL;
 	labels_t *current=NULL;
@@ -56,54 +41,54 @@ void finish_context_translations(void) {
 
 /* Process line from translation file. 
    Remove white space and set name do data before the "=" and sename to data
-   after it */
-static int process_label(const char *buffer, labels_t **labels) {
-	char name[BUFSIZ];
-	char name1[BUFSIZ];
-	char *newbuf=strdup(buffer);
-	int namesize=sizeof(name);
+   after it
+   May modify the data pointed to by the buffer paremeter */
+static int process_label(char *buffer, labels_t **labels) {
+	char *name, *name_end;
 	labels_t *next=NULL;
-	char *ptr;
-	int rc=0;
+	char *ptr, *tok;
 	
-	if (!newbuf) return -1;
-
-	char *tok=strtok_r(newbuf,"=",&ptr);
-	if (!tok) goto err;
-	strncpy(name1,tok, BUFSIZ-1);
-	strtrim(name,name1,namesize-1);
-	if ( name[0]=='#' ) goto err;
-	tok=strtok_r(NULL,"\0",&ptr);
-	if (!tok) goto err;
+	while(isspace(*buffer))
+		buffer++;
+	if(buffer[0] == '#') return 0;
+	name = strtok_r(buffer, "=", &ptr);
+	if (!name || !*name) return 0;
+	tok = strtok_r(NULL, "\0", &ptr);
+	if (!tok) return 0;
+	name_end = tok - 2;
+	while(isspace(*name_end))
+	{
+		name_end = '\0';
+		name_end--;
+	}
 	while (isspace(*tok)) tok++;
+	if(!*tok) return 0;
 
 	next=(labels_t *) calloc(1, sizeof(labels_t));
 	if (!next) { 
-		rc=-1; 
-		goto err;
+		return -1;
 	}
 
 	next->label.name=strdup(name);
 	if (!next->label.name) {
 		free(next);
-		rc=-1; 
-		goto err;
+		return -1;
 	}
 
-	strncpy(name1,tok, BUFSIZ-1);
-	strtrim(name,name1,namesize-1);
-	next->label.sename=strdup(name);
+	name_end = tok + strlen(tok) - 1;
+	while(isspace(*name_end))
+	{
+		*name_end = '\0';
+		name_end--;
+	}
+	next->label.sename=strdup(tok);
 	if (!next->label.sename) {
 		free(next->label.name);
 		free(next);
-		rc=-1; 
-		goto err;
+		return -1;
 	}
 	*labels=next;
-	rc=1;
-err:		
-	free(newbuf);
-	return rc;
+	return 1;
 }
 
 /* Look for selabel via internal name */
@@ -121,21 +106,15 @@ static const char *translate_internal(co
 }
 static char *translate_categories(const char *sensitivity, const char *cat) {
 	char *label=NULL;
-	char *inbuf=NULL;
-	int slen=strlen(sensitivity);
+	char *inbuf = alloca(strlen(sensitivity) + strlen(cat) + 2);
 	char *ptr;
 	int error=0;
-	char *categories=strdup(cat);
-	if (!categories) return NULL;
+	char *categories=strdupa(cat);
+	if (!categories || !inbuf) return NULL;
 	char *tok=strtok_r(categories,",",&ptr);
 
 	while (tok) {
 		const char *trans;
-		inbuf=malloc(slen+strlen(tok)+2);
-		if (!inbuf) {
-			error=1;
-			break;
-		}
 		sprintf(inbuf, "%s:%s", sensitivity, tok);
 		trans=translate_internal(inbuf);
 		if (strcmp(trans, inbuf)==0) {
@@ -156,13 +135,10 @@ static char *translate_categories(const 
 			}
 			free(tmp);
 		}
-		free(inbuf); inbuf=NULL;
 		tok=strtok_r(NULL,",",&ptr);
 	}
-	free(categories);
 	if (error) {
 		if (label) free(label);
-		if (inbuf) free(inbuf);
 		return NULL;
 	}
 	return label;
@@ -175,7 +151,7 @@ static const char *translate(const char 
 	if (orig) {
 		if (strcmp(orig,labels)==0) {
 			char *translated=NULL;
-			char *tmpbuf=strdup(orig);
+			char *tmpbuf=strdupa(orig);
 			char *ptr=NULL;
 			char *tok=NULL;
 			char *sensitivity=NULL;
@@ -196,8 +172,6 @@ static const char *translate(const char 
 				
 			}
 		done:
-			if (tmpbuf)
-				free(tmpbuf);
 			if (categories) {
 				free(categories);
 				return translated;
@@ -209,7 +183,7 @@ static const char *translate(const char 
 }
 
 /* Look for selabel via external name */
-static char *untranslate_internal(const char *sename) {
+static const char *untranslate_internal(const char *sename) {
 	labels_t *ptr=NULL;
 	if (labellist) 
 		for(ptr=labellist->next;ptr; ptr=ptr->next) 
@@ -223,7 +197,7 @@ static char *untranslate(const char *sen
 	if (orig) {
 		if (strcmp(orig,sename)==0) {
 			char *untranslated=NULL;
-			char *tmpbuf=strdup(orig);
+			char *tmpbuf=strdupa(orig);
 			char *ptr=NULL;
 			char *tok=NULL;
 			char *sensitivity=NULL;
@@ -245,7 +219,8 @@ static char *untranslate(const char *sen
 						break;
 					}
 				} else {
-					sensitivity=calloc(1,idx+1);
+					sensitivity = alloca(idx + 1);
+					sensitivity[idx] = '\0';
 					strncpy(sensitivity, utrans, idx);
 				}
 				category=&utrans[idx+1];
@@ -266,10 +241,6 @@ static char *untranslate(const char *sen
 				tok=strtok_r(NULL,",",&ptr);
 			}
 		done:
-			if (tmpbuf)
-				free(tmpbuf);
-			if (sensitivity) 
-				free(sensitivity);
 			if (error) {
 				if (untranslated) 
 					free(untranslated);
@@ -302,6 +273,7 @@ int init_context_translations(void) {
 	cfg = fopen(selinux_translations_path(),"r");
 	if (!cfg) return 1;
 
+	__fsetlocking(cfg, FSETLOCKING_BYCALLER);
 	ptr=labellist=calloc(1,sizeof(labels_t));
 	if (!ptr) {
 		fclose(cfg);

--Boundary-00=_MisuDphRKKHBXD1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
