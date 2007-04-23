Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUYIC001634
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:34 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUWJc002849
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:33 GMT
Message-Id: <20070423213731.099708000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:06 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 11/33] libsemanage: endianness macros
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 libsemanage/src/byteswap.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: selinux-pms-support/libsemanage/src/byteswap.h
===================================================================
--- /dev/null
+++ selinux-pms-support/libsemanage/src/byteswap.h
@@ -0,0 +1,20 @@
+/* Byte swap macros for libsemanage. */
+#ifndef __SEMANAGE_BYTESWAP_H__
+#define __SEMANAGE_BYTESWAP_H__
+
+#include <byteswap.h>
+#include <endian.h>
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le32(x) (x)
+#define le32_to_cpu(x) (x)
+#define cpu_to_le64(x) (x)
+#define le64_to_cpu(x) (x)
+#else
+#define cpu_to_le32(x) bswap_32(x)
+#define le32_to_cpu(x) bswap_32(x)
+#define cpu_to_le64(x) bswap_64(x)
+#define le64_to_cpu(x) bswap_64(x)
+#endif
+
+#endif

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
