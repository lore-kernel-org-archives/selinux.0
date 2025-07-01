Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAB27780D
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382608; cv=none; b=iNJ7cqEJ7xgyyzd3oLdbhnLmtwooMR3JX1UgagZlerJbylbHRJeR8h1uthtZ3mfgzU9Ql78k4Uza7BTykcSP7c4DOK2TiiFm1o3B6VvKiaYVhKzFj1RnIboEizvr6OPOmAZ6XwkTytkI8RwregiAr1pJKODR4kF0b7zxqgw5d/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382608; c=relaxed/simple;
	bh=Nn0YE79pKTEK/gCdLZbpFTBww2Ymlsq17B99r5lPGE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzD++k47dMQW18KMP31y/LA4B38QNiGhyXJbE6rLAKw9GdNoRU2X9BsKxxk+mkiNCo3z76YvyxfYahGxleDweE1li0FnchpVVx/I4DgU2wHpVvrJv0rJMnA08+OdVjzwiR33M6slvJYqmBpU5WLlMFN9JqZUSHRKYLh+6+hX/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrWaEk8c; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrWaEk8c"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a589b7dd5fso99391821cf.0
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382605; x=1751987405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+K88RU6Uvi5mtG0KtikXJMhN3ijgLXpEzQu84uPsNM=;
        b=nrWaEk8cXrpPdlrkvEULPcshmaiwyTIjg/IoNuacVifNuJrxIDfdpGlOpQOodpzQAS
         wkHLFzEI3D1XgQ3SgbU3weou+dIN6RjT508mzg197R+HaTeNOms5o27UIXWpmskevb8c
         tKPtQuJ8r933QBgVBotZ9NnUnKNB+vetNMrXTm56zWekgBqATEcCYxaSYD0p4vKtH2XE
         082iNlah2i/PrAKagaKzwo1xMor7QIU9V2ev4EiXizsaTsIGXwbZtydBtaVAoQBk6en/
         KtBgpcG4q6HCv5EVskhHAqWfI1huZ5GjUk2biTRqcBeH9bQK//qtjdWRiIZjTpdvloFV
         fmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382605; x=1751987405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+K88RU6Uvi5mtG0KtikXJMhN3ijgLXpEzQu84uPsNM=;
        b=sHlb5Q/vvTvZAmaaAdL7tm5jQdgyt4exSG710WSNz2OFiYnyfPqvb2Kq8ZmI881S29
         ICsElmF6DeJYFJt8ym+hSPSMTVi7hOCeXdcDq6rSO3Sc0HKod05ZC7dfpyKsIwk+/vlE
         tdJyAKOgicSC58q4CKhsJDRw6aPgYQ2PHg3FZph5jGrR2rCqOqanvWpPNa5xfPk/ATtP
         64Z9M6V46Rwy69BQcNrGixnIxI4I3t9kM/o4QHkfu/DftNc5eJ6xWL9hwuXOx6fGfayy
         m2UrbWEV9O3mcScYBP2LAQ+3wD8P93nps7igscNs2sEZ6zyxyz9D09tAhWq8Y2wdzvqm
         Ev2Q==
X-Gm-Message-State: AOJu0YzG2qq45hrzY2yWB0YRPIUOChh7dbODSpN5km5bvMT9+jzupoep
	XnpOzbQhMR7hxWjnXIVPOvzBEz2b0r+NqDmCdzQzoTVoHG0dru5RbzFFtNhjRw==
X-Gm-Gg: ASbGncs+RnpcdHMuvt+vWCKDPZJBjvigtz8bLqRNB5LryBo73Pon0LLaw6GOSJJJu6b
	WbaAGTbpzi0oRKnOAvQTABzedkOBbfqb4BwEmcCmsvh+CK+j3ttNz9pIpYY9wOoVZLfDiXGlYDJ
	j+pTyI4CiWoLfphIn9C1j/mqD9/U1uuJH+lizN1qYA+ADrUWq6TknNtqsvDDmaPN5s4mcsgCyk2
	mFwuD6AJ3gcRalkC843UJ/SsZGTo3RafI0StkAhvuEy4RCLpw1DOyQBrXo6YRlOYUzGBd0ogR2P
	jmlU16J4QBU4BqCejd9+bZMY9dYPx1EOc/xMcjF4E+VjDNk5wUOylsIWis0Mt+ecei8I6LM=
X-Google-Smtp-Source: AGHT+IFLDAEXc8VQ5px4IsK3v+6LRCb26LMaF/Yq/hKO60QraNbS8QmA57EcCvamrWpkvRB3Z4W8RQ==
X-Received: by 2002:a05:620a:3954:b0:7d4:63a0:e0c2 with SMTP id af79cd13be357-7d463a0e39fmr733232985a.15.1751382604637;
        Tue, 01 Jul 2025 08:10:04 -0700 (PDT)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313695dsm782887385a.1.2025.07.01.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:10:04 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] Policycoreutils: Make pkg-config work for more types of builds
Date: Tue,  1 Jul 2025 09:03:09 -0400
Message-ID: <20250701130309.260015-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support static builds, pkg-config is used to add the libraries
needed for libselinux and libsemanage during the build. Unforunately,
pkg-config will always use the installed pc files for libselinux and
libsemanage.

Instead set PKG_CONFIG_PATH when invoking pkg-config so that
it searches in order:
1) The directory specified by PKG_CONFIG_PATH, if already set.
2) The local src directories of libselinux and libsemaange.
3) The default directories specified by the system.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 policycoreutils/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index 0f3d62f2..7c9706e3 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -2,8 +2,8 @@ SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setseboo
 
 PKG_CONFIG ?= pkg-config
 
-LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
-LIBSEMANAGE_LDLIBS := $(shell $(PKG_CONFIG) --libs libsemanage)
+LIBSELINUX_LDLIBS := $(shell PKG_CONFIG_PATH="$(PKG_CONFIG_PATH):../libselinux/src" $(PKG_CONFIG) --libs libselinux)
+LIBSEMANAGE_LDLIBS := $(shell PKG_CONFIG_PATH="$(PKG_CONFIG_PATH):../libsemanage/src" $(PKG_CONFIG) --libs libsemanage)
 export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
 
 all install relabel clean indent:
-- 
2.50.0

