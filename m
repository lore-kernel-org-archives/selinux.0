Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8CJi654002758
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 15:44:06 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8CJhGEW027405
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 19:43:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k8CJhhFC015057
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 15:43:43 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k8CJhhFQ015056
	for selinux@tycho.nsa.gov; Tue, 12 Sep 2006 15:43:43 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8CJBNn7001622
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 15:11:23 -0400
Subject: [PATCH] refpolicy: add X object classes to unconfined_t
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-7tGeI3Z4Tb1LbHIS7G/6"
Date: Tue, 12 Sep 2006 15:11:22 -0400
Message-Id: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-7tGeI3Z4Tb1LbHIS7G/6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,
I'm working on the XSELinux code, which has just been brought up to date
with the current X.org code base.

The following patch adds the X Windows userspace object classes to
unconfined_t.


Signed-off-by:  Eamon Walsh <ewalsh@tycho.nsa.gov>

 policy/modules/system/unconfined.if |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-7tGeI3Z4Tb1LbHIS7G/6
Content-Disposition: attachment; filename=unconfined-x.patch
Content-Type: text/x-patch; name=unconfined-x.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- refpolicy/policy/modules/system/unconfined.if	2006-09-11 21:06:30.000000000 -0400
+++ refpolicy-new/policy/modules/system/unconfined.if	2006-09-11 21:08:55.000000000 -0400
@@ -15,6 +15,17 @@
 		class dbus all_dbus_perms;
 		class nscd all_nscd_perms;
 		class passwd all_passwd_perms;
+		class drawable all_drawable_perms;
+		class window all_window_perms;
+		class gc all_gc_perms;
+		class font all_font_perms;
+		class colormap all_colormap_perms;
+		class property all_property_perms;
+		class cursor all_cursor_perms;	
+		class xclient all_xclient_perms;
+		class xserver all_xserver_perms;
+		class xinput all_xinput_perms;
+		class xextension all_xextension_perms;
 	')
 
 	# Use any Linux capability.
@@ -31,6 +42,17 @@
 	allow $1 self:nscd *;
 	allow $1 self:dbus *;
 	allow $1 self:passwd *;
+	allow $1 self:drawable *;
+	allow $1 self:window *;
+	allow $1 self:gc *;
+	allow $1 self:font *;
+	allow $1 self:colormap *;
+	allow $1 self:property *;
+	allow $1 self:cursor *;
+	allow $1 self:xclient *;
+	allow $1 self:xserver *;
+	allow $1 self:xinput *;
+	allow $1 self:xextension *;
 
 	kernel_unconfined($1)
 	corenet_unconfined($1)

--=-7tGeI3Z4Tb1LbHIS7G/6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
