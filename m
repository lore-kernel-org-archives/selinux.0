Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUZ0J001652
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:35 -0400
Received: from scarecrow.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUXSG027833
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:34 GMT
Message-Id: <20070423213732.950111000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:08 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 13/33] libsemanage: testing infrastructure
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adding a globals.h for tests to hold joint variables for all tests such as a shared semanage handle.

---
 libsemanage/tests/globals.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

Index: selinux-pms-support/libsemanage/tests/globals.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/tests/globals.h
@@ -0,0 +1,27 @@
+/* Authors: Caleb Case <ccase@tresys.com>
+ *
+ * Copyright (C)  2007 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __GLOBALS_H__
+#define __GLOBALS_H__
+
+#include "handle.h"
+
+semanage_handle_t *sh;
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
