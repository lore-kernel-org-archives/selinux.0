Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF4384250
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293198; cv=none; b=HkIc5jBPrCtSoVzlQqiupHTkUCSdQrmZODIthAGwZl5SVYIeIR0YK2d0PRbJPt9hxXhaUWgVFZFQw2c8cEmdVWHQeS6p9Ics1o/aleX/G6EvyM9Ws7oJfblTRrMfXAvCJEzKbA+ygzN4fzffS0nZmTkM9pwjKp7v5pa+mrctYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293198; c=relaxed/simple;
	bh=Xzp7ewrin0nZoFg9Nq1yKXiH5I1FfaqFyVbc4poY6uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=BPDnkLonGk2gz2NffZFsIYvRRlNjnoIxjVjaedeYz4nLEFhInR9qmJvU5mjUoBb6llYmIkaV6K6mI+McF/KliYRNaVeQDUTBl6K2ZF1aLRiZJOouzs3k79o1GP9je4KI90QZzzD5aOFTIpRzN7dLnrp1LF1I2Zezihn6XSWAJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feKLKmqi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feKLKmqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777293195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCA/Vw8FEZwkiq5C9vWH/ypQDVXERBBVNHpV9opkpxw=;
	b=feKLKmqieqHc3ItO3dcWVCJ2AzymcfP/qGZmdtn1Z/lAOGy4C+Ale/He/0Q5MBzE6DU6mE
	qo8WVHyq+CcAPSI34IdqSTH+sozEYO43H9CgaOJFo98XlJnjxXwsRezUv3EccyGqx031yD
	ewJb0KspQHDEhkZl8zMUe1d6Bevb+PI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-YpJ_D_2DP22tz8tAr1RF4g-1; Mon,
 27 Apr 2026 08:33:14 -0400
X-MC-Unique: YpJ_D_2DP22tz8tAr1RF4g-1
X-Mimecast-MFC-AGG-ID: YpJ_D_2DP22tz8tAr1RF4g_1777293193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 126F61956056;
	Mon, 27 Apr 2026 12:33:13 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E75991800446;
	Mon, 27 Apr 2026 12:33:11 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Dustin Kirkland <dustin.kirkland@chainguard.dev>
Subject: [PATCH] policycoreutils/secon: fix discarded-qualifiers warning with glibc 2.43
Date: Mon, 27 Apr 2026 14:32:06 +0200
Message-ID: <20260427123304.74899-1-lautrbach@redhat.com>
In-Reply-To: <CAC-oOXP04oBE7ciLr7eZBx857uw8sQm6u5v1DpjwYzfzY8vvVA@mail.gmail.com>
References: <CAC-oOXP04oBE7ciLr7eZBx857uw8sQm6u5v1DpjwYzfzY8vvVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Dustin Kirkland <dustin.kirkland@chainguard.dev>

In my_getXcon_raw(), ptr is declared as const char * but is assigned
from fgets(), which returns char *. With glibc 2.43, strchr(const char
*, int) now returns const char *, so the subsequent assignment to
char *tmp triggers:

  secon.c:365:18: error: initialization discards 'const' qualifier
  from pointer target type [-Werror=discarded-qualifiers]

The const on ptr was always incorrect: fgets() returns a mutable
pointer into buf (a char[4096]), and the result of strchr() through
ptr is written to via *tmp = 0. Remove the erroneous const.

This is the same class of bug reported in issue #506
(libselinux/src/selinux_config.c:284). The fix here is analogous:
the variable should not have been const-qualified in the first place.

Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
---

Resent of the original patch downloaded from githu as the original patch in the
email was slightly broken.

 policycoreutils/secon/secon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index d624fa136f3e..9a05cf1959ba 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -348,7 +348,7 @@ static int my_getXcon_raw(pid_t pid, char  **con, const char *val)
 {
 	char buf[4096];
 	FILE *fp = NULL;
-	const char *ptr = NULL;
+	char *ptr = NULL;
 
 	snprintf(buf, sizeof(buf), "%s/%ld/attr/%s", "/proc", (long int)pid,
 		 val);
-- 
2.54.0

