Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117E1EF363
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814579; cv=none; b=Ao2Vf4NLGQVuv33sAAfXnytrHFdJeEoYAINlZ1vJhMAJnof9Lkf5gluP5JazBUkfgglj06ZFnWMEx2g66+izHnTwaAs9JzbOpqDAgfmrA3JoIhrXhI7cRsYeNHdsHvUEA+UcSTLmP3cmelrRtLY3QLwx/n1lz28Fhla8nqcSTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814579; c=relaxed/simple;
	bh=b4+VVCuulTVS3lasReYQ2g8sMWbZpqYEurik+q7TDIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHXjNsdAmTMVdN8a5xbUeLStCe+RtzWT/FAmwRtazzOHStBFtubZirzVaFHB/7gPmUYDCS3f+ekY0PVhp9soHsPK+OCaZtzqgEUjLT0YTdZc7OSZRl+00hwqm47BC8kzSb9art7+GL2OcUOMwcKF/27Nj8p8OJNFZvxUwyI8NO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wXHZQnMA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wXHZQnMA"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D86923FCD4
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814567;
	bh=uqtVwBDq5g90YIrppYWGT9PUS27SLEfARyjY6b0CvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=wXHZQnMAbweFyixm/4yjK71qO9242A1HNYoXX/nCd8p+RYITpNU5PZTBrcIvtgw7s
	 3Cfua9ykXolkNe8sqNhQTewpZzDEo9hJ8v22TSgfp936vThetM6T14br6KexQGwp4n
	 +Isc3riXaRUo2ZotDauFSLzZeYnIW3I/SI1Qh0dY1yv3rC2RXh+bC5LeZLkAE2z9vL
	 hBoLp6v0DiHX9j0JXXrgUEsBEpHG2OiqmOdkIOiyl5ArlJK/AmmvedXelZbphpQSgx
	 kr72q+roBfgDo+g6bXTg0/Ix14ooarH0l/+izy2fDMvlut42EknAd7q6yoQjnPB6Vv
	 WerhTrb8BANqA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso734267a91.1
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 14:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814566; x=1742419366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqtVwBDq5g90YIrppYWGT9PUS27SLEfARyjY6b0CvJw=;
        b=pe210ELSghVO8bV9V9OMct9PWJ/YDn6nBByI13ppdFFzXm4welQ8IQoxzU1QO8780z
         TeYummi7ISpXEYniheRd0ms1TjME9e22HeokZ6CW4OYCM5dia2/suatU2ntaPM66CYKJ
         II4VG4hizzygmyA15GmZlS7fMOZWqnjCjorgzk5GwuT6fxRQaI4g2tPU1hVKFUTn9+S/
         vX53epQCn43eCEooFbfDGShbYoBzJQm8sL15mHqK0o7eeLScvtrJP0RLPLJnLHUU5DgW
         1Z9VXHip0+2Mf1cWx1QNua3b4hS3MOWBTaZT7qEWUOZDscYaXyIIJH6pKav88K6qbGff
         xDCA==
X-Forwarded-Encrypted: i=1; AJvYcCWsZPm08vieUTTbGWDGQ07PNFlmt7MqbXgw2yXOtpR1l2N5U/hgvIcepP1mQn91n64JeiNcS9cC@vger.kernel.org
X-Gm-Message-State: AOJu0YxclRYVI/agl1E3b+43uGtZkQwOFpI19YeooWqoaTstQ4a2puRM
	lDX42J+77zlnnslOypoxqD2LjFDLr9Pjw5MGA1yMzxmrgwVnQPr/Zq7mvcFO+C4ock0VqszfOfh
	mHZqb0nsp3pdK+gj1qzPCmjNPwb2e+DVUeKSkzz75OxnQGIbvfLb+0+INQQIT9zzKBJEi1Vk=
X-Gm-Gg: ASbGnctl8YKPKIM/BFtzK7FORLBj2GSpm6XgAQNMXg0/3NpMCBzZ8iGSlIBwYVM31Fl
	uF2KFQTApGY6y7Ht3/ixIUmpo9ZP7H0HrPif0YMyPiDj6SezavISF/tK/hjzvTUDe74GZ5ENhTP
	5jwJt7Ednb9jZYz+RdP4g6Skyrd4H0suBfDtm4KKuhDjU/tNNyoql5Nl2VwW/k+FmDRofTIW0iO
	S/NSSQqRf2WZnWBEY1pH3V78EV2AVtm5Nep7ejjJpHAfvo22x8qmqlIyY7fh1LGWsQ7HfWfnJ56
	huEypABvN4kH9cbZuZz9gIBgQM8OgXCySqxOfdgiKr6oJtobCbjEZPs7rcUq//TwipkmObI=
X-Received: by 2002:a17:90b:38c7:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-2ff7cf2a4dfmr33760030a91.29.1741814566527;
        Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAh7edf+w4rzXzQLR0fkq9YMtlXCTroL93A1jr+Tsldo2r/RTEDBE9CJvpxWToVeKTIWZWGQ==
X-Received: by 2002:a17:90b:38c7:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-2ff7cf2a4dfmr33760017a91.29.1741814566237;
        Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:45 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 2/6] apparmor: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:42 -0700
Message-ID: <20250312212148.274205-3-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, we saw O_PATH fds only when mediating fd inheritance on exec,
but because they would have no request associated with them, we would
unconditionally let them be inherited. Until we have better handling of
O_PATH fds, preserve the existing behavior of unconditionally allowing
them.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/apparmor/lsm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 11ace667cbbf..2349a1dd41f4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -647,6 +647,16 @@ static int apparmor_file_open(struct file *file)
 		return 0;
 	}
 
+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated.
+	 *
+	 * TODO: we weren't handling O_PATH fds in aa_inherit_files anyways
+	 * (all-zero request -> fds unconditionally inherited), so proper
+	 * mediation of those will require changes in multiple places.
+	 */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
 	if (!unconfined(label)) {
 		struct mnt_idmap *idmap = file_mnt_idmap(file);
-- 
2.43.0

base-kernel: v6.14-rc6
