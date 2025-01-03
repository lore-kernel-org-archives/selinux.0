Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653359B71
	for <selinux@vger.kernel.org>; Fri,  3 Jan 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898533; cv=none; b=FIWKrrDCPTUPPoVM95iqG6+5nQfTx4wPU3j4Or8MVzTsBAfEBnc8JN0Uj51eeZtkPrVAAvX0zfCbRq9KrE1BWV4cALpVD+g7aNmE/z+gtC0zmEYm+e7+ijAFzdfmvfNODh3lXDv/tWrmCWX7oacXof1YUEWV5QBf847WkRJQZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898533; c=relaxed/simple;
	bh=8wUq8yVNt6rjHD3g3AKiiXZWXCLc4A39GB1RTvQhO8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K59991M8lUMILpOSkJtqTPUKJ0aSA+rKqfZPdo7Jiybeg4bJWkcbtb0tanS+iYge5eSLySWumNE3MgO/RUeL3AjlVJzWeRcLn7rVfm3R15G+u/hqAoSJJ64IhXZsrgQ5lH/vhuO2V+dcQPWfbr8i1sx7jpbBtS7SqIPaP45Hpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGc20aAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGc20aAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735898531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/0KIIi6eoKr6fRFEHWwZ+ONGdK18FGxzBk1P2Q2bBI=;
	b=jGc20aALcZVXUUf4M7y1REVevIKUslls1wEOMIbVHVfVIQCmELTCA/ZT8aw2MIPkuKFWoB
	JIVixiMTTU5gwSCZHd4Dtq71MVrKRNQCu7dLoDdZNuzg3pzgOAcP/S9DpW/yOWLDkaemlL
	/2Zn0Dtx0iGhUshPYrWAKrg69On17Bg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TvcMlvd-NQ6eilYIcthbYQ-1; Fri, 03 Jan 2025 05:02:09 -0500
X-MC-Unique: TvcMlvd-NQ6eilYIcthbYQ-1
X-Mimecast-MFC-AGG-ID: TvcMlvd-NQ6eilYIcthbYQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43619b135bcso64500185e9.1
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 02:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735898527; x=1736503327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/0KIIi6eoKr6fRFEHWwZ+ONGdK18FGxzBk1P2Q2bBI=;
        b=n8rRDRWu4wC8sxqxulgly3Kf2kR1BGWWlegotwY3pSji9xO/j5xgsWstI4Wv86bIXN
         Aes4/Jz3cuc80vtt2Tl8m8UQSjVVGjyYpHqhTsVxteU7mfwJ7CuMPmq7/SewiP9XMeXO
         ShFkOszAbejQ3H4vQ7DN8EsvX83fdkWyxiQnOMYL9PUyB2T+PyIVMXKFp5D5sT8FZyDi
         ZcFHddCBhiK6/ryO5Wy8VJWcsbMXsx4f683Gv9LXKZ8dOAVb5B57dV9ab2llxJa1STXh
         S/Rjkrs+55Bhq62JwovxqBleI3RjmVTK6xlqXhpYbDSAp0s67Wo7qtGjjIYonoOchKZ3
         qkhg==
X-Gm-Message-State: AOJu0Yykpj9qIn3RwPeFPz6JDpQsEFli9vRaoaSD+8dKGnifI6XHjTLm
	VTZUTpj4WbTs4Nl0MWd2i3JKIGevTHYz/+VLTlLQp0WBmx+S6VBP2qh6K3k5QYxdnwTFWaMPwtB
	sfR1Bf4NvWZKc4ARDaZv5pCAw1TaTOosN0Lai18Me0HKpNEAzRdyM0LUluc3nzyerFBikQu42oP
	Er3T9UBKUye68zdNIAXvV17GhYJRd8WAVyWL8meLE=
X-Gm-Gg: ASbGncsJPzk/F1ulieqhDKMGRCPfzREGocssZe/v5IkQPDpTNs/+lNZe48hUgcuL+kM
	rpYUV0fVZxOLLs1HdwJYpNzlVWBOsuTzNRFMG0xOjimjhXboCUL7PCvVq1nU1Q/KPvtonq2LPLW
	gxmF+g5XtERA4lpy8DB/oJvzTe28drIMZbM4nQwIQ6oOY3zdn4rK1VR38z3Qxasf/w9lFJ1nBza
	YdW4LMInz5ZaX5NYnEvHRdfLxBi1qymQRI87sqoX07CcVDMu25lgMRWscAJMf1IFUeBgjR7
