Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE861F4732
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443992; cv=none; b=oX9cxRUaSMM2IqwixobcIVpGKUOXPjoPbd3zzYdRqIkJcOTTtCHPckzJNuZ2INsw4X5BqYUrBE6PdfxfcaX49F+vv1wvf/9JdAxuaF5Huoc/x29zZBIR56SWNiJrhNxvGGRwCuacymGKQ7jEXnt1Cicpd5vUOHldrR3TKI1M/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443992; c=relaxed/simple;
	bh=I9pPNA/c23iGMTwft89PSHf82wrSg8KVrszueYK+GUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKGq52BnnNcclBe2IixkmmlvhNDICmM19ymACJVMyyLb4fed7ZOoiFOLflunmeGTWaLM8AGb2DRWB3hv/4W/4pMnyBiAq03qqYm6bcocd+WEthsrcGJn9ar/KEfr2iZdJurgfNaQeu1LI26EzCOtFdG3IKgq71v9FHnepEpl0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eu7y0xeV; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eu7y0xeV"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734443986;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KRGpoGunek2AVF4mDr9tgLrFLuBIKC05Mb+rubSSk/o=;
	b=eu7y0xeVxelktCzZHRqMcdj1MsbYebjkuxkLnn59ZfFvnRhek0qbpJfnufDQSo8W0kTFTd
	fT3TcDXbD73eSCRwtJUbxWe86KZBwU0gHHJVmaN8c77Oezr78rR8iXjE5hyw/hqr0wY0n2
	QukgWu69K1goktCOsct8YJ4eBGMIh7ClRvn29SaeVzOyC5NFXIuuKvx8hU+ChGy5MeWkap
	rkhHbxOq8LbYE07KZ7n9e5SyhE6OYy3scf0rjb5h5yq4N0w/nkfM3Xme6iGMysOHbT+VA0
	j4X/+Wc0uF6idbDF3CytJPkJjbzF5ThJZVSV4cocoIyvFiQceuUY/E+Hrod/1g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 2/3] checkpolicy: add support for wildcard netifcon names
Date: Tue, 17 Dec 2024 14:59:39 +0100
Message-ID: <20241217135941.536152-1-cgoettsche@seltendoof.de>
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

Support network interface names containing wildcards.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_parse.y                         | 8 +++++++-
 checkpolicy/policy_scan.l                          | 1 +
 checkpolicy/tests/policy_allonce.conf              | 1 +
 checkpolicy/tests/policy_allonce.expected.conf     | 1 +
 checkpolicy/tests/policy_allonce.expected_opt.conf | 1 +
 5 files changed, 11 insertions(+), 1 deletion(-)

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
index 5fb9ff37..a7b0d559 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -297,6 +297,7 @@ GLBLUB				{ return(GLBLUB); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}	{ return(IPV6_CIDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
+({alnum}({alnum}|[\*\?_]){0,15}|[\*\?]({alnum}|[\*\?_]){1,15})	{ return(NETIFNAME); }
 #line[ ]1[ ]\"[^\n]*\"		{ set_source_file(yytext+9); }
 #line[ ]{digit}+	        {
 				  errno = 0;
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 95a0f265..37482243 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -74,6 +74,7 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
 genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
+netifcon la* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index 79d62319..7bbfffd6 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -80,6 +80,7 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon la* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index fa4e319b..3d0afc68 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -80,6 +80,7 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
 portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+netifcon la* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
 nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
-- 
2.45.2

