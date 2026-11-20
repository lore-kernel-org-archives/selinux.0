Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193423;
	b=RUJpAxTU7kLw+rfCZBSrLXBzUNvRJa3+WgK5mmqbPntyiucjO5n6mmmRIfISNrE4/fo6
	 a06cDk/zrhuhAUgH+oA7OMkcdI+QmfYVPyxYZvcQ1Ydd6v/PzTmzvMOYHWVLP2UGA7V8c
	 6J5BJ4rnMim/30NG240Yq1znE2ZKH3fRWBHE/2gBjZtNJTWeDOcIE9InbyceEMF6Nie5k
	 +g7osu4cLO3RXzS20V0PWVb0Z2l+VLNB43KlIE0kx7lIzJTqBa/z47R4w49za/jhcZAC+
	 ugqvpKmKERfElt92iF08V2KbHEzkTjBJyzfNwiFpflcYFyR2Hz94Y8GfTki6hbZQzdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2HVtUtgQHd58tPHpfn4egUI1kNipnzd/Y8meZOZIC08=;
	b=n1sop6imZ+hAk9jJU6wxWla4uVTJiENy7yMkpU0o1juLxONosgw9yWl6UX+OuqjjqsTb
	 OFqs3AMHH+yhUgwqQ0JtxYJXB0VLIG/YcbJeK2e/TB3PCHtjtWpqrcOPOPyeVOInKZ1MP
	 DoOZ02c1Bl0TPG3RB96Nc874l+bhRzDjQQGxnYmF6AQ32OCC/2aai0VuQq+nxY6aFczJF
	 iACBPeWIJkVQByjmUk5BW9FDEjHkdB4IvfJ43vlXztKjiAeCmUJ/lpzPGvX4ymu71Ej3o
	 qx2fyRoCVjmHDRcfYypq4BEgEeTnnwKv061k/MQPQypWsIf7hqzIQri3hQr2kwf7j6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+KnLZOZ;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F7606A334
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 16:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873F7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+KnLZOZ
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f3c616c84so92984985a.1
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 08:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193422; x=1795798222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HVtUtgQHd58tPHpfn4egUI1kNipnzd/Y8meZOZIC08=;
        b=n+KnLZOZioqjA/+z/nYGT3hq7dVrF3CXEjOqH8ywsO3XWSONRBXu4yPM9jRMbyOQbo
         ITAOgwkEl+99jH1TtbQ9gTNq1RgxrnEhbNV4DuGQOqELn3Qs09HsG/Mp5FHrLVVCEhDH
         z7dyiymZ1bFz7sfWjBtqEknfRGpoV0Y3oxSXQ6XeA3wr8Li+qEdVMOnkEKeSiAFTV+RH
         uHWtpZ50UMqZWxtCBfeBIef1XWoVViNKPiKIoMLxyzNxwDvLvvamtObVJhdGOWBDlq5p
         ZCk0f8Owd1do6nLODJUu/28aJQ1cCfI2GcNTw4WZqlJj2csISr4jao89DHdgNEYe9UrK
         vqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193422; x=1795798222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HVtUtgQHd58tPHpfn4egUI1kNipnzd/Y8meZOZIC08=;
        b=kKgfzKPPHuw1P8tMnU4RL+h7MwfrankAkn4wIlQ+okPSAM3IyFTWU3lb4msxBj/mJx
         xcnrJ+UJHRiuaA3+hCAVcW7yeMh+VxLr5LLKimFY/djo7Zhhl82/JZWFhxQeCqlIPjKl
         gCOhkk7w45DdyOSUk+2/HasYzPFGF1BMjHn+9BrKM7jWlUMMrbAZCA4WGaP6FJ6BJ+4/
         FYFSBba6BTa+oJp5x65u7DKUQGz7kEk/oJ629ODVLrYLz9BhfaRB70rs164Sr0Xl7INM
         kmFpeOZz4EqF3rgFdKWTrpW9lsw8rSrN18F1o2Kd2M9mKf/i6dXI5V7FzdpbfXmIbWaL
         GlZw==
X-Gm-Message-State: APuU4Z93iGVaCLj23eIs8tanq9lNy9MFxExhgwFwFjne3D24X8bjSMcP
	sCodSZ6OtERnqs1eXtoJABMMFrqJTSS8ZtvtyYN3QfdP3eqI7NVWQOIxo9Jwbysh
