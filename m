Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233957;
	b=Pl6ez33E9XgWjIUkIawhxOfnY1xdAA7RPI8thvWPwSGd5wgYIWmNT8cImBIQ1s9QSz7U
	 ob4ZfnkHvCoTu0FZn9EMtS/cJwPuU36NCMvaoB2e5Pi38JGo8ZOTUQ7n2lV3331xVSE4R
	 4zOv7abLh85JiAlh9Cb+POlbCmNEkpDPbKsqTDrgcyBVoy+/h2fKuSG57WdaBDIMNJjbC
	 uNSjim8CxrEz4KtSYL0pWBFoY9etFQYmZbF5zVfK5IAObcv7kuYhrKDDyAqjjxkuJgxd1
	 lBG833Jq9R+YfTiBwi1k7VgzAbP5qgNLdw4GYXWvj5nIxwW04hIhEIAy+jDmDaaHC1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Mook2e7CukNIhdM9G0flj6H/F+LU44sBvC2L3XEUjNU=;
	b=BZRs4lnoR67hW11M27Dc2W/BVSKmqA89Pxpef/ipTqiWS36yS61Ap7WIFZETdQS+CmvK
	 sOoRxJcTHvrYU0t/pATry8eJ4LM6+uN4WsSc7O5E5ASg4EhMUBeKKyLj+L93cE4XGStSg
	 uN/DkGgBNLXcZ2YnDTQnVMobZQOQs8Zk3j86C2Nzk0fPs3MiMYZz7t0oCmsDLFGb8p6qP
	 h4DE+JTU77jWOP6eifjbw2HoSOUVoA8yVneDuLUJjqYg3/cl1Ic8qXovU9pjVX7SRVLnN
	 VISc0kdZ7HRiuV5VS2AFZ0+QXq2XSJ7guITROjTy2Apc2+pBVPBS2eJMlWD9zXeCyCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spsdEhXY;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB7F606A323
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BB7F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spsdEhXY
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365f9a04c5so11917771cf.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794233956; x=1794838756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mook2e7CukNIhdM9G0flj6H/F+LU44sBvC2L3XEUjNU=;
        b=spsdEhXYBhFxJiS2rwmgEv5/MbJvml7e6uKhpQNrhQIFGBaFGblYLVGHarQ3Gg7yC4
         Mz31ppST13g1JB9Rg8zjgim6bRRyI+Y1oJu59duXigeB/S+p23pOR2g/oaIV9hJiSUl/
         s6SRaSkXx7vzj82YT8YxjtkV4aiWx3TG4D9pcghsE4jFgAJ80b2B0YFVfgEs3oIYiVaH
         qRU8Awt0YIJ+G4AfcOY/IPJro9bNi7KArF3FNbTd45KuWJ8yrqrzQPmfq+T5sTgKlV4D
         PaHlC+9LRVSoII1gZ4EbWHXbaCPhBlhj6SHRH6hVRT5wOf6UYHQlAGtqyUhC/Lrl6qSa
         /UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233956; x=1794838756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mook2e7CukNIhdM9G0flj6H/F+LU44sBvC2L3XEUjNU=;
        b=kWuCeLYAGM2383J116qYE7oi9RbvTINBaSDQNkAx8u964qVWA26HYhFM+TLzBV7PXA
         xnBCTVWVZMkIeAYuN6lr0Bg2YiaRwPDCg3Dy+C8KlqmOpa/DeiiTyrYA76m5SvSzuGP1
         TrSC8gHNFgm3I76fpmzFLibUA1czthlnd9bzESU0cF+kFD/FhX9DKbMk/Kh94FusxPf7
         pkqF66IdSKE0iiLaPeNwAYqhl6clYXV5n9o4Pv+3xgZpeXkU0jOvFuXuQXoWvY5wOchS
         hRj6rcCZvGzMlFGpERESeqeNkmEjY/FnWH4+hfRLJAJPgjC3MKZjQHGJptkfNGVnUFMa
         p1pQ==
