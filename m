Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2791C2304
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942198; cv=none; b=N0/aZx7RRje3v6soG1e7yizfOA72PndHcO4GgHoXn9rDpXtfnpIpg5n/iQlVmcZW87HGb3sTQlaJx8IDlJtns8nk/vP9hpibKzhDqHdUAIflBgf13AvuHxlkMbDJ73tqyDsf4j0nO2JxhfFz9Ve84w7P8cWPHN7wiUk728E8SWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942198; c=relaxed/simple;
	bh=h1M2u0m6G1MIc04LpAa9NOpyaxz0F9ikzwss0o8Bz5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9cTt5OPmvYDNVUvCbx6PpYmN4m0fK9z90tLxkrpcygOITVu6epIMO8vcJTL8UFkXZu2xax65E/u4PRr11C7aL1KBV4JM99Ng60IvaqTll1S4RPWAEqhr3+Khq6IQU4HtICE40i9NXsBy0Y+Zjcn8huk5s+IVIScxQtMgiDAorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Vwb3erst; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Vwb3erst"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hi3vhawF/IYimFHeJeTkmuepcqDCrm/RvH8JkI/8nr0=;
	b=Vwb3erst8k7P2OvBBlzy+TivbA/bQVYRfmrx9sM3oeYXvB3ibih+v8RTRnxbqm6bKBzIsN
	Svnyzlss1pzjeaoOqbjqHd27ag3uuRElUlk8/Txs+aMSmUFec46/58gRzu9zznMftivIjf
	zcOncLKUn22zIbTCNegdvoxhme6wuVT6X/37SfpfzpJHOFV9WvtwxlvybFph9RUT06l8xI
	f34YWxbwaAk5gEBCceWjjAIhATTsucq1s0SXvFunvrwY4zLMF2MTSViATCE8myqE9sTBiZ
	JIhzhvXPDy+IXTG1ps5Glu41NBD3QJiiIaayZib58bYBdPrortZ9Ci3qh2t2MA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 11/17] tests/inet_socket: skip mptcp if not supported
Date: Mon, 18 Nov 2024 16:02:33 +0100
Message-ID: <20241118150256.135432-12-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Also fix a typo in the unknown protocol case.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/inet_socket/test | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 08c7b1d..71bc7dd 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -9,6 +9,9 @@ BEGIN {
     $proto = basename($basedir);
 
     if ( $proto eq "tcp" or $proto eq "mptcp" ) {
+        if ( $proto eq "mptcp" && system("modprobe mptcp 2>/dev/null") ne 0 ) {
+            plan skip_all => "protocol mptcp not supported";
+        }
         $is_stream   = 1;
         $fail_value1 = 5;
         $fail_value2 = 5;
@@ -21,7 +24,7 @@ BEGIN {
         $test_count  = 11;
     }
     else {
-        plan skip => "unknown protocol name \'$proto\'";
+        plan skip_all => "unknown protocol name \'$proto\'";
     }
 
     $test_ipsec = 0;
-- 
2.45.2

