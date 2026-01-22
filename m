Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CB30DD11
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090872; cv=none; b=k7ZiLMd9+l2HlSmHjxSiveI2U0oIJybu30TGqCa8Ct9iwErKJIZWASY7Z7DfD2sMhvbgEieHoaZXs0RAJpAJgzSdONfr6XVjHWN8yztsiCdQXpa5tk3OjHrxjblxS8W2MkXXI3K4DCYAbciZqf+/Vp5ttrMxGtWv0xknOUbJz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090872; c=relaxed/simple;
	bh=G07Wvq8WvGFjY0dmP+/uGwYn1jnRFIolVqzUSFCwWXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIwRhUQml+TxHxlkyfFXeb4OD/dyF+VeQiMcHIFEoq4HnlICAOus30VHlGzF4186VnrQBIrlzepgggDkN2FMzIG3e7o3eztCRuK7K1fhqDa7GFA4/8wvzcp2/EzNsJCfY4u7NRq++shJFKPMYe3bnn+VFwgbgsT/RTO3MNir9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/2rZ962; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r6rDTYd9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/2rZ962";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r6rDTYd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769090869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EtcMyJILD4z1qrnqIkPGVFTkZx7N2Lh4EB8ICDznUWY=;
	b=Q/2rZ962h3B/ZIk113PX6ENUo9cXI+PExGOp6aJ3Zx+mGQ5c3zOi0lwu5qkiLzai5KZmHP
	J1VOzlli0js12/DHXK3gO88jExXqHAgJjddiu7oQZAxDILqWHDr2gfwZrPt+i5AYt3SuoW
	zVnwW6yBq+oBWfyGGieckexgRv5ez7s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-IsD4KziSNPC34HWwqHWJHQ-1; Thu, 22 Jan 2026 09:07:48 -0500
X-MC-Unique: IsD4KziSNPC34HWwqHWJHQ-1
X-Mimecast-MFC-AGG-ID: IsD4KziSNPC34HWwqHWJHQ_1769090867
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325aa61c6bso630712f8f.0
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769090867; x=1769695667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtcMyJILD4z1qrnqIkPGVFTkZx7N2Lh4EB8ICDznUWY=;
        b=r6rDTYd9ICtDAVJ2Po4KepCxhAFrCKSrA5dgSgjYcWJEjdzPPbQLejdnWrz02TxobY
         jWlJua7WeNrJnHrgxGjcaPlL5fBCdEGh+Rw2Fffo6JCNxnyft0iQwGM42+32wT50V9bU
         LsgGnepJNLDh56mpQNfzV9Q36YXO76+xBg4S+r8WHoCBg0apIXF+nyfPW+6/zMDqoorX
         tuX6zGDXykXoa2LGAzMLFY6X0jHutnLKbjkxZLx8EGsfUsIPs50U3rupoK8svXY99HMf
         7KJd9atXNJWyW8ka2qQy5EXAu9u0qQFF6bcwJpHk4tnM9q7PUKZ0sof3aKreXkXguzED
         R7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090867; x=1769695667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtcMyJILD4z1qrnqIkPGVFTkZx7N2Lh4EB8ICDznUWY=;
        b=THDuNjUmT4SYB3EYx4h839pjD7jgtvqhrR2HTyi83JhnAnzXR4DnfDxvSgkAv4ULl6
         NPhv5tosMgVPSF4cdKHhcP0n+Y2eya/anXrdz0Zht0WYRGeYLJObjQHaW7Gn5ULb36mu
         gTu4RMmcyZduXqBpI3EoVw95YCnKDqhdraNRWLtKIgB2C0Kx1WmSYa4MKvv+T+kMILJN
         wj42cMCIh+vZN0rQRTdPTCWFnc3cDzsxzYeHNBybsop1dQ0AclY3aI0kfP7EN2fid8cO
         CgTxpN/41hAV1ls5+df1umJDG2CBIMMidquvpsFGXsoJr2tSs5V83OjCILe2sNicQfzj
         /d8g==
X-Forwarded-Encrypted: i=1; AJvYcCVLFzsVBaYHucLM+uX1FckxdblY0AixyKC8JyQbj1XbCZQ5b8tuk3z8kviDapGqIZu0u5lzKrNT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5xW4fcRzG6qESarnUE6S7mbknxo37azHYRWHi0YrO1eMC6sc
	S9WfmQXs658pR3e3Hl45mLl0hU46Oa0zs+4kklZaxChA3BYwQmrqYtWJsJ+/K+vbJQyktah5KuV
	RG9uHu7cZmWPftYabK7PaPGSMn+QyWqYRW85iKRhM0gWKAuHe4oE1HDyQPgg=
X-Gm-Gg: AZuq6aL18bivdvcxQ6Vj9IwOve38UPh+MY1reI1BZzlK2HFFAtWxxzPY9ATi32QCiZY
	LgtH4k2V15EO8L/6X9Pu+nin9WYhXrx1o/7eMxaqtz4ckCZyhAY2aC7PJLEYartxovXK7QCYLOn
	eroYU7LWfizYijN+zvu+KiHVWbm/rlVlMb//TwA23gfQ/v2OWe/rZKXq2i9PlLHE+b7ZhQtY6L3
	D3SwtIOpUfOTWHKNUOwV2/wOqvNjtHEvOxXOaeWfYqM299ySkvTq9YguX02csFYHFQZCA/qNeae
	Fq5dLpryKiiuETCMNRQjdUJbfXQavbM2Mo20YTFQ4iHVKGLRkf0yA1n3GRZPOY9/SPc=
X-Received: by 2002:a05:6000:25c7:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4356a024907mr35369565f8f.5.1769090867088;
        Thu, 22 Jan 2026 06:07:47 -0800 (PST)
X-Received: by 2002:a05:6000:25c7:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4356a024907mr35369503f8f.5.1769090866620;
        Thu, 22 Jan 2026 06:07:46 -0800 (PST)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a705sm17390416f8f.14.2026.01.22.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:07:46 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
Date: Thu, 22 Jan 2026 15:07:45 +0100
Message-ID: <20260122140745.239428-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user.* sysctls implement the ctl_table_root::permissions hook and
they override the file access mode based on the CAP_SYS_RESOURCE
capability (at most rwx if capable, at most r-- if not). The capability
is being checked unconditionally, so if an LSM denies the capability, an
audit record may be logged even when access is in fact granted.

Given the logic in the set_permissions() function in kernel/ucount.c and
the unfortunate way the permission checking is implemented, it doesn't
seem viable to avoid false positive denials by deferring the capability
check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.c)
- switch from ns_capable() to ns_capable_noaudit(), so that the check
never logs an audit record.

Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 586af49fc03e4..fc4a8f2d30965 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -47,7 +47,7 @@ static int set_permissions(struct ctl_table_header *head,
 	int mode;
 
 	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
-	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
+	if (ns_capable_noaudit(user_ns, CAP_SYS_RESOURCE))
 		mode = (table->mode & S_IRWXU) >> 6;
 	else
 	/* Allow all others at most read-only access */
-- 
2.52.0

