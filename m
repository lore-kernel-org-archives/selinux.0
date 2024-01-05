Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839735891
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RGtAWPZI"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so2371569a12.2
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704479743; x=1705084543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2ohwGEmnwr+GAOsUmGoRBdUpmmWTdDQR1fHw+646qw=;
        b=RGtAWPZIHMLNZGgRbiJLEY/hHHywLExU2E6hi7jeHXuO/ikfOoYAA0lg1U2qPxKfC6
         5QWwRmFgKjRBpMqZJ8NwJgRytlTWBAzn3TygXRPWh/lLyPViIx+5OireF5uJM0N+ogHz
         y/qfajIqHj9zTYT7QnE4GaqDn3GIyncp0E0pagnByKa4CpUoECcTAEAOzpi5Z/LnfMu1
         WoQ0szqUEgzSRRkR4R/YcWvXCjpV5nL6zDTFGY7Gd2XiW7EFAksNe5YBSdDq28at0CUb
         9Nv/V6mUajSNNzIwNgGhLNkpHdzrsiNXoxtWXW3KG08EUevDsCJkCOBydW8J4JxZN9m8
         iW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479743; x=1705084543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2ohwGEmnwr+GAOsUmGoRBdUpmmWTdDQR1fHw+646qw=;
        b=wlYIlsbDqsiisNdnVQkKZYWf/Exg9ApKQMyeMYeYIF1pZkL4c5eZegb4vRyRruo8yD
         FSgqzl2HYHSvIS91x5nD1sBCGqVPxGZ12uknfGMkOVGwj3aKixDnRQ1ZGeimpfbc+cga
         xmHW+2I5Z7YNOoB+BhkT2LFl26/yskRRhF4EAIDE8x52FH1iYL+UGM4/HQ9XHTxx5vEE
         5dXbuc4mOC47CnNFqPyNoCtD6BcJKF8uZ+ZoLyVQcQqifkhMhH6x6fkYSqma4AqYiHu8
         f0FDKBuY7v5tliymV0aN1qPD+Q6EGukN5RoWgzaxkHRftnwco9H1zYPUBOauP8dRGyaU
         x8uw==
X-Gm-Message-State: AOJu0YxXgr0t7NctC4b1jGy3XXcCTnnYnJmuOZYufn8QeI3RlmzU1o4s
	7rDZYdW9poU0vKO0lZjQtoa4UfY3OhM=
X-Google-Smtp-Source: AGHT+IFAqU4qVX0bqgQzbSfvQTKRAWnQBBQuEymUJnT628Gha+AQG1Sn6Vgeex4Adboh5on1YSNrnA==
X-Received: by 2002:a50:cd82:0:b0:557:2e8d:df19 with SMTP id p2-20020a50cd82000000b005572e8ddf19mr764559edi.64.1704479743300;
        Fri, 05 Jan 2024 10:35:43 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-008-063-036.77.8.pool.telefonica.de. [77.8.63.36])
        by smtp.gmail.com with ESMTPSA id ds9-20020a0564021cc900b0055267663784sm1231319edb.11.2024.01.05.10.35.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:35:42 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/4] sandbox: do not override warning CFLAGS
Date: Fri,  5 Jan 2024 19:35:33 +0100
Message-ID: <20240105183534.1110639-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105183534.1110639-1-cgzones@googlemail.com>
References: <20240105183534.1110639-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Do not unconditionally add warning flags and especially -Werror to
CFLAGS, only when CFLAGS is empty.
This helps when building with noisy warning flags, like -Weverything.

Also drop -W, since it is an alias for -Wextra.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 sandbox/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sandbox/Makefile b/sandbox/Makefile
index 360a8bc5..0799ab7c 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -8,7 +8,8 @@ BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
+CFLAGS ?= -Werror -Wall -Wextra
+override CFLAGS += -DPACKAGE="\"policycoreutils\""
 override LDLIBS += -lselinux -lcap-ng
 SEUNSHARE_OBJS = seunshare.o
 
-- 
2.43.0

