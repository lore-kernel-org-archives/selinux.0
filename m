Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331052;
	b=yzjLORDN6+GuEyhTGYyBBlnbYlk/z1Hocojq/W8h7DUjLURpPPUSTqhyptLJpy8dQjiU
	 hHIk/U4uX1/UP8sQDbZ9ClztS2AVPAYSBMxvR20P/TdXN55zczMe9F/6XpagGWPGXz2y+
	 efoPNmomv4pjHr8UmdPBy9UBosEDvXBTpqLfANroNphEgBJZdTgehTJM0nBXBvAPa39cD
	 2td6sB0E3rjj2DWG4MdPDU+6ZKDfJXJwxkwXfv+1P4KoWYKQHwyLfAo8nyNG9rin1oKgL
	 dAqdFuz1qm4M61W5uJbz5onNNJicj5J0gS0+s/oa704xY6+ANO24YNc+HW9XIH8WE4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IGW9WoGu4sg+6iCTDk+GjpLztThMjlpVJTv4EqblZS8=;
	b=hdx9GVcfDtHEKeMmcbB5dsNciXNmYvAkzB1wtQTaboTGp3Hl+5ZkE2OCboLH+NflM/YO
	 NTRuecInx8qPsFcF2b/oJKUL9xtqURWaoZcWWE62s3awtPwvx01YG1sMgD3P61EIgpYtT
	 aVOwEWFdT1Wg+s2x6GUV3Zp4Mv8+rOcV0ZIPgaXYD84g/Tcml1Q+79wtds3CPu4EnfCtR
	 VYIqLXdrSKq4cnpsOoBjFe0Us5ixV+G6drChxCCKefdD/psWGMUXKJGYakouhMpYRm+mJ
	 ym5mFeo1fwg4TlsLp1N6/fPnHqypQQWz5FD0rUgeipy3cWQhh+nw+gt9wBEYDOjBDEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oC1Qxmnu;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE1606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 17:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2BE1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oC1Qxmnu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f22a8515eso183513985a.2
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 09:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794331051; x=1794935851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGW9WoGu4sg+6iCTDk+GjpLztThMjlpVJTv4EqblZS8=;
        b=oC1QxmnuEchbc+YXyqAGZoGlwaej+CO4pOoM5apQrCpXj3D2WTdqW4hzKzsAE7b+IM
         saFYrcLxApI+aY2JlKWQIwReIGz+7YfPg8oWh/iMgA5EZxo1whbgCRSLGvNrMWrm2NDg
         biY3BsFoLXnQZQUzv5ft6Y/uVeBaCAHmjPM2WRY1AKrC+agQkRh6dKpkUV4qkJMTTg3m
         q26ncJqVfGjatDir7iGpX2bVsISNbMA5fxO3Y9zbNe1CKXBt2ib6Pj6F8hbhmClgPlI4
         SRLcNhNXlxpwbgQp08M/LpjJiIlJ5bPvBB1BqiXoowWw7qtWvSM0zXDUgqQl9YdXqA10
         WofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331051; x=1794935851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGW9WoGu4sg+6iCTDk+GjpLztThMjlpVJTv4EqblZS8=;
        b=rryeHq6cnzFLkH9bEdMWiHT7/wLfnKDbF0FhIuT9GBdpXhCp8P9izkcvgfXeOC2RTp
         U5+9t65PmAM13r+QhpFqKMBNPLX80d9fTee0Xkg/ThGgfjaOvpIRiPkl5Nm8pNXvk3Bj
         p61xpC7/GBpWtWemfL2YsCbvnRydtdZ9cZYKL6n3EsEJLkvqn3dwtHvBjJsuNsbq0ucf
         4Tq4q0J0gWQRk3nlwp1LiJex3+GuRlW7O7XL5QK07tMG/aqhGc/zxkVr71xVYLuTiEZe
         +ZrOGrT2VvmXxrPJZThsGgsmU4Arv0WkrVd8qNi9QsVCJtvV9nOES0qeAWpa7qCfx5sp
         1R3A==
