Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117870;
	b=tS39RHnzrnmSGsCDWhVIgEw6r4RgzOReCEbxSeMtaU31JQC98tHwF5jLJZ1XTIsYcZyE
	 OTga1c1paHIT7o3FZjXbsSMN0vDfcGnBdSaoiIRf5tPLSm2WB4GrfYUk8NIdE4q1ZUBBC
	 Cqzml0q91xnw4O8bMf0AsOKIpjzb8qEB2uSTuX6HjpY8pqyUZcKPjMYIeGbbgbqzUF2Tv
	 /HTKNKf2kDroMsclq0geZ4m+139E80lanqPyM9X3KcHxMbl2j36yegRS6pJJ5Upio7d06
	 zfkLsaoizBFDnEh2JJu7dJJgVnux2g5kHlxqH1ex4eR5yG7b3hkaRcu8F8LDKscpMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RIXB4vJvfQJBhWz4E/799Yqzn9012YFsSNqdR1wNNl8=;
	b=hK1Np6ATk7NBAFewQ/fnPSIFYKI5gQMAI5Jg0sEOxjRW2FNHzDg1nZhlymflJQDqhGoa
	 FHdOz7FoK/dXJXJnm46oIHIktFR+64yOWqZugaldU1BMbiunFFi8JwLoJBrS2JmV6nhSk
	 COYsg8Lvikw6wAIRvAN33yHRCiP1Lbx9vWfz5K7I50t9bJ4+QzFoLLuVxzz/lhB/ZKPKS
	 knaphYzv8vQxuntB0rcI/q7zVDnfQ995hbtsCsdPg3YVxfIgLzbDl9pioMj949/qU22rM
	 je6GMXvnv6KpurAhPXzr9JOcurkRcPMzcU1KqMnVRWrzlG4utq+PYuguxG+2eajxz7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnOeTQsg;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A751606A32C
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 19:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A751606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnOeTQsg
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9495c633eb5so9582085a.1
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795117869; x=1795722669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIXB4vJvfQJBhWz4E/799Yqzn9012YFsSNqdR1wNNl8=;
        b=GnOeTQsgpjgxqZoQkPuM/z19uiqtpsAr8H1rRCMWk2X44KP4v02Jml7SGexYum3aIx
         7GaMMExsdTTNIj82KHueB+UhyTEjC6PNCQFgR0dHo5LIxVlDY+UwN4dWrrz9DQG7rn+B
         i/GPYOjAVTWGq8l7YEN9u7ov1hkRX1D94PlFHcwdB8nNaBh+dXTSCrDefm6MRPMPBuuz
         pSq5OnPBzBrIr+qB7tHmsyWErLEppKA9uRDXWQCx22J9qqqHhum2UAETmasHmhUQ91au
         7WDPzi6nquRRB3rcGirgvG11POa5aEyrhmAFrrrd+aPkh2JIHDvs+Uxl6GGBZjHnutuj
         +dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117869; x=1795722669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIXB4vJvfQJBhWz4E/799Yqzn9012YFsSNqdR1wNNl8=;
        b=wwCcC+Bk9TQZJ4SF+nVja1hQoCZZQkp7/9w+F49rHviZPmTGjwM0tVhnslJbUt44G/
         NG5o65okhnHABeJORJvwxylSqhdnslCk39mLsOI3xTFKqtkCgPRmBg8ZrwQFkp005a0n
         m5TGADAyErB/6b0DXfnnjMLOvRJamj9boS/GBglJ1OcWgrmj5S8+98CctyJHVJ+6OUIo
         42Qd0wrlT/LcM1qj9JKn9YHA5xuL1Qti6JFUFHBmcPH72HQOqxTcL0js9Wg3y7QBtB7a
         ZOX7qnv58lukjCemRnaQ5Km55Mc7lgE/SEvwUbb9ALEhknvgmDEE3iFYYPNkLuw6D+ff
         /LXA==
