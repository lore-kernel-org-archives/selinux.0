Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7VHiIOb001376
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2005 13:44:18 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7VHgCI9016233
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2005 17:42:13 GMT
Subject: [PATCH] show correct error message when a policy has duplicate
	declarations
From: Jason Tang <jtang@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-O90BuyeQFYk3p3JVi/fz"
Date: Wed, 31 Aug 2005 13:43:19 -0400
Message-Id: <1125510199.5306.59.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-O90BuyeQFYk3p3JVi/fz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Although checkpolicy/checkmodule catch duplicate declarations, the
compiler prints the wrong message.  This patch alters the program so that it
shows the correct message.

-- 
Jason Tang / jtang@tresys.com

--=-O90BuyeQFYk3p3JVi/fz
Content-Disposition: attachment; filename=module_compiler-patch
Content-Type: text/plain; name=module_compiler-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- checkpolicy.old/module_compiler.c	2005-08-22 15:16:41.000000000 -0400
+++ checkpolicy/module_compiler.c	2005-08-31 13:25:25.000000000 -0400
@@ -145,9 +145,11 @@ int declare_symbol(uint32_t symbol_type,
         else if (retval == -2) {
                 return -2;
         }
-        else if (retval == -1 || retval == -ENOMEM) {
+        else if (retval < 0) {
                 return -3;
         }
+        else {  /* fall through possible if retval is 0 */
+        }
         if (datum_value != NULL) {
                 if (ebitmap_set_bit(decl->declared.scope + symbol_type,
                                     *datum_value - 1,
@@ -497,9 +499,11 @@ int require_symbol(uint32_t symbol_type,
         else if (retval == -2) {
                 return -2;
         }
-        else if (retval == -1 || retval == -ENOMEM) {
+        else if (retval < 0) {
                 return -3;
         }
+        else {  /* fall through possible if retval is 0 */
+        }
         if (datum_value != NULL) {
                 if (ebitmap_set_bit(decl->required.scope + symbol_type,
                                     *datum_value - 1,

--=-O90BuyeQFYk3p3JVi/fz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
