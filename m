Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sH009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:13 -0400
Received: by mail-we0-f180.google.com with SMTP id t60so3113488wes.11
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:19 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.18
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:19 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 06/20] policycoreutils/hll/pp: add printf format attribute to
 relevant functions
Date: Sun, 14 Sep 2014 23:41:37 +0200
Message-Id: <1410730911-14512-7-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

log_err, cil_printf and cil_println use printf formats to process their
arguments.  Use __attribute__((format(printf,...))) to make "gcc
-Wformat -Wformat-security" detect issues.

This detected this issue several times on a x86_64 system:

  format '%lx' expects argument of type 'long unsigned int', but
  argument has type 'uint32_t'

Fix this by introducing an explicit cast to unsigned long.

While at it, constify the format string argument of each function.
---
 policycoreutils/hll/pp/pp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index fd80657321bc..93e2889b78f6 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -54,7 +54,8 @@ FILE *out_file;
 #define DEFAULT_LEVEL "systemlow"
 #define DEFAULT_OBJECT "object_r"
 
-static void log_err(char *fmt, ...)
+__attribute__ ((format(printf, 1, 2)))
+static void log_err(const char *fmt, ...)
 {
 	va_list argptr;
 	va_start(argptr, fmt);
@@ -75,7 +76,8 @@ static void cil_indent(int indent)
 	}
 }
 
-static void cil_printf(char *fmt, ...) {
+__attribute__ ((format(printf, 1, 2)))
+static void cil_printf(const char *fmt, ...) {
 	va_list argptr;
 	va_start(argptr, fmt);
 	if (vfprintf(out_file, fmt, argptr) < 0) {
@@ -85,7 +87,8 @@ static void cil_printf(char *fmt, ...) {
 	va_end(argptr);
 }
 
-static void cil_println(int indent, char *fmt, ...)
+__attribute__ ((format(printf, 2, 3)))
+static void cil_println(int indent, const char *fmt, ...)
 {
 	cil_indent(indent);
 	va_list argptr;
@@ -2200,9 +2203,9 @@ static int ocontext_xen_iomem_to_cil(struct policydb *pdb, struct ocontext *iome
 		high = iomem->u.iomem.high_iomem;
 
 		if (low == high) {
-			cil_printf("(iomemcon %#lX ", low);
+			cil_printf("(iomemcon %#lX ", (unsigned long)low);
 		} else {
-			cil_printf("(iomemcon (%#lX %#lX) ", low, high);
+			cil_printf("(iomemcon (%#lX %#lX) ", (unsigned long)low, (unsigned long)high);
 		}
 
 		context_to_cil(pdb, &iomem->context[0]);
@@ -2218,7 +2221,7 @@ static int ocontext_xen_pcidevice_to_cil(struct policydb *pdb, struct ocontext *
 	struct ocontext *pcid;
 
 	for (pcid = pcids; pcid != NULL; pcid = pcid->next) {
-		cil_printf("(pcidevicecon %#lx ", pcid->u.device);
+		cil_printf("(pcidevicecon %#lx ", (unsigned long)pcid->u.device);
 		context_to_cil(pdb, &pcid->context[0]);
 		cil_printf(")\n");
 	}
-- 
2.1.0
