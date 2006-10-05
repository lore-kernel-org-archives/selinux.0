Message-ID: <45256E3B.7070508@trustedcs.com>
Date: Thu, 05 Oct 2006 15:42:35 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        eparis@redhat.com, johnpol@2ka.mipt.ru, herbert@gondor.apana.org.au
Subject: [PATCH 3/3] Fix for IPsec leakage with SELinux enabled - V.03: Process
 security errors for scket policies also
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This treats the security errors encountered in the case of
socket policy matching, the same as how these are treated in
the case of main/sub policies, which is to return a full lookup
failure.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 net/xfrm/xfrm_policy.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- net-2.6.sid5/net/xfrm/xfrm_policy.c	2006-10-05 14:36:07.000000000 -0500
+++ net-2.6/net/xfrm/xfrm_policy.c	2006-10-05 14:38:32.000000000 -0500
@@ -1013,12 +1013,16 @@ static struct xfrm_policy *xfrm_sk_polic
 						sk->sk_family);
  		int err = 0;
 
-		if (match)
-		  err = security_xfrm_policy_lookup(pol, fl->secid, policy_to_flow_dir(dir));
-
- 		if (match && !err)
-			xfrm_pol_hold(pol);
-		else
+		if (match) {
+			err = security_xfrm_policy_lookup(pol, fl->secid,
+					policy_to_flow_dir(dir));
+			if (!err)
+				xfrm_pol_hold(pol);
+			else if (err == -ESRCH)
+				pol = NULL;
+			else
+				pol = ERR_PTR(err);
+		} else
 			pol = NULL;
 	}
 	read_unlock_bh(&xfrm_policy_lock);
@@ -1310,8 +1314,11 @@ restart:
 	pol_dead = 0;
 	xfrm_nr = 0;
 
-	if (sk && sk->sk_policy[1])
+	if (sk && sk->sk_policy[1]) {
 		policy = xfrm_sk_policy_lookup(sk, XFRM_POLICY_OUT, fl);
+		if (IS_ERR(policy))
+			return PTR_ERR(policy);
+	}
 
 	if (!policy) {
 		/* To accelerate a bit...  */
@@ -1604,8 +1611,11 @@ int __xfrm_policy_check(struct sock *sk,
 	}
 
 	pol = NULL;
-	if (sk && sk->sk_policy[dir])
+	if (sk && sk->sk_policy[dir]) {
 		pol = xfrm_sk_policy_lookup(sk, dir, &fl);
+		if (IS_ERR(pol))
+			return 0;
+	}
 
 	if (!pol)
 		pol = flow_cache_lookup(&fl, family, fl_dir,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
