Message-ID: <446B69E9.8020105@redhat.com>
Date: Wed, 17 May 2006 14:22:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Antill <james.antill@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com> <1147879972.3469.139.camel@code.and.org>
In-Reply-To: <1147879972.3469.139.camel@code.and.org>
Content-Type: multipart/mixed;
 boundary="------------090506030406050401020905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090506030406050401020905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Updated patch with

void fini_context_translations

memory checking on strdup

CACHETRANS flag in /etc/selinux/config to turn off cacheing

Lu -> llu change

I will leave a more complete caching solution for later...  This handled 
99.9% of the cases.

--------------090506030406050401020905
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/init.c libselinux-1.30.7/src/init.c
--- nsalibselinux/src/init.c	2006-05-15 09:43:24.000000000 -0400
+++ libselinux-1.30.7/src/init.c	2006-05-17 13:57:29.000000000 -0400
@@ -78,21 +78,17 @@
 }
 hidden_def(set_selinuxmnt)
  
-static void init_translations(void)
-{
-	init_context_translations();
-}
-
 static void init_lib(void) __attribute__ ((constructor));
 static void init_lib(void)
 {
 	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
-	init_translations();
+	init_context_translations();
 }
 
 static void fini_lib(void) __attribute__ ((destructor));
 static void fini_lib(void)
 {
 	fini_selinuxmnt();
+	fini_context_translations();
 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.30.7/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2006-05-15 09:43:24.000000000 -0400
+++ libselinux-1.30.7/src/selinux_config.c	2006-05-17 14:00:27.000000000 -0400
@@ -17,6 +17,7 @@
 #define SELINUXTAG "SELINUX="
 #define SETLOCALDEFS "SETLOCALDEFS="
 #define REQUIRESEUSERS "REQUIRESEUSERS="
+#define CACHETRANSTAG "CACHETRANS="
 
 /* Indices for file paths arrays. */
 #define BINPOLICY         0
@@ -175,6 +176,10 @@
 				      sizeof(REQUIRESEUSERS)-1)) {
 			  value = buf_p + sizeof(REQUIRESEUSERS)-1;
 			  intptr = &require_seusers;
+		  } else if (!strncmp(buf_p, CACHETRANS, 
+				      sizeof(CACHETRANS)-1)) {
+			  value = buf_p + sizeof(CACHETRANS)-1;
+			  intptr = &cache_trans;
 		  } else {
 			  continue;
 		  }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.30.7/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2006-05-15 09:43:24.000000000 -0400
+++ libselinux-1.30.7/src/selinux_internal.h	2006-05-17 14:05:25.000000000 -0400
@@ -70,3 +70,4 @@
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
+extern int cache_trans hidden;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setrans_client.c libselinux-1.30.7/src/setrans_client.c
--- nsalibselinux/src/setrans_client.c	2006-05-16 20:43:27.000000000 -0400
+++ libselinux-1.30.7/src/setrans_client.c	2006-05-17 14:15:33.000000000 -0400
@@ -16,6 +16,13 @@
 #include "selinux_internal.h"
 #include "setrans_internal.h"
 
