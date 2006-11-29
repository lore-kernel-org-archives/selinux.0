Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATLWGMP001774
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 16:32:16 -0500
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATLVXa4004524
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 21:31:33 GMT
Date: Wed, 29 Nov 2006 16:32:36 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
Subject: [PATCH] Rename class_destroy to prevent namespace conflicts
Message-ID: <XMMS.LNX.4.64.0611291628410.24574@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

We keep hitting naming conflicts with class_destroy included via 
linux/device.h, as networking related headers are increasingly being used 
on in the core SELinux code.  I've tried using external declarations 
previously to prevent e.g. skbuff.h being included, but it's not going to 
work in the general case.  I suggest we simply rename the SELinux function 
to cls_destroy per the patch below.

Please review.

Signed-off-by: James Morris <jmorris@namei.org>

---

 policydb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ba48961..cd79c63 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -468,7 +468,7 @@ static int common_destroy(void *key, voi
 	return 0;
 }
 
-static int class_destroy(void *key, void *datum, void *p)
+static int cls_destroy(void *key, void *datum, void *p)
 {
 	struct class_datum *cladatum;
 	struct constraint_node *constraint, *ctemp;
@@ -566,7 +566,7 @@ static int cat_destroy(void *key, void *
 static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 {
 	common_destroy,
-	class_destroy,
+	cls_destroy,
 	role_destroy,
 	type_destroy,
 	user_destroy,
@@ -1124,7 +1124,7 @@ static int class_read(struct policydb *p
 out:
 	return rc;
 bad:
-	class_destroy(key, cladatum, NULL);
+	cls_destroy(key, cladatum, NULL);
 	goto out;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
