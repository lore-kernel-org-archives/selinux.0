Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBD4A21;
	Tue, 20 May 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742475; cv=none; b=FGRQ+uErg5ppITW4h+dlUuWdAlSUg4RbcgDsZTZWLy9jmTW1/spC2Lv/pmxGclDZsk2p6RMUH6wJgoDavwu5W1cCts5bkRXlFP+VyVOTuP9iorogwj8f0TkHWp3PJFRizjdI8AeQA1R0s/CSHoLUY+AscQWbJKmjMcszrvCUtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742475; c=relaxed/simple;
	bh=EnFflaUL8027SIYZFlpUUbUT9Umfow/GO+ggQMC+eow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAjUNnq1Qv68uEyOOcSDuMkPgZudSBpUNlK5KRZMjgk4G/VP7dL0e37VS6k3V70+ARkFCHjJKBeB1qTY8q4D5zrpH4PCHpIv4DJJX8Q//K+oMUiLlCshE38Kqj+qETdpKwRX48Dgvu5Qa9buCM67s+Z18bEb9XU1munJ2hoNy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYBtuQMo; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYBtuQMo"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7cadd46ea9aso849520585a.1;
        Tue, 20 May 2025 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742472; x=1748347272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZdHis84uwUWSgQm932zXiw6jTbpv4wKjM8Lb9jymcI=;
        b=QYBtuQMoCQT4686jHShbur8dmX/weZyp2rwuAPjAnRS4ISe9S2qhZmtDbpImS/f4cw
         stwoXhNDaNlCSj1AWk34L2UiCxMT4lOKGuWWoyuGfCpsewSBOWkQjXgrbZCssGuHsXi5
         7rPGz3OYN8pZarJKrBFhW3bxmXZuV2iGm1h4xzwys2Kl2UiNgLH8uA+ud7yadB77N67H
         qeS3SXKqVyjy4Ci6SKfyWCB6qwVAezus8IWVgRvi33XOAHEBimuZbs7apMoJz7dShHWx
         dKtZgWSEFZtWS+LNfXFLQt+q/kUIowRhH5LQYC2o0ztyOoplDtsWEw9XihbxjTIrOIRO
         yf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742472; x=1748347272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZdHis84uwUWSgQm932zXiw6jTbpv4wKjM8Lb9jymcI=;
        b=fxPI0foJv81xy9I4e+qIXb/HnqowVzK/P4Kc7BFwJ0LcyhWgmbey6GorFygQpesVgv
         sxnnbaIxcbDD1GRI/w0LWlKq5vW5cGmp+TPI61LudtuhiZnNN7h0CZ57ls7f2SEmHdtx
         Vw74/L8ElsexH7CmZfU9O/o0N+7633g/2hA9AsBFwZNQtNaDvGPa4xQGZ93pDpzRbMWi
         LMJAuvIBY0pfhr77nRR7wCdu+Zj0aet/fjlwCZaCVyb8BFmUN1k8v2nmm23nkVa4eTJ8
         02NrffMvv/5hq0UBH7D30caiKo/URTmSwpgpTQk9z3wbHmwdL5J/7/vk8NO74gDQOIIo
         FPqw==
X-Forwarded-Encrypted: i=1; AJvYcCVXTPzslCxNORVa55o41aDPQh7VnHMKUXenKlNNvCIx4YmrP/2MYVvtwLEhun7IAiEfZIH9dJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTOUeRoIocw1aDCiVraRbUzc5N3wyy9ihfkvFQ89r2NCmth+E
	zJzMGRaotxz+lMu3PMONh6rezxXjcXv6BoeEoAvoOMvQ4wc397Mg7uy9rkLVdg==
X-Gm-Gg: ASbGncsCDnhbaZS0/Ec7DN4h10j7WrbuCk6AIGvQDfzwH0lAmpXIqixXlk+lgywjnx1
	KGlY6yjEjTVRc+HYopTwK9U6IMhaDGR55w6ONO+/auoMqujH6kYVQgW7DjfbONuT3SnODcIeINF
	+udV0HDytW9I0TcVVQlkWIjK29uebpmwpcxFiYE2YsVf5tjgW4z5xTQPFcESSQbW8cHUjcpxalI
	6UEErkOgRcekL+fqsrBSa2SI3txY7aYKrkaYpXgT6VP5XK/CS6FkIoRIaIEZettiKhCn6JAVm2s
	W6J1DhDhsXLZOCtoeCpfzdnm1TFfhsk+DUSudhcgasj2fFlc581Hvx9hw6Livzxt3gsfsgsLkiX
	wq5TQycdpUVavlJhpFQ3AfywDFzbUrxQTJXYrTv/olFt49fJA3sjXyA==
X-Google-Smtp-Source: AGHT+IENwKYoxeoA11JngAyZ6hJ1CDiH3jAQ/AspDkWovW07A9Y367SNgfW2rMdh5D4bKJT6yp/7gw==
X-Received: by 2002:a05:620a:288f:b0:7c5:9a09:cb73 with SMTP id af79cd13be357-7cd47f13490mr2283670285a.23.1747742471921;
        Tue, 20 May 2025 05:01:11 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:11 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 11/42] selinux: exempt creation of init SELinux namespace from limits
Date: Tue, 20 May 2025 07:59:09 -0400
Message-ID: <20250520120000.25501-13-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exempt the creation of the init SELinux namespace from the
maxns limit. It was already exempted from the maxnsdepth
limit by virtue of only applying that check when there
is a parent namespace. Otherwise, if one were to set
CONFIG_SECURITY_SELINUX_MAXNS to 0, the creation of the
init SELinux namespace would fail.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cbf4417eb1b..b2efe6b1e566 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7817,7 +7817,7 @@ int selinux_state_create(struct selinux_state *parent,
 	struct selinux_state *newstate;
 	int rc;
 
-	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
-- 
2.49.0

