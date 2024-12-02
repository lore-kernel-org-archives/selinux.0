Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48D1F9407
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137471; cv=none; b=iWskqEjVOumPw4g8W9LjhrOlWEio5nYWYHHB5wEFLYoUmICkmfOOD5H72ktADIv8DmnZoSTuZKE38QUIf7JaewiTSDV3kkElIY1V6t9ZJhXIgwC6VK90bXGAwYXnX1MDJUGLI+ilJ85yXEWkTs7B6BeMnpjvHmLKpHuNGoeDkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137471; c=relaxed/simple;
	bh=fQraB5+AZhzT81zBVlss16taGijUXRRvq6dXuOL97qE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DM/taWRyFugs9cQX+7DnHQIIQZ7wr5ycvu9J1Ojlj2WbbeJbdqI/8bvbjq3Z9Up1LL8hKWhdhwEBjCqE9kcUeBqXGshT+0BH+lP1/sck08dJXA0XqWANw2iy3cfs1vTTKXLEKQbOlvSEe4s6dsI0QSOm+ukmfy9EKJxr9eYFVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gJrrzATa; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gJrrzATa"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1733137457;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=G1fYWJ62y8v2tBHKZUG6CJT+wTBcerDEkFSxoCwmnxc=;
	b=gJrrzATaC+/Lm2w7kbbAYM1gdB/cbXoISCRA3n3U/hhOntNtSRFdZAmdKe2vdxZCyHinUo
	PhGzWjsDBBSQdLJoIeY8bxKq5gWKkDnmvJ4opuiVU8rxZhr5/qbSvxh/eN36SV1mBHsE+8
	D2dsL2nPZ1ACGPyf0rQ1FE4HLJAjilo67L8+7vRvL9efwn41jBjHiQ7bDp136gygYAeWL3
	vl6ZHnkEFQlZVRbdObOYbsLBZqtH8hl2jYvzIBtL+5QJpYq2ei6263AgcXB7+eXje8TJOA
	VnqefalY14CoPCNzVUV78hQ7bWQd29ZJUuzHhBtBWvv4SGgFdY62RKkOeXVshA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] checkpolicy: drop host bits in IPv6 CIDR address
Date: Mon,  2 Dec 2024 12:04:13 +0100
Message-ID: <20241202110413.27032-1-cgoettsche@seltendoof.de>
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

Drop the host bits in the IPV6 address defined via a CIDR notation in
define_ipv6_cidr_node_context(), similar to
define_ipv4_cidr_node_context().  Otherwise the kernel will never match
this entry since the host bits from the actual address will be zeroed
before comparison, see
security/selinux/ss/services.c:match_ipv6_addrmask().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Note the traditional address+mask syntax does not drop the host bits as
well, so they are also dead entries, but I refrained from changing
this legacy behavior (the CIDR support is new) and checkpolicy nowadays
also warns about host bits set (and fails with the option `-E`).
---
 checkpolicy/policy_define.c                        | 9 +++++++++
 checkpolicy/tests/policy_allonce.conf              | 5 ++++-
 checkpolicy/tests/policy_allonce.expected.conf     | 3 +++
 checkpolicy/tests/policy_allonce.expected_opt.conf | 3 +++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4b0eca6b..2f811b67 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5709,6 +5709,14 @@ static void ipv6_cidr_bits_to_mask(unsigned long cidr_bits, struct in6_addr *mas
 	}
 }
 
+static void ipv6_apply_mask(struct in6_addr *restrict addr, const struct in6_addr *restrict mask)
+{
+	unsigned i;
+
+	for (i = 0; i < 4; i++)
+		addr->s6_addr32[i] &= mask->s6_addr32[i];
+}
+
 static int insert_ipv6_node(ocontext_t *newc)
 {
 	ocontext_t *c, *l;
@@ -5884,6 +5892,7 @@ int define_ipv6_cidr_node_context(void)
 		return -1;
 	}
 
+	ipv6_apply_mask(&addr, &mask);
 	memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
 	memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
 
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
index 51a8c40a..95a0f265 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -76,9 +76,12 @@ portcon tcp 80 USER1:ROLE1:TYPE1
 portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
-nodecon 127.0.0.0/24 USER1:ROLE1:TYPE1
+nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
+nodecon 127.0.0.1/24 USER1:ROLE1:TYPE1
+nodecon 192.168.41.0/16 USER1:ROLE1:TYPE1
 nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
 nodecon ff80::/16 USER1:ROLE1:TYPE1
+nodecon ff00::1/8 USER1:ROLE1:TYPE1
 # hex numbers will be turned in decimal ones
 ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
index 355d9991..79d62319 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -82,8 +82,11 @@ portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
+nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
+nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
 nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
 nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
+nodecon ff00:: ff00:: USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
 ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
index 74eec4ba..fa4e319b 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -82,8 +82,11 @@ portcon udp 100-200 USER1:ROLE1:TYPE1
 netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
 nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
 nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
+nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
+nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
 nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
 nodecon ff80:: ffff:: USER1:ROLE1:TYPE1
+nodecon ff00:: ff00:: USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
 ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
 ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
-- 
2.45.2

