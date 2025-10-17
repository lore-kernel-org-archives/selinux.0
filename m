Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5416225BEF2
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734147; cv=none; b=bnJ9Vgajm4cz3AESNjFDTo+0lsYQK5afrYbij25YPNLgrI2YGZ6Ae4lAQynd6/Dvra1BPhVeZhsvNoybIqtA04/BDCgsigwInsOzENRnU3r8q2CZg6h2Tr/amvR3TZlacDHaFuyWOOoKGXOOWjnQDjEvejj51sydFzUVVVk03/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734147; c=relaxed/simple;
	bh=yHHngQpeJUhcXZ8Tk8ygkCfx0smf6LjcNEh85Agei0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUymSKSRNgh7gVJxEeH9cw7kMvrT6jA9qYmSb48XpAoJ+fPqaGc3SZdG0KEsgGUp3/+7EBf4jTnLm1qdyCAG896u++/5DFH1tiaYF2ELDVhOgsQ0WcThy2eWF5FLpIkqzGj7zDJuCqRZoZ6Lw6ZbxcHDv/Mli8wK7ug1rtJ7oH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pe/AgVAO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pe/AgVAO"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c13813464so41485716d6.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734144; x=1761338944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de5ug2mVr6qNuprssovqUXozxrrm7m9gudds73sIQ4M=;
        b=Pe/AgVAOskLoUzfIoRRZRbXuKmjB48t6lvvjNoh3Rp8dUQmVJBK2wNNErT8Wdfyr2H
         qJYMySBP/nTJVknHp6NUJLCatvH5PHypSPIqUV9b7let522tRKimVDkMKLuyJF4bRtQg
         oLEj9Ruq3yi2UYTlGBO0G7erXne4NQh75ytjsYeDZhZ/PHloD/h1XYGW2/wF2aF0Y7Pt
         9P/wjuzkPitoe2+qXQOJmtcIkFW/2gPFglh5pzjwasyPiZzbrQyv4JOnqB0lJ7BrsnvF
         jJo1JbQxqFEtq/GPvmDnAXROKFTSm/nIuWkojpufnn4tgIggjO6kHRpaLboLzE3XYut0
         aX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734144; x=1761338944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de5ug2mVr6qNuprssovqUXozxrrm7m9gudds73sIQ4M=;
        b=lc0aEZfm7QFcNdBwv6H65Sg/zVNQhtjJGFpOAMKjnAoxWSrTC4Z/Wu7emKglxFAlnZ
         UGoAYyYNN8uPQ1Wp2s25/wv1fYoUtVKmu/vR2rkTZj1TMnbAuCKx9ChHHh6lDWaf2saP
         qR2Lj8fsBoP5M0iKwe8gcJ875ppMrlpvmf5tNUhix9GK4jSBRH81eUlXvyKxjck6MN3j
         xZWXB3DEweXsqJ6GIJtrsrz0pBvInGGuX1eWkroCPZr0LutKibAkmqbWEhCsCgFVnF1Y
         8mzYHND0vN2d3C8aKL3i6Qv0j6e+MiRtbeHAUzwjObhjRSNAdlOn7K1oKU29Ct+rPP8Q
         4rFA==
X-Forwarded-Encrypted: i=1; AJvYcCXtxO8isU9zUlYAqZ52GRwEnTqHFpz73LnifBV/kOW9dWP7J2UU0DY1+gsMqj6AfBrmpEKZubFA@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX5hXptgnFZUZSItqYfvSbR3gK3YuWZc4gJQFpx+CO2HFY260
	mqgkJc+RMSJCPQy1gnl3pcMGxOhJLmjWEqAeaZKk3vvY93UQpURBC6luq72H0S/M3A==
