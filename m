Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCA3BBA09;
	Mon,  6 Jul 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381874; cv=none; b=AmF5y6cx/2ER06gOmscwqeRPsVod+/oif9jfZEdjzaKSkB9xt1XZP8glfWW0Su4W4BQ6hAxvm1tnw0qve+9kSdUnFB+c/B09LuFJ4mBbHVqpI9tldTY+uJo0PKVmadIP9Hla7bjo+uTKP9WvBprhVGxed2V1errerBFg4VAOKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381874; c=relaxed/simple;
	bh=SGXruGBGwjgp5g8L7XLPNe2tO/N+wka+Z4m/+8ZvWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me+QJWrz3aJhkHecYAcFMTTLmLW+aqhsm8KERpSxwMbKCsl5LrjoDvxQ0+M8Kl1/FOV9OBQ99KwypMyW0JvLfj30Hxn4H/i+GJXxXZwmF1vcmkZYRiwdOAM/+T01V2I0mB20K3vpIpn0Ifzlcf1+um4q5b369rm9Lsz53a/ee8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNvOlpmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNvOlpmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD921F00A3A;
	Mon,  6 Jul 2026 23:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381873;
	bh=C0Oj2urdKX2znWe2Q+So/G2dlfJ6QUaRUHUFQVEj8QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNvOlpmA3DAD5QSf/tAIIHQ7tGDMfJ2M/IKU4uOfevfBsfggnSiVX2SKJ09VkA3YJ
	 /XAWHWuSEVtDg0rtB/rt2SMSKGjYXNCXtjFkqfztklvi0mE0bhjfsv67+jp5OmoYSj
	 ZsPnymkpG1acMUeGlYigNl0ToMv5+uq+E9DrB7eyv50w9d6+/wRoUFfqUaRW6OaLQn
	 NGHZ3OOMncWiqhg9sqC+/7seNDUfNj7I9s/qW2lBZuo67gsz53lKjfLYA+GV/EA6aM
	 Dh83zXTrlPi0ZBiNbVYx6PWQp6r9phZrOvoR/XFSogu9WWsm6UyPGuFB2NeAXYt+am
	 uwoDoezEyaPVg==
From: Song Liu <song@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	john.johansen@canonical.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	herton@canonical.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v6 2/8] apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
Date: Mon,  6 Jul 2026 16:50:47 -0700
Message-ID: <20260706235053.4104951-3-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706235053.4104951-1-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

path_mount() already strips the magic number from flags before
calling security_sb_mount(), so this check in apparmor_sb_mount()
is a no-op. Remove it.

Code generated with the assistance of Claude, reviewed by human.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/apparmor/lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 88d12e89d115..71f30dd43f97 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -705,10 +705,6 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 	int error = 0;
 	bool needput;
 
-	/* Discard magic */
-	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
-		flags &= ~MS_MGC_MSK;
-
 	flags &= ~AA_MS_IGNORE_MASK;
 
 	label = __begin_current_label_crit_section(&needput);
-- 
2.53.0-Meta

