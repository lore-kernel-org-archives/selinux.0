Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u618qDPK007097
 for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2016 04:52:13 -0400
Received: from localhost (LFbn-1-6691-76.w90-120.abo.wanadoo.fr
 [90.120.129.76])
 by mail.free-electrons.com (Postfix) with ESMTPSA id 0B74DAAD
 for <selinux@tycho.nsa.gov>; Fri,  1 Jul 2016 10:51:50 +0200 (CEST)
Date: Fri, 1 Jul 2016 10:51:49 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH libsepol] Add missing <stdarg.h> include
Message-ID: <20160701105149.154f5be9@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add missing <stdarg.h> include

This is needed to fix the build on uClibc, due to the usage of
va_list.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Index: b/cil/src/cil_log.h
===================================================================
--- a/cil/src/cil_log.h
+++ b/cil/src/cil_log.h
@@ -30,6 +30,7 @@
 #define CIL_LOG_H_
 
 #include <stdlib.h>
+#include <stdarg.h>
 #include <cil/cil.h>
 
 #define MAX_LOG_SIZE 512

-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
