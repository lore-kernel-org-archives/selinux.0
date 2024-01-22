Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB753D3A2
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931719; cv=none; b=pMBHhf49v9NMTBevw9tCqg0WKNcqGJCCOtoFtUULSi42zbU0JRu6s25l7B8hJ1lI0Tc1nyunYssxZt4vzB24WQQwciDo2yldG7ocakleytLKGwnT8VpqZxbt8euKUXhCIR4l6MT3F9rWFw1JtDGt2qCaksgVvVmv5B9R+y3ltPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931719; c=relaxed/simple;
	bh=63YbdgP1Oo0xkhjEBl3krZuGz9L+GOtn0nbUgJE0N4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsnxoEbNH/RtqbyPalTQ65ntgdCmXZMz3Rn/g/rrmHx53WWOunI90AXIwZyc80PP7UKwccl4UinaC0vZcJREM5Q12fKilu7tkdTdB8gubVQqolxw8ZiC14S5PsBfzslhY860aF1hAlDUfKNoXOSsTOzNf6CrfuG0xzGVKkexHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ve6FYOWQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ve6FYOWQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so540401366b.1
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931716; x=1706536516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaPv4Mo8+LQF4D1JnZ7XJPcuvY6YRaSAd4GjvCvWRF4=;
        b=Ve6FYOWQsHbn/sE0xx/oOQNTWG2At4de6FOtF//BcB2XikAauaObCcv/LvnGySac34
         uZWiH0kPGSITdxu0cdUp4Vyw1Qi/pU9NdRE2fr1UvkNsNM8ZnLuU5y/7z7iuYI9k+4Ro
         EjFpY6BoUncciVRJBu51tX3xhQuk1bCfvO2ITSDvkWXkTnvq8AH+dOT8HjXPoHpFzi+G
         KBe2LLe96b8ldIq8/wBMOmK2rHgyZL3V0vA//NH/WdLHPreeCjdkJgxJU72UiTLjMiaf
         hJeSuvtlSrH+JCq7NdT3StJqoZn0uiL4Nyak35C+d4AL+V5NUYaL6MjvbD/a56LZd8Ni
         HjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931716; x=1706536516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaPv4Mo8+LQF4D1JnZ7XJPcuvY6YRaSAd4GjvCvWRF4=;
        b=g3vjDviuJSE+OSqWnbyudcZdSecpf+UUy3y8Wy6Bp0UyWSJp44IBz5oRu/FC6fyOoz
         QziVoWKc/jFr6scYt0g/rgngaAUQXtEVlvUBZkgjV5rUyT90pyhqdximetpaOceSdDlO
         b1UWTVrTE2qU2N0Ijnyj5ihUioCe74wKd7udXHzqJZL199U0H0VL/xhuE80d7DsFN84e
         SwgO0XkriyfPhmoiV+USdqGIM7Ip6MVqDA4yMleGSGhWOa0XSuUpvM4KjYhsb+3JlaRv
         /ZRpNh3LHI7qyV9lDa7DamUBUMimBt69y/1Owatfw0lNosV47J5bZ4KtEwWFVTjdaU4j
         TwcA==
X-Gm-Message-State: AOJu0YzqjJusCL4RSoWhB1La4LFOKTjMAcPGMzvEuy9hWQaEzIaJdB0Q
	ltm0gCYttgY/9x/xackYTTGBdSkagvz+CTvEuWdQxeYQS7mMomdaaxrsFmlg
X-Google-Smtp-Source: AGHT+IGlS0Tj24eXlAJy2IBWRrjIrF1kslQMIZ1ADiDmWakn7rtxFe/nUz1mJ2IodzIUWJ8IsBTgQw==
X-Received: by 2002:a17:906:2850:b0:a2e:acd2:1fe2 with SMTP id s16-20020a170906285000b00a2eacd21fe2mr3937765ejc.76.1705931716254;
        Mon, 22 Jan 2024 05:55:16 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:15 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 05/15] checkpolicy: check allocation and free memory on error at type definition
Date: Mon, 22 Jan 2024 14:54:57 +0100
Message-ID: <20240122135507.63506-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 053156df..ec19da9d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1399,7 +1399,7 @@ int define_typeattribute(void)
 	return 0;
 }
 
-static int define_typebounds_helper(char *bounds_id, char *type_id)
+static int define_typebounds_helper(const char *bounds_id, const char *type_id)
 {
 	type_datum_t *bounds, *type;
 
@@ -1482,15 +1482,26 @@ int define_type(int alias)
 		 * old name based hierarchy.
 		 */
 		if ((id = queue_remove(id_queue))) {
-			char *bounds, *delim;
+			const char *delim;
+
+			if ((delim = strrchr(id, '.'))) {
+				int ret;
+				char *bounds = strdup(id);
+				if (!bounds) {
+					yyerror("out of memory");
+					free(id);
+					return -1;
+				}
 
-			if ((delim = strrchr(id, '.'))
-			    && (bounds = strdup(id))) {
 				bounds[(size_t)(delim - id)] = '\0';
 
-				if (define_typebounds_helper(bounds, id))
-					return -1;
+				ret = define_typebounds_helper(bounds, id);
 				free(bounds);
+				if (ret) {
+					free(id);
+					return -1;
+				}
+
 			}
 			free(id);
 		}
-- 
2.43.0