+// Simple cache
+static	security_context_t prev_t2r_trans=NULL;
+static	security_context_t prev_t2r_raw=NULL;
+static	security_context_t prev_r2t_trans=NULL;
+static	security_context_t prev_r2t_raw=NULL;
+
+int cache_trans hidden = 1;
 
 /*
  * setransd_open
@@ -193,6 +200,17 @@
 }
 
 
+hidden void
+fini_context_translations(void)
+{
+	if (cache_trans) {
+		free(prev_r2t_trans);
+		free(prev_r2t_raw);
+		free(prev_t2r_trans);
+		free(prev_t2r_raw);
+	}
+}
+
 hidden int
 init_context_translations(void)
 {
@@ -225,9 +243,24 @@
 		*rawp = NULL;
 		return 0;
 	}
+	if (cache_trans) {
+		if (prev_t2r_trans && strcmp(prev_t2r_trans, trans) == 0) {
+			*rawp=strdup(prev_t2r_raw);
+		} else {
+			free(prev_t2r_trans); prev_t2r_trans = NULL;
+			free(prev_t2r_raw); prev_t2r_raw = NULL
+			if (trans_to_raw_context(trans, rawp))
+				*rawp = strdup(trans);
+			if (*rawp) {
+				prev_t2r_trans=strdup(trans);
+				prev_t2r_raw=strdup(*rawp);
+			}
+		}
+	}
+	else 
+		if (trans_to_raw_context(trans, rawp))
+			*rawp = strdup(trans);
 
-	if (trans_to_raw_context(trans, rawp))
-		*rawp = strdup(trans);
 	return *rawp ? 0 : -1;
 }
 hidden_def(selinux_trans_to_raw_context)
@@ -240,8 +273,23 @@
 		return 0;
 	}
 
-	if (raw_to_trans_context(raw, transp)) 
-		*transp = strdup(raw);
+	if (cache_trans) {
+		if (prev_r2t_raw && strcmp(prev_r2t_raw, raw) == 0) {
+			*transp=strdup(prev_r2t_trans);
+		} else {
+			free(prev_r2t_raw); prev_r2t_raw = NULL;
+			free(prev_r2t_trans); prev_r2t_trans = NULL;
+			if (raw_to_trans_context(raw, transp)) 
+				*transp = strdup(raw);
+			if (*transp) {
+				prev_r2t_raw=strdup(raw);
+				prev_r2t_trans=strdup(*transp);
+			}
+		}
+	} 
+	else 
+		if (raw_to_trans_context(raw, transp)) 
+			*transp = strdup(raw);
 
 	return *transp ? 0 : -1;
 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setrans_internal.h libselinux-1.30.7/src/setrans_internal.h
--- nsalibselinux/src/setrans_internal.h	2006-05-16 20:43:27.000000000 -0400
+++ libselinux-1.30.7/src/setrans_internal.h	2006-05-17 14:07:34.000000000 -0400
@@ -8,3 +8,4 @@
 #define MAX_DATA_BUF			8192
 
 extern int init_context_translations(void);
+extern void fini_context_translations(void);
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/avcstat.c libselinux-1.30.7/utils/avcstat.c
--- nsalibselinux/utils/avcstat.c	2006-05-15 09:43:20.000000000 -0400
+++ libselinux-1.30.7/utils/avcstat.c	2006-05-17 06:18:39.000000000 -0400
@@ -27,12 +27,12 @@
 #define HEADERS		"lookups hits misses allocations reclaims frees"
 
 struct avc_cache_stats {
-	unsigned int lookups;
-	unsigned int hits;
-	unsigned int misses;
-	unsigned int allocations;
-	unsigned int reclaims;
-	unsigned int frees;
+	unsigned long long lookups;
+	unsigned long long hits;
+	unsigned long long misses;
+	unsigned long long allocations;
+	unsigned long long reclaims;
+	unsigned long long frees;
 };
 
 static int interval;
@@ -172,7 +172,7 @@
 		while ((line = strtok(NULL, "\n"))) {
 			struct avc_cache_stats tmp;
 			
-			ret = sscanf(line, "%u %u %u %u %u %u",
+			ret = sscanf(line, "%llu %llu %llu %llu %llu %llu",
 				     &tmp.lookups,
 				     &tmp.hits,
 				     &tmp.misses,
@@ -195,7 +195,7 @@
 			die("unable to parse \'%s\': no data", avcstatfile);
 
 		if (cumulative || (!cumulative && !i))
-			printf("%10u %10u %10u %10u %10u %10u\n",
+			printf("%10llu %10llu %10llu %10llu %10llu %10llu\n",
 			       tot.lookups, tot.hits, tot.misses,
 			       tot.allocations, tot.reclaims, tot.frees);
 		else {
@@ -205,7 +205,7 @@
 			rel.allocations = tot.allocations - last.allocations;
 			rel.reclaims = tot.reclaims - last.reclaims;
 			rel.frees = tot.frees - last.frees;
-			printf("%10u %10u %10u %10u %10u %10u\n",
+			printf("%10llu %10llu %10llu %10llu %10llu %10llu\n",
 			       rel.lookups, rel.hits, rel.misses,
 			       rel.allocations, rel.reclaims, rel.frees);
 		}

--------------090506030406050401020905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
