Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D232ED21
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595599; cv=none; b=K6m5Pa7aYxjwfBe5gb64eWpduV2rNPxwsj1rGy12BJAgS1PgluPPxRTs1iaZyXRW389E6XNTAIt4v+IvNaG8wRlR0LA9L9y+eNSdvOkHZyvgLszRvVotaA2dqVwSAk0hQ7VxRlELxkagMh3QEH6bhM8XM6A6YdmxQ3X8blCRl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595599; c=relaxed/simple;
	bh=rsNRSZHfddv+agozzXjMjd0ekVPkoo8G5YWChybJSJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0LBSGFw76N7ws9hY9g+K3KCulaAIxOitcf+M4Ca1OoOvxrfFeA061xWqL1rSwaVzf6EdLqTRHLRhLc/NUGP80g2GdbZ6RceNVvgsMy3XfcCnHMpKGoxRXtLl16A0QpLaDl/RYK42JJe1UMW0ZsBE9FXlnb6Kz4b4FD/TDSROFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3ealCEb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3ealCEb"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91591f19716so131307785a.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780595598; x=1781200398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETDNizVNaZz8ysMnYsgyBKWb5JqbzIOfMGZ/sQym2Ow=;
        b=i3ealCEbxm00+yIQb6bO93wIJvQCO/7ONr/9o/Z41wPDhtTVI5uoaW7qSF5fINoA+y
         CTTmIqnYlhhQQEdl9dANY0kopj0dT51naxqM8PmU85PS9AzWFr5aSTQYU4x51+tB77TA
         9Pmbn8UTx4tgoJM5Clkz1fswS4f+8+g8xtw1LXEu0eR0ZowanB+C1Gfgj/9PjoHHTrAf
         dlTGryZuHnqltjnfd40U0fn6KwiVFWTV+Kfg03zerwhV1SQ/CHD6vdt+0BsqEcRylm+9
         d77KxQo0A1FKlFBdMrwJ3Dx/bFXUG02yOKzuhLPRQd6N6xhjOpBvHU2frdEcqVv2Qzez
         wahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595598; x=1781200398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETDNizVNaZz8ysMnYsgyBKWb5JqbzIOfMGZ/sQym2Ow=;
        b=Bl4LEsRaw/m1QJBV6Fzus86IVfmaCVtkXF7FIDEeIzKf8P3QFCwiwuLrsIC0/ch5iM
         wX4z3/dkbY0DmxgtP+g/G0CCqSLbHXhsacWaVdU5hVE/l61x56cU/0Po03H12KbqVWYC
         NqebB0IeDylQpyv+MPprPSWalHj+iP9jRXUPPLBl8EJe7Z9lRYCPtwuB9KMJzEUyTdXS
         xlHKL34m9O1FVpfAcRRwKVBpfBGGPGjjc74NtNojzY2Lf9wTlxbS1VojjNy2kZyNKh5D
         8EYvgQTFTdmBG/TUrSoBgzGIIXOLkiZFyJAFLQNpS6IuJp86taB4CZHazQN1mFClQtkz
         PEeA==
X-Gm-Message-State: AOJu0YxUESegzz3Lkjl39+NIjvl9BhlEwu60I5J/TyZMddA6b7PIodiE
	jyLXiPyuQzg0yaj+8AEhUKRYk3+CaozN3mqHWbEGQYZ05qM9+CHRydi31vp79w==
X-Gm-Gg: Acq92OE23bsUMhP2rUfSanYPAt6RoWGTQ/DbOmszDL167CoGYbuqZyxaZug7jlCGBBD
	1VtZxPbG5hkFOwc0hoLhDNBlSLi+dQTy5K9QRVgP7IiA5e86Lwg5uYgDktitlAk4XKg3cQcldPO
	SiQPWPCjoHDSUxnnEg3z0uH3LdFS52ePhxf98Q/EPLK4b8JF/5JT4R8rDThDnTTohcJCxeqCPk2
	2Dp1aGGTml7OeBWhIdqLgsT8V5X/kVnWWs0A8sKJ3KyYDfB6l3oqovMCj7ADFqeSOjkGhCC7lMT
	2TIxhWj9CM6gqEdvFDhHw7AEla662vaDVOMEoJ4DBBZm7r390rdOXfyBa+xjZhryeAHcXoDZppi
	d3xJPJKDLDjbPbRvkswb9AHjri9HAKEiiHTwrJS/BvNRxy/xfqYa26aKuHMsMcf0VeEYI/Nzu5H
	Dtqm3tkpQiuBf4rhTKpVbp8oJRf04NlpDKx7hK3+XGr1pu6eSAa7rMGCoe5KGdJ8zViJsCjqa5w
	/dWcqtUWcB1v6YTIFW0OS+JmdmTWB1blvXT+g==
X-Received: by 2002:a05:620a:6ccc:b0:915:9943:d795 with SMTP id af79cd13be357-915a9db5714mr24548085a.44.1780595597688;
        Thu, 04 Jun 2026 10:53:17 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm646259985a.43.2026.06.04.10.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:53:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] mcstrans: fix glob() error checking
Date: Thu,  4 Jun 2026 13:52:57 -0400
Message-ID: <20260604175258.264439-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glob(3) returns 0 on success, > 0 on various error conditions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 15c2d76b..e0593c76 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -854,7 +854,7 @@ static int process_trans(char *buffer)
 		unsigned int n;
 		glob_t g;
 		g.gl_offs = 0;
-		if (glob(tok, GLOB_ERR, NULL, &g) < 0) {
+		if (glob(tok, GLOB_ERR, NULL, &g) != 0) {
 			globfree(&g);
 			return -1;
 		}
-- 
2.54.0

