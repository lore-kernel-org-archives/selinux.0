Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84C2F7EE4
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308887; cv=none; b=oLFAb1eBrov1M/fHvEsZRweqou29o4u+8myjgKXpvCKOv2uuGsziZi3ZkzuG/qpdno4/6TS3joRrLtu0sAWP8OFdD67iIb4S1C6s0hnYLh2/tGVPhmyklUhd/l1JSNV66iWBVInlHHZs6+g8hf/4iVkuoRtE5Q6HVF/FXbV750Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308887; c=relaxed/simple;
	bh=nL8vz0aFA90gaMj29S2SXHTa/pjQicflvtNgmNaLeLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UoaK4HieUcj7SbX80xbovqsT6KmH1/dSUGyzM0B2RD1+wXcKxfccKZKUs5TV757qJW2iIQY/Pw3m6teTYljZdPrzV6seBGKh/KJmZTlB1Y1217Pxo5HvRzkgwTsp6ZKRi6OtdmhHu8ENETH/LKNK1u7dzsIziK97FOw3Q3VjCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jurQ0gzl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jurQ0gzl"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8eefd4a8057so41902486d6.0
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784308885; x=1784913685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zce1oCUSgbilCM8eMQ4gHXjxb35eFJ03DswuXEd9dt8=;
        b=jurQ0gzlSQ8CNzJ5XH6K+TEm81zn3L+heWsaJqiv8EzOUxAdUF91gjAjhLcTagff7W
         VStW+/iFuNFi/vPFsWwfXqo2ykPW8m9LElHqVSHODyij3htOGVJQS59zfV9Wyr5uVw24
         EkQocQIkdDFQGw3/+fZuAtPrYu0/FiicW16AH4b9bimxVfQLu+LGFNVP0AXOcBmQIAlp
         hk7HFPht24v9aEehb1/yN1tPNvsxPD6W1iDoSWg1N+P/ITbh46prVhB2d8+ggYrFwBYT
         0DgKq2tlp0hSdh42eylHSRimCY9ZM8beZb+47Sxwd7KFckmzNDXSouelcoifnd58HiWv
         J0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784308885; x=1784913685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zce1oCUSgbilCM8eMQ4gHXjxb35eFJ03DswuXEd9dt8=;
        b=TwVl18CMuSoXOefakOOkSfsFUBE52pPqvxnCo5iCuesQK9mUZqDuHYy0zAOYnRqVuf
         hmMDfShUh/1z6JQOw0n2AJVPduVcmgPEI2Rl00XR4mXgBkZ4syJq6xyVxzMhFkH4ayw9
         k1dmFwAzqiZOh7t7YLb6airi/dtzTLFJV2QNnER6OO8JM4ugSLD6tnaOXufkFfCwS5/1
         jK1VbSo2pwLfMZ9S+o7nyJlciMCqxBrTacJCAxjo7OfDaCkzZecDcf6BT9WirBQqqezV
         /SSBI7ClbEBFhojPyhBuADFyvnVJ2S4a9NbLNPuWRVaRr1BEMkTu6cMhLxPUXKHkdJV0
         Bv5g==
X-Gm-Message-State: AOJu0YyUvtzajIUlfXARx+L1+cNisZrQKRGw4U7csV4KoEwbhayhcQJH
	8XJpA1Didl1X0xptgO8ivG0RT7d/D1Shnq7KbQPSS+6XfnYJ3AVkCdQDl6oU2w==
X-Gm-Gg: AfdE7cnT/KQLJKPuQZJ7W0L/WTDvhM/akn12wq/BDlFOU9D0ALh+3qX5LpKzvgZpWN/
	7heGhx4zXPeT4PoDCxaq75MTCY4dR5N7sv8eCcuz+Zi/FdZCG0Z8nozzhQffB1xAi8D+zuwcFyW
	BXphDdpvmCHeLRRDQhfCO6VsLZde6AMlRdT6OHZ/n8cJqZAiS5Csop4zoy3Mr8QsORwTtlZg8kn
	lwOc4+B96qn4yEX97+5A5tYhX/YMcuP6Rg23BkQcN19Q/ahrR7MEJAvbrdv1LAjEakvslCCEphQ
	eLaZ344LakO3aZMTaDn3aMr2kUVxY4Ay4JuzA/y5n6mh2ZmBKXfFrUWHa2bLwY2dqLQvy/CWIdL
	Z1U6Fs1HupxCN0pKXLGew2w/Bko8ef86T6bvfwxQ885a2EEHlbWzRSwZtJHV1o1G20XgqcNyKeC
	p246gVdO31FVf4OA3YU3Cm5mDC6QmvMiUecmUTv1LZ39YT0PBR3X+iV3fJ2EM1dvMParVrVa9lK
	XquZg==
X-Received: by 2002:a05:6214:1255:b0:8fd:6dc5:94b with SMTP id 6a1803df08f44-907784dd19emr41649286d6.64.1784308884841;
        Fri, 17 Jul 2026 10:21:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077856002esm22206926d6.11.2026.07.17.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:21:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/sepolicy: generate: drop or merge symbol table overwrites
Date: Fri, 17 Jul 2026 13:21:09 -0400
Message-ID: <20260717172110.19156-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

self.symbols["openlog"] is assigned three times with only the last
one (set_use_syslog) surviving. Drop the first two since they
do not appear to be relevant to logging.

self.symbols["pam_"] is assigned twice so combine the two definitions
so that a PAM-linked binary sets both use_pam and use_audit.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolicy/sepolicy/generate.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 0edda54a..f88d6852 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -212,8 +212,6 @@ class policy:
             print("Can not get port types", e)
 
         self.symbols = {}
-        self.symbols["openlog"] = "set_use_kerberos(True)"
-        self.symbols["openlog"] = "set_use_kerb_rcache(True)"
         self.symbols["openlog"] = "set_use_syslog(True)"
         self.symbols["gethostby"] = "set_use_resolve(True)"
         self.symbols["getaddrinfo"] = "set_use_resolve(True)"
@@ -226,8 +224,7 @@ class policy:
         self.symbols["getpwnam"] = "set_use_uid(True)"
         self.symbols["getpwuid"] = "set_use_uid(True)"
         self.symbols["dbus_"] = "set_use_dbus(True)"
-        self.symbols["pam_"] = "set_use_pam(True)"
-        self.symbols["pam_"] = "set_use_audit(True)"
+        self.symbols["pam_"] = "set_use_pam(True);set_use_audit(True)"
         self.symbols["fork"] = "add_process('fork')"
         self.symbols["transition"] = "add_process('transition')"
         self.symbols["sigchld"] = "add_process('sigchld')"
-- 
2.55.0

