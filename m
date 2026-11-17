Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910736;
	b=k3k4cgzDThX2LYV9XHDXOlrPnkG3zbhhyTwQM8Smj+LZZNfe1NDXxmAT4DXwtin2OtyV
	 rfojF/tjJEgQii/wxla2bkObNSsenbPJyeVb8MLqq3KrhwtVuyEyjkNZAPabI3lyYy8AO
	 QhuC3sjGJs64Urdf7lBMzo8Hxcd5lzxXeEpOrDEK5jCpj2r66L/unptxSa5TzN6A2A3p3
	 GSdVXoHSZohP8uESvV2e02fIoM49dKmBGfRHH1DQtx8FkpFinYok2vIeG2uW1LQCnteN4
	 uWsv6bcfnR1VKlO6ETDycf0sRqzd7SR3/K9zT/cr4Ljsq/B46v0/+oUYyslQ0+nPROQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910736;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=xyJt/IA562jYSqS9g8xyRoMMlRr+/oArZPwne7/nZrs=;
	b=R30jP4dWynlHAF/X5CN69Hmiakg3B+JUTb5VvToDL/PRMl1Fa0H+qs0yzQ5Z1YMg3p1j
	 DH65AWJqgakDFuotdxlqQDc/CxVG5ae+Ii/h+Naj/thVCLKmsWWmQcp2IuXbvGVp0zjWp
	 ok9oSqzzDPSCJ4adWQNz7Q8ax3RUToFz9IFBrJ77rz06UzmpWV7aSPM4OT/fAmIscZ0H5
	 ssDOpRk7j8JD1QLwEs+b2pIc218kgFkCTzKfw8w4JVOXsj7pDYY+HLRG243QYfq/fD2jA
	 0e7ve2n4Aj3w0BvTlRByhhWVYbEwP7ADfioSfvmgqvUZtc4jTlyniZ8TZZOQwZx0NbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Dv9awIs5;
	arc=none smtp.remote-ip=83.166.143.169
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81896606A339
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 10:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81896606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Dv9awIs5
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLL56hVpzXHN;
	Tue, 17 Nov 2026 11:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910733;
	bh=xyJt/IA562jYSqS9g8xyRoMMlRr+/oArZPwne7/nZrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dv9awIs5gUzRG+z63H0PIB1hWCqFtXbb/oeVorObp4TuVEOdcTZrZKTlMT7XLHc1v
	 Akfz04OdpGBVlHdY4vBJw3SjsM0gurUmSKllW5Xi+q+NQUksPhScHUZ44KyD6AFEBl
	 Oo7riDrp7FE6PgKklYtzrdM9PuU4IilcZVtQIxLw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLL43Dp3zK4J;
	Tue, 17 Nov 2026 11:18:52 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jmorris@namei.org>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 3/6] apparmor: Use security_capable_lsm() for policy capabilities
Date: Tue, 17 Nov 2026 11:18:40 +0100
Message-ID: <20261117101845.2523770-4-mic@digikod.net>
In-Reply-To: <20261117101845.2523770-1-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

AppArmor checks CAP_MAC_ADMIN for policy management and CAP_MAC_OVERRIDE
for unconfined stacking with cap_capable() instead of capable(), so that
other stacked LSMs do not have to authorize them.  This also lets a
process in a Landlock domain that denies CAP_MAC_ADMIN manage AppArmor
policy, and one that denies CAP_MAC_OVERRIDE avoid the stacking
restriction on unconfined profile changes.

Commit 31ec99e13346 ("apparmor: switch to apparmor to internal capable
check for policy management") made this choice for CAP_MAC_ADMIN.

Switch these checks to security_capable_lsm(), which keeps this choice
for LSMs that only implement the capable hook.  policy_ns_capable()
still makes its own aa_capable() check.  Update the comments that
described these checks.

Cc: Georgia Garcia <georgia.garcia@canonical.com>
Cc: Günther Noack <gnoack@google.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/apparmor/domain.c | 9 +++++----
 security/apparmor/policy.c | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index af9e8431e3ea..d2c111783457 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -884,11 +884,12 @@ static bool is_profile_priv_restricted_to_stack(const struct cred *subj_cred,
 {
 	if (profile_unconfined(profile) && profile == profile->ns->unconfined &&
 	    aa_unprivileged_unconfined_restricted &&
-	    /* cap_capable returns false (0) if true, hence true here means
-	     * doesn't have capability and the stack will be restricted
+	    /* security_capable_lsm() returns 0 if CAP_MAC_OVERRIDE is granted,
+	     * otherwise the stack will be restricted
 	     */
-	    cap_capable(current_cred(), &init_user_ns, CAP_MAC_OVERRIDE,
-			CAP_OPT_NOAUDIT))
+	    security_capable_lsm(current_cred(), &init_user_ns,
+				 CAP_MAC_OVERRIDE, CAP_OPT_NOAUDIT,
+				 LSM_ID_APPARMOR))
 		return true;
 	return false;
 }
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 63f7821b4dff..ba162d921805 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -876,8 +876,8 @@ static int audit_policy(struct aa_label *subj_label, const char *op,
 	return error;
 }
 
-/* don't call out to other LSMs in the stack for apparmor policy admin
- * permissions
+/* don't ask other LSMs' capable hooks about apparmor policy admin
+ * permissions, only LSMs restricting capability use through capable_lsm
  */
 static int policy_ns_capable(const struct cred *subj_cred,
 			     struct aa_label *label,
@@ -886,7 +886,8 @@ static int policy_ns_capable(const struct cred *subj_cred,
 	int err;
 
 	/* check for MAC_ADMIN cap in cred */
-	err = cap_capable(subj_cred, userns, cap, CAP_OPT_NONE);
+	err = security_capable_lsm(subj_cred, userns, cap, CAP_OPT_NONE,
+				   LSM_ID_APPARMOR);
 	if (!err)
 		err = aa_capable(subj_cred, label, cap, CAP_OPT_NONE);
 
-- 
2.56.0

