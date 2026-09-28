Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB834E9C0A
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611116; cv=none; b=rJ3JJctIMTzyQEQv1WDvICOtDa4XdcbU07uTFz2JuMabOxNVE6btUBVsF9W5MYMlPl393uqJknAOEVy2Pbltnm703IrW3Q9E1x8h/yTWHp4eMA9mw+OD8cweXdw+UG8tbMxzxh3d4KQ6EiRp4r0gKt54H2CKkYFawaqG2DLNBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611116; c=relaxed/simple;
	bh=6f50NTLvGjq4PAf8tO9opD6STZ0ZQmEMXHuN+5nopq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcq55HysEAcq68sCvyIkXlXG9vv9wBzURi0zZ2rqCTKDqfZa+L5RUdzZCD9kCJSkkJU+maY/sKjceMriUh+Xt5SArqEtwV7bsMidstZx+2R6dbNVW2Tv4Fzg0H59mXG9BShDO5sseP0TmN3lmkZnqcLacPNJtpWksRYDKCmo3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TJlHKbNz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TJlHKbNz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611102;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UpNZwqGGX6V1XILzDCDP6eK9vSPXTk1MKPDf35VqQ8=;
	b=TJlHKbNzIzaSnybXCghMjGPsXXg6tN4UuG4yV0Zp8BiHG6ADPCMW4doCknEPNEUxkPL0rg
	0AZVL2QeFCr+KNXaF69OuQMAlvc+Yi8kniH1KZyLC27ilxTzmuoQcBmGxdSEJVG2d0tFkI
	LEKPfYfwZFqPLg8uc7RgvTqNWGFN+QEa9p2trF2KpE4Niw1CJJnFbF6hplTa/ZanrA3F9S
	c7BY+xvd6dcBeSd0mRjV4H06ZXqfGjZyGL8cDReexEEPSzCJEd7Tvp+RJjoWbHLnAo/H3d
	hLoIVCDnpDUHhp8nSymDBVaOqg1b/4vo6+bmp8T7KkmEG/7rE0lM8lKAfljGUw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 09/21] tools: quote command to prevent word splitting
Date: Mon, 28 Sep 2026 17:57:40 +0200
Message-ID: <20260928155753.2259807-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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

Reported by shellcheck(1).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tools/check-syntax | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 2775eb4..89d74c3 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -111,7 +111,7 @@ function style_fix() {
 	[[ -z "$1" ]] && return
 	[[ -z "$2" || ! -w "$2" ]] && return
 
-	tmp="$(mktemp --tmpdir=$(dirname "$2"))"
+	tmp="$(mktemp --tmpdir="$(dirname "$2")")"
 	case "$1" in
 	c|C)
 		tool_c_style "$2" > "$tmp"
-- 
2.55.0

