Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE330CD95
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821230; cv=none; b=SPTZuXu0p/4zE+L2jotgzyYKjoh+IZLhgnkUfoYmQ3FnBwqhDtVCeABozmg4C0RU1cre+TjbhmCt34pG12zH6wcdOjQZNeMdD7ZjnTOP1nuNzfDaqY+4eYpxVz38MLlh1tGbPd3xZoqcRIoyyrEznv8hUXrhMPCnBKjnGYzyt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821230; c=relaxed/simple;
	bh=PC6HGg6D+c2cgMjYO8Hbcrz6I1qb33hFwgJrKKdZixw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrxWBaNfGsVRnhRFVbYCV1ue2/4NyhesV0yQni89lD3AHd7KnWoJl3Dzvq1LuBAccL2VfZzdyTusW0WI/tE/kEk/hjtKY+FWU2W+Irbs38cUUadV9meR1xMfD5hzgokQwoUxo9eqw3gVu6HDsbuhh7cSu4Xe7ox1zpXADLn1wEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSmm/9i4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSmm/9i4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso10812255e9.1
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821227; x=1759426027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5iTntjnnlrGj4GPAHYZEAFju/8ZKpaujM2i31mxFWQ=;
        b=WSmm/9i4Nb32WFaXWmSZiLIerWrc1oJT3erU5/+QPvqmA/vywQLvrxBWHg49k/9OHz
         2Mi3PzuprzfcDy4R37cyVUoSKh7IvKBR/n7VbRcwB/20rz5PZIE6+bdeoohqfelth11U
         u8+EdRQc7XSf4D/tRzUc8WywFbUEnbpZu/SMCT9/jVuWbINRZpGhf+EYjUNhzcUqSGKN
         NCElT5h+YsSdr3F694LEqlzj3xvfoFtMudLMtihsR5+OYuJlPDdgpuMZOVEdIvEQ5rbl
         rBxO5hC/E71ZzSYzQG00VRkd8mgh2/Rj934cPVu7JzO7PKuYB9FLEuiy6JnpWhcKqhOB
         LvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821227; x=1759426027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5iTntjnnlrGj4GPAHYZEAFju/8ZKpaujM2i31mxFWQ=;
        b=rhgE7REBcCifUNt78AUj25vWigu5M5qSGF6EYonMdOA/e77ZqK0vIn76Ow/1hGqImV
         +mnvq7pZfoavQ4pEkEu+dC7N6oVnktxY0w3CKj6icXqUzEhcRHq2IonMUkg8SmeFqsK8
         X18/0SPIBWwuKEfV3XLouZEYaP7EwZ/IVw6z9a1N9wQEoiXr7fs0xIIn5hc94ds6UpYe
         7LqbPl/aQqT/cGPIvUNX08R9x6zjfMCLlyozs3ETXaCO3tTqTI1r4dtTuY3AluJsJhgc
         fpbE1NvqEwDRhDI1GIwN5NiAsSKgk7LMveHCWfx7juw+PNjHr/WDQwrCrsPVPkHCjc1h
         AeWQ==
X-Gm-Message-State: AOJu0YxDF0t/mFkDPSiF3KquVWxvHo3llqv37MdgbpSvAn0StBXGQVTm
	yIY6h+wqZAq5zJTAmVPdnC/9hOrJJ+CR12s8dA2jrY+sZ8/CAM/frvsnmYje/w==
X-Gm-Gg: ASbGncsSBfSV9EQ4OXLoVnbyhcfJLAhT85ZmDxhrq50zRoszFO5ASV1e5DPIphm3YHd
	3DCXSGbH/1V0N97qpiIciUOUNKGu/VGsgcNo4NUTVTDt/elQtWQrGnCQXOLE+XQrQ2rVLnNo9CH
	ZAGrKx6mjiXVdlRI0+D9WeXdEYqWcndeMAZ9W+JfOB2fYydsPOVI3dlKN6VH8DmOnNOQUfFXCDs
	O9QeU6ATdyKTlEpFCb79cbAOBtEU3kvzeyC3mLyr3YWKfNafcee88EKGN8oYMw5X9j3iGJI0/Me
	uPGH+J1sBYfjTAYuwp56k5KnJ6lJMhecsBAAupKx5zQkvNEw0dQHegZqkarBfWW7/befpBP/Wex
	nUFGzefc=
X-Google-Smtp-Source: AGHT+IHMqO9WD0m80DLWZsIYaP57xu8lz7qv8TkX/UaQh2J9sS9ie5ftSnA2hU8NgSHJxJSfMn0nDw==
X-Received: by 2002:a05:600c:4b16:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-46e329ba996mr37019045e9.10.1758821226939;
        Thu, 25 Sep 2025 10:27:06 -0700 (PDT)
Received: from sierra ([81.79.59.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9b6e1bsm95227725e9.10.2025.09.25.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:27:06 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] build: Make sure SHLIBDIR respects PREFIX
Date: Thu, 25 Sep 2025 18:26:47 +0100
Message-ID: <20250925172647.931521-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not respecting PREFIX can pollute the environment in various build
configurations. LIBDIR already respects it, so we may as well make
SHLIBDIR respect PREFIX too. Fixes #494 on Github[1].

[1] https://github.com/SELinuxProject/selinux/issues/494

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/Makefile | 2 +-
 libsepol/src/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 261c22d4..c855e759 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -10,7 +10,7 @@ PKG_CONFIG ?= pkg-config
 # Installation directories.
 PREFIX ?= /usr
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= /lib
+SHLIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index a1aed072..f8574d70 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -2,7 +2,7 @@
 PREFIX ?= /usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= /lib
+SHLIBDIR ?= $(PREFIX)/lib
 RANLIB ?= ranlib
 CILDIR ?= ../cil
 
-- 
2.50.1

