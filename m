Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6693361963
	for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380843; cv=none; b=k0tUY4JXkPVCdiiFLnVQ7REqQjIaSp/UAb5zCSyJ+zuzZAKtxiuXNUMqE0oqg0j9APWmvxX8vCITBFUrcTiaQ014K49y32I4Ba521LFNiYmdVqAJj0PeBTImecDtBb+CbFiqbvvyrA9CirWtH9AML5CgOZDRC+2amfNJgpOZs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380843; c=relaxed/simple;
	bh=yOkDdO1+mXhPLtenABTx18AMZuD5Auafbdg5SlFmNBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r44hVgm28QtvF3HZbEPhVm6NF9geesczraW5cRX7VUWvB4eZUevp+/DmnSq9CNEUBL1ayakAwzmkzS8CQZ5BPhY+3HfLsh/RBo+dhCHf1Nan+eyCxahum4ugIDVp9ccjSnxmhLchIddd+dLfKhurXl+xVx4uOJOjNWDbfmL39zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tB1Y0B8C; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB1Y0B8C"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52b3934af3fso20601001cf.1
        for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380841; x=1786985641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mSzUWe9T4HCh+YCe8gNilaOrV3ZWsdu7eNrsvlRDGXo=;
        b=tB1Y0B8CuD4tDw4ctS6dn89IxCvYGzLH5+O6V5EFP/95D7JJmjxyZscGiWEao9XJ5l
         9ADT/2joAg1UVJmpm2WJeUHfVE/+LuJGxrad7cbuE3ATh092TxapQ6ZEHYgE7OgV9oJR
         zcEoUVtOy+C0UtQ3Lb/h78dmsl2WkugXGwAFa73fxd6P57RUhdkJxxHILIFClG8QhTi4
         oxFt4k5gSuMi0eG0LgFNrrnSszGSouT00sWp9B/aYj+uxUXTtXV2tFA6rTK+t95zChIK
         tDJVhxqdoOnSmIYwwC+5yPwpby0gLnJsN+H2OPxHwnvII10OmPcLdWPOIqxdyYkoV7F1
         7wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380841; x=1786985641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSzUWe9T4HCh+YCe8gNilaOrV3ZWsdu7eNrsvlRDGXo=;
        b=Zgn3IOlspxg1z7X6oovw1a3Ohb8Ya/XkCJxtT+AV4mj1dGRJrlqNfoG/BXOUtFpXpX
         4AyI/PJFflaKu8iMxAib95rRkqjjuVczNW6ieIt/oNP1ALQsaYFbECzMNaodjB6oNQ+T
         XX6t/h/sy12oNS1jzBbS7+yHTC3YjQ+GgG2sgCka5TFCm+C7g6ITFgi847aglFaQlmDL
         IHz8utI3G/DNCNKBWLiegGvIJNmeRcdvfphAzOq2dGoTSc1N8rF2LkazXUIZgy/ShaDC
         jCU0kdFZW+/BL45AF8DOfM89S+/eGoJ4WWE4uDvIPGukkKE8GxFWugyzsaAQ6lw3Q6gq
         eDGA==
X-Gm-Message-State: AOJu0YxSPV6Un3E29w/UfJQAB5L8D7TlF83JxID9pzjVTwaDPqX76B1/
	+TlxGiFt+ZxPwa3vtejMvES4kEWCNmgYDqdUKl1E8YBXNthkdexbp8RobthzxA==
X-Gm-Gg: AR+sD10cJ5hYJKkQ+O53g2CFv2QIgmMLGdCJU+2ZXj4tR5APSRWNz3YhXyVKFardrPk
	W//ZGE61dsmN1/r5x2hc3SUU6puN2kbzBD4+H4h+I/NE9QTG1a6XYWG28pl38+m0cAagDckZDcJ
	2yp1LuS+9fuaD5O64LRnhVBgkyAKBdjOaPOAqdTz54ZM33yJt2JSmtz73uyo2tTu8xuHZsdmf6g
	CNoQXJYnfKyLiNkFJMRD0GOBaTyCSy5z+ImDcqqxQnsgSEYz7Of55l4lb2dPwzhKEVTeydC0Kdi
	UL2JaggHnQ4Tvn97c5QO8bBJOyATxHRN5RCkJfBP74jSYZhzRhbYCu4XuzbJumX/86kLijtvCfA
	xrCjkqJksDH0KbsOYl1nuu3bJgMAUCpt14Hwp9ahJQPe2rUEwtDehBMR9hwbJ4FZOyvDoM8eLXr
	AwabWsO19wGouu6J/PRerPGkEkF56ohH0yJZJUX+M33r3HStvP7NEvjt2Zg+BAmx0NOb5bQ/mgM
	Dy0bEmgu9Mr4B0+OqCqp4+JjHi0AvADQZ3ywFnABOPoOSBffI6OKdm6TmlPYY+C
X-Received: by 2002:a05:622a:4d43:b0:51c:1fd1:e755 with SMTP id d75a77b69052e-52d0b256a13mr363946111cf.36.1786380840747;
        Mon, 10 Aug 2026 09:54:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d1659f955sm75127821cf.18.2026.08.10.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:54:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/actions/build-userspace: drop duplicated make install, fix comment
Date: Mon, 10 Aug 2026 12:53:40 -0400
Message-ID: <20260810165340.50579-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in a comment and drop a duplicated make install from the
build userspace GitHub action.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/actions/build-userspace/action.yml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index 03f9e0a2..941c1345 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -96,7 +96,7 @@ runs:
             # Test that overriding CFLAGS, LDFLAGS and other variables works fine
             EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS="
         elif [ "${{ inputs.other }}" = "test-debug" ] ; then
-            # Test hat debug build works fine
+            # Test that debug build works fine
             EXPLICIT_MAKE_VARS="DEBUG=1"
         elif [ "${{ inputs.other }}" = "sanitizers" ] ; then
             sanitizers='-fsanitize=address,undefined'
@@ -144,9 +144,6 @@ runs:
     - name: Build SELinux userspace
       shell: bash
       run: |
-        echo "::group::make install"
-        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
-        echo "::endgroup::"
         echo "::group::make install"
         eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
         echo "::endgroup::"
-- 
2.55.0

