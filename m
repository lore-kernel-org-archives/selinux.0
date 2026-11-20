Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199302;
	b=kq9uW8JBJIjs1maoCYs/FcJg+JE+KaEjNC5YBpmuOrOYKjFCqG6MKeCvhVzakHS00aZK
	 uTk6ALhIdXVyjJgncPpi1cxsBmmC64P+sAdi6/6PTV3Q9K8Uot/eJpJ0yPOsARqXyGc3W
	 DcvTXmAHcloTdIoNdE1e7Sm5QGwFtZK+RwzI7JgK6u6+f8ZNALrJPGhphGMqccJb2d401
	 cCGJi49qdfzYqKLMVaxRubYgSycLRQHWPxzHQR0bcsw3H9Bhot9R9U3/JAz1PVJHEB/90
	 ZT8BD/gBpfE/LUptC4CprA2XPcXI0FnZ8fkUZeChwV6BqgwMoH5vDP77Bxx9DvY50YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3uIRJpg8/SFYOPoIYi8GRAGLu5TjqhLherfpa8I9naM=;
	b=nW9rLT12601UHbwtasNkG47cLhp/pSwYKZ4OmNdo5sMobhwpXfMzANXuI+34UAmF2Zas
	 rxLxGw2dEgr0+g6z+sMbuHJqtdK6AQ2rv83t3RcqT1B+Yw3KcZ9Cmlkossyz+fDtRGgbA
	 0k8gGxdBoyz4w32cRm7ZUVd2mYSU4KfO71LhiEJxC+3qEohxzXbpQegypa7XvYpvclbtU
	 VkglhZ0Z+5z9LGQtaFVasWlGyibn5C0rWdEq1qRWOw8mk0gJ/ZYq1rsdvRAYeHARryhSf
	 a6+9TFlsdaSBIkuh2juFIxxrEY0OnkS3XZwCcQVmIH+zcgoVLMPHw4AO1RDJVl2M8BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkEqzuWW;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73E606A325
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 18:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E73E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkEqzuWW
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5430f70c827so17034291cf.2
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199301; x=1795804101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3uIRJpg8/SFYOPoIYi8GRAGLu5TjqhLherfpa8I9naM=;
        b=HkEqzuWWRXgjeIFE4EJZMHJnYcLzvEXSJKZtlfBs5DWp29r+gF/STo1E0+eblk4gZQ
         W+LLUDGRlhaFhYw4YRo/wPlFq9GXj6cbiQj+dYcuBaI48NAmCZtSnTFx8X0/8JbJuLaN
         SUgzyWs6uerGKPKt9okI/5l80IAjhoEolenkorvbSi+vM8iTV3d13iZD8Zr3IK069vJS
         ZLJarG4zp72eNidRQkB1/u6SF8UJNAT3wiVTxW/Gdu1ucaGLz4Bep2RnZE0gG1kVeZJd
         3J+p8mI9MYIF687bK6c+4EabwOJrauASzNlIho5Y0bSApy4S8DXnCjbIRewIRxhc+/S0
         wzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199301; x=1795804101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3uIRJpg8/SFYOPoIYi8GRAGLu5TjqhLherfpa8I9naM=;
        b=C34A1IPiE3T5fd5rVbRHKDlPhq+9ZQZK8NlEPEvZXOeHzHvy++lm1dam9sjxUnWT2I
         jJREeuCJZ0ycL8CvbDzs7OwfXdmoNviWEqjh0BkFv29gaBwnDkEHL+vf2nAp4rpkAYGO
         GDh2ca7Upy/BwBx7EHYnUvUfYJ5UBxBnVzJZ9Gk8PfrTWDcw0F8p1QB/H7Cih14Bw9pM
         um/aWtq4vQG6q3DstO4fFpf6R54C7Uvbf5giJdK97pRqAvI716NPwn8V+NNRl0qqRRqr
         Btnda7JyosA6SLI3DNqBKZ7qgPFoOvR3IAHeeJc+sbsMKKD698yk1372YsAoiK9KMrQa
         zaig==