X-Gm-Message-State: APuU4Z81FwJuwz9gG7lrKo7MHgljpi8TCYaIhv3nwJCpzx5lg4nMg9Nb
	DPG5nCnIafBwWs3LCb9QEdYA31EtO8NgTPCL3hToXAAXIRExVC6WRWXUxVU57A==
X-Gm-Gg: AYBFou1/EcVKvWrZFhl78PB4gcWeNFZQOK7aOa+HaDBxYUf7LGb9s/BYnthjNW3G3MQ
	Edd6HGgLx4WNd+rt3bEe1jESU46JTvXkQDOMLuOUdVrosWVgdCk4bIvl5Ul/bFKJjj2YSnxme88
	SoLwv9hxN6Ai8oYxXvcey2BzkwsnnjyRwJrO6T/QI5QjzTBCryHFQQESmYzJh3uhQyJNh96AbQO
	YRkok9i3pVaGz75PFSEUQ7FsZrhFJE7Kcf3j+CxbLbMod3sBwOJGgVnwwQzhr6xliuGR2BPxsYK
	WoxFwK6wOudVFvyX9YHXTYMOas+EX2m4F4GNYa7Mxp9yZgGXvdtjNal7z3Kfs9dB0hvXNrabPaS
	UsRgoURQosTdQht/keyT36gDJzlY8MGev4ztWuMOgr2J18Mwz+K7+94UQ+y1+cnxQgVwmeZkkft
	DB6E69zzJOg99ViNk0ptAm6iWaFPF/jSxSOBeyrlYpnFFbIuvhK+/tLmm4pIL5UmcsLdvcf3YrS
	wv4mp4to0dWR/JzeDMJ785uMkuoxZK4Jye4uDJhm3T6GRi4exFSMSqckxFTipJzEyk58f5IT04o
	4b/7ttxYxnNwwh5hvaM/Rs2goG0JwCXVuLJ+9xASgcDx52bLWKADXIY/YFZrmec8jYnphN+OsHH
	P4R6dBXaoA6OhwBKk2F8YgeGMTAtaqR074RvE2DqLFLHtXUb2yt8Z44M5CFxSl2BtTpmcc1+izW
	3hrE+a4HKLq0vNm9Uudt5dePe0pbCiWO9e
X-Received: by 2002:a05:620a:1787:b0:947:1d0a:c8b4 with SMTP id af79cd13be357-949bab46a6fmr114372485a.56.1795117869267;
        Thu, 19 Nov 2026 11:51:09 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34a38bsm32547785a.13.2026.11.19.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:51:09 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] .github: bump to latest actions versions
Date: Thu, 19 Nov 2026 19:50:23 +0000
Message-ID: <20261119195022.1554-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119195022.1554-2-stephen.smalley.work@gmail.com>
References: <20261119195022.1554-2-stephen.smalley.work@gmail.com>
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

Bump to the latest versions of the
setup-python and checkout actions to
silence the Node20 deprecation warnings.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/actions/build-userspace/action.yml | 2 +-
 .github/workflows/check_format.yml         | 2 +-
 .github/workflows/run_tests.yml            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index 941c1345..46e67bd3 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -25,7 +25,7 @@ runs:
   using: composite
   steps:
     - name: Set up Python ${{ inputs.python-version }}
-      uses: actions/setup-python@v5
+      uses: actions/setup-python@v7
       with:
         python-version: ${{ inputs.python-version }}
 
diff --git a/.github/workflows/check_format.yml b/.github/workflows/check_format.yml
index be85972b..2f6a97e0 100644
--- a/.github/workflows/check_format.yml
+++ b/.github/workflows/check_format.yml
@@ -8,7 +8,7 @@ jobs:
     container:
       image: fedora:latest
     steps:
-      - uses: actions/checkout@v4
+      - uses: actions/checkout@v7
       - name: Install tools
         run: dnf install -y make clang-tools-extra
       - name: Check format
diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index b9270492..445ccd2c 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -39,7 +39,7 @@ jobs:
             python-ruby-version: {python: '3.13', ruby: '3.3', other: 'sanitizers'}
 
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v7
 
     - name: Build userspace
       uses: ./.github/actions/build-userspace
-- 
2.47.3

