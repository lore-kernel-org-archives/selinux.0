Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CA2652AF
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309264; cv=none; b=e6nBA/ipPDer2S1ZqwwdgeRIgNCzukzXSmkWc7UWqfqVNH5Nhnlr8ZuxpvNj/0bM3jJfWCDRxpZFcIYgeob/66YeM8RX3nMQHnZBOdILr1KyBBMxMqVbLisWQYNkRZ90cPjfnJFKwWBJ1hp5qkzZFl6AuOSX4WGYt4GrRgHsB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309264; c=relaxed/simple;
	bh=neO1lcOZjIoKeRqP8uIyvVa+LtuG4ytvIkBdjnbXSRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvukhHVhtFGDhEYW/sGZjoG1T4B0N1eJAPTJE+cBSo/379w1Rypgf62T8RKO+/oHBoLawhyrCTxiHjKRdoqID17rQ7GelQrE4Lj79s3FieStBGucR5cNYB4XtDGWYLk4xeby2FRmkx4cdZWZ+gW4jxoWHi1/CuryFmL//mdtjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA0TOOGe; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA0TOOGe"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfb91795eso76985561cf.1
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309261; x=1784914061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VF1frgUhFRh6feiB9zw7uO4COTTTuXiTovTq8HEF7uk=;
        b=EA0TOOGeQq1h0D4NOfxEbSunGW1myT50yvRvdhbliPAnCMc9mfHJBWWQ+/5VrkgQY5
         jBrT0M00aEQSWV2ARvGZ214s06gNrQLvSTkOytE6/5I4ry4ifhgA28+yCqHM5kBnABN/
         1/Plwd8J3A6aLTuUBN1f5OkCIS18q0ufvo16GLuyOKWwglgPIOF1TarJ0pqKabBPD2jv
         Qk3eUiaNW3Fxv2d+EkjRgwLZkiQ1nTx+ZsiBqo2lSEb7CUPIm8voDjdyO+BzUz6ZnGEA
         HEXZVxfKXnTtenMLXCI3/nsHBU5rLB4UHU7o4ruPdW5BSnwdldFFcIkTV9UxQBaxkO9R
         Ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309261; x=1784914061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VF1frgUhFRh6feiB9zw7uO4COTTTuXiTovTq8HEF7uk=;
        b=sSucbFk7TZIuMqz1MHnjY1TVVzACzjcfE2CvqVSwbpX5B/N8R7Kgzm1PhrVI6QdRWH
         n4mo2V5WOKzNM7H0F7aScyycaG/t5OwMYHkDc3C4YfvQzrOQeKIzIw1y1/rVujpICqdO
         uoA+DglQdTPmV0WujgbcbW4e3gzlSKuKKRsh/wyrQo1Mj3nn3RHV+H22BUeVPCGIHkCs
         Cqef3Ur4ftVRKE18V4U9X72eJaIQQx6bZJtWMCDJ1Dx5Q1uYEnzAlFSeeNB+QQiLoAcx
         kLhV8VT3XQpnnWToBQd6NB4J7P9gOyxlGJilh9D6/rTMEPl0Qp+EEf8jy7Oy4DBBx5Yh
         LwBQ==
X-Gm-Message-State: AOJu0YyMDOl6+w1U9dGmI6zfiKtQULcFgWxsyzUG69zYENXx3lsGIe/4
	T8Lr0H9UseCjbaia5kW1yBxAxWjUiOGhxZnHrBboqCMkBb685QxjWP2SCff2VA==
X-Gm-Gg: AfdE7clR/EdWC5g+VFS+61EkEFwx6yBXTokplJoIkg7i2AffDRzoThg0mH00Djw4Nnk
	91T35nph7VDYWXXVabmipi7aI0KV17yPOEwqhv5dHFQUelwdRcXaGLZVeorpAkFmINnVt+X7ZQl
	/XEIgFdOzEHMteyD4c/QxYKFkNmR5JV93lOaZgJNQWLmG+hQMK8Y5UDF0wrcOc4wVFhWExJQjMA
	n/w4pdw/4CmCBRgo5N7KGpbRgFbVQEm3ti+Gw46GDOm6VoE957l6S6TIYi/VUFXiyTD8uNnqsOS
	SyXqMPWEhR5GGM3hObYjnqWsDgNFGWgvh5H7KfH4g30rnL4/BR7/wLMLigUW3pFrf0gVYInFGAh
	91B6UX1vv3RhFTidH3jfPcc90weTkgFg2go9ukYRPOky9fVaWLDKtshrfWjcD2T4mL80f2wScYw
	/ymQ21H+FMiP4xB4fYnXTG9mgkdQu373aAFdb+1s3nv+IYMcZnek+P23StEm+JYedV2otSD0dJN
	E5g1Ura+4B4/b+x
X-Received: by 2002:a05:622a:2517:b0:516:dff5:68c4 with SMTP id d75a77b69052e-5213c008207mr35819401cf.7.1784309261299;
        Fri, 17 Jul 2026 10:27:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786effd1sm21987836d6.36.2026.07.17.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:27:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/secon: ensure that range_bg is not left NULL
Date: Fri, 17 Jul 2026 13:27:26 -0400
Message-ID: <20260717172726.19402-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The color string from mcstransd is split into eight tokens; every
strtok()-result is NULL-checked except the last, so a truncated color
string leaves colors.range_bg NULL and disp_color_to_ansi()
dereferences it. Check it and handle the same way as the others.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/secon/secon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 48daf9d5..5cc3d943 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -696,6 +696,8 @@ static void disp_con(const char *scon_raw)
 		if (!color.range_fg)
 			errx(EXIT_FAILURE, "Invalid color string");
 		color.range_bg = strtok(NULL, " ");
+		if (!color.range_bg)
+			errx(EXIT_FAILURE, "Invalid color string");
 
 		color.valid = 1;
 	}
-- 
2.55.0

