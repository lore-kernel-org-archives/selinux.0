Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.25.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342659;
	b=2/IpG96t1OWcuTCDx95VoaC9uAHZO6AWx4K3tYm5ItSDKoZnVnmK3dpPCmmgM9CVmdrj
	 s9+04zxAMW+y14K9w4bpLWYm6I6Y4TC39fAUFUglnM3V67HlnF/d1i1HUWvi49Gz4HQ+6
	 Oo6cKKDEC9j3pWQ1vXN/D8iL3Nom5dtIMyChdZNQKVbmJeUCyX26NLL8xkRyvEr7TSL+d
	 ztB6bp8rfdDsxs/7B3wZqH1Nv8804nfQpQvYOwuCQbrZbnafEtvGw+1OFHaRJDTE2Z1ie
	 ovkinweoGup7F4vPjcxBnDRg3t3/Ocw5ONW7iN8GF1w8aoa3K0ZlFzBZUa1Wt1Tp8UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342659;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=xyJt/IA562jYSqS9g8xyRoMMlRr+/oArZPwne7/nZrs=;
	b=0WP108H5sdCq1hAqAzMKz2qNRC59PVHaceETrpd9AtP0Rd2YVC81F9vEL4WqAzCondLh
	 SBPLZigEDkGshwcAFxbdMrAxttYt2smQ/+c2chuhwjRA6KBKhn+za+3P3BDklQ/7c5Yqh
	 mEfMdX9jcxh3AyqYaBFpY+aX/M7qfr2FtIapefvSNhUCGOl9BE4uebK3IjNsDmao2aFSW
	 yUjkKwOWNvd2vQ46gh9Uzf/yWnxC3nKz4PtHFsgHcM3HB/MP+ANP8fwPtFEIOT55t5jf5
	 F8SvKPnpC8FVtYj+Bu2e9PuRPdVEuL7GbGFqivSE2PPMXnIynzBMeYci9mVT8rhOvyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=RkE1Cx9q;
	arc=none smtp.remote-ip=185.125.25.13
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359896072526
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 20:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359896072526
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=RkE1Cx9q
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJFS1k6pzGDf;
	Tue, 10 Nov 2026 21:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342651;
	bh=xyJt/IA562jYSqS9g8xyRoMMlRr+/oArZPwne7/nZrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkE1Cx9qAQvpLdQzufswkGl40o1xzLZO7MgdBSyik5rHM8qNAiJPlA8vGIBKwww83
	 LihVFyDjCuxZMjCA7a9IlSXv1N1WxZe5d74TNG5vf5RQAc6wqA6j9pylHHNVdyS67t
	 YS/A735saKW0Di89c3fbbOx50xtBb6wBqs5HuEiI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJFQ52LqzyHT;
	Tue, 10 Nov 2026 21:30:50 +0100 (CET)
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
Subject: [PATCH 3/6] apparmor: Use security_capable_lsm() for policy capabilities
Date: Tue, 10 Nov 2026 21:30:37 +0100
Message-ID: <20261110203042.2410140-4-mic@digikod.net>
In-Reply-To: <20261110203042.2410140-1-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
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

