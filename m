Message-ID: <447DD3D7.4050200@trustedcs.com>
Date: Wed, 31 May 2006 12:35:19 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
Subject: [PATCH] fix masking of capabilities over netlink in permissive mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think I ran across the problem described in this thread:

http://www.redhat.com/archives/linux-audit/2006-May/msg00059.html

The process' effective capabilities are always being masked with the
allowed vector of the avc decision (for self against the capability
security class) in netlink's copy of the process capabilities (eff_cap).
The allowed vector takes on a slightly different role when SELinux
is not in enforcing mode - it starts to track used-but-not-normally-
permitted actions in the allowed vector.  That is what is causing
the first attempt to fail (the allowed vector has not been "inflated")
and the following attempts to succeed (the vector has been inflated in
response to its previous use).  Does my reasoning (and patch) seem to
be on track?




This patch removes the masking of capabilities passed over netlink
socket when SELinux is in enforcing mode.

Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 21dad41..c7650bb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3599,7 +3599,8 @@ static int selinux_netlink_send(struct s
 	avd.allowed = 0;
 	avc_has_perm_noaudit(tsec->sid, tsec->sid,
 				SECCLASS_CAPABILITY, ~0, &avd);
-	cap_mask(NETLINK_CB(skb).eff_cap, avd.allowed);
+	if (selinux_enforcing)
+		cap_mask(NETLINK_CB(skb).eff_cap, avd.allowed);
 
 	if (policydb_loaded_version >= POLICYDB_VERSION_NLCLASS)
 		err = selinux_nlmsg_perm(sk, skb);

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
