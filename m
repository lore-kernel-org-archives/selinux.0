Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CBC502563
	for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906947; cv=none; b=lSWzOt8htbPaaUJFP0pte5+gX8x0UlShAkItUICl0xDxsoVOUdQpiz/mSVCRe8HNbotxj3Z2TXmRctvBJF2dvvatDv4jynlF61ZLkcasbb2SXTcAj8EnB9wBDHWn2fMp43ACPXFcXP+oQC+hJR8lD+yx3KYLXMzRgCCqjCbI9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906947; c=relaxed/simple;
	bh=LvbFrJ8Kwk9JOGeMwVe4YMHXDjb4kEKJ7S7/4J7a+fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdhetGFr0I8JLNPeUm+ZWKyAP+rzYwrEkgJfOGlEtzbPkm7n1i1vCR1aB8Jv9AxKjp9KSTaaS/GlehrU8EJ2Stwmo7o+Y4CfmYyKpTLeptfkIWHkGUuU0jRUX4hIGk6Q0LpKtbt331LHwjNIuVxkLxbrEX8vqKK1CYn1PKVVJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzA/VmTe; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzA/VmTe"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e4f0d7d77so8536185a.0
        for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906945; x=1792511745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AaJA2Mr7yOI8hGE7ArM/bvD6+1wKOkr7bBsraKB6X7w=;
        b=MzA/VmTejZ56meuz2Ogtc67Y++lqG6chGLC6gkV1Qkw2LoKyN1kG4G3HCKv4VlMHI3
         CUjWd3Uk0weR/y9LDYmdRe403frjGzsZGTq+eyK17GQF0ptCh+0EDr5TktHgy0KBQgU1
         Yasq/E/++0+Nvr2p2AxobyIEH0OEwcwt9A4rD9qAGQI9m+6bwPKOHxPGE3WjfzQNgU8q
         aaIZn/qf1Vay++dnn2yy9hlO6vCnOog+QJWEHOh9pJBgHLkVBkBZLVtbJId0GYZErvn3
         qIzcDTvbV4E0LbeCluvqyX3O5Lfu/9qSx7u43bjt/Fcz6LRCKppgizOzNAntqoFoklKI
         stRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906945; x=1792511745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaJA2Mr7yOI8hGE7ArM/bvD6+1wKOkr7bBsraKB6X7w=;
        b=EwQclTr5nYods/1iPxYJUIZ0rDhW87E83AKW5xKpWnqhXnldnHpLpl4S+HhOb2Mk41
         kEvG17qtR4AF1dzbDjuuJ6MbSoQsircq7tKqcUUcrM5Nn/KCYYoEts00/5T9mkHb7l5C
         zaMvPMbKh4u/Ga+Ulw6cy+zEBenhd9CQ99sA+0HDn8ul3bIAjVKyGP9+pB54fNF7DTod
         m2G9ZHORUU1TPp/OvjNBEyug6grq3IJNntDceqtRm6wjcKV4vWTCAX27YrG4MJEfoyvm
         nVe/Lat97HNUdCfQq5xF43WXxfAETqZoPjHTZYq2JpwMe/UkV4aWy2i6DcOWX++3SVuB
         kGwQ==
X-Gm-Message-State: AFq9FYLbkkrITihHpE9Z/iEe9lCoKwNib2WA2n9gioDnOBywV250FONm
	vRcXrQ2lU0TDyGUU5nsTh/i6qnCDfFZk6AjEBHLftqz6Ook3HImMeL08WBYpKZ+S
X-Gm-Gg: AYBFou2j/dJCQvA+OrHTb4wB9QZGSu7ND3aJMhqx9LyQKZiGyMOUK77gQukyDCFJ9an
	MIVP2xfU2FJpduvwsB8vJZyCN1WoOnVYl9zln3YNYi46F/ncW+LA8THQ/CI58+OOGr9mi/avYq+
	XKsxzgq9cYRlTMwmql+y9wvK70NTq8kCuanAIk/O+9H/6QXF9u2kNyQU+wZbCqhl1fUbUpgUMj3
	l0YZqwmYrERzddDWvukVO6KOjpltgtTTWbMslck3FqglikfqfTnyn6KBUuvGuzlevEgw++JCNJ9
	XXlB1DhQ9cGFrdHJ+f3yTZ3XiX4uHDPdpXn4KjFoqectk55QefJuOtRw+MyCycPfiRQG6q6ZgIp
	JIwIIYX40sH5MIZxlAF7uENYdUUPgXKptuTytZJkQgFxGjCDtLaRevIjTlRhBv4CUaw4pIhRvx7
	/DGVvgerMthL7duC3bHQLrHQHUNAvzn8Yqc+QGzny0Fdx4RrRHELYrcdl361INQoWFpahrrEmhf
	xR0mHCaK68dWaxtFwGuW+jvE7hAKPv86LeQFmnLhIntrIglgDsCV3r4Ia0pGk+tUqBEBzP4sTA=
X-Received: by 2002:a05:620a:1b8b:b0:93e:c173:f691 with SMTP id af79cd13be357-93ec1743306mr1845717085a.37.1791906945120;
        Tue, 13 Oct 2026 08:55:45 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm266606085a.37.2026.10.13.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:55:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: skip initial SIDs with no assigned context in module_to_cil
Date: Tue, 13 Oct 2026 11:55:30 -0400
Message-ID: <20261013155530.219330-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpolicy -C on a policy.conf that declares an initial SID without
assigning it a context (e.g. tests/policy_allonce.conf declares sid
security but never assigns it a context) segfaults in context_to_cil()
indexing p_user_val_to_name[-1].

A policy source file is allowed to leave initial SIDs unassigned;
expand_module() drops them with "No context assigned to SID %s,
omitting from policy", so the kernel policy and the kernel_to_*
decompilers never see this shape. module_to_cil sees it only on the
checkpolicy -C path where the parser-built POLICY_BASE policydb is
converted directly without going through expand or write/read.

Skip the (sidcontext ...) line for an unassigned SID the same way
expand_module does. The (sid ...) declaration and sidorder entry are
kept, matching kernel_to_conf, and secilc accepts a sid without a
sidcontext (it is dropped at expand time there too).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 7516612d..44ae04d7 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2941,7 +2941,7 @@ static int ocontext_isid_to_cil(struct policydb *pdb,
 	}
 	for (isid = isids; isid != NULL; isid = isid->next) {
 		i = isid->sid[0];
-		if (i < strs_num_items(strs)) {
+		if (i < strs_num_items(strs) && isid->context[0].user) {
 			isid_array[i] = isid;
 		}
 	}
-- 
2.55.0

