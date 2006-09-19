Message-ID: <450F3ABE.605@trustedcs.com>
Date: Mon, 18 Sep 2006 19:33:02 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
CC: chanson@TrustedCS.com, jbrindle@tresys.com
Subject: [PATCH 1/1] SELINUX: Bug fix in security_sid_mls_copy
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following fixes a bug where random mem is being tampered
with in the non-mls case; encountered by Jashua Brindle on a
gentoo box.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---

PS: NOT SURE IF THIS ALSO NEEDS TO BE SENT TO NETDEV. PLEASE LET
ME KNOW IF I SHOULD.

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 27ee28c..7eb69a6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1841,7 +1841,7 @@ int security_sid_mls_copy(u32 sid, u32 m
 	u32 len;
 	int rc = 0;
 
-	if (!ss_initialized) {
+	if (!ss_initialized || !selinux_mls_enabled) {
 		*new_sid = sid;
 		goto out;
 	}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
