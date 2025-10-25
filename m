Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390E52F88
	for <selinux@vger.kernel.org>; Sat, 25 Oct 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761416473; cv=none; b=ZjB6gFCwvjvRov1yHYkd9AKktjor0svD4ifREaCxjz+D5YPtOOBslutWjHsQXfG85gXn0Ku+XcBDwd5iW3C7hAJncDHs8QTyplBaEtzQ1gH1zwG3SQp3oc0NkoS2KxMpNaNTV6U18u/p6ZPSMVn6pG035x3IRoCYKhR0JaWX+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761416473; c=relaxed/simple;
	bh=wJzW2mLPC6MWO4ec9ujHDAwJakMua1pqKxCA0tnYRaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPAQq9CNVbHyk8ZThjss283QD9OHWTyyqKxVZb/wDp/C9YEmQ6Rb+XjBBoz0TOV4NK2iLohBAA5DQ3JmaJV4pWFPcKecOISxhj8XeI9LuHdPQ7CcrcAIEjda1u/dxPwpNv7e3q9VP3sw7AzdTWb44GyqhrAOQCot3sunoAgKsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=JvHcoZ7F; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="JvHcoZ7F"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1761409234;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=50KnzE+Bay6BnHI132SNw6J7TDUQw6JtZ7cXA5g7opo=;
	b=JvHcoZ7F8Q9ySeFlBVckx9o1jnCHWnxflmxJ47T4wj1HL3xliBiFTze4DOo+9Rl7xTv956
	XAXO2vby8GZLHQMI/Qcuqb6zSyNveQSFuYjcAE0TwUYbXyC/TpuRz/gWQQkI/jcix9l2jq
	lSM/1NRqailGz4rDPkyKerd+vl9i7OJVTB/7ITK5Oso5+bROOTGa5ZrV7gzbyaVnOBlopR
	9S87RW1FzAAVTu+wYzII0zlGqIsNXOTMopsrlOO98gVl6sBLL9WL5xguhkjmKDT1kvZVW4
	UHPJOPF5FNxjHB3uSRzYL+1HXhYus/6tuawayCzJ/62CmPo23Hyy2wNSrDjOOw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] secilc: use correct long option name for -X
Date: Sat, 25 Oct 2025 18:20:01 +0200
Message-ID: <20251025162001.300193-1-cgoettsche@seltendoof.de>
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

The long option is called 'expand-size' and not 'attrs-size'.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/secilc.8.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index 5c0680a8..924a75af 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -96,7 +96,7 @@
          </varlistentry>
 
          <varlistentry>
-            <term><option>-X, --attrs-size &lt;size></option></term>
+            <term><option>-X, --expand-size &lt;size></option></term>
             <listitem><para>Expand type attributes with fewer than <emphasis role="bold">&lt;SIZE></emphasis> members.</para></listitem>
          </varlistentry>
 
-- 
2.51.0

