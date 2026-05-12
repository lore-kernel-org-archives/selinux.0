Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4325B09E
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610867; cv=none; b=Szxjn41mUCXJ17TfeqRdRApsmZUW6xgZyiVNDlkra9nrrY9mRfnUGdMaI2YF6bMrONPFdEyy6Y0MHdrvvABOVJlgLpEINCSHlJ5AF+Kp+t6JUD+mxivYuC7AIHxYkrDdHs0WZeRSF3k/Zgrt2dWUSWKtLPeQZ1zCMzmTJcsEEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610867; c=relaxed/simple;
	bh=t6I3OpCMuVdLo0NB+BFiuQSnB5XlNt3KNbOpa+MndQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq9epRPDu0GMoTfpKxx4XBr8Zz9Q5VvBgJOF46iQNnQXKc40Vuo2XdEwJALncDAZVq4adGRiQEX77HL57cH5+50y+qwUjrpCrraDCop/4uJZWiYr36UuIWQA60GuWzfUR0StX86RdVGQgfJTcyIt73B9e32wQVw9U7GcldCmltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9SfKWYm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9SfKWYm"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90d2e6b4fb4so105991085a.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610865; x=1779215665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wh0L8zTMNZFyIarLDfdRPKKWv7ii0AKoSygY8xUDcQ=;
        b=G9SfKWYmOw5nMOuOdbO0GwTGbtq9Q8Bu0iy2L+6vBrqZeu4jmzrMS+VmpSYRpMJ8IO
         8z+suQYX7TA5vlgn/+4uC3p+kGcHjlWlaMOXYWRC78FuncJkE/ot/ui369pu+SEReqDI
         S/ifTvDsJUygyqr1ep5bYtNz96jCYHYVO6fBArZ2F1llI+idyqketajxKURfTdDy6kpA
         h+VgGIOYKvHlJpYxe6qh4ZJuzeBw/1VgRuK/acKv2/OKofpYNU8zSsbd1Kv7w4ImSfa/
         B7U4eSCzrJ0hvEpskKIugyWj1rzLHvPcojK7AR4lmecssivMXXOXcN4cuKVCuMzchVuK
         YZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610865; x=1779215665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wh0L8zTMNZFyIarLDfdRPKKWv7ii0AKoSygY8xUDcQ=;
        b=G+VLeR1HeTAXRaNo5VOammIADRcTf+k+Cle4XLo1vd0icJ2afWWAWPQc4InjXroIR3
         8xEdg1uIQ1WOqwhF9vsPrm4fBy+gxXs6dUHFjvakzTmp1B5UdXUk3/j8rh8gdzDQp9AG
         nTHOVfjMxTbOcHL5fXFgnoXskRSt5o1goC5E5Fsenx+VsLrLsekGAgAgZOB1fDBIfrfG
         HuXs5CpVTNaQBk5u1OIaQsVt/PlX60LiTcQBqAxwugdrYZ+cquIlKQEDtiPVEkbPG8nx
         WXFXZw/tR18wo0EHEhAS5Wffytg9isl4IdGpHUi/wMIK18j7XhVvMqo+BD3HHN7I7ces
         h65g==
X-Gm-Message-State: AOJu0YxRjvb8kJ+px4J0jmzzNU8UZB0YaVQaLQMLIPqxQQadKlFlCkO2
	JQE7GINkZWkM9+wst8uK5fTC10/5z9n02h3STLHgaIr1tgw0RpK9bGJXVQ/wSQ==
X-Gm-Gg: Acq92OFk4sME+3E0UFk6LCQczOZbcMqDhAmCO0iLiKKTnP81CM5gx0qxHBhTRiKhcvs
	0H8Uym2JeGs0JdkXZbUepFPJwXbjlyDCozDDLKhZKUqHcIIuJWDeV8TuZY8+xDhu4zhnVE/ob0W
	nng4f6vp4m7CN8x1RoSwKZKNbybkbBtzmweTtHbjMqRjBp4BsDSGl/iEJcqX1TMv50++I+gD3/x
	Adk9FcD1YGj+QREe87MSH4jy+TG6dYJOnCxGeyoaxjh8nwY033+hFcatVbFWFhFPrxzrL/H5NlJ
	Snu/bXzCr3NNDTHFAnJZKj1FcMX7BNy0GJ3eOQJ4f+BbQgaV1FFVK2xNWaQCUNifarXKiPmpp9X
	1NPkrni/4b3QqlgOBEGne00HZlTES47PQHEvPIar29sgXmUuyls4rWCIcSVttBIPD7ZytFKLm4s
	M8VvjAAhl2iIHnHiFXBGf8sfJ0QqBInMXBkEimuqbEt4jIzcdrV2QYM9eW9v6lqbqGyM/Yesuyo
	zdy4NOFtjKWyGIy9hwrw4QX0D+0XYGsBBxBKN/y8A8vkcEjp2QA2kk6WIlpiBptFA==
X-Received: by 2002:a05:622a:5910:b0:50e:601a:217f with SMTP id d75a77b69052e-514a0a9a344mr227738651cf.25.1778610864799;
        Tue, 12 May 2026 11:34:24 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e85bf27sm129189051cf.30.2026.05.12.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:34:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: pass O_NOFOLLOW to openat()
Date: Tue, 12 May 2026 14:34:02 -0400
Message-ID: <20260512183402.751341-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not want to follow symlinks here.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 2512a18c..4e441b3c 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -428,7 +428,7 @@ static bool rm_rf(int targetfd, const char *path) {
 	}
 
 	if (S_ISDIR(statbuf.st_mode)) {
-		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
 		if (newfd < 0) {
 			perror("openat");
 			return false;
-- 
2.54.0

