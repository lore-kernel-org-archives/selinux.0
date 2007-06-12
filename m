Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 09:32:44 -0400
Message-Id: <1181655164.17547.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
> Extend SELinux to allow capabilities to be granted authoritatively.
> Introduces a new cap_override access vector to indicate when the
> secondary module (i.e. capability or dummy) check should be skipped.
> Handle the new class gracefully even if the policy does not yet have
> it defined.

Ah, I realized that this has the same issue in permissive mode as the
get_user_sids code - we don't want to arbitrarily allow these
dac_override permissions in permissive mode (otherwise setenforce 0
turns off DAC as well), so the following patch should be applied on top:

diff -u b/security/selinux/hooks.c b/security/selinux/hooks.c
--- b/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1424,7 +1424,7 @@
 	int rc;
 
 	rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
-				  CAP_TO_MASK(cap), 0, NULL);
+				  CAP_TO_MASK(cap), AVC_STRICT, NULL);
 	if (rc) {
 		rc = secondary_ops->capable(tsk, cap);
 		if (rc)

I'll fold that into the base patch for submission.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
