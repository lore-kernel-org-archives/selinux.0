Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5017ADF0
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677640; cv=none; b=D5FC2HeQmeaSuoboAIB+CLLvW72epweYj2Hz+5EokOi6HF0wx+JtrMnM1UzEaIB4OY+LjkNFZ637ZdhPe1E8HQkU5LBudticg1XOq3hh4sZXJsdjTqcjDkXjaaSK2/1uXQ2vwwgR3il0M3lGGCiNqRlVkjXw/yHXybFUJVzZYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677640; c=relaxed/simple;
	bh=N758xsscg1j5iUzxcnYV2NuN/BVwUzZ7pjj4u4n0WCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8ugSWGG0XPAAlVnfv6Lt6gL61Zo7kB+jKKnX7/Gbk1Q01AxiYn0mJ5+Mwx6IW1f3/2hAz0e2gXZYxe0B1wB11ClHrWrPjulED0dR5SvOzZrnizBw18LHRzFhaZF9O+nAwXAosYt4kaPB1nSw8ZvfWdDbIzTnPJvfdipW0alKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdY29pmE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdY29pmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724677637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QT8lf5mm9iWDhlz8PS5X1/LO79S+PPvsCnWmobjlCPU=;
	b=UdY29pmEpuLmLZEZTjr8edIhRrHQbRwp+FljPp9BqoLtZkxjZLbMNHNGl7d3oclWbUnfQf
	57lTeSY+djTWo4pNrTZFoTiZnTOrHgeUB1FTlehoTGQXVwhSNxprN/1HIjYJLpOqGUNshs
	oGpOwr0mTnL1PGiPBxB0oB1FhJ1vl9Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-Mz4FLOgfNzOpE4dgRn6S-w-1; Mon, 26 Aug 2024 09:07:15 -0400
X-MC-Unique: Mz4FLOgfNzOpE4dgRn6S-w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a867bc4f3c4so718583766b.0
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 06:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677634; x=1725282434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT8lf5mm9iWDhlz8PS5X1/LO79S+PPvsCnWmobjlCPU=;
        b=U3w3XXkoa3gg2lMa3N2mQNG4mwvYr6AJ2he+ueL9Ctdxt5fZ6oV4xbZv83v/InFs52
         8zce4NUm/PGwahg3lePpHi69fRpbb0QWV1FHGFwSLs9tYPBlVmr/yhrq8Xoi/yPHTpCG
         M/JRClqyxbbZ9OWSb+RXZ+ssv9b+7XSxp/KopUe/2R3k467ChmQ+SipV9VV7+e4B12S+
         gHX3xIiD8GfUBUG3m4QhO5LX7sJdNqN24cLUPpXyj/9zn+2gbu6CK1CALjxh4wUf00Qe
         yZeU5C+vk/TQRLVcuIn9St8cnNZDapYIxUQ64xDk1tQUuYdiHnyy5NKDtL43VM/iP+nu
         Dm0g==
X-Forwarded-Encrypted: i=1; AJvYcCUGoF9tFwyIfFOa9b+LftPXX/LK8QjKsqVL7bqqxdRtTF1VJbNx8S/7/nT+WVQr7vpe6x8uJWQA@vger.kernel.org
X-Gm-Message-State: AOJu0YwurZnVS4X/B2GBzPII3Dt//B4oYhkEuCgIDyI2QXfPyN9nMXVm
	vVN6Wejc6yyUX3CSKahYkiRkEm4dz4OmTrxrmMVZpVn58X5l8atWz5GOJwkYRfFy0yo2Wu8ueg3
	GKX6krpMoWPY2DpBo+7iy9Kd+54CVtpb3bvE8KPldLvfnzRDOM814B10=
X-Received: by 2002:a17:907:72c9:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86a309adf6mr1221354566b.25.1724677634294;
        Mon, 26 Aug 2024 06:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMUDlt8DybpTH0kwcX/XKT6qaULsyhgHI3OUZQq9tkVmm8pYBDmjG4y5t+KIz9vx7HsCF9Q==
X-Received: by 2002:a17:907:72c9:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86a309adf6mr1221350166b.25.1724677633744;
        Mon, 26 Aug 2024 06:07:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d16sm664298866b.22.2024.08.26.06.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:07:13 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-sctp@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: fix association labeling in the duplicate COOKIE-ECHO case
Date: Mon, 26 Aug 2024 15:07:11 +0200
Message-ID: <20240826130711.141271-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
on new_asoc, but as it turns out, this association is always discarded
and the LSM labels never get into the final association (asoc).

This can be reproduced by having two SCTP endpoints try to initiate an
association with each other at approximately the same time and then peel
off the association into a new socket, which exposes the unitialized
labels and triggers SELinux denials.

Fix it by calling security_sctp_assoc_request() on asoc instead of
new_asoc. Xin Long also suggested limit calling the hook only to cases
A, B, and D, since in cases C and E the COOKIE ECHO chunk is discarded
and the association doesn't enter the ESTABLISHED state, so rectify that
as well.

One related caveat with SELinux and peer labeling: When an SCTP
connection is set up simultaneously in this way, we will end up with an
association that is initialized with security_sctp_assoc_request() on
both sides, so the MLS component of the security context of the
association will get swapped between the peers, instead of just one side
setting it to the other's MLS component. However, at that point
security_sctp_assoc_request() had already been called on both sides in
sctp_sf_do_unexpected_init() (on a temporary association) and thus if
the exchange didn't fail before due to MLS, it won't fail now either
(most likely both endpoints have the same MLS range).

Tested by:
 - reproducer from https://src.fedoraproject.org/tests/selinux/pull-request/530
 - selinux-testsuite (https://github.com/SELinuxProject/selinux-testsuite/)
 - sctp-tests (https://github.com/sctp/sctp-tests) - no tests failed
   that wouldn't fail also without the patch applied

Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/sctp/sm_statefuns.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..7d315a18612b 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2260,12 +2260,6 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 		}
 	}
 
-	/* Update socket peer label if first association. */
-	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
-		sctp_association_free(new_asoc);
-		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-	}
-
 	/* Set temp so that it won't be added into hashtable */
 	new_asoc->temp = 1;
 
@@ -2274,6 +2268,22 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	 */
 	action = sctp_tietags_compare(new_asoc, asoc);
 
+	/* In cases C and E the association doesn't enter the ESTABLISHED
+	 * state, so there is no need to call security_sctp_assoc_request().
+	 */
+	switch (action) {
+	case 'A': /* Association restart. */
+	case 'B': /* Collision case B. */
+	case 'D': /* Collision case D. */
+		/* Update socket peer label if first association. */
+		if (security_sctp_assoc_request((struct sctp_association *)asoc,
+						chunk->head_skb ?: chunk->skb)) {
+			sctp_association_free(new_asoc);
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+		}
+		break;
+	}
+
 	switch (action) {
 	case 'A': /* Association restart. */
 		retval = sctp_sf_do_dupcook_a(net, ep, asoc, chunk, commands,
-- 
2.46.0

