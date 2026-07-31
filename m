Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4653416125;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519850; cv=none; b=giuN9t8t3UWh075lP09AIhqcHjh63uhG1l2GGbFquDo/nywSgMKozhyqSx0ayIejhKoSfFkRsP+iAtYCgEqMb1yK/0r0OrL5xZkjz8Oh9ghxALhP3aJQkGG7xLqcUvlgdpaFEexcKDLojfclc+GSpRnInHdyHd7OAnxk8ybHgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519850; c=relaxed/simple;
	bh=PLkkmGRA1MvUV3Aj1xQ20xyb2Y/W9NXMEoXlMvEX9cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvAuLn+th7jSWXZ/aVJvVcZMrNgavMiYAGLX/w0YE4bifk+4ZHJV4sDg16qYWKWokSa7vjTa4WLpHtqHs69JLYRiQVwn5vrzUt7iXpKjTpWHqWGWgiUB/cUJw/Ko/nhjs53a3GhHDJMIb5KDYK9KH9lIROYAsWGK9gQdyDpOwrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfuMPBT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfuMPBT+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0305FC2BCF4;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785519850;
	bh=PLkkmGRA1MvUV3Aj1xQ20xyb2Y/W9NXMEoXlMvEX9cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CfuMPBT+RB6JrztQEnBIBLel5Jc5ViipV9D7BvG7xPu+wddbh5UVXnWRimZj0dLQL
	 dropNh731s3ciEIw5rRThxDd79nP+G26sEm9y7rj0vWEn2jE1MKxpY/nEtyTQnam6N
	 fF2KDyYqCQceFWAcA4YMF0MfsBqzKmdmq06Cr3oHH9ID3FwYzki+p2aLJaV10125b2
	 uk6NgjVa0eBoJ7ixpjpgu5zIFfzzwNZscdgcq+6lde4jRE/F2ahYRVDXc8UFtiJw3L
	 nX0I8mtBemEclNfoQO+O2UHCivupZDDQgFoJi40Y75GU8eG3eTIEX7VOdpDv6y4Irk
	 2T1OWMIVzW7tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D996CC5516F;
	Fri, 31 Jul 2026 17:44:09 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 31 Jul 2026 12:44:09 -0500
Subject: [PATCH 1/4] selinux: do not cancel a policy conversion that never
 started
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-b4-disp-d32e997b-v1-1-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
 Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785519848; l=1563;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=9Qq8XJedLiodysrUmiyu10hH6TBgjvkDd7Iu7+OmmI4=;
 b=NUCyDDPzA4NIDI3YaWpAh9+dO4rxlHCk0xPk72BtxXUpO72Odon7DAmg7Z7bg1req4rRK7fHx
 gQPQrKcumabCK6mMKbFuwvFY1n1AgvcLuY1JBX/FOLjXmjDEpf1gQH5
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

sel_write_load() calls selinux_policy_cancel() when sel_make_policy_nodes()
fails, and that helper dereferences the outgoing policy to cancel its
sidtab conversion. On the first policy load there is no outgoing policy:
security_load_policy() returns early for that case, before it converts
anything, and state->policy is still NULL. A first load that fails while
building the selinuxfs tree therefore takes a NULL dereference in
selinux_policy_cancel(), reached from a write(2) to /sys/fs/selinux/load.

Skip the cancel when there is no old policy, mirroring the check
security_load_policy() already makes before it converts.

Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/selinux/ss/services.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2d828548f3db..90e81186cb2e 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2221,7 +2221,9 @@ void selinux_policy_cancel(struct selinux_load_state *load_state)
 	oldpolicy = rcu_dereference_protected(state->policy,
 					lockdep_is_held(&state->policy_mutex));
 
-	sidtab_cancel_convert(oldpolicy->sidtab);
+	/* a first load has no outgoing policy and converted nothing */
+	if (oldpolicy)
+		sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(load_state->policy);
 	kfree(load_state->convert_data);
 }

-- 
2.55.0