X-Gm-Message-State: APuU4Z9DVq2D0CbEyL3GWPgXUnWrKDqx6iIaoRW6MvKEo966I8e/3wuc
	XyWYh5X29gimmKzlRkt76Ck0IZjGAeLN9T/OPTU+W34KbYkOo/Di6k8pmUYfsHUr
X-Gm-Gg: AYBFou11fiRxDQunpaMv6OzL8eS6DpsaDDnVrAr3i3bwHWUSziyFCAtCxheKp1quFHt
	VWaGaSbfglNomTMKXYnmX6WqVoWA1MsrYmj0nwXb77wM1mGI+i+IxmllaZy9tvAq8/LkMIUyege
	wY851vx3Mn9sDMvS9oiw/zzgrjmuUJF8wOkCI1UBujkv8LYGlURO4f6ySc4MagQFs/mw2eXLXuO
	L4ySSJtKiZU5S989XaIGLVEJYnThsI0IQ+tXar5HtuGpsB0Yqg/TsFMAII09K38tgo5yvfrcvjO
	S5rSr6l7CEB4UtODOkxd70NVyngaTM/wAAVVvUYnalVVcwrHroNmLGm6sgosgUclx4Cz+bSzIIz
	iYM3DFfDVhzL9O3SOx2D6CQHHZZyQzm+XupPS31WVBoZLyMXXqLRRMqfeIQGhLQp2PFVor+/x51
	BAIOInvUu/hXrKN87Gup43vyxx6iZ7U1jhVKn0TzC/6o8VnD3QUwkqUCSrERe/1jsijY5o0KI9f
	Fe/AhVTd2CDFS068HBj1oRUiDYtdVKpQFSe6Oz7jUlQLXpvhDlm7m2R4lXgpL8rh5xeu+tEsfaq
	48GmvApcV2vFeBNZ8Srjq1XOlQ5YNDHM5zI/FlgHXhIf65P6gsvDk7YNLiZDNB92oHT2XXk+lr1
	ewYEuzF8jdzO9YND1LEirIgZzJKnop6aO5ORzHvjQdQueR3amYPBXPUh5htlXqA7WMWi2RHAuex
	CMQ1igbEqlc1jAAhJmYY5fjc4t/iHFlUC+4zXt8DWqEJSmsQ==
X-Received: by 2002:a05:622a:409:b0:536:990d:79a0 with SMTP id d75a77b69052e-552a604fa4cmr59833661cf.49.1794233955802;
        Mon, 09 Nov 2026 06:19:15 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55263e658eesm41565991cf.10.2026.11.09.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:19:15 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] python/semanage: fix permissive add with bytes module bindings
Date: Mon,  9 Nov 2026 09:19:02 -0500
Message-ID: <20261109141903.121983-1-stephen.smalley.work@gmail.com>
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

Stub the sepolicy module in test-permissive-store.py when it cannot be
imported: seobject pulls in sepolicy (and thereby setools) at module
level, but the permissive record operations exercised by the tests
never use it. Without this the new test fails in CI, whre setools is
not installed, before exercising the bindings at all.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/semanage/test-permissive-store.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/python/semanage/test-permissive-store.py b/python/semanage/test-permissive-store.py
index f8e657ee..5792ffe6 100755
--- a/python/semanage/test-permissive-store.py
+++ b/python/semanage/test-permissive-store.py
@@ -7,10 +7,22 @@
 
 import os
 import shutil
+import sys
 import tempfile
+import types
 import unittest
 
 import semanage
+
+# seobject imports sepolicy (which requires setools) at module level, but
+# the permissive record operations exercised here never use it. Provide an
+# empty placeholder when setools is not available, e.g. in CI, so that the
+# bindings themselves are still exercised.
+try:
+    import sepolicy  # noqa: F401
+except ImportError:
+    sys.modules["sepolicy"] = types.ModuleType("sepolicy")
+
 import seobject
 
 BASE_CIL = b"""
-- 
2.56.0

