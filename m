Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sI009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:15 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so3077520wgg.9
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:21 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.19
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:20 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 07/20] checkpolicy: add printf format attribute to relevant
 functions
Date: Sun, 14 Sep 2014 23:41:38 +0200
Message-Id: <1410730911-14512-8-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Once __attribute__ ((format(printf, 1, 2))) is added to yyerror2,
"gcc -Wformat -Wformat-security" shows some issues.  Fix them.
---
 checkpolicy/module_compiler.c |  1 +
 checkpolicy/policy_define.c   | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index ffffaf1c07f0..cdb361e04766 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -40,6 +40,7 @@ typedef struct scope_stack {
 extern policydb_t *policydbp;
 extern queue_t id_queue;
 extern int yyerror(char *msg);
+__attribute__ ((format(printf, 1, 2)))
 extern void yyerror2(char *fmt, ...);
 
 static int push_stack(int stack_type, ...);
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index c292eae85d93..cf3245a17d60 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -81,6 +81,7 @@ void init_parser(int pass_number)
 	pass = pass_number;
 }
 
+__attribute__ ((format(printf, 1, 2)))
 void yyerror2(char *fmt, ...)
 {
 	va_list ap;
@@ -3959,7 +3960,7 @@ int define_iomem_context(unsigned long low, unsigned long high)
 	newc->u.iomem.high_iomem = high;
 
 	if (low > high) {
-		yyerror2("low memory 0x%x exceeds high memory 0x%x", low, high);
+		yyerror2("low memory 0x%lx exceeds high memory 0x%lx", low, high);
 		free(newc);
 		return -1;
 	}
@@ -3971,12 +3972,12 @@ int define_iomem_context(unsigned long low, unsigned long high)
 
 	head = policydbp->ocontexts[OCON_XEN_IOMEM];
 	for (l = NULL, c = head; c; l = c, c = c->next) {
-		unsigned int low2, high2;
+		uint32_t low2, high2;
 
 		low2 = c->u.iomem.low_iomem;
 		high2 = c->u.iomem.high_iomem;
 		if (low <= high2 && low2 <= high) {
-			yyerror2("iomemcon entry for 0x%x-0x%x overlaps with "
+			yyerror2("iomemcon entry for 0x%lx-0x%lx overlaps with "
 				"earlier entry 0x%x-0x%x", low, high,
 				low2, high2);
 			goto bad;
@@ -4023,7 +4024,7 @@ int define_ioport_context(unsigned long low, unsigned long high)
 	newc->u.ioport.high_ioport = high;
 
 	if (low > high) {
-		yyerror2("low ioport 0x%x exceeds high ioport 0x%x", low, high);
+		yyerror2("low ioport 0x%lx exceeds high ioport 0x%lx", low, high);
 		free(newc);
 		return -1;
 	}
@@ -4035,12 +4036,12 @@ int define_ioport_context(unsigned long low, unsigned long high)
 
 	head = policydbp->ocontexts[OCON_XEN_IOPORT];
 	for (l = NULL, c = head; c; l = c, c = c->next) {
-		unsigned int low2, high2;
+		uint32_t low2, high2;
 
 		low2 = c->u.ioport.low_ioport;
 		high2 = c->u.ioport.high_ioport;
 		if (low <= high2 && low2 <= high) {
-			yyerror2("ioportcon entry for 0x%x-0x%x overlaps with"
+			yyerror2("ioportcon entry for 0x%lx-0x%lx overlaps with"
 				"earlier entry 0x%x-0x%x", low, high,
 				low2, high2);
 			goto bad;
@@ -4096,7 +4097,7 @@ int define_pcidevice_context(unsigned long device)
 
 		device2 = c->u.device;
 		if (device == device2) {
-			yyerror2("duplicate pcidevicecon entry for 0x%x ",
+			yyerror2("duplicate pcidevicecon entry for 0x%lx",
 				 device);
 			goto bad;
 		}
-- 
2.1.0
