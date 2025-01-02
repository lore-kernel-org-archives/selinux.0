Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AA13BC0C
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836365; cv=none; b=LjggFaN3NC5tF2pU+YyMmbEeXbGcODGh9qgZSlFh7ReWa93iZs7Ymy2vS4OlTTMSjSCFSE3SPUoqP92bYwmS4sJLnXUP4sYWq8BZmWFAjY4mhnAoj4iRUkohUeYisnK+vS/xeGA6Zwhqv0gGmdQ7CuQPJWd9UBGYw5RVyirf70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836365; c=relaxed/simple;
	bh=JmXtFZxpD/PAWZ6O1X3aNBClCaVuZmb60sV8E2bBIUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/yypCghrrxFor564KFZ2DnjbCRkZ2DDqKD6ICz4r7h6gyzPMOKJOMtZJfs7/48fyjJBh8dw+nCjxtOX8W6pIp/A+mSTAtbis5pdOCyzufqq8LUDI7b1zhhkT7+So6q46pTZuME0twTdceo0mBuOqZUfBJONOb5BVmTrp91Uwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUUSxyON; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUUSxyON"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a1d43821so110002211cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836360; x=1736441160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMG6ObMctKHXcORkMwPGBPDSOmStMVuUAEpzMpjAx6Q=;
        b=BUUSxyONbNvMkdr4q60gjLdpqMKteD2ZPRWHXVnL9VY8CUry8kXtPcMpfqAFNo2qbf
         OCwjmTpTGxhHSOYLqvLQ28kLTIsWWUOxmVnR2/KA5TSi5zIFByZB1vKMrPe3vDA3MZ/L
         TxxERn7s/tW40rF/KLAAUUiu/xCctRVzkvRRWrIHxmM2sC+qVqgnKaNof9F+niR7wt7m
         /UKarx0qzhb9yCaUWbnIRINO+QCyd6Ud+M+EL1MRw/X1UOyfuctMLWG9xrCHe9wrszs/
         QIVfP+JvyzP+nMs7XnTL2WwOlR3IkrMhOnWsGwPuPGBNeIVfNGDCve9oTS3iQ9w+TAEt
         dARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836360; x=1736441160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMG6ObMctKHXcORkMwPGBPDSOmStMVuUAEpzMpjAx6Q=;
        b=oZgXcixc17iPXKZlJotrxDQ/bJ0a8KRnO7MxTIBplY3Fuha1CK8EUsfjR8SNjptqD7
         Ushpv7zlZDgDI0GfSrCJOhidoJQi++2xS/qLIRFEPgs++kpaYfAXP2HTKP4xF5jTMaM3
         Y9rbRkXlzTuMaMt8y/aj1mf9DMlrcYC52jnWS/t5W4cJuuKn1IKxDcXV82AydluNHbQJ
         FlIPu/pkiRlMbSJ2GEB71TVhHXWtEICnDtCWckWEWSsNFxqgkiZi+9DuEL4C6v2cwcdF
         V4VHtknf97HqJQQK3qt/ay3qLhy92yCoE8AHtiw8nSEHAQ/sSFFtiYKJhItbtuiOuO9U
         Ok/Q==
X-Gm-Message-State: AOJu0Yy549BnJ76LK3K5LAIGURjRwvTXpn1rBDZlVT5NLvNUTL03x7jS
	ryCgYnh3+aTbELZ/ep5y0sVX1SyoNNbxo6fVzOs1RPFKPfA4kxVimmiC1Q==
X-Gm-Gg: ASbGnctPoG0gT8KLLN4Cej9QhbXJQZLZFLjxR65Hu6QSSbIaMKfuzDOrcAanditVVcr
	ZfqnkdglZLrKzzho9SLw7TjrT3X2vKDW66ctLPv7TEjVedf6io2La8QOXSEkTW6CJFxqnTBKQD7
	Re+yrptgLqIJyconTSAfnxLJA/zmWkytrZMqVQYJEkD6MOY85sNWtH24LlrcdE9yTjJjuD9YFXJ
	07W9fK1Zb9LTyPfcOhzL5tPPcqfo//lgCNfeTgtEEbwoQOcUAo6NBkIuf2M5OtY+0sODZuO18xA
	glEhf5mQLsz99OIQICyKHjvCkyxoo7R8kyo7m0rfik5Rqoi8IJvMkuqz4tuGTRXYPtkKSA==
X-Google-Smtp-Source: AGHT+IETsG24V03dvnD+pKjPxQMc+fQWRcPtB4usXgocCQmrwYAT1yo5VlCr9fE995/kfmKQUZoRaA==
X-Received: by 2002:a05:622a:1a23:b0:467:61c1:df38 with SMTP id d75a77b69052e-46a4b1135fcmr858014101cf.12.1735836360324;
        Thu, 02 Jan 2025 08:46:00 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:59 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 37/44] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Thu,  2 Jan 2025 11:45:02 -0500
Message-Id: <20250102164509.25606-38-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disallow writes to /sys/fs/selinux/user in non-init SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c91bf329692c..de4d7eda415f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1354,9 +1354,16 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
+	if (state == init_selinux_state) {
+		pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
+				" This will not be supported in the future; please update your"
+				" userspace.\n", current->comm, current->pid);
+	} else {
+		pr_warn_ratelimited("SELinux: %s (%d) tried to write to /sys/fs/selinux/user!"
+				" This is not supported in non-init SELinux namespaces; please update your"
+				" userspace.\n", current->comm, current->pid);
+		return -EPERM;
+	}
 
 	/*
 	 * Only check against the current namespace because
-- 
2.47.1

