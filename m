Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49553201
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408298; cv=none; b=eojdANKIIMK2Kv7nLF4B8718f56ak2/5tUiam2In0ycHk+8nsStHAtpNgDx6422Qw2FTjZKehsfyLo3VHaRDloLr7lgUm9OJs8slhHLrny9+Ij1xXHDX77X5ctHLpAxu6MFba42HEqSdQhcJg7Zup4PT3MY+tISkHgIQn5qNZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408298; c=relaxed/simple;
	bh=6499/ii48CkgrX12Lso9/KXHRZldY0iwa1WYK6BJNQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otb9PlGVcUSFYs6CGUli1HoS6OUnCawbDbKDTXScqnChRUoNHCRYzt8k1o4bV+EgeTvZo2rVDT+DEZEdPglqqua9Y/YG9nsXdkKp/yxa/3lcmDhtEdZQ5Fbt7HXKsUlcTskS7bpCtpNA4z9Pt6MmrUV+22D/yfbSI0to+9yLV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eUSDgOAQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eUSDgOAQ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408287;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Me4XeS2tn2r9weOFR6wllI1UqSR+ZZRRYcoLWWLAI9o=;
	b=eUSDgOAQwiRT1tId949KniZplYYbxliFCWMXiZYhiqNeZcZnHflLwaSruQ1jNd0LPmeVHA
	9NDW0DsnIlmN/AAHmOM/DE85Ihy+PRaE4J1pC8W5APx/buu0+rsX6HE8bFzBOMnsZ3h6ig
	VtbyrooCs6eeDdaS1JtEyUSqB9M4xOTJ6WrbWTegZO70EHJMCNbIYn8jEIZgQdPsk3yhz6
	ymXzX74o/LlfTuNlHpW92RH3BRHyo/glo/Ea4Tm2LswzJGALGOa4ZmFGnjemHWFnVl3rpz
	ywA99jphBk5C7Szj2D73qLlL9ztM7+lqNkLxW0G/8WVNgjWEGBKuMq+ZhgYuwg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/5] libselinux/man: use void in synopses
Date: Mon, 29 Apr 2024 18:31:19 +0200
Message-ID: <20240429163122.63181-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163122.63181-1-cgoettsche@seltendoof.de>
References: <20240429163122.63181-1-cgoettsche@seltendoof.de>
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

For functions that do not take any argument use consistently void
instead of empty parenthesis.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/is_selinux_enabled.3  | 4 ++--
 libselinux/man/man3/security_policyvers.3 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
index a887b48c..16b7cd3c 100644
--- a/libselinux/man/man3/is_selinux_enabled.3
+++ b/libselinux/man/man3/is_selinux_enabled.3
@@ -8,9 +8,9 @@ is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Secu
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.B int is_selinux_enabled();
+.B int is_selinux_enabled(void);
 .sp
-.B int is_selinux_mls_enabled();
+.B int is_selinux_mls_enabled(void);
 .
 .SH "DESCRIPTION"
 .BR is_selinux_enabled ()
diff --git a/libselinux/man/man3/security_policyvers.3 b/libselinux/man/man3/security_policyvers.3
index 041ff3a7..b2f6185b 100644
--- a/libselinux/man/man3/security_policyvers.3
+++ b/libselinux/man/man3/security_policyvers.3
@@ -4,7 +4,7 @@ security_policyvers \- get the version of the SELinux policy
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.B int security_policyvers();
+.B int security_policyvers(void);
 .
 .SH "DESCRIPTION"
 .BR security_policyvers ()
-- 
2.43.0

