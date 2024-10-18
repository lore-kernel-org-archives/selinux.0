Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150D2022D3
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264899; cv=none; b=bCjLqJ5dkdsFBEhic7vgl3MCpE9Pv/78oNbScVCbMGtctoCWdTKEcTj8Yjn5daOgF9h2cbv69gaylE7qAAICSgqbZIT+jlF2HPk5Okt0mFH/D1u+zGGJTr7amvwMG7Gj1fPbDMml9A5kGW/GKxZn8LQoQlkZtkoPBGaqvcLJ4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264899; c=relaxed/simple;
	bh=onZofa3gAEmufDYGOZ+AZ6iIbE9+1BjJ9znCPwZ1hNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GL8SUy6EeAw/QwesHACiwnHRnysuu7TA+vSK7670DjsraFWGEzhgAxHjmlxCDHU6ny/+1NV+Qk3rnxtZNCkpqFcO3Z1LqU/FrP8aKrw0WZkM/6s6+y64p9QUJzvXXbG2KOjAs4tb1kNyu0Zk9OdbH5kcYyxGLAvaZJCqemQ8N5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uchsIgAb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uchsIgAb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729264343;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k7WsEn8ShF3Z5iY3y6FFJCE3W4G/Xx0ii4SyE2DbKYA=;
	b=uchsIgAbQOWKtiJDZLv7jWhI4BtrU5GDfMfuoAD6tCM73pKk6vTZeMNlUeSM5OjTBFmp4o
	+diuzZYHjne2LZyPXZxyzaKmw78WPRo/x5LVpr0I9dnQyHY9Z2p6K5sMIyxjMY9gSiC3xY
	BJoU3CKHhGBpYF0pPzeWl/aj2qEd2nFmoFYDsimPiF0k4RVM7Ji4k3UpvPo7SoJvm45nWY
	/VattJ5GO3Q8I1V/tWtfT8CyOu8eRR46pgqrx6BoTHEszJdB4hbvlq2w8XT4thpaTo/5in
	/TSL6SzfHDfIePZfWwwrfSLK1JwLFBGWYZ+YfDWyG2ROkUKRzKaIjxa2n0MoFA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] checkpolicy/fuzz: fix setjmp condition
Date: Fri, 18 Oct 2024 17:12:13 +0200
Message-ID: <20241018151213.444982-1-cgoettsche@seltendoof.de>
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

setjmp(3) returns 0 on the first fake invocation, adjust the condition
accordingly.

Reported by the OSS Fuzz Introspector[1].

[1]: https://storage.googleapis.com/oss-fuzz-introspector/selinux/inspector-report/20241016/fuzz_report.html

Fixes: f07fc2a75 ("checkpolicy/fuzz: override YY_FATAL_ERROR")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
index ddb43260..331201c0 100644
--- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
+++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
@@ -101,7 +101,7 @@ static int read_source_policy(policydb_t *p, const uint8_t *data, size_t size)
 
 	init_parser(1);
 
-	if (!setjmp(fuzzing_pre_parse_stack_state)) {
+	if (setjmp(fuzzing_pre_parse_stack_state) != 0) {
 		queue_destroy(id_queue);
 		fclose(yyin);
 		yylex_destroy();
-- 
2.45.2

