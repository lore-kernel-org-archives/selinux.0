Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48222A1FA
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606062; cv=none; b=YkcPNvg/+yqBBRwCZ+TmyUVE70iALj8liIruCwLT30trDUZ3rcqetHer4yjujKjcZhkZ4d8dWIzmXHUzk/vPba5gnGESTyeR7FpvZJ2PUf7HolVM3Jxn6lpVqClskFPIW0kTVDzc3kejedUkGXz4tYxs59GxfNS9laj+rLlBP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606062; c=relaxed/simple;
	bh=42oySbpUJudndt3nwCGVXXFS4uvTsEXD57GzbRaU8Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOT49XOA9PnJiPKFWRL54D0XMjg1KkXaZHl7V4yzgME4LAUB9OSs9cst1OeYaYmDEAQj/+87dmZWGEaJeAx5R3AuL02dpFStoYsUi5fddrUvQRZd7llAlA5SspRzz3uDdlE+f5VfiVoCvHaJzzRCKg0yUM8nAh0r38xhJjtwkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=EbCIR3EA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="EbCIR3EA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1748605727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pE7kbtLQynSXazpoAgA3N2rUdamps1fppYMPbWob8+8=;
	b=EbCIR3EA48eoIVMQdPh31e161IRUuLo31p3X36olV9XKu79hhQsC8kn1aSW93KKqZ1v4zA
	uCUBH45kZFIb7FbZNfooKHHMae8aJ6OI3N0qXSqVdV0NCj8PTVsLSD5BdqAACClRbudvKy
	6fIaypDyQyEfCssQj0hUn8vAmK0fm+OLZSwDTTVgyhrsOC+j0xtPRNSKvqQbUuB7wl6AqB
	JMesVfVrsGIQudbcEdceyf6dR8nth6Kp0qGlhQpnJLS4lEsM9SbW/TERImPFvSEMNvDLLk
	/ZstqbCmN+omU76UJ8xmbEZqV8GexqRoYCAr8rg38vRp+9h2PdhWyxBkM+CyYg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] checkpolicy: add support for wildcard netifcon names
Date: Fri, 30 May 2025 13:48:35 +0200
Message-ID: <20250530114836.30643-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250530114836.30643-1-cgoettsche@seltendoof.de>
References: <20250530114836.30643-1-cgoettsche@seltendoof.de>
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
 checkpolicy/policy_parse.y                         | 8 +++++++-
 checkpolicy/policy_scan.l                          | 1 +
 checkpolicy/tests/policy_allonce.conf              | 4 ++++
 checkpolicy/tests/policy_allonce.expected.conf     | 4 ++++
 checkpolicy/tests/policy_allonce.expected_opt.conf | 4 ++++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 7e117222..f9181eaf 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
 %token POLICYCAP
 %token PERMISSIVE
 %token FILESYSTEM
+%token NETIFNAME
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
 %token LOW_HIGH LOW HIGH GLBLUB
 %token INVALID_CHAR
@@ -748,7 +749,7 @@ opt_netif_contexts      : netif_contexts
 netif_contexts		: netif_context_def
 			| netif_contexts netif_context_def
 			;
-netif_context_def	: NETIFCON identifier security_context_def security_context_def
+netif_context_def	: NETIFCON netifname security_context_def security_context_def
 			{if (define_netif_context()) YYABORT;}
 			;
 opt_node_contexts       : node_contexts 
@@ -901,6 +902,11 @@ path     		: PATH
 filename		: FILENAME
 			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) YYABORT; }
 			;
+netifname		: NETIFNAME
+			{ if (insert_id(yytext,0)) YYABORT; }
+                        | IDENTIFIER
+			{ if (insert_id(yytext,0)) YYABORT; }
+                        ;
 number			: NUMBER 
 			{ unsigned long x;
 			  errno = 0;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 7bdea427..0076062d 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -298,6 +298,7 @@ GLBLUB				{ return(GLBLUB); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}	{ return(IPV6_CIDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
+({alnum}({alnum}|[\*\?_]){0,15}|[\*\?]({alnum}|[\*\?_]){1,15})	{ return(NETIFNAME); }
 #line[ ]{digit}+[ ]\"[^\n]*\"	{ set_source_line_and_file(yytext+6); }
 #line[ ]{digit}+	        {
 				  errno = 0;
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 95a0f265..469eb9b6 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -74,6 +74,10 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
 genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
+netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index 79d62319..b3a51bef 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -80,6 +80,10 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index fa4e319b..a7914c64 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -80,6 +80,10 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
-- 
2.49.0

