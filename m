Message-ID: <4554FEE5.9060200@trustedcs.com>
Date: Fri, 10 Nov 2006 16:36:21 -0600
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: cpebenito@tresys.com, sds@tycho.nsa.gov
Subject: [PATCH] labeled-ipsec-policy: Cleanup
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This modifies the mls constraint for polmatch in the association class.
Specifically:

- polmatch need no longer make an exception for unlabeled_t
  since a flow will now always match SPD rules with no contexts (per
  the IPSec leak fix patch upstreamed a few weeks back), as
  opposed to needing polmatch access to unlabeled_t.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---

--- serefpolicy-2.3.18.vanilla/policy/mls	2006-11-10 14:27:52.000000000 -0600
+++ serefpolicy-2.3.18/policy/mls	2006-11-10 14:29:43.000000000 -0600
@@ -614,7 +614,6 @@ mlsconstrain association { sendto }
 	 ( t2 == unlabeled_t ));
 
 mlsconstrain association { polmatch }
-	((( l1 dom l2 ) and ( h1 domby h2 )) or
-	 ( t2 == unlabeled_t ));
+	(( l1 dom l2 ) and ( h1 domby h2 ));
 
 ') dnl end enable_mls

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
