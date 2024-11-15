Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEF1BB6A0;
	Fri, 15 Nov 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677818; cv=none; b=DTxkmB1GVVgvvHl4yb/+sfnmVQ7W+NMOrKGUqLbqY3IwAt7PAFkSFaDmyJyx7JLu3on6SVezwXwbbW42Kx/Ctd5ivAwmk6COUFGhQH3Riisuw2i9cirSWBtqh7qx24sMNa+my8bDepZWoJ4HyMGV2+D2a9GGpy3incpgFsXfcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677818; c=relaxed/simple;
	bh=IstwLW2zhn3qEWdFp8adFMJIYE5vUm/rY+EtmrHoKjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPAwU5v/mwvVQXkoKWycqdL0OBUPprtBSn3zG5D7B25B0PgT7GlGRO+QbyqlOKZSpvioVryOH3m/GDf3cIbQM4cosXVmqre/GyecLJXUkn5CMs/rB7RyC+NgPi/SpY6HoZB4YfNsnHvcsZqoajyKw7aAC/h9EwMu08M170Ztlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NIihLPGo; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NIihLPGo"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677807;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNiCQzCcJNVkbxJ9W1CrNakvYqMUJxFpdDW+E1fK980=;
	b=NIihLPGoPCBLaG22L/+oEJj4RD0KG1+FsguxpOLcYP+kd6G11a37kuSD0pGMf0E9Swb2ph
	Rpn/sGuuO9Y0P2Ws32/q5fPyp2p8Ld47T/p/W8q+Am7T9+K7a3K3uXWBWlba7vkZ0xrJZ6
	lwLKK4MGiiynnbl7Bw9F98yGiUFHi05qlc9ztW0TGazBR9AmEhvxA8OMDBJQAt5I4EWHAA
	/pcoaH6/2c43v+d85GMtwobhI7aaBJaE7HMi6O43N1V+HYFJIwL4VbfUPi+CEvlnMsaYOr
	/CmloRejxNfMA3skraP2ufbdbYnlm5RokG2UgeG1jV4c7UXHhGIVn+dC2vSzQw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/22] selinux: avoid using types indicating user space interaction
Date: Fri, 15 Nov 2024 14:35:21 +0100
Message-ID: <20241115133619.114393-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Integer types starting with a double underscore, like __u32, are
intended for usage of variables interacting with user-space.

Just use the plain variant.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c       | 2 +-
 security/selinux/ss/policydb.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad3abd48eed1..637a180e6b9b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3135,7 +3135,7 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const struct cred *cred = current_cred();
 	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
-	__u32 av = FILE__WRITE;
+	u32 av = FILE__WRITE;
 
 	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
 	if (ia_valid & ATTR_FORCE) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 4bba386264a3..5c11069121d3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -144,7 +144,7 @@ struct range_trans {
 
 /* Boolean data type */
 struct cond_bool_datum {
-	__u32 value; /* internal type value */
+	u32 value; /* internal type value */
 	int state;
 };
 
-- 
2.45.2

