From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] SELinux: indicate fatal error in compat netfilter code
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul.moore@hp.com, davem@davemloft.net
Date: Tue, 23 Nov 2010 11:28:08 -0500
Message-ID: <20101123162808.3588.18495.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101123162802.3588.74894.stgit@paris.rdu.redhat.com>
References: <20101123162802.3588.74894.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux ip postroute code indicates when policy rejected a packet and
passes the error back up the stack.  The compat code does not.  This patch
sends the same kind of error back up the stack in the compat code.

Based-on-patch-by: Paul Moore <paul.moore@hp.com>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bd6dc16..dd1690f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4529,11 +4529,11 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	if (selinux_secmark_enabled())
 		if (avc_has_perm(sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
-			return NF_DROP;
+			return NF_DROP_ERR(-ECONNREFUSED);
 
 	if (selinux_policycap_netpeer)
 		if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
-			return NF_DROP;
+			return NF_DROP_ERR(-ECONNREFUSED);
 
 	return NF_ACCEPT;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
