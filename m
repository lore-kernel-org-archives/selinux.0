Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FE4779A4
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577783; cv=none; b=PVQTZ+BiZfYNpY7CtwA1d1Oh6n6Mx5hyHOtQZw1BgkBirHn6Mq4pmUYeQIOHsoxZNC4iEB6HjNQ0Pqj0pclllvacpHNy8prS4y1yU1g8diSKKqDPCuAXbgUZLiaYHZKb3T9Y58iPbRyZAHKvtNZ5LkAWE1iBbXmRr+tKEB88fOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577783; c=relaxed/simple;
	bh=DBkl/A881qlfF3UjJqOHePnfAMyBN6ngZlt7ygq0q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0ld3YqXeQu05LvKivOt2BPVnIDlM4/tqO9ThvtoHtdn50IHBTDEkzK8e+Wk5pD8sLufaDOmm/Cln58EDf/7fxpa4t8Y4mNarBLcf9DNleRdg3+jew9GfTNzd6ZCbRGd20kCiwVgcfkHth9nEz9re7MJBvuNexvp64UP6QkCNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsSyVlDp; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsSyVlDp"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9158643e538so63222885a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577780; x=1781182580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUNr/wib30UjBvbgDiLE2Y+OB+Wwuo41twZQET88vLU=;
        b=rsSyVlDpzRI4zPNsDRuIz/eMuhRwKGENiqwfP0tcCVJJrOY+JBr29ykpSRLgKdxzd/
         sHFyhHJUidklc5HWy/FP/o2pCTmIWupgkx9mj+HDZqKHWoWIvXjRz5T8u2ScMGJyB8Fe
         VrPBOJn25FGGsaUjCEzgBdITUMvU2OXPG7mVcUdaovkxkmCl1oCwnkWwqx3NNrxuJgiV
         0zQkdVMHK5utkyZ89Gbt59gl9rFQMiFY0i8SRxkjkx/zSom6X1nIQqn0JXyspV+wsC6D
         7dlEk2UfO1lVkSvrgeVFZzqmlg4ehk3qXo666BfSOq46uRCOiBM0tcs4nXTCvCbjQ6yq
         xESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577780; x=1781182580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUNr/wib30UjBvbgDiLE2Y+OB+Wwuo41twZQET88vLU=;
        b=nrinfkIHmKuDWXZFjy40rJlMeRVT1W7SNAREI063s36B1lsZ1nPf/yuweDbM4TiFpU
         jiSpv6LhNSpzHVi8lvHSgQnQMCk9pmPe5mrsyJLK5v8UbEnwYcRnY8zzG6jmrxbv06Oi
         0HF0w3d6MHSSwii5IsCP5hMZEi7z4uo+zokk0JDDc8rXGNq8DclFMaJ1mCmOsfiFnkB5
         kaRVxU5kQdgnnMgDBIPQVxuPM6Bw2h+41ElSyfBwcFi/xTAVM3h+l61tq8upC3t5Ulad
         3te3y2Ce/K6hcnBm2GXOIp5aphJoZIMCLZGFW8+c24nbzbxNmFD0Wx8CIRNYnIRf5I5c
         ljAw==
X-Gm-Message-State: AOJu0YztrsdaI68pWu4ZlpKmcaOJm4kxJSDi0/2SVTyxCMZVSLYQUMwL
	QyirCYdN7OefrMthsTna+dYvAHAocbPICGWwdtuwq9SnXaisY11d1csvbVbC0Q==
X-Gm-Gg: Acq92OHcyPeuUT2un+wOaFrVNEGuSRgUTrqDvHh52sXbEsn95daw8H2rnzoonFfS81L
	VGHs5GNssaWP3Hrd5garLJ6YUtmEMVxa+pSmiO6N8hW4i9Nu66V26NQMbsQ0QVf+fixecyeL8ih
	tYSZuGMpWQPdltRjCfd45e5FlEunJ1MwuxjHrvFf7wQ0NvIOz54dERF9PX6rGkdqAKHbTR4jNsM
	dumQ+F4MWhTaZZJn3qQSiXz4a6GTCzRBZDA9hwy+HIUhiqMeeLx7DpC9TGleQnP6rkUmyyHiZpi
	H13bu68DibKz3IUCuZWh3awbQ677cfnuwOHqycq/mU51swMBtqYfiDCHs13HkWfFLgV6CMUfD96
	NCAAcPhxJ+XfXloMO2MIGzhyYrdbwWWpFKiFUFChc453PBmSr2dN4LJ64Ug4sqfXkdNmOUUimr1
	JLc3Z6eWMQ27XQoBJxvzL9FxZTvD0aJcSfa/QIp7izpn4afhl+grX4Ruy59xdMEiQd8K8o+zwSQ
	4IKrsl0cFkEHlVSJOotIgeiZMMC5VDKuk0LXg==
X-Received: by 2002:a05:620a:371b:b0:915:213d:837 with SMTP id af79cd13be357-9158a844511mr1328000085a.57.1780577780297;
        Thu, 04 Jun 2026 05:56:20 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm598297785a.18.2026.06.04.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:56:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/6] mcstrans: mcscolor: handle NULL my_context
Date: Thu,  4 Jun 2026 08:55:54 -0400
Message-ID: <20260604125557.255554-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
References: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getcon() can fail so we should check for that and handle it correctly.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcscolor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index 3eae10f4..fd8a248b 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -90,6 +90,9 @@ static int check_dominance(const char *pattern, const char *raw)
 	access_vector_t context_contains_perm =
 		string_to_av_perm(context_class, "contains");
 
+	if (!my_context)
+		return -1;
+
 	con = context_new(raw);
 	if (!con)
 		return -1;
@@ -257,7 +260,8 @@ int init_colors(void)
 	char *buffer = NULL;
 	int line = 0;
 
-	getcon(&my_context);
+	if (getcon(&my_context) < 0)
+		return 1;
 
 	cfg = fopen(selinux_colors_path(), "r");
 	if (!cfg)
-- 
2.54.0

