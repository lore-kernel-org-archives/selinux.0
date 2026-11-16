Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856471;
	b=N2i0XYPzLH98iu00HBW9IWsd0sIDb3F61Wd4vwwWWr+5l56O4kwhxDbgKQkiJQB6g2VO
	 0aFgdp7YrlC7+U1KUHOoJ+TXqn4D2JuXGTwVGP4iB2z06K+8XvNLirtMOB0T5J7+y562Q
	 P5ltQRflg8EjM1UHZbmeB2k3gSeX9DJJwNV4wsXhsPpmRbgiq+siCpsN0sIi8ygIdPhxR
	 aiyx6vaI0eflCCuGKwC3dHbhlMFNQLVBAt7OKiXyy3OapD4QZZElFbR8ahq5no9mHNv9V
	 Tot3jFS3xmBgcZwUKWf9q7GKVwE3ha2UYB8b6tEFyGc8ptQp9Zm1cJsii1h+FvSgYKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AyviebTlidN/fRVPA9QzC5rktuAuojHstR/52uUgrTo=;
	b=t5dK3Vbq8rpKtcGzNfoG64bS69INmyWuTIZ+NG3bZixx4DwrCQSgEeCnub/2LYBsF5kI
	 5gwQ69me/YiZqI5CWVUxLE5aO0edbraAC22IJ2Ma6h6uesE3xMgArt8ljDASL5FBd3jgU
	 tt4PBTv3UCq7ZFiq6DiZw/gteDxbdTXQav4DYiAy+ggZKl4bvONKTNQe+rQq/a71vANyM
	 78VKQ0nr1OfoxH4SL2ZKU84NAxOJcRntwqBvQ6arglPIs5m6PS5EPgxwAt9vf2xg78fzH
	 Z6z4jltNZ/wlT3uwctrt10Uc1cQ62VgaBPLbiBzl9D7/jj7iQLgctxFzwuIcGSa95TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0LErZUH;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D045606A323
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 19:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D045606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0LErZUH
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f22a8515eso407159685a.2
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794856468; x=1795461268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AyviebTlidN/fRVPA9QzC5rktuAuojHstR/52uUgrTo=;
        b=f0LErZUHko02o9ZyZsAQcqVfcB6PfycUyt3nJDTfucwX0lonQlTTqAiCIRnPFrKrS1
         iuU0tliec3LDJ2cBEX50JXyDnBPrqI2LytqVeUDGVZbBbh3cpksEWcppq7AqjBChb07+
         Gp5olREhPMRCHdJkjdNgH6CW7Hvy0+U9i9rs1qd95Fd1FyYNNqruMPjjjAbmcPjIQclq
         hoHzZhPMXkeoNbqL0BUGQaVybVYDBtVzGQrAO8i67c/aQkfTM45jZaOVli4PdEFnsfRQ
         sZBYFsiDasFHeWgXy5bn3P4GZbSxNdakUJ0sjJeIRmY1IsVaYQ5cXMR4eww/cCoAtvlT
         1Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856468; x=1795461268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AyviebTlidN/fRVPA9QzC5rktuAuojHstR/52uUgrTo=;
        b=sXCaSxc5ZACMC9oNJtRFzzb3Eii6L+CXQJLO2qCWqoe8ywqgCswcNQAjdAe+DDbtrM
         SEZISXs1In3QdE+eZJriklsu+G0z5Aj5WGOdAAvsBR+oAsKm63We/YTJXMtL1APMaW9E
         nS4J1g3OSof1OXx6BiAmgvDaJRl6gf5h0VZPlZxHKCJP9BgCGGSv83yPVao2Q7oASDGp
         xspIyGcvK0fmImEHBAJDJ8JyNOFq3y+mbL2T35n/qSk9nx/P/jSrkqsITtD0IjflbxaM
         Xv6yCsR9GR/7BQbcN+h35Fx2mESbFVef1sNJk9+V0jpRw9tVwvLX+/YIFFRdY6nj4HFg
         F64A==
X-Gm-Message-State: APuU4Z+9Jc9j6Uiz8phn/6gNzwoYFcP65rZ4cH+XnIdkx50cmJC2h9QC
	ud/2ps1wCuWE+JWxePBYrgL9jLd4fzDeDuugS/y3s8iVXIfsM0+mT1eBpm/GpKac
