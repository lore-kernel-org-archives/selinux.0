Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACB1FE44B
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957869; cv=none; b=gEx/a2dflXz+kBx+mm+oQXTzunoa/GtL9/NEgvVFM2/cRPShMERZcaRCRdrATK/EP+gh4sSI7tvbvLmXfuwbC/f22LsdFcOh+Qo3aMIzxg4ersUaprUc20fOu2FrsbAZtU+IaMyrE/KghsGSE4kx4re3zEXSaw+V7LafMEhoowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957869; c=relaxed/simple;
	bh=CzqM19HI39OADDIN139XONvl9a0xm0JaIlHVuF1Tpjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A77zz3VN6Wc9+qkrAbHqP2dcqWHCR2RRtgy2H8c9N8AZkdTGwoLEjloHoTDguwiFnrv+oslGRmFYiUxINkjETkitbyKZCcKcN9INgJOZ3sYgcrvMbT94DGZiNXHX5GnMhA+TJdYTvPxf2ITRiiC+oi7nSUOMrUo4XA+xIyVRm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=AePkzX3G; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="AePkzX3G"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741957859;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yig+9lWJV06N3VM45MScijRxGZq0oSskrgcn2u7SJ84=;
	b=AePkzX3GxODUEa91+KLJt4shvkf2PvUuIZSXxgohw13WppgV1SAinBqin3cHQlqfo+wK6X
	CwwndDntGI9cy/Ih91xESj+H5ukF71ChQxGXWVkPnb/+w6KU6Vr2674GwmZujGYFUX5a1s
	xFSLG526535CfIO1v8k4iiO9ZfAMhPFCZEmVXZl7ohGQYmJ7R6kGFl3Lg80ZnLQqfFGk2e
	MeP/YF3QR4d/2vfDgqxydw8j/pMhPeew91vfKzZ5idjfvm5URy/TiZsGcQp5cMhuRbturD
	e45Yqmd6aa1B1fdsDllJwGQCZG9ip7D4huTU4dKbwIOI3Zcs3hovjk+UUIyS4Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 4/4] libselinux: limit fcontext regex path length
Date: Fri, 14 Mar 2025 14:10:53 +0100
Message-ID: <20250314131054.24450-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250314131054.24450-1-cgoettsche@seltendoof.de>
References: <20250314131054.24450-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Limit the length of regular expression paths in fcontext source
definitions to reduce the worst case regex compilation time for abnormal
inputs.

Reported-by: oss-fuzz (issue 393203212)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 470e2385..5fc76b7e 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -439,6 +439,12 @@ static inline int compile_regex(struct regex_spec *spec, char *errbuf, size_t er
 	reg_buf = spec->regex_str;
 	/* Anchor the regular expression. */
 	len = strlen(reg_buf);
+	if (len >= 4096) {
+		__pthread_mutex_unlock(&spec->regex_lock);
+		snprintf(errbuf, errbuf_size, "regex of length %zu too long", len);
+		errno = EINVAL;
+		return -1;
+	}
 	cp = anchored_regex = malloc(len + 3);
 	if (!anchored_regex) {
 		__pthread_mutex_unlock(&spec->regex_lock);
-- 
2.47.2

