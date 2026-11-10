Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308364;
	b=cHn/cZIjlCYj6eDWZCQ3ysGLBA0IXi1K4Nq7T3gxAvl4bDHdroUNAHpis2CrLujl65kf
	 PYs7wSCpE+xBkM9P+MPbocY9QCOAn3nohicxXnEGdL3JEpIDI1lDVG4RavkCJOGlisn0C
	 67arW0foFB5ms+xg/7cYa3tI1+GgnkfqEVO6foGGL2Z2C14W5B1SJU4le0gVs7i82MGha
	 coStUzlJlehNYj7+roLbP+d305lvnFZSY3CBSwJqyUAqW7w4Plv+JYkZYgWtZbuEwjneN
	 byxMS68GKA4qMIATndGDSivqna834laSFFHyh5RswG30aQ14WCon4ASy9g6+QHFhQvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308364;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AEhoMch2RIFKIifTY+xsNXjeiSN+rVqSYYSe0sRVagk=;
	b=WRDP6ooi54LsB51unEMR/srkBe6sCHJaCySVR2lYhaIHjCg7m3NvcUQu607ey/AocHJj
	 /mFGOnEgxA9OFTqpNwowpAWxLvXhtumaLUskNlwTYXLccl7QvD5PpCm7legPgXiZg9Zgq
	 EATcJ7ZDYvhy9BqOfZhKbcdDTPTJ8bA/+svDZesiC/jXDgea1BxGLZ5G9B8pfsN1W4RMe
	 BQRredBJLHok246tjOy+F0gbTHH/9WcFAXDzIM3yJYQH8uLGwDfqG0cJK1+9ZcmytgNzI
	 LCUB64m6VpRF4DGmw4l1ItFtX4pYWlo4f4w492olbYyx6j3cM2PVcUN/GjtoWAYhC2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=E1gilP2k;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD7660A262D
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD7660A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=E1gilP2k
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308360;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEhoMch2RIFKIifTY+xsNXjeiSN+rVqSYYSe0sRVagk=;
	b=E1gilP2krZ567+ZsZgXbkvg++YlkP4XFv0MIJBDzA6+4xUNr7AeGZTPOcucgnGQyNl8lb/
	nRZrlBBK42e95iL64VPh7WTILorS0UlofSEDuebipNzZHQZKriC7Ae4Kw6pDGfWNHM+sHT
	Z7ak2Cd/A1Yssuhy65NPHdFvz+gN2ErJ/5jdVG6DBbYW5RyqfM1iEpzvUT00W8jTthHRyw
	JZ/KYcNhdt8qWkDytBjVMqQClhqrwwhmEjxEWmTz/C7LYV/wLHSZfLDtypvP5sWCSNHvYp
	aMjZ1Bt4RN+nNFGZl2bgLzfXpgkAEa22iYn+V/NRdTmALBAt9qmC1Y5RoCxwtQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/7] libselinux: only strip a trailing newline in matchmediacon()
Date: Tue, 10 Nov 2026 11:59:03 +0100
Message-ID: <20261110105906.58509-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-1-cgoettsche@seltendoof.de>
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The line trimming tested for any non-NUL last byte instead of '\n',
so an entry on a final line without a newline lost its last
character, truncating the parsed context.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchmediacon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index 38311413..3fcb8ddb 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -27,7 +27,8 @@ int matchmediacon(const char *media, char **con)
 			errno = ENOENT;
 			return -1;
 		}
-		if (current_line[0] && current_line[strlen(current_line) - 1])
+		if (current_line[0] &&
+		    current_line[strlen(current_line) - 1] == '\n')
 			current_line[strlen(current_line) - 1] = '\0';
 		/* Skip leading whitespace before the partial context. */
 		ptr = current_line;
-- 
2.55.0

