Message-ID: <45ABFDAA.5060105@trustedcs.com>
Date: Mon, 15 Jan 2007 16:18:18 -0600
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, eparis@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        chanson@TrustedCS.com
Subject: [PATCH 1/1] selinux: increment flow cache genid
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, old flow cache entries remain valid even after
a reload of SELinux policy.

This patch increments the flow cache generation id
on policy (re)loads so that flow cache entries are
revalidated as needed.

Thanks to Herbet Xu for pointing this out. See:
http://marc.theaimsgroup.com/?l=linux-netdev&m=116841378704536&w=2

There's also a general issue as well as a solution proposed
by David Miller for when flow_cache_genid wraps. I might be
submitting a separate patch for that later.

I request that this be applied to 2.6.20 since it's
a security relevant fix.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---
 security/selinux/ss/services.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3eb1fa9..ff03933 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1299,6 +1299,7 @@ int security_load_policy(void *data, siz
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
 		selinux_netlbl_cache_invalidate();
+		atomic_inc(&flow_cache_genid);
 		return 0;
 	}
 
@@ -1354,6 +1355,7 @@ #endif
 	avc_ss_reset(seqno);
 	selnl_notify_policyload(seqno);
 	selinux_netlbl_cache_invalidate();
+	atomic_inc(&flow_cache_genid);
 
 	return 0;
 
@@ -1853,6 +1855,7 @@ out:
 	if (!rc) {
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
+		atomic_inc(&flow_cache_genid);
 	}
 	return rc;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
