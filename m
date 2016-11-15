Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFMG06S010231
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 17:16:00 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9957B5646F9
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 23:15:56 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsemanage: use a macro prefixed with SEMANAGE to
 protect dso.h
Date: Tue, 15 Nov 2016 23:15:23 +0100
Message-Id: <20161115221523.17519-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/dso.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/dso.h b/libsemanage/src/dso.h
index 5c69aaef0090..8c9a0140871f 100644
--- a/libsemanage/src/dso.h
+++ b/libsemanage/src/dso.h
@@ -1,5 +1,5 @@
-#ifndef _SEPOL_DSO_H
-#define _SEPOL_DSO_H	1
+#ifndef _SEMANAGE_DSO_H
+#define _SEMANAGE_DSO_H	1
 
 #ifdef SHARED
 # define hidden __attribute__ ((visibility ("hidden")))
-- 
2.10.2
