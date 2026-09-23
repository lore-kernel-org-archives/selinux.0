Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805A55408C
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182391; cv=none; b=GFoA5GlwFUDtS6Mt37/9OGKsvn0UUINu+OIMm2mX7rVjOGg9eMWl7Po7b+LJUUxt+8YmJOqr4PelNqT/zz/SD0HY0jwRaxuISL5yEsdE+VghS0DoxetKo5zKJTotJppptRTtznBeRla4aB3C7wMeBwBugT4slbyFSWOqEfE2zng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182391; c=relaxed/simple;
	bh=x9Dxe9o04rrJ4bAp4/AdZoLW70MT5cpM1JH/JE5hgXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9Z/LZ/Poka2jxmbzLg1XV+XZ6TI5dw51befDk/w6SSLhiP/Fw/NqEgDAqxExjNx61HappHJTWFS+k4bfQhwMAPO1HcFtAoXQPdSGWhLBLAxpSb16eHsYgh/eqJsKtMv7OEMdRTRVjsxlqBKWHQnG3LtbMS+sSzXOUt05eR1LNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+ATMxaV; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+ATMxaV"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91059280d58so7975036d6.1
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182388; x=1790787188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bwngqkqKYnylCkPxApbCkkOUXHtVsJtVqbj+QPwUunI=;
        b=C+ATMxaVPWKSWnRqU+wbff3vUJklEVPhXF5f69xQWFeG0oNQdtuWEVTXjUOuheoLJm
         QGJUJA5fOs7sTjxM9/g5YBrpk5iJOXtnXJeo/7M1Gf15EZU+6OYdo/n5eONZYZPAOCIZ
         5NAE+IQJd2SNxKgFAg35ZqmWysANP1PxOhoURfxQ8QPo6awEj8grAJhaHqXrohNWoKqL
         5SPsjzlxVoIrGfS4HNORiekuc69v0fWDUgIJGcZBQQS2dU+RNEbU95Kcvit5UuAzwENC
         Y4MBQheVtaPrb0v6t92101dPMpf5/g5Tce0l57zxPdu6qDDl5clPGKX38vwQ7Wmtd64O
         JD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182388; x=1790787188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwngqkqKYnylCkPxApbCkkOUXHtVsJtVqbj+QPwUunI=;
        b=jEy/SCEOfEXhpO7aJfc/e38pzMZayvcn3fBqZ+xFhCEOew56CcMYrZmfpUrRZbruUf
         SKgkLMB09YhjgUNguomGyI1Ij3phL3ihFU8hiO4aRGONFLPQ/tM+Q/f4z5vISliBOZey
         0OnMmQmvLNSVPuCVOMJDiSPKtnkKaNehIQUK2rO79uT4P7COa5wU0coe/xBI9+fGKsEh
         QiNcovyj7XScWDhdqXgJVSLp5FnnapBv+CeMVZnJ0xr2uKR04t6/QbD2Ub6UIzXkEw6b
         o6FG28/iMXE3d6LsuJ2DLo0YLS1nfn2nCvhwS0x2QcwNjub5mn28HuM9LRLLKlS//Qo9
         6ltw==
X-Gm-Message-State: AFuF++kqF7MRyGgprlIPraN1wRa0ZW6W0FwdVmdjWvlQrAhPoQVkPYlF
	xmD+6MN+p4JUxCftNv6EfAcVbmnykWNC4ZFxGez6Xz+f3D83ZdOwiI/9KfJ23g==
X-Gm-Gg: AYBFou21tuf8h4W5iM72EqvR9ki2tB8XjHl7Mbd5w7i3SXLFbFjnKIhxuuC83ypE5Qa
	H1JzCaYXlym28gxv/bRxCGy3nwMp28AvXOnNEuvOjFgKrNhAi622jhoEXKeM4qr5kg0lrLmZr8I
	GlJDAbROT24N5jC4MIh6LvcFzBr8px1wNL6pxdJESQeTU0Eig4fCypng1zUS2+4VRPnDkljD+rn
	XI87cu0LYnE738x2c9nlMhCsqvbjiUAHa7Q/M27eGFvJHN4Hh/hMj+Bl2uhHtsSh1uPtAcFEVV8
	5DR5nMMucYsWU3lGg/Igc84nbWdWYLDix8S1NbunWWPMPzwZYQluAlBm4YgcR9jWmdvovuPJ1+H
	B9IX9aeD6OJR79ph5qXh3gwp+EaitCKp8qF28x3vSE4e1uOgs0rGm8KkcFU3pl0PGkVVatNZKHM
	Gh/6uklQKSthNSiIhaatWi4airxE5ovzTLM1x36w/Vp07OVjdfZoRE0yyGmSOgULK1fObaxb2gD
	O9oeP6VYSULQsCwtmORk0eD37RpE6VDKOteZagDbKu67K78OfBWBZTm2ad6+WTwroMf6bTKj5M=
X-Received: by 2002:ad4:5cac:0:b0:912:2d72:c08 with SMTP id 6a1803df08f44-9140c3305ffmr50020766d6.13.1790182387633;
        Wed, 23 Sep 2026 09:53:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4116b9sm24180886d6.20.2026.09.23.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:53:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] SECURITY.md: update to reflect our current disclosure practice
Date: Wed, 23 Sep 2026 12:52:48 -0400
Message-ID: <20260923165248.56940-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upstream SELinux project has never posted security advisories to
the oss-security or distros mailing lists. Historically this was
handled by the distribution security teams. With the recent enabling
of GitHub security advisories for the selinux userspace project, we
have started publishing security advisories via GitHub and on the
selinux mailing list but are still not posting to oss-security or
distros. Update the SECURITY.md file to reflect this. Others remain
free to forward advisories we release to those mailing lists if
desired.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 SECURITY.md | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/SECURITY.md b/SECURITY.md
index 1f255c81..8d690eee 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -61,15 +61,6 @@ and responsibly disclosed. If a CVE, or other tag, has been assigned to the
 problem, the GitHub issue title should include the vulnerability tag once the
 problem has been disclosed.
 
-### Public Disclosure
-
-Whenever possible, responsible reporting and patching practices should be
-followed, including notification to the linux-distros and oss-security mailing
-lists.
-
-* https://oss-security.openwall.org/wiki/mailing-lists/distros
-* https://oss-security.openwall.org/wiki/mailing-lists/oss-security
-
 ### Maintainer Process
 
 This is the process maintainers will follow upon receiving a security notification.
@@ -91,4 +82,4 @@ This is the process maintainers will follow upon receiving a security notificati
    period up to 90 days if the complexity of the issue requires it or if
    severity of the issue requires coordinated rollout amongst distros.
 6. Public disclosure will involve pushing the fix to the public repo and
-   publishing the security advisory on Github and to the mailing list.
+   publishing the security advisory on Github and to the selinux mailing list.
-- 
2.55.0