X-Gm-Message-State: APuU4Z+ddKDbfrd7PLgj3TxxNHrE/FLezvWOTXjqA2r+sAFQkZQsi34+
	us5WJ6Or3/sPDqdarDc5rhLSTYPl1aavJtobK71wL1VQa2E4JuYRIh4FIYA9NrOO
X-Gm-Gg: AYBFou2mOeFHAhoJ46bu70BvNt1XZ7tFzZhpWjsKqDXLcNCnachmoKefk0jdt4PGYUh
	EMsGac28qrkGsFve3g7CisNWEfmzZyHRzSUqycvCosDRw2GBt9uvKOqg212i2w3DImxQuK4//oI
	Ftf0+20C+AORzelOsMwjXJ+I77t4wXO63GR+/AnyvJ5d0sApKBqu5IoZN/iwQjTROhgwAVrpxQq
	Ilm51NTcgA/vj/DZnsDoBuI28aMvHKPSK13hF8BVx5EcrYX0/zm5+Dr1V6ebgMH+y1OPm6bxAWi
	ZksDWDkhksmxtIXlH8QasjjXRprncwnbeVlvl1qu2P200VzOrEWDiTwbiacfDbzoL1KjQM1sa0u
	2sfhBaA5dXtBMQT/ZLhkw0j4JO2LaNv6Kd+Kz/t/kdRRRqYJ95Rf3cwJ7WQiaEtKtKxt5wBKtZm
	58XRrlwOu2fXLQWBYzfFD2DvNSfbLfi/ALvVmlfM/JcmUVT/WzYxe9RRjN4uZ9J6o5hdIMf6Y/b
	A8UZJmy09Hb69qwzSnWr3H4dX+on2u2UUcp4iHIybGR3Jpxu3laZGX7eQGoECt39dmUMgZ/aQkJ
	NKld9d+FvsyuPniS9XoaEV2+kR3BjqwP+lI1ZSJJ1wqZzW7d8EEB3who/Lzni8/ZGEC7rGE6Z0Z
	aiuithVLkRt0Dvu0NyD5ImzQ5DVzDenVoRuthGBASjP0CXiRfJtGjkEiVONhW7dcBSRMyfhjjn2
	9pN1jd3o3R2crl50h2QD8sFsCMJUgyk2EkwWymYT3w0f+Z6Aq0Y/Q=
X-Received: by 2002:a05:620a:1708:b0:944:dbd:8253 with SMTP id af79cd13be357-9479f337da9mr517710085a.59.1794331050615;
        Tue, 10 Nov 2026 09:17:30 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04adabesm25714456d6.11.2026.11.10.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:17:30 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] tests/bpf: reformat to match CI astyle defaults
Date: Tue, 10 Nov 2026 12:17:15 -0500
Message-ID: <20261110171715.3597-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The testsuite CI is failing on check-syntax due to using a newer
astyle. This appears to match what Fedora 45 shipped so applying
it to resolve CI failures.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/bpf/token_test_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/bpf/token_test_common.c b/tests/bpf/token_test_common.c
index 201fb43..e99991a 100644
--- a/tests/bpf/token_test_common.c
+++ b/tests/bpf/token_test_common.c
@@ -120,7 +120,7 @@ int sendfd(int sockfd, int fd)
 	union {
 		char buf[CMSG_SPACE(sizeof(fds))];
 		struct cmsghdr align;
-	} u;
+		} u;
 
 	msg.msg_iov = &io;
 	msg.msg_iovlen = 1;
@@ -154,7 +154,7 @@ int recvfd(int sockfd, int *fd)
 	union {
 		char buf[CMSG_SPACE(sizeof(fds))];
 		struct cmsghdr align;
-	} u;
+		} u;
 
 	msg.msg_iov = &io;
 	msg.msg_iovlen = 1;
-- 
2.56.0

