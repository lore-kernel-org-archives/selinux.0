Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6E361667
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323376; cv=none; b=ZRpNiSqqXgjMghebj++jWTDrUMmEiqjeOJE/bw5laTTEJbUicRBBtGuDrU75eO0ADuLnG2f7DnVId7ADo29Uz77V7bbmc4Qbn8hXUmw2EGSoFyjpAZ+RVfhpoHoGV6NncGw4LbG5XpFBpp0A9YUWrLkyPy/9n8vKYg88neVmd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323376; c=relaxed/simple;
	bh=l8DnlYrZ+YA6FEyl8S8Xv1ACcaWVWY6U4DZ1ABHmjD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2SADk2nM2l8+zWh4OknN2OyMIHGTCmGdfKlAF84ImtSH2b+vUzJI3kW1RzVjLDopQwziQ1I5wH7rSS0Wm82NWvGIjKJd4VLTQYmGSAsKn9495k1K/sMUOGFncNXtLGu8y4Im/teIvvWSrf48G8wSseAtvFhSk7OKJ/iCJl/vlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcyp0zS1; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcyp0zS1"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9638d15f871so1496713241.2
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323375; x=1780928175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNSa+D1y8/EiXrzVcasNPFV3/jiQhuB14iwNuyiijlA=;
        b=Zcyp0zS1JiUNMJmSAJeJA9Ts4Z2KvSOj8gft6pE5TGP1BSmxDoGArnuUI3IkFZN8gd
         /9KahbI7xy64AS9VWxhnvfRluR5idZwM97eoAWCdZBxj4C8H1pKbjMfZ9abVqjMvu3oA
         +WeJuGWSgkPJI3wao9f/aTlvKnI82qq7kuaOM6hhkfvusFrSJ/S69roxrjfm7PeH8VM0
         1Cjgfuk/6jBwfaEoTcTpnSU2T4NAtubZPqOUEuzEKvIaABUQ3zYuGSeLKqhH1R+Um9f3
         0rCpCFs3pBsZIMBPCnj1iqQRZSSDJGkFPSic/b5qBbiGQWPgiXbTxXIQQ9txFqoFkyqV
         4kVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323375; x=1780928175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNSa+D1y8/EiXrzVcasNPFV3/jiQhuB14iwNuyiijlA=;
        b=OABJ0X1lm4by88aqvkdET2c3to+7ivUVSAmVj6Xw3pTuhHFj7NGqp3oOiLDRq8PVxi
         q6Seb6cnqX3nymMlRbI5wX7r76Ac2cLXr4RYzr0IjL2f4pLEciEt+BAPbYYb9QDvxuCX
         JezTU1ybb59U5jgQD1j8BXrDaq0UrATLXlpZCPCJZBMnUemOBeQ4IYpO47DHyjPob/ld
         ypJfBhQzbX2WGJBtUAB5EN91CTtkL1IhXUrxVukvSv22KvcDnXIEAuEjFT7q66k4jslf
         6ozopa3Iz8bUagzprKk4OjUU3/uqmAXDUgk4hrzzUd8C0fiF41emfdKfHPyzNH0CrQb0
         R1hQ==
X-Gm-Message-State: AOJu0Ywmy1jkpbU7KZpz6fgxqq5DVwehGD9jMHuXQir25tc9tvvUQnSB
	KW0julT3sziB6JZm8OXwS44RVtfCWbAIIBlHFEzrHYzRB9K/+z+QoYgEsdYUGg==
X-Gm-Gg: Acq92OHQxQhCjik9BT3zr8Eh5Es4SF7wwnIvkrZJkdY3toejWQTumXsb9XmWTSfIZoJ
	xzLwrNfL1Z+//UfyDCBnr8S1EJnyCUTqfViX/UsvicDb5ur6Qt6Pr0SyxlW26+ItPmSf8MCOJ2g
	CaBmrd9nZsuwz4ohNaHie9d8+ILECFlh9WrL/q3APG4ldnFjXOhjNoNpZMm2zpK9L/WRFZLbskN
	gCm/nMGwn3L9jQbFn5JXXXEm+5kyLmydAUbXBINuLBO1zj8VxdzpXsd2oRqBPMn+GqOrO8lrmbi
	6vdAL5lVvolrSCmedK7YKngB6quj6MQEptEK9e3cbaU2eG55rSjTq3lH72nLUIF2G81mp35cqkP
	RX2N/lQLFYIWsWEjlUs+bpLvdxzjVNZB7Beshsk8XihSJ9a2havxBSV1iSdgXiz/6x/C51vI/u+
	om3pOhncu1ZzF83Y+Zk14JgdciYVX0Sf19kXI5oLs+vjDbEzVMcQSbM9JYSnx/sRw+1o+Q8zDlf
	z5gY18ZXverFQ4DhevlHKZ84MPltkHyRrX4XQ==
X-Received: by 2002:a05:6102:2c87:b0:611:6fef:90d with SMTP id ada2fe7eead31-6c6a38213e7mr3954334137.31.1780323374553;
        Mon, 01 Jun 2026 07:16:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm109607285a.24.2026.06.01.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:16:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/6] libselinux: label_backends_android: free prop
Date: Mon,  1 Jun 2026 10:15:50 -0400
Message-ID: <20260601141552.191733-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
References: <20260601141552.191733-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not leak prop on an error return from read_spec_entries().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_backends_android.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index 16abb8d0..4fa4b22e 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -102,6 +102,7 @@ static int process_line(struct selabel_handle *rec,
 				    "%s:  line %u error due to: %m\n", path,
 				    lineno);
 		}
+		free(prop);
 		return -1;
 	}
 
-- 
2.54.0

