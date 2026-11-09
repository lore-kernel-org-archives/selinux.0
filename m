Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233958;
	b=YqHKqlgT7/D21CYZlUmTUFF8WGZ2aBo8TTYxa0zS6vI3csq1z5pqEimo9HdzYKTEUvlh
	 CF0UdeP8GPr0sbQshcEeLHaRG8eEgmp2PL4KdcSxyIhm1dTTPjvM43qFFBT+hz6+fA1De
	 VbnAqlpnQjuomffGgLx6c8B/BSy8GGdbEjdp6xy7hGoPb/YFE+r6YSmlZJEFW1KNGIwv4
	 13FKw9T62WfhLWGSBLlCiJkxKHHNpImroTmsfubUA8X1LM06H5J3rk+KKWGiQrnG5pVQw
	 /yXht35TqgNfv2FBIckVXL0EUjNWJ7ZvAuXz9hByXgzjFhGECUK2mKs6oaMZQdUmZRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p+QrP6CfSzOqt8WbeS9ZlLoL09psT06m1eoiiUBqyGI=;
	b=sy6q06JzbVSgyX7QvFVUBlMQ2xiZr4pjNt/V0trgNsIJLIyJCLxkl1aogsi+c0nSwcAl
	 dyKoL4bwqL1TWSex1Q7s2s+kF+N39WYgQKnEIuub+LOmW+AkIKgnfHqBNP4PAHySsAWPE
	 5gAwYEHl/OvGUu/O0KBi19F4eN5o2CyE9vq4QGZhAJsEJhcdXxaP6o0sVcEK+H9P3/Akf
	 D3fZUxmoptuEX3EvOAuqGSScAA6RECDygWLcedQcMx/9kmvO36iKI8HwZOsDexKmegGkG
	 2kwECdewFy25HwrmGEoS7Ffl0I6jHR/9nj1gdNEsTc1jQuHw1c1yv+TTGhmAzxqTT/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eHGOWz32;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E1606A322
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 14:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8E1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eHGOWz32
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53653e30353so12259471cf.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794233957; x=1794838757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+QrP6CfSzOqt8WbeS9ZlLoL09psT06m1eoiiUBqyGI=;
        b=eHGOWz32Wd8GhC/J+An24dd3Ex31CK6LMzlRvrJIp5Ex8euVyIvGPOZ3UEzKWOieKN
         iERDvsUw8dmvMGz37EUXE8vj3igvKV9WV5TGEo/z8ZILte1OktiPSBnDZG/P6f2OIIq7
         1SpnPqwYv8agquXAVOdwRuTbgxfAcMcm2ikc9+kkeyTNxHSDxEkJggF5QjNKjZ9eFmKv
         mKwQ+zmgfgIonOQPmgC/a4KIJFs1RfBMAQ7sk443Ey3D8NoJR21ceeHr4M4I8DIpN10t
         iO0HTvzZDCCYedWdbV38cL5hiu1jcciiuai+bXZ2xuPPFKRsxCxQUYskjp8iklI3ZFZ9
         ALRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233957; x=1794838757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+QrP6CfSzOqt8WbeS9ZlLoL09psT06m1eoiiUBqyGI=;
        b=0SMrdZL3oGNIFGFaNZdJZrEiUteaL2kZZQzpgpPuou7CXq5JOFcbbdhweDbDWG9115
         N0dLXP6UfLzpdR+tTe1BOeO9J8UPeDIFiGL0N2CmrZVt8XcEdT/FFJe0K03LKMP1ASrQ
         DQbCHCWYSUr5z+w5nsIWIBr+thiKCWnqrIXU5QanyxlcU5QWKgoz6pmDBPGSI8UcFOjH
         i33stcuAMSi+K4rhxcJ2Ol3QplUbzoRhtbpOXRJwDmxcgaQdKInZgWZi96vj/RadYaS7
         4ZwVTzMq6Rd+aA5+qvebcPv9fc7ia8/08put12bNwcXINpi6haneX1BOhXYyVpooHH95
         V6/Q==
X-Gm-Message-State: APuU4Z/7utllULsAtdVl0FLxbbY80Y228AfDs1Uo9c0WhQdMj2P9b3KN
	EmsutbuiARXASX5n7zeW6i063w175yM/bT2BxMsk3jjsEPf3+fXJy6w9ksc+BMAi
X-Gm-Gg: AYBFou0qMuqZCNymIkC3v3t0Og9MdV+4K7fyyHiMBf4zpBRwJWBxpmpemMeCAwMhecd
	bfAVoum4SlCKGlrjeB1YrJW425CNcdiELvZDM+HQd3ODPtuAaitBqltH6cEA5utZKWCwq7T9s04
	eBit3E+X33w15WHabYkigaWLxYeftokJWaTCRguDGz7VN9t3aBF1RBP9x8/uNmiNnGzWqkCoD72
	/KFIPRjQNphp83cSO+30OtwPF9l/qLSIebxJLVYAlHEnY6hdC4zLjXRB1KUb/oadnYw3t1xx+mp
	OfxS+HJsS1TvY0udRnGrMYzSBMi1pHzPhXDtYCP7kNwMTpUYDbMaE2btnHrj3s4WyTvdx95FxQp
	PCklya2hqP9HB0CPL6Fj45N1v4CWUHBVjgOqmzhzTtfF2iId5CHMBUa8Pqc7GQSqtyTKblm+db3
	HCvZLy0T2fRjXWvg/JMCVvdEzRiRgCsvBCGKGyuXi4jiO/o2NbyvvFOILSvI7fFDpHZAuVawqqp
	4Wocb8oIkpAOSTVoT6tSWOPSfgaMT3aGvPLz9LO9/cvg6FnbS6Te7PYFPDaNM60wjys3ZIiY39m
	/NyGsJq1ZBFRAkO3lKWtyPJ4h+GQ+B7hTiWDXUafRxf4gWjwd4kDvsg8ETYVI0ydfWFSHpDQIq5
	ewGFhPWrn4+09vQNH07sxWhspkBCUlGEL5xJmnbVmk+qsZfWgSIzktS3q5xa/+zStOawhOfhU9c
	FlljsnI9Qoh2E6dvB8RWzm4zWUxg1k5T7JMu9pI+ks/kY4ZQ==
X-Received: by 2002:ac8:5d92:0:b0:536:645f:c901 with SMTP id d75a77b69052e-552a6634d05mr64500281cf.67.1794233956584;
        Mon, 09 Nov 2026 06:19:16 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55263e658eesm41565991cf.10.2026.11.09.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:19:16 -0800 (PST)
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
Subject: [PATCH 2/2] python/semanage: replace removed unittest.makeSuite in test driver
Date: Mon,  9 Nov 2026 09:19:03 -0500
Message-ID: <20261109141903.121983-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109141903.121983-1-stephen.smalley.work@gmail.com>
References: <20261109141903.121983-1-stephen.smalley.work@gmail.com>
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

