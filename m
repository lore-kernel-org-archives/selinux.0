Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF41A00C9
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334640; cv=none; b=YAIcmo78T2GpVxTXBXVkW56fRevq5SP0W+xL6sW7nfPEkhmBzHghg8INQpLP+iLG8DoFRKgDWEPv9akMCM+jSkkwND8UnARMfXLDP2hIkN3ojWpjHOOhBoqKBX4fLAPwzyeTDlRahFfdTWbk+gjX1ZwAtCbbNopzed6JCF4lbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334640; c=relaxed/simple;
	bh=j7pC6Y6yxRnJGflcqyKNTVw7kh7w4M+Ld/jDCTrRJr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMbB4NGJHQdX6puvb9AJil2k6AQhvW/UnW5bolanWJlZv0uVEI06Kq2GVEq7yQ0Lt+UvjmLGAsvtnzDP5MbUIW/oqKuxeaFiuIZBSNvk5WCgaG4OWEt8BUji/feSQoSOd0xqqdSSLWzu0yp0IdDLXXMaHky3tfTsdGJM9NazoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WGV9cIdh; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WGV9cIdh"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334634;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZZBdMvQRwwHxxH4YB3+MiDiZeoJH5fdOoiFTMHIgQA=;
	b=WGV9cIdhY/li2QbRr89RX7mWMUaqLrDh9Jq+HLu5gM35GhqascNhnZBpo/6097dmbO70u9
	HY2iY3DvjwJjYBGsI0sgC3kGkhV7/U60hrGVeqAptZeE+JW2gjgYAXue8pzTJfyNygtfFT
	A9/XnyJ1KX4oMkZGI9UlDMc+zGHTGAPhc92OqQdg+UL3SPvNdrm4IcFCNY2H06E0Yxwwtt
	G2fl5EyM2OGxLgQ2JoVx+rs7pOD9tZ+GuNY/xKI8bkUHeQv1E8r/ZNGv0e3nxuBQyV3G1Q
	yYSm3yh2uimq2zvhVLjyg1O+x8aHlRB8VqVByW2rzACTcNF1FjAEtjDi8t22Dg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 09/47] libsemanage: drop const from function declaration
Date: Mon, 11 Nov 2024 15:16:28 +0100
Message-ID: <20241111141706.38039-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

Using the const qualifier in a declaration for a passed by value
parameter has no effect.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/parse_utils.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/parse_utils.h b/libsemanage/src/parse_utils.h
index 52408373..d52ab271 100644
--- a/libsemanage/src/parse_utils.h
+++ b/libsemanage/src/parse_utils.h
@@ -48,7 +48,7 @@ extern int parse_assert_space(semanage_handle_t * handle, parse_info_t * info);
 /* Throw an error if the specified character
  * does not follow, otherwise eat that character */
 extern int parse_assert_ch(semanage_handle_t * handle,
-			   parse_info_t * info, const char ch);
+			   parse_info_t * info, char ch);
 
 /* Throw an error if the specified string
  * does not follow is not found, otherwise
@@ -58,7 +58,7 @@ extern int parse_assert_str(semanage_handle_t * handle,
 
 /* Eat the optional character, if found,
  * or return STATUS_NODATA */
-extern int parse_optional_ch(parse_info_t * info, const char ch);
+extern int parse_optional_ch(parse_info_t * info, char ch);
 
 /* Eat the optional string, if found,
  * or return STATUS_NODATA */
-- 
2.45.2

