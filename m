Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56JDNHK029141
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 15:13:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l56JDJXZ011029
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 19:13:19 GMT
Subject: [PATCH 5/5] libselinux: update checkAccess for object class
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 19:12:00 +0000
Message-Id: <1181157120.6578.40.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change checkAccess.c functions to use object class discovery where possible.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

---
 libselinux/src/checkAccess.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: selinux-obj-class-discovery/libselinux/src/checkAccess.c
===================================================================
--- selinux-obj-class-discovery.orig/libselinux/src/checkAccess.c
+++ selinux-obj-class-discovery/libselinux/src/checkAccess.c
@@ -13,10 +13,17 @@ int selinux_check_passwd_access(access_v
 	if (is_selinux_enabled() == 0)
 		return 0;
 	if (getprevcon_raw(&user_context) == 0) {
+		security_class_t passwd_class;
 		struct av_decision avd;
-		int retval = security_compute_av_raw(user_context,
+		int retval;
+
+		passwd_class = string_to_security_class("passwd");
+		if (passwd_class == 0)
+			return 0;
+
+		retval = security_compute_av_raw(user_context,
 						     user_context,
-						     SECCLASS_PASSWD,
+						     passwd_class,
 						     requested,
 						     &avd);
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
