Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBMChJVb011264
 for <selinux@tycho.nsa.gov>; Thu, 22 Dec 2016 07:43:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAFF580F63
 for <selinux@tycho.nsa.gov>; Thu, 22 Dec 2016 12:43:18 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: Generate SWIG wrappers for
 selinux_restorecon()
Date: Thu, 22 Dec 2016 13:43:08 +0100
Message-Id: <20161222124309.27686-2-plautrba@redhat.com>
In-Reply-To: <20161222124309.27686-1-plautrba@redhat.com>
References: <20161222124309.27686-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/selinuxswig.i | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/src/selinuxswig.i b/libselinux/src/selinuxswig.i
index c1e4ef7..687c43b 100644
--- a/libselinux/src/selinuxswig.i
+++ b/libselinux/src/selinuxswig.i
@@ -9,6 +9,7 @@
 	#include "../include/selinux/get_context_list.h"
 	#include "../include/selinux/get_default_type.h"
 	#include "../include/selinux/label.h"
+	#include "../include/selinux/restorecon.h"
 	#include "../include/selinux/selinux.h"
 %}
 %apply int *OUTPUT { int *enforce };
@@ -61,4 +62,5 @@
 %include "../include/selinux/get_context_list.h"
 %include "../include/selinux/get_default_type.h"
 %include "../include/selinux/label.h"
+%include "../include/selinux/restorecon.h"
 %include "../include/selinux/selinux.h"
-- 
2.9.3