X-Gm-Gg: AYBFou1quyzjqtbe14V2Fqf81R0lIitnrWGiEZh9H9qAdkfG+U8/fF9TMXJFpoUWPw6
	3t1eiuR0NkdBXoHBnL/8q/XzN0WBeUg4RRoX4YmAj67JajRn+hMXRDx+de4A/WDCm9XV7lSPh8E
	XYgr4E0bIDcJTANiuuvHIW64BHCMSdUXo3gkjZx1uSsPtMCiSDcoZPkImGQ90fc/G4Kz9DfA+fK
	eO5xkh+dRAfMrLGrLYxPK/KjRNI2zg5ZucZ1giFnNF5HPAgqk8eSp170zifxAS6nOvbuOrCUxIU
	4m0TVrL9RXeJGgX8pbSAQOfJQHtP8uAkKCm2m7wlpVooAVjQ5kyZ4uwzhDoz+DtuAPDd4gZxVE1
	V1q2O0eOv+madr2ZeW4FNTBAzU5eIe8z+Xhy6kIQnIOwBc6KWHoBy32kitGC6FCvnRfXMdqb6fF
	KZbdh9IY7Gvrv1pjPad4AzGGRKJAiGh/HTVHSKznIVZOfr7+KuN4YJn6JZTYU0vFvEREdAZB5d3
	AdutJT60WlUbYrTrzut0VUdW3lqDqfjtR409lp1CqXQH0GmzdkyNptIFkbXrwr6yf75qaiY84m/
	QMiZVZ8P+5J0UaDvSnCwVFBrHXabnfDsQpgo8+481ECgSECMAC8XfHXLUp1mJR3qNT5HyDQeAVc
	90FuUlT3wmaxp3vVCujumdt3iquBKcRGb369EosKO2XJ0jjsovVp8oVjfQCeuehW1ymF+FQuCVO
	qcxcZflb4O0H9dCRiEFTAoSxXpqaSh11mywXEZFziKoA/MCQ==
X-Received: by 2002:a05:620a:4492:b0:949:7fb4:2712 with SMTP id af79cd13be357-949bab123c2mr585274085a.66.1795193422233;
        Fri, 20 Nov 2026 08:50:22 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb031617sm229256785a.1.2026.11.20.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:50:21 -0800 (PST)
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
Subject: [PATCH] libsepol/tests: clear loader environment without env -i
Date: Fri, 20 Nov 2026 11:50:05 -0500
Message-ID: <20261120165005.37638-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The test-downgrade mkdir was run under env -i so that a host mkdir
linked against libselinux does not abort under Asan when
LD_LIBRARY_PATH points at the freshly built, instrumented
libselinux. On hosts where coreutils is a single multi-call binary
linked against libselinux (e.g. Ubuntu 26.04), env itself now loads
the instrumented libselinux and fails the same way before it can clear
the environment for mkdir.

Clear LD_LIBRARY_PATH and LD_PRELOAD with shell assignments on the
mkdir command instead; the shell links against neither. Drop the
now-unused ENV variable.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/tests/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index a47b452d..45e094ce 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -1,4 +1,3 @@
-ENV ?= env
 M4 ?= m4 -E -E
 MKDIR ?= mkdir
 EXE ?= libsepol-tests
@@ -61,14 +60,19 @@ clean:
 	rm -f $(policies)
 	rm -f policies/test-downgrade/policy.hi policies/test-downgrade/policy.lo
 
-# mkdir is run in a clean environment created by env -i to avoid failing under ASan with:
+# mkdir is run with the dynamic loader environment variables cleared to avoid
+# failing under ASan with:
 #
 #   ASan runtime does not come first in initial library list;
 #   you should either link runtime to your application or manually preload it with LD_PRELOAD
 #
-# when the source code is built with ASan
+# when the just-built, instrumented libselinux is in LD_LIBRARY_PATH and the
+# host mkdir links against libselinux. Shell assignments are used instead of
+# env -i because env may itself link against libselinux (e.g. single-binary
+# coreutils implementations) and then fails the same way before it can clear
+# the environment.
 test: $(EXE) $(policies) test-conditional-count
-	$(ENV) -i $(MKDIR) -p policies/test-downgrade
+	LD_LIBRARY_PATH= LD_PRELOAD= $(MKDIR) -p policies/test-downgrade
 	../../checkpolicy/checkpolicy -M policies/test-cond/refpolicy-base.conf -o policies/test-downgrade/policy.hi	
 	./$(EXE)
 
-- 
2.56.1

