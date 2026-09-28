Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AF34D5994
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618329; cv=none; b=nptuQ+pWDbtwMd/Au5jWk4MVq6I72vkA4co0mJ0MOgF5G6tna3nhrub6DDS7UQBFQc3V3l62c7vMezgZMyAwohyaPcraZc+xwO8x0yPos0/jdtuHgEO87s6kNko8isz2RojATEgYs3KJkZlSUCVbiRF3g5WVjvIavAYZsdtkRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618329; c=relaxed/simple;
	bh=QXueCtxR2MPKvUkKkGoliKd821jNxrSf7zeDfYddBXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFoAIoGQDbUvvU5/oMS/1uk9D/omBcOb91DR4m5QrKm8A7OP+CGNXcMyiiHUi16Sc4UhEFx69m31Gla9Do3oM6QMj0YHKooQgJd9mEr4C/MNYW6bppQVGoR2NwyM6I2XEM6S17Xax+81c8SZlkAgvE5PrRo4sxTM+oc9yEb8XtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpN4MU7B; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpN4MU7B"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so41352361cf.3
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618327; x=1791223127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=85SL2bnfNlviLE+vw8NYbxgLCoP4pGSgeiC99yyz9KY=;
        b=SpN4MU7BHWrZxvCvoMdS+GFt2gtfDv1RYvqTfmpb6NCGtXweZFz4Ng/mhngvDuEQWf
         mEud4ujdB2sAj6wnHodKtAnPowisWqUBR68YQiJborEtO35mHMLheu8vOoRs7VNcX2GS
         c42Vs+1COuBWDWhQ2NWZXJKPoP4jVHcc+HAH2gWUIrT5oIrex85XgQCsOnafbv8XQ23h
         GCEZQLAPJvKgzE9+BdaaBt7BdiIHTqEeu6a2mzVwPgdWBX7h7F1X5tY4w2UTARBEH3jQ
         VJlakR+GcLxkH7mqNgpqacwLi/5XCR5SroE2RodWE9ehe2WyeAqsJVPpogqmr+Td4nIB
         N76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618327; x=1791223127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=85SL2bnfNlviLE+vw8NYbxgLCoP4pGSgeiC99yyz9KY=;
        b=mp6hx9MpyTSuSctlPV8fDIqSD6wTr9Ua1MyI6PEvjSP27NZ5mDoB+QpU6hzpT6ZguH
         1xeCBYiC5ZTTcn9U8Vw9VLn1EsHNh0By0JYb//COpWPvUerglmvAeEU4iK4osBnuCoVW
         HvF/TBmIHA7fwsgtDoF4H3n8u3gx5TlOSLB6GI5hWDV/gUa6ksTlbbH/bTXHrKAZTmyX
         Aaf+SE2FEZrWL5WF8R3yvwSqxvoubjjp7vZpvcicgQtMtUqbO0ZZiomkO1V5HPI4ggyL
         Idb0q7eyAA/m8Z4SoUw6WdIQgHn3x7Y9lESDa3eZoDozriMe63uTo9Jsl5pHitDK6BtU
         7nlQ==
X-Gm-Message-State: AFuF++kRBeCn2SGcry5tagNLPhJ0GNq3T8OWTtufsmsxgs+PTF1HBWlt
	Oe2pYDiKT05NkgAEOvQmmA1MNUHho7EKK+8YOrfjfq2jIktOzsW/I5g9b2nhig==
X-Gm-Gg: AYBFou05erU6WF4yfBpoRfvmBV2wuawV9wWcprrR3e//JtzTZ/YCCiNOuehsG6XliEj
	Y54QRPIqlKRyOyuwn7DK9ArjjQwKzrRHjiltDCJUALJWHXIrpN/viGZ3EebWenKOGsP+g2KKCXe
	v8YhBgvJ83wVA8bgeCd/qJm1jDWV78iEcQKsRxYDtaazdu6Ue5yHFBdioCgHLa6glvSzVployx+
	8EfPLbAqe56bjS16WOTN20dUadYGC7K+UQJUyRzXVG6/mFUghX0IGBtUnNqquiRnl9LDoPvE6Hi
	0eSu7AhcsVr5CzwuUjaJwxrV6DX6DA5uFqRQTLoigjcy/vVQ8HSnjeDZ8dJZII8aH4kftLo/kkp
	3ENgiIVked9GRIbQ//mnYCQh3lRbOAy7df9Pb6bl6ZwJF4lI1qInkqxfiinPgz7jNNPSqMuBYEo
	+fouCOXiIC9TA3l82mEw+J16VDj1XDgyAQKwOKhynMDjnnuUOqr/XatGyKAoTXe9s6hRkK6gBlk
	8/pvVMtkxfC0QB6TrYsDzumeyX8t0kJYtOQj2g1SSU2Zg2Pex6h93D8vW0gPzc4ueU/Wg88bWQ=
X-Received: by 2002:a05:622a:c07:b0:533:39bc:efec with SMTP id d75a77b69052e-53339bcf3b3mr107923491cf.2.1790618326915;
        Mon, 28 Sep 2026 10:58:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322422063sm67366331cf.28.2026.09.28.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:58:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] gui/statusPage.py: also enumerate policy types under /usr/lib/selinux
Date: Mon, 28 Sep 2026 13:58:30 -0400
Message-ID: <20260928175830.78464-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928175830.78464-1-stephen.smalley.work@gmail.com>
References: <20260928175830.78464-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_selinux_config() populates the "SELinux Type" dropdown by listing
/etc/selinux/*/policy/. On a stateless install where the shipped
policies live under /usr/lib/selinux/ this yields an empty list even
though the running policy was found there.

Walk each configuration root in turn and de-duplicate by name so an
/etc override of a vendor policy is listed once. Sort the entries so
the menu order is stable, and skip a root that does not exist rather
than raising. write_selinux_config() continues to write via
selinux_path() (i.e. to /etc/selinux/config in the writable
configuration root).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 gui/statusPage.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/gui/statusPage.py b/gui/statusPage.py
index 832849e6..82b3490c 100644
--- a/gui/statusPage.py
+++ b/gui/statusPage.py
@@ -30,6 +30,10 @@ DISABLED = -1
 modearray = ("disabled", "permissive", "enforcing")
 
 SELINUXDIR = "/etc/selinux/"
+# Fallback configuration roots searched (in order) for installed policy
+# types when populating the type menu. Writes always go to SELINUXDIR
+# via selinux_path().
+SELINUX_CONFDIRS = (SELINUXDIR, "/usr/lib/selinux/")
 RELABELFILE = "/.autorelabel"
 
 ##
@@ -195,13 +199,20 @@ class statusPage:
         n = 0
         current = n
 
-        for i in os.listdir(SELINUXDIR):
-            if os.path.isdir(SELINUXDIR + i) and os.path.isdir(SELINUXDIR + i + "/policy"):
-                self.types.append(i)
-                self.selinuxTypeOptionMenu.append_text(i)
-                if i == self.initialtype:
-                    current = n
-                n = n + 1
+        for confdir in SELINUX_CONFDIRS:
+            try:
+                entries = sorted(os.listdir(confdir))
+            except OSError:
+                continue
+            for i in entries:
+                if i in self.types:
+                    continue
+                if os.path.isdir(confdir + i + "/policy"):
+                    self.types.append(i)
+                    self.selinuxTypeOptionMenu.append_text(i)
+                    if i == self.initialtype:
+                        current = n
+                    n = n + 1
         self.selinuxTypeOptionMenu.set_active(current)
         self.typeHistory = current
 
-- 
2.55.0

