Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381E449B11
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514851; cv=none; b=djNYZ0kQVA3RlCYcoQ8PcAcAbVjLRcIcZG/Az+LaprdedHCCy7Ot/sogj5Fu7E78TKfYFwH1qJnnQVU8tCeceNTJRZ9T9FUqVKO2LTCqTJ9O1YXwekjcsfH/veekpkNVcKCmLcVP3qbjUeEXIaK3i68TWZMhWC+9IAvkpyVcrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514851; c=relaxed/simple;
	bh=QeUJ+dCf/iluqNtG/QzAa8n7zhPU8qGX3YYpvQX6tXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6DnQwoGnKcd8BrPsj5u35sODRioYX1dH7xcFmQ6lRXZTjfv9eXhjhVZI95ZGIY9EIzCHh2VH4+iucBRUx8hKQ/TbJRihk6zKtjeI6b/co11e71AIDFeNDOtmcbrwKALCv+WlVr6+TDPaAQmR+GqukEMZ6Q1QrzdOMjkx9HiLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxTkS/aP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxTkS/aP"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2808dbc3so6788341cf.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514848; x=1786119648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzeJjbGGNi07un5hk+AEHru/eSXyUE3kYRUp++3VfOA=;
        b=CxTkS/aPwvF40UeTl3FogyfUUc9S40E71UQiqHNl1KyV1faJoVvrp2NoQ2qDrAO9p3
         8UJwkSRssWEtoQlmzfNF7jZsQeeCuQtXxrB8oX+ruMrt1zOLSY+Q4xTF8UXXIOGziO/e
         hkVDLvtuFpn4HdnvTy+6EcC492GqDw49ournDvP8mI/n2SBLhash4tTm0tXGvGwVJzq3
         LYt0wALtrFxSCrgYlKF3HlPEnb4kQOBbFWHbNJS4F3o4D1015PQPgIV72wEH+H843x6X
         6EWWdF/k2x36By+Ew/WwdttV54a2FEK+F1+kyFFKNN4voeTZsBS50O4uIyclOu1Qv2i9
         yoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514848; x=1786119648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzeJjbGGNi07un5hk+AEHru/eSXyUE3kYRUp++3VfOA=;
        b=iO0ok0daBkeI9i+aFDTOuspNmy0uOB+3kV0+sZGHwfcyxyLtOiZHJ5ioLf0PhnoYFB
         y1MPP0EVahGPdkYF/xWdBILKJbXrpzIUrADvd+NQTh+1FrmVn+d4JOqgJMwvWJQB+bHs
         F1AbE9G8apqDApG+paMRVLBvQjrwjiKaK4G6PKzITqspmkuWjiILyHgb6ux+IDIw5T7t
         e1rogFyz9aoTjXsexxBWPuxEd0LBaliMATdFb6ucAhC0+KUZEqf1OFceOBenZx8tpaG7
         PCmAoAHQ14+DlfhOBdwG9RUXY5vx/cpFsct2wm9j+mJ/b4sl8U5PBIfUQsXhP2Meaw8X
         1Ybw==
X-Gm-Message-State: AOJu0Yy7gkvQH5864oqtzthm8NSnGyOsBUzmJ6pRpDa3xI53Zqj9ufC8
	Pz3vSnzgk8wLzhhtjFseDi4rU7wEP7hag/GQzqoYg/T46Jk2zlR4/shua97TvA==
X-Gm-Gg: AR+sD11E4BK6s0WhhOwAFcmlqzikFcg3bC3iWDWLPxYJW2WMi3JGSo54xifpJs0bFww
	nyvQTbaLVVsdlN/uNrbPgYPz+T3odVkGdjZkRcBiOQMdmDd11yQVKv1elQYMkkdZhJjMedkUZvI
	tzO4XEAfA27Mx/SDJoWlOxSZYNtzPEmHqpnMu8VBAnjQ75cTuFe4SkmAL4I+dsq6Suqrd1h0QMC
	qAZAlBTR4VsnmW38bDBW83G9lBdirpvxszXLW7eVHkll2hZ/p73DSVDKF2wgU9qDjt8wXNGvMnj
	zmjVXVHWXwgQd5Rpd6K1pUPMe8Ox53cE4bsqVOZE6Cvsk4iAGnO5zudS7YQmVH74hHNPN+c400V
	nwW7yGn+/FYOTRdxkZpe82BdkHmSq1HjcBS73AwJ8p4c3ILny+3B3ZN3xNCIZpWAx7GArwUgCXW
	XWjJ0FJs0EO2fn3aNRhpBI04We/P35ySifitMCigCAIcjPAAokgyPQD6Tg+hnaQE+L03X2J2SBQ
	JMYbGoVF7TYp5Wf415NR5S60kWmhpmt60kAdA13kUlBvGeRcxsvStPCGGZd23NPtQ==
X-Received: by 2002:a05:622a:5908:b0:51c:73f:e3a7 with SMTP id d75a77b69052e-52b56752287mr17098131cf.26.1785514848074;
        Fri, 31 Jul 2026 09:20:48 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb96ad0sm11076161cf.23.2026.07.31.09.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:20:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: fix direct leak in user_extra_to_cil()
Date: Fri, 31 Jul 2026 12:20:33 -0400
Message-ID: <20260731162033.19084-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free all the strings on the exit path.

Reported-by: oss-fuzz (issue 539257834)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/module_to_cil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 2aaf4feb..06fbdc30 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3680,6 +3680,8 @@ exit:
 	free(line);
 	free(user);
 	free(prefix);
+	free(user_str);
+	free(prefix_str);
 
 	return rc;
 }
-- 
2.55.0

