Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q32FJJX3016517
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2012 11:19:19 -0400
Message-ID: <1333379956.49089.YahooMailClassic@web87014.mail.ird.yahoo.com>
Date: Mon, 2 Apr 2012 16:19:16 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] XSELinux: Fix initialisation of polyinstantiated properties and selections
To: selinux@tycho.nsa.gov, xorg-devel@lists.x.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Note: This patch has been generated and tested on xorg-server-1.11.4

The specfile (x_contexts) is currently checked for non-poly properties
or selections first. If an entry should be present that specifies
a poly entry and there is a default non-poly entry as a fallback, then
this will be used instead (this is standard practice so that there is
always a known label added). This patch checks for poly_selection or
poly_property entries first and then checks non-poly entries.

Example x_contexts entry for selections:
poly_selection PRIMARY  system_u:object_r:clipboard_xselection_t:s0
selection CLIPBOARD     system_u:object_r:clipboard_xselection_t:s0
selection * system_u:object_r:xselection_t:s0 # default fallback

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Xext/xselinux_label.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Xext/xselinux_label.c b/Xext/xselinux_label.c
index e5929fa..ceb5a7e 100644
--- a/Xext/xselinux_label.c
+++ b/Xext/xselinux_label.c
@@ -97,16 +97,16 @@ SELinuxAtomToSIDLookup(Atom atom, SELinuxObjectRec *obj, int map, int polymap)
     security_context_t ctx;
     int rc = Success;
 
-    obj->poly = 1;
+    obj->poly = 0;
 
     /* Look in the mappings of names to contexts */
-    if (selabel_lookup_raw(label_hnd, &ctx, name, map) == 0) {
-	obj->poly = 0;
+    if (selabel_lookup_raw(label_hnd, &ctx, name, polymap) == 0) {
+	obj->poly = 1;
     } else if (errno != ENOENT) {
-	ErrorF("SELinux: a property label lookup failed!\n");
+	ErrorF("SELinux: a poly property or selection label lookup failed!\n");
 	return BadValue;
-    } else if (selabel_lookup_raw(label_hnd, &ctx, name, polymap) < 0) {
-	ErrorF("SELinux: a property label lookup failed!\n");
+    } else if (selabel_lookup_raw(label_hnd, &ctx, name, map) < 0) {
+	ErrorF("SELinux: a property or selection label lookup failed!\n");
 	return BadValue;
     }
 
-- 
1.7.7.1



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
