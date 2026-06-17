Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C9477E3A
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710963; cv=none; b=jh+66yK+4tD8TcjcGTzXZb2lYy+tKEefjEQYyQQQw0cYTCKGGRTaGL1v9S0Q+GPOMCYnhZbh9cxIYPZ8E/Ii+n3BkImK1y3Z8hPyGamc8TP82To7KzNvh8OKZuGH500Q0kbfFWjbuvwH6QAnc1yTrR6ss7/ghwiNAsQfBKSZur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710963; c=relaxed/simple;
	bh=LEAtUIwXx733TEfIjdl8zMHJuW9vvzRgkQ6q1k1HZ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQbCDMaJNmnvCh273no5JC4GO4m//MeXPNo6AXfh3dD/RiIWXahj400bJXf3GcQJwmA1YI0R8jZB7A/WntzWxwxg6xJcibU73jXucAzD0RfA7tzg04pO/YqoYbnqzCzaIrcjpRrj4oTtDGtAKElYsGYJqUSaTHmVE8UkR/QiDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLpvqM/H; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLpvqM/H"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-517dc520840so63025501cf.3
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781710949; x=1782315749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3CMwwCm/HIeqve7XUWEtsC7bzV1MSb47AuDvqSDtUs=;
        b=pLpvqM/HhzjHEt1dO317EMay+8665EO+omN016nS5eQpF3piqUuf5bPvOWX4e7vWMJ
         bHQ6puC0wf/RUXeR+JPUE78r7H25DZvNypgMc7Vt3rvtDVUlc6IQI8wKK3S8EqyMRo4H
         u6uOBS3L5tPy5wOaiuj6DsC56ahLZr6q62HoVHNAujUDhGR65yColW3U804DWjcOnXG3
         KbvZgtZgLffpQdz8Q5TkHx/LpQyxTCfp3fnCSz5jjxEL1VxFXpOKJJvSi8YfSqskgksM
         q2ggl9c2tsVHoRHjvgFHVUGB+eGzyrkStpmpvh/4WDDcNBsasrON1HVOJdIIE7Ws0API
         qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710949; x=1782315749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3CMwwCm/HIeqve7XUWEtsC7bzV1MSb47AuDvqSDtUs=;
        b=MRs17ETTDCnU7tnod+3DIlklyRfFx8tvPCPyQbJuwa8Qv6voT+EH2pdtDwtSxoYxKA
         +KWIWO3TkFcushlNPZkCAJtFNAvw41C+RIvDc31L46spvyoDftS7FI9wNVlnYh3KnbSW
         tTuoWmsDuqnHLpL156G+9vcJq5HZys+VIlYJpQCoFI9P7z9BEMa/tHoSVshcGM3gNpA1
         fTPtizgAT0/ZBByqutYPO/kBe0CBSiZgwJ5FBa4LYFOmlsEXKpm+cU9msoP3XbkoGWBd
         wvmgPHd8emHraD7MfvNFErnQWxyWNHzyMwbUAKNdjxCgOvbJ/E6Qt0bib0Z2YfzELWGc
         GIdw==
X-Gm-Message-State: AOJu0YyCrabgWDcDGoME5XWbnydxcXjIlMnt7TMVc0TWUJe+xNWYggJE
	LaDI/+Gj0kMqscFIOTNfJo8lYTCNdGwbYpBZ+bTctKkNvZ+b84UW+iTOfKUdyg==
X-Gm-Gg: Acq92OH7LfHxSqRWvdAZwIuftDrMa7U5as4+tIzCrw+xoQyli/sOIda9OFMKQ5lQBcB
	TTojU+oRI0fkBn8XVboDjCDZ7ejgcxTAP7CDFQB3ymESczLU1LQ7murkdncR2oTOI3mpPLWRo2F
	5i7TgA789b9ZN6K1ZT9hLYztU4WFzKCiR3Hu+RNjLmQc7mswcDIcuHwRS5Ye4YYHSgraijlw2cS
	CUOBSYrJIQuuOZEw5W8ZjSbGuNNwVKtHfcpqMMYR1Ba0VuRjBzWLuuXrwdIg22zI6Vi8TyYL5hN
	AwtWgZfDs2nbhg04cw/0GN4vY3UKi4bAD1q/qXaGNWHAtlvmlamKeLmn1jEjD3cdBowuIzimmME
	Se+JpxcXRFMXHv31v/J4EpugqW/BSabyPbGL3kyg8A1QHz0CWpsMCTHPDq9lPy63Q6ckxzJw8XH
	nw76Tm/hzJsP484YOqueKdqDHV8EiOeSLQoFPACYlIoJXOTUn0AnhFB5cxExTeOl1cxD9ed4Awd
	tA8jjJw1onttYCc
X-Received: by 2002:a05:622a:a6db:b0:50f:c1d4:d9e1 with SMTP id d75a77b69052e-519a8fa713emr64450631cf.38.1781710948823;
        Wed, 17 Jun 2026 08:42:28 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642740sm171215131cf.7.2026.06.17.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:42:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsemanage: guard end of path in semanage_fc_find_meta
Date: Wed, 17 Jun 2026 11:42:14 -0400
Message-ID: <20260617154214.67285-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

semanage_fc_find_meta() skips the character after a backslash with c++
but does not check whether that lands on the terminating NUL. A
file_contexts regex token ending in a single backslash advances past the
NUL on the next loop iteration and reads one byte past the strndup
buffer. Return when the skip reaches the end of the string, matching the
guard already used in cil_post.c.

Fixes: https://github.com/SELinuxProject/selinux/pull/529
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsemanage/src/semanage_store.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 0134aaa3..f14ebe97 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2530,6 +2530,8 @@ static void semanage_fc_find_meta(semanage_file_context_node_t *fc_node)
 			/* If an escape character is found,
 			 *  skip the next character. */
 			c++;
+			if (fc_node->path[c] == '\0')
+				return;
 			escape_chars++;
 			break;
 		}
-- 
2.54.0

