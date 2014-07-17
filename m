Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6H62UBo026612
 for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2014 02:02:30 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
 [147.11.189.41])
 by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s6H62V6B013643
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2014 23:02:32 -0700 (PDT)
Message-ID: <53C766F5.4090905@windriver.com>
Date: Thu, 17 Jul 2014 14:02:29 +0800
From: wenzong fan <wenzong.fan@windriver.com>
MIME-Version: 1.0
To: <selinux@tycho.nsa.gov>
Subject: [mcstransd] Fails after Reload Translations
Content-Type: multipart/mixed; boundary="------------050001020502070307020404"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--------------050001020502070307020404
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Generally the mcstransd works well on mls enabled system, but if 
"restart daemon" triggered, it will fail to trans the mls levels.

* To reproduce the issue:
1) apply attached patch: force-to-reload-translations.patch
2) build mcstransd and replace the one: "/sbin/mcstransd"
3) start the daemon and check results:

   $ run_init /etc/init.d/mcstrans start
   $ id -Z
   staff_u:lspp_test_r:lspp_harness_t:s0-s15:c0.c1023

   $ ps aux|grep mcs
   root      3004  0.0  0.0  14884   668 ?        Ss   09:37   0:00 
mcstransd
   root      3116  0.0  0.0 103252   832 pts/1    S+   10:39   0:00 grep mcs

   $ grep mcs /var/log/messages
   Jul 17 09:37:05 localhost mcstransd: mcstransd starting
   Jul 17 09:37:05 localhost mcstransd: Failed to initialize color 
translations
   Jul 17 09:37:05 localhost mcstransd: No color information will be 
available
   Jul 17 09:37:05 localhost mcstransd: mcstransd initialized
   Jul 17 09:37:05 localhost mcstransd: Reload Translations
   Jul 17 09:37:05 localhost mcstransd: cache sizes: tr = 26, rt = 26
   Jul 17 09:37:05 localhost mcstransd: Failed to initialize color 
translations
   Jul 17 09:37:05 localhost mcstransd: No color information will be 
available

I tested this on CentOS 6.5 with mls policy enabled.

* Why does it fail?

Check process_trans() in mcstrans.c:

  723 process_trans(char *buffer) {
  724         static domain_t *domain;
  [snip] ...
  784         if (!domain) {
  785                 domain = create_domain("Default");
  786                 if (!domain)
  787                         return -1;
  788                 group = NULL;
  789         }

As I think, the static pointer "domain" will be initialized when the 
daemon is starting, it will work well if that's all; But if "restart 
daemon" triggered after that, the point "domain" will have an old value 
but not NULL, this will prevent the create_domain() from running. In 
this case, an empty "domains" causes the translation failed.

I have a workaround to get it works: workaround-for-mcstransd.patch, but 
it's a bit ugly, I hope someone could give a better fix for it:)

Thanks
Wenzong

--------------050001020502070307020404
Content-Type: text/x-diff; name="force-to-reload-translations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="force-to-reload-translations.patch"

diff --git a/policycoreutils/mcstrans/src/mcstransd.c b/policycoreutils/mcstrans/src/mcstransd.c
index a65076d..1dd905a 100644
--- a/policycoreutils/mcstrans/src/mcstransd.c
+++ b/policycoreutils/mcstrans/src/mcstransd.c
@@ -416,6 +416,7 @@ process_connections(void)
 	ufds[0].events = POLLIN|POLLPRI;
 	ufds[0].revents = 0;
 
+	restart_daemon = 1;
 	while (1) {
 		if (restart_daemon) {
 			syslog(LOG_NOTICE, "Reload Translations");

--------------050001020502070307020404
Content-Type: text/x-diff; name="workaround-for-mcstransd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="workaround-for-mcstransd.patch"

diff --git a/policycoreutils/mcstrans/src/mcstrans.c b/policycoreutils/mcstrans/src/mcstrans.c
index 4d31857..00747a6 100644
--- a/policycoreutils/mcstrans/src/mcstrans.c
+++ b/policycoreutils/mcstrans/src/mcstrans.c
@@ -719,9 +719,9 @@ static int read_translations(const char *filename);
    Remove white space and set raw do data before the "=" and tok to data after it
    Modifies the data pointed to by the buffer parameter
  */
+static domain_t *localdomain;
 static int
 process_trans(char *buffer) {
-	static domain_t *domain;
 	static word_group_t *group;
 	static int base_classification;
 	static int lineno = 0;
@@ -776,14 +776,14 @@ process_trans(char *buffer) {
 	}
 
 	if (!strcmp(raw, "Domain")) {
-		domain = create_domain(tok);
+		localdomain = create_domain(tok);
 		group = NULL;
 		return 0;
 	}
 
-	if (!domain) {
-		domain = create_domain("Default");
-		if (!domain)
+	if (!localdomain) {
+		localdomain = create_domain("Default");
+		if (!localdomain)
 			return -1;
 		group = NULL;
 	}
@@ -814,7 +814,7 @@ process_trans(char *buffer) {
 	} else if (!strcmp(raw, "Base")) {
 		base_classification = 1;
 	} else if (!strcmp(raw, "ModifierGroup")) {
-		group = create_group(&domain->groups, tok);
+		group = create_group(&localdomain->groups, tok);
 		if (!group)
 			return -1;
 		base_classification = 0;
@@ -844,12 +844,12 @@ process_trans(char *buffer) {
 		}
 	} else {
 		if (base_classification) {
-			if (add_base_classification(domain, raw, tok) < 0) {
+			if (add_base_classification(localdomain, raw, tok) < 0) {
 				syslog(LOG_ERR, "unable to add base_classification on line %d", lineno);
 				return -1;
 			}
 		}
-		if (add_cache(domain, raw, tok) < 0)
+		if (add_cache(localdomain, raw, tok) < 0)
 			return -1;
 	}
 	return 0;
@@ -1758,5 +1758,6 @@ finish_context_translations(void) {
 		destroy_cat_constraint(&cat_constraints, cat_constraints);
 		cat_constraints = next;
 	}
+	localdomain = NULL;
 }
 

--------------050001020502070307020404--
