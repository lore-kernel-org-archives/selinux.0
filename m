Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB0358367
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668144; cv=none; b=hHQx6mfgwraedtwSr2mh1TiHyAr16HL44eRqXX8y/83Z9PdD0UFZ2QdR+PTqvNrfdm+V7e2JTTEVQ+VUpJ5FeURA0EkyCOqxqERJjN7TfOwo/CcEGsT1jIvcsaYzZGk17gU3nDxqOx/JX6dA8ZBGuCH8Sl3Odnq9+sX30eKlyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668144; c=relaxed/simple;
	bh=ffqvDegEvDyo16g1/WoIFULrUF525UgFa3jcNg1uU5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVEWDOiXLUeX5rThT27TanG8jf+3N9NbD5+1CuwgYcr2lypl3e95sgu0d9HA+lgXxhM4onG8d5+lo08rmHWo2Wpkj2WrjiYx1a2A2EQFxgj2Oie6+W+ZwOrfG/6tk30QG35BorOFcbF+A1RsuF2JVObLw6VhAb2FY3cUmP0GWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rDrMMTDC; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rDrMMTDC"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780668136;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zFX8devmIEn/S2AJw7mdpYVdE4rZd5xy6WI00DoEVcY=;
	b=rDrMMTDCzjJDSebuyb17oUZdgGBXR7i4Kp9ghV/bygw4/DJO/b79JJoz/VMddb/qrJWY2z
	78kzDszMSY3l5dJRPXDFdhC3AnGQrQxUGCgwaIwjGQDEuw3TJa10w0RNGysM7a8OzbMDvR
	cp9tfxLypyX1y9DtonMefbOpLrlVqmJ4wYid+qM0GGAPGJx5/6XE4qQrnNmRgqqO600PgD
	Eqa/OVuwDsAWDQSqnkaKatqRWMhrS5q/AqxjVb3EUms3zanH7P6xkcbAn1OjXwcAfX0CvM
	I4LhAYTLGgwycK7DHy+abs+3LiX0eiwgaeKcodZwUDbrcsUFZN27xMaBE4HWAg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/4] libselinux: reject invalid file_kind in compiled fcontext loader
Date: Fri,  5 Jun 2026 16:02:00 +0200
Message-ID: <20260605140203.76848-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

load_mmap_literal_spec() and load_mmap_regex_spec() read the file_kind
field as a raw byte from the compiled fcontext file without validating
it.  The text parser only ever produces values in the range
LABEL_FILE_KIND_ALL..LABEL_FILE_KIND_REG via string_to_file_kind(), but
the binary loader accepted any value 0-255.

There is no memory-safety impact (file_kind is only compared and passed
to file_kind_to_string(), which has a safe default), but an
out-of-range value lets a .bin file carry specifications that behave
inconsistently with the equivalent text format.  Reject file_kind
values greater than LABEL_FILE_KIND_REG for parity with the text path.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 824fa080..ac0a3ab0 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -618,6 +618,8 @@ static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool validating,
 	rc = next_entry(&data_u8, mmap_area, sizeof(uint8_t));
 	if (rc < 0)
 		return -1;
+	if (data_u8 > LABEL_FILE_KIND_REG)
+		return -1;
 	lspec->file_kind = data_u8;
 
 	return 0;
@@ -706,6 +708,8 @@ static int load_mmap_regex_spec(struct mmap_area *mmap_area, bool validating,
 	rc = next_entry(&data_u8, mmap_area, sizeof(uint8_t));
 	if (rc < 0)
 		return -1;
+	if (data_u8 > LABEL_FILE_KIND_REG)
+		return -1;
 	rspec->file_kind = data_u8;
 
 	/*
-- 
2.53.0

