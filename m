Message-ID: <44BBAC2A.8060104@trustedcs.com>
Date: Mon, 17 Jul 2006 10:26:34 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH] security_compute_sid: minor bug fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Initializes newcontext sooner to allow for its destruction in all cases.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---

--- linux-2.6.17.vanilla/security/selinux/ss/services.c	2006-07-14 09:28:40.000000000 -0500
+++ linux-2.6.17/security/selinux/ss/services.c	2006-07-17 10:12:29.000000000 -0500
@@ -833,6 +833,8 @@ static int security_compute_sid(u32 ssid
 		goto out;
 	}
 
+	context_init(&newcontext);
+
 	POLICY_RDLOCK;
 
 	scontext = sidtab_search(&sidtab, ssid);
@@ -850,8 +852,6 @@ static int security_compute_sid(u32 ssid
 		goto out_unlock;
 	}
 
-	context_init(&newcontext);
-
 	/* Set the user identity. */
 	switch (specified) {
 	case AVTAB_TRANSITION:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