X-Gm-Gg: ASbGnctR/rRE7cLNIoqKoOwnMi+GJxqATxFXoSyT9eeU4fv3qKumleWZanYs071XEnl
	kkBdGogUhQ6R2i5R3vWA7ZbDGvvpfnxDTHeXrrtaeAjaE9IwoRlV4dnk09ZYvernRRBGyQCp2CG
	i9XDF1XPdvIUNzVMPL2fUPLdD7/Ufhfofus04nWD1onh9fxJAwhxNKY3/1wXh2uuYW7eyGNXV5X
	jqrlhXqYAwOq7vp6aBLn4aBE7T03pBZBJ+sMksbOHZMN6BKIDCAJDNjR5abs6xvut76ht9GGSpT
	Q8TdK/uEwmv06M8qNN2LQuigy5whNK9EE5kzSBGoRpbwcrQ1y3UxIZ/tEkKwM0lwUREx/zEn5Vu
	9/rm+CM8u+B5fM2+m434N/eG5/oDOaHLrDcggDxl0iX4aCxD+EfIT4cROy72iVXs3MvL4RwAk9d
	L+AFMH1fi1nUPyAyW0IyTogT9W8gOJLIWehNnJVcQaX6+DqMxfD6oFNSp6
X-Google-Smtp-Source: AGHT+IEYJmrjzDT9K864SuCp7sxuJyWWaXrvY1Fk78ny0HD8OrrSO2cVj40cf/XLne/qfT3Stj/vdQ==
X-Received: by 2002:a05:6214:2307:b0:86a:7c95:126f with SMTP id 6a1803df08f44-87c205a72d8mr73592276d6.27.1760734144281;
        Fri, 17 Oct 2025 13:49:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028966fasm5125866d6.33.2025.10.17.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:03 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 07/11] lockdown: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:21 -0400
Message-ID: <20251017204815.505363-18-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=paul@paul-moore.com; h=from:subject; bh=yHHngQpeJUhcXZ8Tk8ygkCfx0smf6LjcNEh85Agei0c=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quiqxWeas4jEgIZPsHE0eeK7NugKpzhvoo9Q HkksUQVL1WJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrogAKCRDqIPLalzeJ c5xvEAC7aR1LlzJJg1z391U47fb3R+GNViN6q6HOIsS5bdJiyQaVKF7rhXe3325zz4ZsTk9mmHd 9cpq0irofr6aDY0huPN75OH/aYcltJB7OZqO2hMKYafg6Desd3hcQAvt5/8XwHd5WjbQvdPPvLQ YI6FU/+TiHmEZFNj1b4BC2MEVBICy78YDAIFR78fSe2il84+XtOQyVNEr4WjmiXE+Qm+tt3uoq8 FnSUyNgB+NWa8Vbwq/3DGjnp659tBrOqTpUJjS+dC2iO4s2jop16uFwpOSNjvrpbwzhtZJFq2SK thD7/XvE2Ht6X5OJs6tFyjqPO22+PqdjigT0tWy51eKcj9KU1O2z7Wj9K7qTlZnuoUNqNAkjnfc xNpF0B2stNrhd0T6smvBJ3a/lgcPyjhFmzgGZaE8Cs0WZ89Lh53VUvFI0t5XpTVicRLwD1gKmCD xiOqGGEzcxqUUSDikJVgCHXriqZqoAAUhsti2F/NHUQTZeoUhSmvi7qRTdE5W/fmNVVfOFBUYrm kEKc19sahbCr8wBOZP7i3J6l18yVNUBH2Ef7Yt3pYH321IKvp7jGkSH3a0fP2wcnGvah8vF4vzN 8Be81CqN5TLKUvjcfzP2vboDi6Z6Ez/DdH792CzdzZY0Dn86Dyrbr7ld2E0E8AZXNl5IqFNhVFL +FYEg8/ZNe1hovg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lockdown/lockdown.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4813f168ff93..8d46886d2cca 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
-core_initcall(lockdown_secfs_init);
-
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
 DEFINE_EARLY_LSM(lockdown) = {
 #else
@@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
 #endif
 	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
+	.initcall_core = lockdown_secfs_init,
 };
-- 
2.51.1.dirty

