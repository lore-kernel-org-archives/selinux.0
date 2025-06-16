Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA911DE3DB
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087863; cv=none; b=SL+9etRSnRqbpG6ybzaesrqYGmfkCZXSYn8mYzQ1lvYS3gMnw5zEmjDi1efEZvyBx4UO8ZHyM0uK3oJ3NdzBOIYMlH6mgYEo4JhP5SKTR+8dz70QQI/3f17uwpKN8N4HxUJKMZEhQcAgztBXF4peXdcGB2PB9iaMndu1fVtFuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087863; c=relaxed/simple;
	bh=1J+GL78luEsmtTib65rlUPQD47iNRC7mG8l867Xwx3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPbz3Q7motBmaxZf8gg+LGCIjFLSQ1DjvSLkJYeWX6wNJcIj9kVeq5HQBwynHGyxkvJUlT7zw+cCzFEQCg1x97RZqlJqbvKcDkMDCILLVujPK7rFbvnDLGktYl5bOghMqkq7RbFIqHDlZ+ghtmcUw60iStKjR/OKlNEdaf7qF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Juf2O961; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Juf2O961"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1750087544;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYVr9zbZVihSu5raJLLMuDB6o4y0BxK1yDlokQ77VQ8=;
	b=Juf2O961F1MiAlquABeYywMF+lLUtJPqdR9fZhCscygFTcSvOiInMcg8o12+IpQpKz4upS
	+sy289wsmyiwkv23r0XFoXJqgdCjLIl9ChmEEI1BQRjGg/5QCm76DRa1anN/l2hREKoDWi
	vt8BiJCQCTL9hNY0e6BkZm88cWxCZi1TguEve0gBsut2tNK/ZS4j1l9LLp0BusEo6nkR22
	Fj2gJof2N0oo7eAlUOoO+y6HmzpNGdNAnVbhnBelyQEAvtd0IeOfM5Oex9K722HNv6gccc
	9M54rqSzkGW0Lxnc2SzFz3G+ojftTkOBdPBt9kWknC8MVdlWyeWaFkuoIjLmsA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 3/5] checkpolicy: add support for wildcard netifcon names
Date: Mon, 16 Jun 2025 17:25:31 +0200
Message-ID: <20250616152534.26053-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250616152534.26053-1-cgoettsche@seltendoof.de>
References: <20250616152534.26053-1-cgoettsche@seltendoof.de>
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

Support network interface names containing wildcards.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: also support names starting with a digit (tokenized as filesystem
    name)
---
 checkpolicy/policy_parse.y                         | 10 +++++++++-
 checkpolicy/policy_scan.l                          |  1 +
 checkpolicy/tests/policy_allonce.conf              |  6 +++++-
 checkpolicy/tests/policy_allonce.expected.conf     |  6 +++++-
 checkpolicy/tests/policy_allonce.expected_opt.conf |  6 +++++-
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index a88a6a7f..0089e541 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -154,6 +154,7 @@ typedef int (* require_func_t)(int pass);
 %token PERMISSIVE
 %token NEVERAUDIT
 %token FILESYSTEM
+%token NETIFNAME
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
 %token LOW_HIGH LOW HIGH GLBLUB
 %token INVALID_CHAR
@@ -750,7 +751,7 @@ opt_netif_contexts      : netif_contexts
 netif_contexts		: netif_context_def
 			| netif_contexts netif_context_def
 			;
-netif_context_def	: NETIFCON identifier security_context_def security_context_def
+netif_context_def	: NETIFCON netifname security_context_def security_context_def
 			{if (define_netif_context()) YYABORT;}
 			;
 opt_node_contexts       : node_contexts 
@@ -903,6 +904,13 @@ path     		: PATH
 filename		: FILENAME
 			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) YYABORT; }
 			;
+netifname		: NETIFNAME
+			{ if (insert_id(yytext,0)) YYABORT; }
+			| IDENTIFIER
+			{ if (insert_id(yytext,0)) YYABORT; }
+			| FILESYSTEM
+			{ if (insert_id(yytext,0)) YYABORT; }
+                        ;
 number			: NUMBER 
 			{ unsigned long x;
 			  errno = 0;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 3ab5c2c7..8f9d73d6 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -300,6 +300,7 @@ GLBLUB				{ return(GLBLUB); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}	{ return(IPV6_CIDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
+({alnum}({alnum}|[\*\?_]){0,15}|[\*\?]({alnum}|[\*\?_]){1,15})	{ return(NETIFNAME); }
 #line[ ]{digit}+[ ]\"[^\n]*\"	{ set_source_line_and_file(yytext+6); }
 #line[ ]{digit}+	        {
 				  errno = 0;
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 6565703c..4b1edb4f 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -75,7 +75,11 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
 genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
-netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon 1o USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1/24 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index 5697bb6e..17eff98c 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -80,7 +80,11 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
 genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
-netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon 1o USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index 478d1db8..6b0f73fe 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -80,7 +80,11 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
 genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
-netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon 1o USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
-- 
2.49.0

