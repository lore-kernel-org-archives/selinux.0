Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237920;
	b=nIC4CtOb56/m9mRjQAwlsQwceUti8SZT70ScDGdEi6GfkiD4OZIy3PuT8eWcwP96Eiyq
	 j5O1di0MWVwGSutmVYCHJeuX68XESxgAyU3g5owbiaHuc2R6FBYeQXJxhv/ZmLYIrYQDR
	 Q7RMnKOGMES0X0psftSoDj4Ph9xj3xpCjS8xFNJyT3mcQDcbTxk+iCBPVj3BsykFLCAf2
	 zr3wDi+HfCeyfKHI//1Tco97SsBahAg2QVCvqsxUphXBLL0Oi/410TXpaYGj/8VbE3D3A
	 XeSdeUFPwvd0Jf/IWiEisfyg+NFGVxkFFLoEpksZ9sZSDV0pu3FdeOTbuVKNnIiw85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p+QrP6CfSzOqt8WbeS9ZlLoL09psT06m1eoiiUBqyGI=;
	b=nz1usVueO9Vtu9PCnRRe8TkJwtqSrZYd5rTQceMb3Qm0NwtNJHK5lNnNZeQo5vo491qY
	 KFB29IWK2Q/W19yMgYwMdMhqMGi/N3N1Q1KmVfF7kiL76+7sBDSY7tvNWvhYKSp3F8z6u
	 jb60hBMAepUiYA+lS8LGjfSjkAMDdgSa6pRbLzTgIpd5Bhe5etx3Q6UMcQC4ohtnR39Ed
	 cCt6QBhr6ZzmEQdqNrUo97J/Sh0UtYUqE+2VtJ3vFf/AoJ6Z+1W//emnlZlXe/OFDiSpL
	 USq73cXNrE2amlrWlDCsqWYpGL/K7EnulUnuAfYRPuEtzl8wmnZFxpSGJTnnokzoGkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a5DCvJZI;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F5606A326
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80F5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a5DCvJZI
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso10091396d6.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237919; x=1794842719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+QrP6CfSzOqt8WbeS9ZlLoL09psT06m1eoiiUBqyGI=;
        b=a5DCvJZIXA171OdLdsUszF0FlNEGKhVpHOEec6BWzkR6arxDGgQEBT4WldQWGCYAbr
         kMCMvSV0wG0ekl2HOZG/XF+5bqK2dgZocqG0Di6X7wMfQtxHd+jvyKd7bdZl4x+s05YE
         fOTNCmHjuT679kIq1zIsCgoc+keCAIgP4ZeFmxXRSbulGXb2puxuDcnVrRZq/dIoAUYm
         XLPHEMj19BkmwaYkrSf+QD0jXhnwFkZ657ENLBArb6lLTeFZS5Pm7axKcSGuPQehsQ5v
         skChrBr4Q3+6kQiacq0eMn/ZZjbzPYRfEmpICWb1aDYTLVAXg5AeiTtwl69Ep6jNhpiz
         ixNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237919; x=1794842719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+QrP6CfSzOqt8WbeS9ZlLoL09psT06m1eoiiUBqyGI=;
        b=Z+WnSv2VHTUV1sCLREc4Vf8poN30c8DQv1OP26fnyLxc5b7rzpYixs7LWf/cm8S909
         i3tfPj3/9/ZCZrn8tamHFd28cP2aIG9K4QDuVPtcL5QdrwiJiMG0c5FSl4du+UYeJTTT
         PGJNEHjtUhn3jtuIpqHx9rLGDUQz9FCKg2pOF8Djy4TnR8S7ZNZvWcLECKTK4cMQqFMO
         lJg29D0QPsRUb1SPv7/h1wsJOPtEbgEz5tuN2npkscHzdEsBJ/Ma3m9DGyJL2leEUSl6
         7/xZk54H3w+mwXzfViBQpRXAf4rDLKorlWa6Yrc7rEHbSCQ9WIKhAolEFOr2P318CL1u
         dZmg==