X-Received: by 2002:a05:600c:524c:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-43668b7a1eamr327131425e9.28.1735898527606;
        Fri, 03 Jan 2025 02:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESL8ALiA78OD4+iWO5ZAXI4toPt0qJteyRbi+x4mpmFHifKRzVnON+3rOcYeDgnbmmc4R7qQ==
X-Received: by 2002:a05:600c:524c:b0:434:f3a1:b214 with SMTP id 5b1f17b1804b1-43668b7a1eamr327131155e9.28.1735898527190;
        Fri, 03 Jan 2025 02:02:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm519175535e9.1.2025.01.03.02.02.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 02:02:06 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace 2/4] ci: update Python versions
Date: Fri,  3 Jan 2025 11:02:01 +0100
Message-ID: <20250103100203.32580-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103100203.32580-1-omosnace@redhat.com>
References: <20250103100203.32580-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .github/workflows/run_tests.yml | 36 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index f8b6f146..af913d63 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -10,33 +10,33 @@ jobs:
       matrix:
         compiler: [gcc, clang]
         python-ruby-version:
-          - {python: '3.12', ruby: '3.3'}
-          - {python: '3.12', ruby: '3.3', other: 'test-flags-override'}
-          - {python: '3.12', ruby: '3.3', other: 'test-debug'}
-          - {python: '3.12', ruby: '3.3', other: 'linker-bfd'}
-          - {python: '3.12', ruby: '3.3', other: 'linker-gold'}
+          - {python: '3.13', ruby: '3.3'}
+          - {python: '3.13', ruby: '3.3', other: 'test-flags-override'}
+          - {python: '3.13', ruby: '3.3', other: 'test-debug'}
+          - {python: '3.13', ruby: '3.3', other: 'linker-bfd'}
+          - {python: '3.13', ruby: '3.3', other: 'linker-gold'}
           # Test several Python versions with the latest Ruby version
+          - {python: '3.12', ruby: '3.3'}
           - {python: '3.11', ruby: '3.3'}
           - {python: '3.10', ruby: '3.3'}
           - {python: '3.9', ruby: '3.3'}
           - {python: '3.8', ruby: '3.3'}
-          - {python: '3.7', ruby: '3.3'}
           - {python: 'pypy3.7', ruby: '3.3'}
           # Test several Ruby versions with the latest Python version
-          - {python: '3.12', ruby: '3.2'}
-          - {python: '3.12', ruby: '3.1'}
-          - {python: '3.12', ruby: '3.0'}
-          - {python: '3.12', ruby: '2.7'}
-          - {python: '3.12', ruby: '2.6'}
-          - {python: '3.12', ruby: '2.5'}
+          - {python: '3.13', ruby: '3.2'}
+          - {python: '3.13', ruby: '3.1'}
+          - {python: '3.13', ruby: '3.0'}
+          - {python: '3.13', ruby: '2.7'}
+          - {python: '3.13', ruby: '2.6'}
+          - {python: '3.13', ruby: '2.5'}
         exclude:
           - compiler: clang
-            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'linker-bfd'}
+            python-ruby-version: {python: '3.13', ruby: '3.3', other: 'linker-bfd'}
           - compiler: clang
-            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'linker-gold'}
+            python-ruby-version: {python: '3.13', ruby: '3.3', other: 'linker-gold'}
         include:
           - compiler: gcc
-            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'sanitizers'}
+            python-ruby-version: {python: '3.13', ruby: '3.3', other: 'sanitizers'}
 
     steps:
     - uses: actions/checkout@v4
@@ -70,11 +70,7 @@ jobs:
             swig \
             xmlto
 
-        pip install flake8
-
-    - name: Install Python setuptools
-      if: matrix.python-ruby-version.python == '3.12'
-      run: pip install setuptools
+        pip install flake8 setuptools
 
     - name: Install Clang
       if: ${{ matrix.compiler == 'clang' }}
-- 
2.47.1

