Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD6275863
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701219; cv=none; b=GGfD8PvxhwN8jEy8GqGeN8TVXF9KecWH+ViCxcWJH2JPd30WzAr1B57nNuxl1CCwGJJVkLXHJflMFP9FJHgqorETEiwXwpNNfUZFsbVlpYKEzbB9TcD6uvyMXlXSBkj37QwXFkH0NQ6Bpx47sWD5veVNeT3kgLKMxfOzplDCsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701219; c=relaxed/simple;
	bh=h5dIhNUGRcNVLReL7I05zUY5kTUC0DzPldBHwsd5x9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOu9z8Ooy6AnoJ8wfIIkKCOgkbYS4xrWW7w+v1YG7yoQ+Mn1RPyNwWRrD7BNGqUl8B9YJr/i5DYdxRVSEOfwN8cNJXbwMYhOQSgEYCkByVACniO+3HZUNtNwOJ6QsERGwV+6Qyv4t07pRYH+lgMO9kU9jsz4woPSusTHk4kmtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SaSrlG2N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SaSrlG2N"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22a976f3131so53304915ad.3
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744701217; x=1745306017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvP3jktdcQlD/wgwVWubnz5z+eT6waZA1U4rtXZRHts=;
        b=SaSrlG2NoX3QQbjT2KAZd263HQGTexf+55IukAw8U7sxe3JSb0Hm0tqgpSX8Bm0gpb
         1KaF380X4EnRJAWWCIS9hVhm6vWAM5SgtBpgpefrE9LF9I69ybzHjK2ZCWiePpg6IK7u
         4qzjEk3Q51umeo8sCsFII/9TFyBc1VetlGBjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701217; x=1745306017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvP3jktdcQlD/wgwVWubnz5z+eT6waZA1U4rtXZRHts=;
        b=LGRdtjzXnj17npJlV2WHhGOl6D3fZPyAT2Y8jGMTTFVWXTn0UL1jpZsiTOdhjcYAix
         ZXOezdUxfzS2mXVJROXLfKdw3Aj/FbSi9zDOkStQyGo40cU1P7jwbfJmvIlQJ5u0mcAx
         kYMziEf/6+WEnrKr8ygE9uBG5PBHZmJmxQd+BuG/kl2TW/WfUcY2LwjI7FK/+m12/VK2
         SmNBR19UbLI+mxT5GSkLHAxp/hXhRtvIzHxPfmIcDscZRMg7o/kGI51Bt9UzKy38hQpK
         ke6KDiR3xoYnsTsQevptXvceRWwMNngmUNJTiDdePRqhDIOQVvqThfqjb6LQ4Rhnfdc3
         Zx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyflhlAJLqzSxAlboSbXVrr8/aTE76klLAbD4xHdsmaGOElutdxS1vzsGq6/h8Yrjblc1WlNAw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bX165hFlgA9wyRuiQ6uuWEpa9M6+8vxo3NHhwubFxG2swRIX
	0VYPwJ5MpgNdTJ0+TQumB3Xk5xqPQhDFEWKfzZQ5Yin8wdkGI/HXHTkd5llFfQ==
X-Gm-Gg: ASbGncti2lsCu4k1nSSnLvsLa/utCw/OF+S57Lksgt9k3TX8dgI7cgP8aarMgDJnkq3
	xVJuLYkZ50UuH55JxENhHyfJnMotn2dhsEXzGeRn1X4XPyk30JAIBJjO9lYDowPw5DZ6upMJwpA
	COpsOZeA4o4SkfZjm8pv+Rz4SjaEXaZP+EbAWvGsyc7odObvMGJuJzBo4b4i61rIn9r9ggh9EFC
	szQlZarHrLBdBY6Mtjj9Ve7NJiOR7qO6axyDfNkmKjQQe4cdTWymqzp5ruGlM2yCOSvd9fsug0y
	mnkHnboDcZVHuxVDMkjflyiK5VNmSTLMqXcY8ExjP8IsDb/pKtb5EVpzzMlXCXd6Sby7ofTCqJS
	VOHSsVC0qLS+sy4HcwKoDMgfVA4n2GgPH
X-Google-Smtp-Source: AGHT+IHzbUw60awGAdnr73JeuAX7Ko77w21zXHTS5A1bqgbmfAjViEsZsECWSFQGbmRiP92KE4/mbA==
X-Received: by 2002:a17:902:e5c8:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22bea50017emr210745615ad.39.1744701216954;
        Tue, 15 Apr 2025 00:13:36 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b65496sm110776435ad.42.2025.04.15.00.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:13:36 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH] binder: add setup_report permission
Date: Tue, 15 Apr 2025 00:13:29 -0700
Message-ID: <20250415071329.3266921-1-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250415071017.3261009-2-dualli@chromium.org>
References: <20250415071017.3261009-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

This adds the new permission "binder:setup_report" for the kernel
patchset "binder: report txn errors via generic netlink". A new test
is also added to selinux-testsuite to cover this new permission.

Signed-off-by: Li Li <dualli@google.com>
---
 policy/flask/access_vectors | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 58a559ca1..36817566e 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -835,6 +835,7 @@ class binder
 	call
 	set_context_mgr
 	transfer
+	setup_report
 }
 
 class netlink_iscsi_socket
-- 
2.49.0.604.gff1f9ca942-goog