X-Gm-Message-State: APuU4Z/z2jbUdxNq8X61Y9WU1m67BXpMw9S38Y1c1BJq0r2/xDyFwJ3a
	6CBcZiEBcZFxApDlkBR9+nckCJBfvzFJorQG2yGDwr17oDRY2QLRiRtTCkPOThLs
X-Gm-Gg: AYBFou0whJzFNhXxfHM36VBPfuZXAoO0NBGIBCYHwoX7kd+cdlqQGBvJrgN+C47CSe8
	lZqRA5Nq0uw32MHt12FAf2Kf+vx8UM153DudI/Vd46OhAlSDeAa44rAcvt5vC8k78uMka5KTUts
	BHnoMhm9M6eLQ7IBrHIspzWAc6nzdpcy64XmFD+gObrnDgdRBILs6Q4RDvQRxP9q4xgDyFQMvNF
	+rPQe8v3XCBm3YApr5zIpxOM5CTkMdpLAI6HQMrOSbSePfKbNbZd87dkTLfcNZLBUsztVNHiYWO
	YNbtWPx14/AJfrm/6pSrBc+hjLMBFFjWDn9yRIe7hnH/nT4PnB/6n0CSfwXFr0yKR/4M25U6jx3
	bOQL0dbkPIK54uGEOwZDA/XGd/6eoRtfEFoN7x8hTXP5k7lAAcprkUEGus46+3N9uWRbve2Xb82
	SjifSgK1oCtRXCnEWetzgpWHvbcy8ih060N+W7vhAgPENQ7rE15cdyV3C1RQ1yZmRvkL6+w6gki
	ksiUkX7WZ1l7nMLGxHiN3xWJAZLaUIARc4l5ARSfEYaYmsvD+uqz4YssQPOeef4QEEeNspPFiYx
	YRW5ZfyltL9YAV3xNpEmN8aYY3Pqv30cEk7UM9I9oFB2oAUAlYjrkJ0XQGvgTAeDeMeAclLCy8V
	Yp46aYkL7KEP+eMjtPFlLQ2uX7h8/faIMb1fqJ5Vv+hpkrt8qRG2ZbfaEdnoATNEagUmzE5MMpK
	ka1DTXr4BL3X0Ld3JIHhpe7mZUv0DWRK7BIoqwaFFJTKsKZ0CYUnxIeuFJeoGvg1/Laywb
X-Received: by 2002:a05:6214:2f08:b0:91e:9811:7a2e with SMTP id 6a1803df08f44-91ed240dfb7mr61584026d6.13.1794237918520;
        Mon, 09 Nov 2026 07:25:18 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecee766c1sm44208046d6.36.2026.11.09.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:25:18 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] python/semanage: replace removed unittest.makeSuite in test driver
Date: Mon,  9 Nov 2026 10:25:01 -0500
Message-ID: <20261109152502.124123-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
References: <20261109152502.124123-1-stephen.smalley.work@gmail.com>
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

unittest.makeSuite() was deprecated in Python 3.11 and removed in
Python 3.13, so running test-semanage.py on a current Python fails
with:

    AttributeError: module 'unittest' has no attribute 'makeSuite'

before any test runs. CI does not catch this because the suite only
executes on an SELinux-enabled host in enforcing mode.

Use unittest.defaultTestLoader.loadTestsFromTestCase(), available on
all supported Python versions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/semanage/test-semanage.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/test-semanage.py b/python/semanage/test-semanage.py
index d99e3fda..004b52e9 100644
--- a/python/semanage/test-semanage.py
+++ b/python/semanage/test-semanage.py
@@ -219,7 +219,7 @@ class SemanageTests(unittest.TestCase):
 
 def semanage_suite():
     semanage_suite = unittest.TestSuite()
-    semanage_suite.addTest(unittest.makeSuite(SemanageTests))
+    semanage_suite.addTest(unittest.defaultTestLoader.loadTestsFromTestCase(SemanageTests))
 
     return semanage_suite
 
-- 
2.56.0