X-Gm-Gg: AYBFou1XIxloAcRbZ/oZI43ul6sZxNob9QKWSpkKaFqpwnzGoMW4K7grC5n0lQ47Cjg
	sgbtxu9hIGEmR+Njxc2pQjIRNpHwE+c9N/lcEJrx74WDGY/H+rYu0Fv+B2wPJk7U+ChgPnGBXaW
	xmPpoRRNesbpz8grBiFfhzvuLcjT9ObrZQZAzM02d6aCzutmF1dOq4vYYKzRXpGWT0z8i7ctCQQ
	dKqvixVJNj7214NPnfocDxi5iC/OdHuuJY5XFXBMj4+MEUl8KbL4XF8FXu9klTRmDBjnP7JBADQ
	5O5Fjs0bC7UiR64E4XmCAJRI52lGTBaYzoE6+jQVR66eTqBnUI3cPDbZLrryrmQ7OqZc0GLYJxH
	d5k4wmeC67rBGuPFLyMXBSUrRzopWRnb/J/3io0T694ZUayiyg3PEGP/sl2soh7W9H/L9kYk7Ke
	5VJdAGvQVMw0oGkqmD43qs4g7VkyPpDVn6HqFKQwtHblvJxlUM+WGcfwemx8VsOWk1bd/Hj+L90
	/GQeRTM9kdjcleDq8M547sqgk+jEBFrOZyhx/7d9O82eZpTsTd0tv2VD8YudJuda7dFiqrdz0qe
	WQpa2WDnYwHcXsiJ61jKHjk6e3TwGgAFGu3tvWikbxThhjjdZ2W95jwpkb8t0AS30uyb4RfESho
	MoI0LIHEVHi6THIUmEYVA/Zp4NzEYAqZDwK8oramlbywzk/zcxWarG/K4SBxcNfrUHrrxMNLBip
	CH0f5Y44hpnmRSd7Lrqvf8HXBavu9cpHy31ljxzqFZxoxyJmYid/4=
X-Received: by 2002:a05:620a:400e:b0:93f:3bb5:5454 with SMTP id af79cd13be357-9494bbb2205mr1969638385a.14.1794856468518;
        Mon, 16 Nov 2026 11:14:28 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c831b7dsm911815985a.20.2026.11.16.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:14:28 -0800 (PST)
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
Subject: [PATCH oss-scanner] projects/selinux: fix running all the tests
Date: Mon, 16 Nov 2026 14:14:07 -0500
Message-ID: <20261116191406.209164-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The original Dockerfile and instructions for exercising the tests
weren't quite adequate to the task. Amend them to ensure all required
dependencies are in place, including creation and use of a non-root
user for running the tests and using the selinux repo's existing
scripts/env_use_destdir to ensure the environment is set up properly
to use the freshly built libraries rather than any distro-provided
ones. With this, ./tools/check selinux ran all the tests successfully
for me.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 projects/selinux/Dockerfile      | 11 +++++++++--
 projects/selinux/threat_model.md |  7 ++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/projects/selinux/Dockerfile b/projects/selinux/Dockerfile
index b81a35e..5a0bc64 100644
--- a/projects/selinux/Dockerfile
+++ b/projects/selinux/Dockerfile
@@ -24,13 +24,20 @@ RUN apt-get update && apt-get install -y --no-install-recommends \
 	python3-pip \
 	python3-setuptools \
 	python3-wheel \
+	selinux-policy-dev \
 	&& rm -rf /var/lib/apt/lists/*
 
 # scanner contract: the checkout lives inside the image, at /src
 COPY . /src
 WORKDIR /src
 
+# Build and install everything.
 RUN make -k DEBUG=1 LSPP_PRIV=y DESTDIR=/src/build install install-pywrap
 
-# Smoke-test
-RUN make -k DESTDIR=/src/build -C libsepol test
+# Run tests as an unprivileged user, matching upstream CI: several test
+# expectations assert DAC mode-bit semantics that do not hold for uid 0.
+RUN useradd -m scanner && chown -R scanner:scanner /src
+USER scanner
+
+# Run the tests once
+RUN DESTDIR=/src/build ./scripts/env_use_destdir make -k test
diff --git a/projects/selinux/threat_model.md b/projects/selinux/threat_model.md
index f049921..b1deb86 100644
--- a/projects/selinux/threat_model.md
+++ b/projects/selinux/threat_model.md
@@ -108,7 +108,12 @@ Last review any remaining components e.g. semodule-utils.
 
 .github/actions/build-userspace/action.yml is the GitHub action for
 building the code, and .github/workflows/run_tests.yml is the workflow
-for running the tests. The TL;DR version is 'make DESTDIR=/src/build test'.
+for running the tests. The TL;DR version is 'DESTDIR=/src/build
+./scripts/env_use_destdir make test'. env_use_destdir is required so
+that the tests run against the freshly built libraries rather than the
+distribution-provided ones; the tests must also run as an unprivileged
+user, since several test expectations (e.g. DAC permission denials) do
+not hold for uid 0.
 
 FUZZING.md contains instructions for fuzzing selected components;
 oss-fuzz is used to regularly run the fuzzers.
-- 
2.56.0

