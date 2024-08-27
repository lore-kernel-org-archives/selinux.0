Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67E1C5783
	for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770526; cv=none; b=UDAPCryDdWu5qYYG0fGxrKJ1bFYvI6xhArp1poELeVxmAXeZjncdo9VXJz0Fqpb7zqY4S5Kw8qPyD/wEV3K7yrUC2Zuy7A9Q8olYO8yasmyJNzMkufwg26Yt/reLRcByHABuk6ejW7nRYnpmr8bqgNG1BzsGFPWhZFnlVFw4BsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770526; c=relaxed/simple;
	bh=0PEd9zy526Ch+XXGz3w7kVqTGG3nk5tAMoMXAhxU9yI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mwp+qDAo97D+SE7EtT06DOzdkGkcjuJO+wcPOBharrGTMlxbkB0utGd1PpL4ehQsonJNlW1UpWVAKk+z8Msa2PP3LkpVKf/YT1VZ+QgtZle8EHx71/PnAc+99kncie6CYbK/Y8xX5EFgippxZeiplkwyyOoIhIwXVHrWJfJIR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ata//i6O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ata//i6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724770523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FX4q0kwPiqhQCriJHFBZ0Jtu9afOrLaKykP9jGDkv+8=;
	b=Ata//i6OHs6yaQ78HVgks/GBEl2RlppIQPGbW80qWkCr3uRopUz/Xhs/37U/IK5MCo26dr
	rRCCWuzUm0TXlZHUIdZeuZW1lU/C5kMaAwWeC86CVZco5y1sKAh/djRnKC4TtAOHynONRP
	iSUOAmuOs/3yh5rUrRQnRvai1fT/KnY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-x_LIi52BOuOKAU3Lmoj0jQ-1; Tue, 27 Aug 2024 10:55:22 -0400
X-MC-Unique: x_LIi52BOuOKAU3Lmoj0jQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-429e937ed39so52653985e9.1
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2024 07:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770520; x=1725375320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX4q0kwPiqhQCriJHFBZ0Jtu9afOrLaKykP9jGDkv+8=;
        b=oUaZonsB3GEML8vSfSx9Tu9sHNNO2fRAdX/cjhqH3RnBFqDGoYq6Bj9mLLnRGeYLla
         bF2FATLEE+1sS2kME6bxZkWqaI7zdoT3cZpTgWswCbO8RrIUJGt1FCbghqqaazwQJXX4
         SHDYGxynXrhFwIwKdiwvJqdVWndSdGHklda8h9fy59gT6Li1a9nWRuQXlT7Q/Ub2wFz3
         k9Ppf7XGOAAYx8Z3wm0zxZyTnji/TdnCxM6sQq2sTRosifBG3PkKQcYi6OsjDdx220/v
         X6PnUx9dz3Uy7w+xRGxVTVtUvkl98ZhPFt3ZJTsxdXAz1YJEduDYpFrzkM3y2Al5Ou89
         26EA==
X-Gm-Message-State: AOJu0YyitIzppk6vWvJ38zfN++X7LiHvglzs47JteE5KgUIblved26zH
	ACNO13EwxQ/kCF705WegJQlrfm3KckbAHoswnUnfVj16B7qpUW3vHRH//oFu5530VwyvXw4O5sE
	GhpfTdwTW2CD7A8taDU0eu1ssCKVknxt904CZrl/VJPsJ80b6O+qx6IYZB0jDmUdnsG5I9yNFIA
	5IDMzBwvtvmXqZj+vFOiXMokovJLtWckbEC8cZTq4=
X-Received: by 2002:a05:600c:3ac5:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42b9add47aamr22604155e9.12.1724770520424;
        Tue, 27 Aug 2024 07:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbnpK1FzuEFXulLuWMkY8XFgKHcpx5Ky30L5/F7vbcoUBJwqSW/F8tKG7YZ92hqlMgNxeYbA==
X-Received: by 2002:a05:600c:3ac5:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42b9add47aamr22604025e9.12.1724770519866;
        Tue, 27 Aug 2024 07:55:19 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff594sm13296367f8f.66.2024.08.27.07.55.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:55:19 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/key_socket: skip the test if CONFIG_NET_KEY is not enabled
Date: Tue, 27 Aug 2024 16:55:18 +0200
Message-ID: <20240827145518.469490-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RHEL/CentOS Stream 10+ and Fedora ELN will have CONFIG_NET_KEY disabled
[1]. Make the test skip itself when it detects that PF_KEY is not
supported so that the testsuite can still pass out-of-the-box on these
platforms.

[1] https://gitlab.com/cki-project/kernel-ark/-/commit/99d6d1c86fe1bb1df5c0b80f4717826c2330e291

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/key_socket/test | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/key_socket/test b/tests/key_socket/test
index a13327f..3f371fe 100755
--- a/tests/key_socket/test
+++ b/tests/key_socket/test
@@ -16,7 +16,13 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 5;
+    $result = system "$basedir/key_sock $v 2>&1";
+    if ( $result >> 8 eq 97 ) {    # EAFNOSUPPORT
+        plan skip_all => "PF_KEY not supported by kernel";
+    }
+    else {
+        plan tests => 5;
+    }
 }
 
 ############ Test key_socket #############
-- 
2.46.0

