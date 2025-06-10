Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6A25B2FB;
	Tue, 10 Jun 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576216; cv=none; b=CjyJhE+7fy4qAcuguPRX/eVB5FNWmIBUXLpE5/V/cvukSY66Y1gb8m/cgN31CGfNDTPEBeAW5RA3v4BpqwYaV2zqOaRmRCU/lc2m6Nb7JD+bI55Br1GLBtVy88djnS9xBGR5gA/BkaRRpifaY/xg9K9fSSyS/osn4pi2F5hFm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576216; c=relaxed/simple;
	bh=OTjsQhUf3xBtV0qQmQv6b9VsaYoDj/Tdws370lfW/LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLs9/aO9Y7O8psppz2gsoBH5nKRNDHQd2fnIxbbqhuINZvq40fOmQYjBqW1f3P7J3rKvOxYh5XPTtlzp7kfgws+bhg4GdSVxT/85QVuYogqFP+quI1LxwZkndfb1QCw2u4a1Yhk22cRU/ndZA069SMwgYC1/YZT+j5Mm0qVImW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCUKzoYO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCUKzoYO"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d098f7bd77so8879885a.0;
        Tue, 10 Jun 2025 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576213; x=1750181013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQmvaYpshQgggAfrTGPxLjctbLCmXbNTtiqtUQutsAY=;
        b=CCUKzoYOi+iKkCWUzHBHJAw32GYgkc0ILb+NKEQ2h3dJ44I9PANLYAuAjv4QLWJoC0
         iaQbhvLYjP5wfXmfi2KueC417xLXauGQ0Pfd14Tgq0mbr9X+fuooTnZ2ZG2N11b4wAQa
         T27vP6QYral0LY+suU0rekp3CTO+mPrfH0Dy+LAebFj6MAdZuL1OHSfHwrWv+HDo+NZX
         5XTeDr0hY97DZJ7mwPJtMO4PtjY+E6h/Zgp3PbpPM+tqAm5Xtzt+4yTHICiRdxrl4J/s
         AhnxS3cBEtEkyrlwgzN7w4g0MfCwuVFpfFl0l4NpqzUERBbxv7WUk83VqVCClbbV4ver
         /F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576213; x=1750181013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQmvaYpshQgggAfrTGPxLjctbLCmXbNTtiqtUQutsAY=;
        b=SBVa7sxmwOV4LL9/IdK4DczALTLv4aPD+Zz4voq8Yom/iaFsUe0hziGkx5a6ewB7WM
         IoQoFleOisl26Frgs5p2/B3xUWw+Xcw9Z4e/WWRfI+WHP/UtPGYH4f+g1uwyVsba317g
         GyilnhknrdJwAqS9TM0e4MN5uh3plU3/TPH+MS1FJZMbMCzMKhpZIasN9t/2m9RGj11N
         V2t0K9Goznp/J5lUn/Blqwhn4qEModwNQeCguEqEPpwh22PrWia4pxdaAbBammxYfnWB
         YGKhn6o//gVwkBWJg1k/ZVEAiy6+9/XMvPPXmfQTtKxw/9XYP9UF9AhKlOVi/mmts9gZ
         zrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWii4gZaKIpjEZCGDMv/zsmS+x12ArU4xROuHjzXkf518uYnbXNxICb9NavDL/5qrkfTSLB5M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGOfa/A5jBxG71NYeim0dlThSptdTB2KZiHd4Dh9G/s4MnapIx
	iiO2DaZq6cCybMI34Kz7LhK5+WfBBcustIFrv4564fQKitiX++MF86OjNsXCtA==
X-Gm-Gg: ASbGnctisSXVoy0cOtvRMFnummeC2JeUsr9g3+gC+WKiNBOhVOz+AYbdwfCMLS/9Pvt
	g4oBdmwz8bbCCpb89O7O4ftdtxZNpfmHOvs7eBX+vwdV2BiEx482Wj+eV2n4HpfwY185agFOFHb
	WPwnnuAbjdaBQh7iYXsUOCpYKO45JgQ1JGq9l8SvlxJ2Ey+CDHUe/4Qxnv5w6IwT38OyH4fQhbR
	mhg0/EFJ6U/hG3ToVZtSIIrzb5oECm8q0wG14w+rOypfs7/wgIprQrw0Pii6uQxYuUfcxxFkOyn
	CHKppsb5KjYx7fmypiGWWzawK/nAmLpv4Ya1pHsFbU4FUwZUaUUjM5hCv009Ky97giX/Kq9a6XQ
	k6MBreLuHY9h8gi8CS+SUAHFGVc/q2GWd7cTiSu7rDQBmZyN419NwKFJGw1ZYFoyxbQ==
X-Google-Smtp-Source: AGHT+IEEmCRUYQzLFevic8EbL8OZwyVTiwYmnA5tTSfGty5JSRJkpEG9bKO2cUpfXiq8kTdhy1x9TA==
X-Received: by 2002:a05:620a:c41:b0:7d0:a2c1:975b with SMTP id af79cd13be357-7d3a8881b23mr28184285a.14.1749576213394;
        Tue, 10 Jun 2025 10:23:33 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 41/42] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Tue, 10 Jun 2025 13:22:12 -0400
Message-ID: <20250610172226.1470741-42-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert nlmsg_sock_has_extended_perms() to use the
cred_has_extended_perms() helper for namespace-aware checking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c5ab227e0ffe..6343479f99a0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6273,9 +6273,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(current_selinux_state, current_sid(),
-				      sksec->sid, sksec->sclass, perms,
-				      driver, AVC_EXT_NLMSG, xperm, &ad);
+	return cred_has_extended_perms(current_cred(), sksec->sid,
+				       sksec->sclass, perms, driver,
+				       AVC_EXT_NLMSG, xperm, &ad);
 }
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.49.0

