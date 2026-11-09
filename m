Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243607;
	b=m2+g30f/kl4jmFsCI249LxGxsNLVF2hFmBEF2TAf5KdoXHuMuOw6KPWXikx+xB8f1OA2
	 gNCwOi8KcyeCEfS5z+7vcdDiXGSAmKkzYOWh9SVFZejgtucBQliZKAec0AYq3ihtDtWLd
	 RmQa6sMT76ocjAMFx2A2JHDal70e4cFaaOrDGl5dEtxgb0EcF0FUJOMOfzBI70wD9tGIz
	 Ey7tJe8a1CHkoQndmZtAxN9OBoHSpu8lnNTTVKvBdZ5MN9mw5FNQJ/3/H/C7XFOjJ6F8+
	 E3HWFyzH5AQk3AFNlsx9Xws/r1302HcpyPN+/neUXS6s9DdG0+DqTmZqBwx9Yy1/JzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4oRbTIpiBFqNerUaisLFQ4oAQLBu56UVoUbIIhDTxE4=;
	b=r22NYRgDfQ11vcifb88fe7wGsyutpmfV7x86mQDOuYiK0Cd/kexOLUBkeJCjuY0RzRs4
	 XoLldn40hjipOXZhb5slPmDtfHfYwoGeQ5x6Ssm0e8dU4ap2ZnAN1CW/u6y567+Con9Lh
	 Wn7kqgvojzrPjjlqWKCK7NRo+dkmmSZQBsSYrfCgSDLH64zsd1x1aSM5B8HEcIpGf1+pV
	 zd2733ZYeS71fWqNH5G0OHQEXObE5s0BMI+QwXM/QDWjHRmwQzEg1tILObJZJEtjeXs6r
	 VpYRhQ27lAvDdMDJsz3p1BSBk3pQyOg7FPAhY9M1IuHCZgV0uoSXj9qdYVOjmObK+AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDdXITGG;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3D606A325
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 17:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB3D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eDdXITGG
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36f8cdd30beso915211eec.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243606; x=1794848406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4oRbTIpiBFqNerUaisLFQ4oAQLBu56UVoUbIIhDTxE4=;
        b=eDdXITGGJWUoMmHmAtjghQH/pX1xA3TTArij0p0y3Y8RX30nUSBZLCg/0TtlOvixDb
         h/3sWwcN8ATxPFFcK/7xBLGLu3N0qRlh2xy4T+Ce0rSF6ZAvPBPfkSVLlJAPWCYJTAOb
         jJeCNKXPqk/nzRnCvl79KkbVxpbS2dX3uYQoxYn1kDScAfVlqouKl77Za1oCo0Vidy1A
         ZfDoW5Q/+x14rdW76ohTTIpfhcczw14MlX3vwtTHS0Gx8DqgOjWZDbEzEZkJOwcuZJ9F
         NddiW2La16NuGfIH/kVwgFYUGjCXGVtHzl8KJiH9XkpldsNJdyEsONuGfKGppzR0s+9w
         wt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243606; x=1794848406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4oRbTIpiBFqNerUaisLFQ4oAQLBu56UVoUbIIhDTxE4=;
        b=tuOWSpygWjh7Nv0d1kApXBRoreYy59f4Ng4kAOrIXACn1tOb/gsMo3x+Es+TIIRuyi
         Ha5fWvZK0mxMwezMN7BGKTLdr2NY2YbiTcK3A844V/OZxLdQwLyOaHbWLO33zDcB4zb1
         HzrN3ixNCkO59siqqziLm5APQ2J0xMA0L6UKramsQBj3Bbi6FJwAxp9LaqsODSTTySZ5
         vrbSWMMC2KNMG4ci6HOwfQ1liJ7BD4d7kmQI0If7Bx3B0rx9Scgk1ldc7apxfhyaeLMD
         ObfHcD9wnn8B5eNy3SUtBjIONjyJXFz9sc7i+esdZfQ1jA6hmZiEsi7dQ+vOx6PUZDC3
         G4ww==
X-Forwarded-Encrypted: i=1; AL+hErFn6sIhDX/Ayg8UIOa/INUUPn7LJYGd0L3V4wnZNFvgaxt2k0wumdU+C8itqDwlbohP1jGFOu4d@vger.kernel.org
X-Gm-Message-State: APuU4Z/IpmhZp4aWvDVm13WXzO1wADS9zKmHSrMWc3VBAsv1eB8mBZPM
	7J01DBKYRqGjn60JdR5rQ0IkgQm4kIjW8Ich6PCGaCLQSjsvu2aTacFZJHQrYCYV
X-Gm-Gg: AYBFou30i1Dteiwiwpua67tC5v2JR0TKav/GRnckvsBDk0oFqaSPjvReERCZnGUZ74m
	XkFtB7rzGwqKsienFsJsj7dHZb30Hpk5rLZN5R2zumhlbYYyVRy0Uyftp8kN8uZOYUIg4Ceudhe
	rwWeN0uYNkKmzH0fPhNQFZzlfPdu136P0p0fhXXPBdbiHsCG65WDnvUlIRGguKPEzwsj0EAd3I/
	nsxGCS1wPybv8cyZxfv4IIVaKt6rGm7Jj7UVhyrnCaSbGyKG9SQWTpnNeenDsynFq0ilSzr3BTl
	5LTLoIZRhSdehB4ebcmulTOVNacLBZxtbAX/PVOpSXM4ezLhmJse18O58yalU+Hcd+YKSoLKi4I
	Ne4wQSlooHKl03+SuUwWeTuycXH266MOerA4m/1uxCKQtEqztHMWS1k+2sx283IoMSE4wb7L+TU
	ASvSXLIDTzAkP6i94Dx9LgVraG5FZw5pzl+Q5RiRqtlfnSvQP9Ew3W+hoiT4itGvjgOm5AkkXjh
	V/MZuUNjzG0oP1MLSnPUJyE9cfAR7AT+Pqkl7DXu094ftrTk5gCvi7zHpFIvuIviTv7AwjUL968
	KqMDtiiQh2W2xgZ5NDHZj2m2SK4t8g==
X-Received: by 2002:a05:7300:2153:b0:371:ede8:3e9b with SMTP id 5a478bee46e88-3725ef0f5bbmr12262115eec.36.1794243605818;
        Mon, 09 Nov 2026 09:00:05 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:9b1b:1e76:b09b:3a78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-373920a0219sm9394010eec.9.2026.11.09.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:00:05 -0800 (PST)
From: mdshahid03@gmail.com
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] selinux: fix potential use-after-free in sel_netif_flush()
Date: Mon,  9 Nov 2026 22:29:39 +0530
Message-ID: <20261109165939.138448-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

sel_netif_flush() use list_for_each_entry() while deleting
entries from the network interface list.

Use list_for_each_entry_safe() to save the next entry before
deleting the current one and avoid accessing freed memory.

The issue is reported by smatch as potential use-after-free.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 security/selinux/netif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index fa6d24a37c39..d5e258fd52aa 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -242,11 +242,11 @@ static void sel_netif_kill(const struct net *ns, int ifindex)
 void sel_netif_flush(void)
 {
 	int idx;
-	struct sel_netif *netif;
+	struct sel_netif *netif, *tmp;
 
 	spin_lock_bh(&sel_netif_lock);
 	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++)
-		list_for_each_entry(netif, &sel_netif_hash[idx], list)
+		list_for_each_entry_safe(netif, tmp, &sel_netif_hash[idx], list)
 			sel_netif_destroy(netif);
 	spin_unlock_bh(&sel_netif_lock);
 }
-- 
2.43.0

