Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u669hUeK015341
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 05:43:30 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B115201FA
 for <selinux@tycho.nsa.gov>; Wed,  6 Jul 2016 09:43:29 +0000 (UTC)
Received: from moo.home.annexia.org (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u669hQMP007869
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 05:43:28 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: If autorelabel, force permissive mode.
Date: Wed,  6 Jul 2016 10:43:22 +0100
Message-Id: <1467798202-6412-2-git-send-email-rjones@redhat.com>
In-Reply-To: <1467798202-6412-1-git-send-email-rjones@redhat.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 libselinux/src/load_policy.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 4f39fc7..337a8a9 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -315,7 +315,8 @@ hidden_def(selinux_mkload_policy)
  */
 int selinux_init_load_policy(int *enforce)
 {
-	int rc = 0, orig_enforce = 0, seconfig = -2, secmdline = -1;
+	int rc = 0, orig_enforce = 0, seconfig = -2, secmdline = -1,
+		seautorelabel = -1;
 	FILE *cfg;
 	char *buf;
 
@@ -332,6 +333,17 @@ int selinux_init_load_policy(int *enforce)
 	 */
 	selinux_getenforcemode(&seconfig);
 
+	/*
+	 * If /.autorelabel exists then we should start in permissive
+	 * mode because (a) the labels on the filesystem are known to
+	 * be bogus and so should not be trusted to make security
+	 * decisions, but more practically (b) mislabelled files may
+	 * cause services & processes required for relabelling to fail.
+	 */
+	if (access("/.autorelabel", F_OK) == 0) {
+		seautorelabel = 0;
+	}
+
 	/* Check for an override of the mode via the kernel command line. */
 	rc = mount("proc", "/proc", "proc", 0, 0);
 	cfg = fopen("/proc/cmdline", "r");
@@ -342,12 +354,18 @@ int selinux_init_load_policy(int *enforce)
 			fclose(cfg);
 			return -1;
 		}
-		if (fgets(buf, selinux_page_size, cfg) &&
-		    (tmp = strstr(buf, "enforcing="))) {
-			if (tmp == buf || isspace(*(tmp - 1))) {
+		if (fgets(buf, selinux_page_size, cfg)) {
+			if ((tmp = strstr(buf, "enforcing=")) &&
+			    (tmp == buf || isspace(*(tmp - 1)))) {
 				secmdline =
 				    atoi(tmp + sizeof("enforcing=") - 1);
 			}
+			else if ((tmp = strstr(buf, "autorelabel")) &&
+				 (tmp == buf || isspace(*(tmp - 1))) &&
+				 (tmp + sizeof("autorelabel") - 1 == '\0' ||
+				  isspace(tmp + sizeof("autorelabel") - 1))) {
+				seautorelabel = 0;
+			}
 		}
 		fclose(cfg);
 		free(buf);
@@ -357,7 +375,9 @@ int selinux_init_load_policy(int *enforce)
 	 * Determine the final desired mode.
 	 * Command line argument takes precedence, then config file. 
 	 */
-	if (secmdline >= 0)
+	if (seautorelabel >= 0)
+		*enforce = seautorelabel;
+	else if (secmdline >= 0)
 		*enforce = secmdline;
 	else if (seconfig >= 0)
 		*enforce = seconfig;
-- 
2.7.4
