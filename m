Message-ID: <4526CE64.9050704@trustedcs.com>
Date: Fri, 06 Oct 2006 16:45:08 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, paul.moore@hp.com, eparis@redhat.com,
        sgrubb@redhat.com, jbrindle@tresys.com
Subject: [PATCH 1/1] selinux: Null-out secmark after use
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This nulls out the secmark field on the skb after
we are done with ALL the access checks in the postroute_last
hook to handle the case where multicast packets that we send
might be arriving back to us on a non-loopback device. This
would cause the flow_in hook to use the secmark on the skb
(ostensibly from the originating socket) as a security point
context, which it isn't.

Signed-off-by: James Morris <jmorris@namei.org>
---

--- net-2.6.sid6/security/selinux/hooks.c	2006-10-03 16:43:21.000000000 -0500
+++ net-2.6/security/selinux/hooks.c	2006-10-06 16:18:55.000000000 -0500
@@ -3903,6 +3903,22 @@ static unsigned int selinux_ip_postroute
 		}
 		err = avc_has_perm(skb->secmark, SECINITSID_NETMSG,
 				   SECCLASS_PACKET, PACKET__FLOW_OUT, &ad);
+
+		if (skb->secmark  && skb->dev != &loopback_dev)
+			/*
+			 * Our multicast packets could get copied back
+			 * to us, arriving on a non-loopback device.
+			 * Leaving the secmark intact here will cause it
+			 * to be used as a security point context in
+			 * the flow_in hook above while it's not in fact
+			 * a security point context.
+			 *
+			 * We may be able to retain this marking if
+			 * we can reliably determine that it was a local
+			 * packet although it arrived on a non-loopback
+			 * device, in the flow_in hook above.
+			 */
+			skb->secmark = SECSID_NULL;
 	}
 out:
 	return err ? NF_DROP : NF_ACCEPT;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
