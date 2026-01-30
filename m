Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545330BBB0
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737458; cv=none; b=H9VrNaznXr0qUAZgfG7hWTi+kue4zXDD3JLuOQwhr3mXZKqNIQRCne5iB5QzP7Ag1xNHRJ++xErvBb1HK2lOV1XyY/VTO3+LJr0J5d4nAfSxZlEFsiU2G83KWN9M/S/UB/c1vU5TBahn44RiMZjHP50M6toyl9Y9W2ZVEYJ0Oi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737458; c=relaxed/simple;
	bh=fl0gRg/jJ+j1i4Q1Uk5hLb7eQefZfCsILxC+MiXNU1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3xc90Gs1GTVJl75m8xRLUTT1ZvbEk6dQGoJiXQgHdIGf6RlYmWwsBqUdj+QWgk24m24Ehyi8Y36I/udg58vloZ4TMKSqRr50Q0XuyZ4G5baWFYwLYJVCXyFEvBP+FjqMTELTvsHCjlrBFb3J+SihmYcFgDXJFZph+bfsiQ+nPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=epuM+tpz; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="epuM+tpz"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b785801c93so4155229eec.0
        for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 17:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769737453; x=1770342253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5I1r202hAdaXKfF5gZlOac35JdMK93Gs4VDucx7RvTE=;
        b=epuM+tpz94UDVzyGN/xvyg2YXS02KDMupsWawMrNUv78IPu497+pzg52Wuu79TL1+F
         1or5qkI13JvR04Ux4ufF3F7E+dYJtOfu8HcfSCzv7sN6wt7Jm5kni5XNTyC+KLAKWSYw
         2ucaTVgWRzFy2JLtq15WN2z7xI9VMf02ga3tY6ioVkkO3uWuz5qNPJw+zmoUpv60JSs/
         VA4KaXAQyTYI0wLMyDS+cU3zlQ6yizapUrOvOGAEfmu+y0xc7YDLu2w9YWnfCDtFitML
         RygyF3Z+AS6/WalocvMQDYnQW0iyyQ7t5HY9u7iwb/hX4gbjNVg9FQifrzQPG5SrE1jy
         uAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769737453; x=1770342253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I1r202hAdaXKfF5gZlOac35JdMK93Gs4VDucx7RvTE=;
        b=RyWL+0CX1VIil9JR+8tu21A4UtAwWRZYK8+uqM/nV2yiTS+CQEUg0hKAU3eASMAcK8
         EZmHgOuD/RiyVsdImEywgnvrMD76bf6dH6JUdwhT1+UIGu/O96oavMpIhNBly76bltEn
         VCe6khLvIkXdxG3kxlolTQ2YBErp6lXu9oU57ghlEPL2Sjx7Q1HUWRevtXy8Tmz6/AgF
         CsXU0UrLFphsYh3b2+l/NehzGjIenQw+9Vp0jigIbV7mRJsPs0S2wXRkTt8oYmndFlMb
         NeIwfDSpGhVGzEmkzGNUeqMfWPa4m8CPJ76fhOqvk5MzmZX7xrKEKdIO6F74J644JNUl
         CKqQ==
X-Gm-Message-State: AOJu0Yxz1dRCrYtUEpBsD6osx15FJvTUvmST6GpZSWwfwuoLHSXC5xAT
	LalYZCS4N5DDnhWwcmLCZiNq/Zob0L+EkM5gFm2AAS5JaJNLfOHrg6HIqzfMQaR4E7nLRiSRPGs
	d4J7t
X-Gm-Gg: AZuq6aKOYISet2OJYSUoLs9583QymGhoJrPAyNy86dnTPLzY7NuBIWnxjh7V56Rh6aC
	HI0lLH7W+p8B0hZe39jolOAC139mEi8cYuVaDkslRAFBIm7dEbgda79phOBrFS2gGpI967ANO6p
	0MF6vdIvQ2jyq3pZbkEFwg8hT/Wm/Xri+bkE4WQAFOORB+kaDwLpic5MRQmud20+MQ9D5Fk9PQB
	YsSX9QfVOwshdJw1Zr4OWHTOn8Cpjdh2yvAAhGAwdU+b2J8j0nBgfgcwNoH9ma3repwQcgSJvoT
	vozCQ19AaX4mgTpsOen66Beu/nqfpsXXVaFQe6Dstu6HIGE7ZsKGMAHIojR44UMYXbBx5cqj7E5
	zG3aN8D7Mh11rB2ARB0BFCLqxQun30ypf1sfQCqe/FlBZlL/E1UOqUqy+cdCryy2oxp+yiVOArc
	OMqRlPbTr5HhuY4j0WkenQFUq9YHCCSQfuTzYP7uqxPIo0NM4=
X-Received: by 2002:a05:7300:fb83:b0:2b0:57ec:d1a6 with SMTP id 5a478bee46e88-2b7c863c550mr719225eec.8.1769737452981;
        Thu, 29 Jan 2026 17:44:12 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b7a1add664sm9297543eec.26.2026.01.29.17.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 17:44:12 -0800 (PST)
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Cc: Jason Zaman <jason@perfinion.com>,
	Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] scripts: GPG Sign overall tarball in release
Date: Thu, 29 Jan 2026 17:44:05 -0800
Message-ID: <20260130014405.47915-1-jason@perfinion.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the release script, there was a GPG sig for each component tarball.
There is also the overall script with all subdirectories at once, but it
was missing the gpg sig.

Reported-by: Petr Lautrbach <lautrbach@redhat.com>
Signed-off-by: Jason Zaman <jason@perfinion.com>
---

3.10-rc1 and -rc2 had the signature missing on the upload to github.
I've signed and uploaded to those releases. The files I signed were the
local ones on my machines, ie did not download from github and sign, so
there is no risk of any changes/mitm.

 scripts/release | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/release b/scripts/release
index dddbdf22..94125a7a 100755
--- a/scripts/release
+++ b/scripts/release
@@ -53,6 +53,7 @@ for COMPONENT in "${DIRS[@]}"; do
 done
 
 git archive -o "$DEST/selinux-${RELEASE_TAG}.tar.gz" --prefix="selinux-${RELEASE_TAG}/" "${RELEASE_TAG}"
+gpg -b -a "$DEST/selinux-${RELEASE_TAG}.tar.gz"
 
 echo "Add the following to the $WIKIDIR/Releases.md wiki page:"
 
-- 
2.52.0