X-Gm-Message-State: APuU4Z/h07H3YfQXA0AJ8OPw/1ZDnMKDlVWj2JmgbE0zxWdfW7Ygg165
	V8b6Ag8Npsjx7eHSdZXz1mJj8Lv2A9a5N24K50yQ1nGuJEys44UkXEhBp2gLwYEA
X-Gm-Gg: AYBFou2AV4AU61rj9KleeF2k3qir6/2/2ZepnvlgDV1vos7rhJaDgMl6llLLioq5yPk
	jJ3L1J1JdrhjCgzpK1hTQqP9Iqz8vf+zhmqipjZFG2d69Nm2j9NMezdIYgErqNADDmTU+dmzoLS
	RoZg9iLarAfcebPwt4TMEbw6Tzvt6TqPUPDEyhXtw/CG+wX+AysPlc8ZQUmTVfvGAYJLDSUcBqc
	TS+fvEY1yc14+8s0LjL6d6wdqV2KEL2LJrEdkmRs5r6mfy8Imr26OI+Z79F5S3ifRMJLhWwdAqJ
	hnZGm3ayR5gtTCIaPxJfIJicq2P40ixx8/UGhAZOuiCZ9h+chYkwo51Zjgnru2nYJrPAi3gGKF5
	Het07Gj/FDIJKtgaNoohSlVfP1SPSkF5hpJOvkZJkqz4Wf7/P7WCc64mkM3cZydmHZ1aRP3R9au
	Hub/TyC/1mUCFCjvEjVEqjgGvitWxMx75Ekw6d7X8w8DmK6Z+0PGm/Y50K5cx9GQSIdkoTLho1Z
	MX5PE94MIzt3fizTYSMY77VpIl5+YnRp7cqAVJ/hTvzoVW7+Q8q7b+rjNsRu3U98OkL3ZGwSED7
	GDkhVXzrxhoaXWVyXd+n3Bbcc+43ZKWyiaXUP2i5byJSGXml7bTFfYsPTNApECuGfRPAX9HMdqw
	keUlD0TFRA+O0qDzgdl+5j/Zjv2TW7ZEP1UJcKdnZV8LlFlRqKrdDYVbanb+dbIQW02fVTWuc+5
	Fo7fXQcCjdFb5f42rTm4c/U82yAbdvlLVTZypREwyOEohoyw==
X-Received: by 2002:ac8:59c3:0:b0:55d:3201:308f with SMTP id d75a77b69052e-55d768a4864mr75422991cf.9.1795199300836;
        Fri, 20 Nov 2026 10:28:20 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7887b610sm28733251cf.23.2026.11.20.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:28:20 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] .github/workflows: drop gold link from CI matrix
Date: Fri, 20 Nov 2026 13:27:57 -0500
Message-ID: <20261120182758.38923-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
References: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gold linker is deprecated in binutils and can no longer be used on
ubuntu-26.04 and later. Drop the gold matrix entries. We could add lld
and/or mold linkers to the matrix if desired but that is left to a
future change.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/run_tests.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 3313ccf7..749c5b4f 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -14,7 +14,6 @@ jobs:
           - {python: '3.14', ruby: '3.3', other: 'test-flags-override'}
           - {python: '3.14', ruby: '3.3', other: 'test-debug'}
           - {python: '3.14', ruby: '3.3', other: 'linker-bfd'}
-          - {python: '3.14', ruby: '3.3', other: 'linker-gold'}
           # Test several Python versions with the latest Ruby version
           - {python: '3.13', ruby: '3.3'}
           - {python: '3.12', ruby: '3.3'}
@@ -24,7 +23,6 @@ jobs:
           - compiler: clang
             python-ruby-version: {python: '3.14', ruby: '3.3', other: 'linker-bfd'}
           - compiler: clang
-            python-ruby-version: {python: '3.14', ruby: '3.3', other: 'linker-gold'}
         include:
           - compiler: gcc
             python-ruby-version: {python: '3.14', ruby: '3.3', other: 'sanitizers'}
-- 
2.56.1

