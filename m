Subject: [PATCH] sepol license fix
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-+LfSao/TS1culjXGeSFh"
Date: Thu, 22 Sep 2005 16:50:43 -0400
Message-Id: <1127422243.21806.36.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+LfSao/TS1culjXGeSFh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This changes avrule_block.c and avrule_block.h to LGPL.



--=-+LfSao/TS1culjXGeSFh
Content-Disposition: attachment; filename=3-sepol-license-fix.patch
Content-Type: text/x-patch; name=3-sepol-license-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libsepol/include/sepol/avrule_block.h	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/include/sepol/avrule_block.h	2005-09-21 11:27:28.000000000 -0400
@@ -1,9 +1,20 @@
 /* Authors: Jason Tang <jtang@tresys.com>
  *
  * Copyright (C) 2005 Tresys Technology, LLC
- *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation, version 2.
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
  */
 
 #ifndef AVRULE_BLOCK_H
--- libsepol/src/avrule_block.c	2005-09-22 09:41:17.000000000 -0400
+++ libsepol/src/avrule_block.c	2005-09-22 10:18:26.000000000 -0400
@@ -1,9 +1,23 @@
 /* Authors: Jason Tang <jtang@tresys.com>
  *
+ * Functions that manipulate a logical block (conditional, optional,
+ * or global scope) for a policy module.
+ *
  * Copyright (C) 2005 Tresys Technology, LLC
- *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation, version 2.
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
  */
 
 #include <sepol/policydb.h>

--=-+LfSao/TS1culjXGeSFh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
