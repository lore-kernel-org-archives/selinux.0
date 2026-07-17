Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C10345CAB
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313315; cv=none; b=n64fItPTIa2l/F2QeyTFTaK3eaEA7hVjAtw1R2hZ/Ia4yVBWTVIKrdLgr4VdsM3ewUDKanZd8j7o8jFfXrbnfjgtrgCP03yCOTBM3+V4yiomzFwkHCZjLdUZW7m28tooIkaXvmwmrIctk3nr2CWowLoVJHSmpX1o9GpXE97/DDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313315; c=relaxed/simple;
	bh=ganUOdpD9rIsE6FCs0zzqbPKDoHnouItflbJcGNavGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDf0KS1ciA7qdgwPWGYsvPMrLnUrLOpRKaO9r/jJRbtqeMJoOU/WWHi3XhtgOqshAvlwisLyiCPeIxZ3/Qar/RTZziSKaekxJV8IEviheZOKC1PLqdxsDFttwNFAq4oZeKfDkKO5RXRe9kn+vX6P1WHKAPX6T3pR79IDzJMUXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWGVlaPH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWGVlaPH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ff88549786so97204796d6.3
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313313; x=1784918113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pj/NVpOhgzYObyjSWrcRi3DVKlQOYX+1iwi0Rcedu1M=;
        b=rWGVlaPH23jYY9FsuRjQdOJtUCbSS6LH4lP6yn0FkISOIkYee9BwIIIIzQl1I03cqs
         kDa21eLTsdzW/6xE/UGxaqoy5doBfWFJXhDiTIQVsb05GE/C6UItpISIyTAsRXRY45v7
         FffVEZjuYMqE1vAq0T+y7fVRqhyXdh+0Ro/LHP/EVORPKk0EdMXmRapg42R+HURGGZbo
         2T2yGqxqdA5mQ2ZVppGzew2ScDbqFosEeijuFZCv0/d0i/fabYLjDSGCCAMNzSRErXdb
         36ZWcGv4j2RiTULeRhxCoqA19CNe1CaNlXWnpNVxfhnHAJAY9sAhe8KAXlWKLzB5htrQ
         KWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313313; x=1784918113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pj/NVpOhgzYObyjSWrcRi3DVKlQOYX+1iwi0Rcedu1M=;
        b=Nhugtg9MzQ5qBNkrmq8PQ2M2QtQ0EKgGIpNTSxF9J2OxhqYJb3GArpL3ub5AtABZcl
         xmZJciOPu9KqvVapRSUpqCkF5pAGdkCkcoB5/3wl9wKO7AWwxjjmYDQ9NyJaS0QeusCD
         Hq8to9N4Tx65206F3C3aUF8Qw7D7gx4+Jxhv88XjvOOeJvIXf/hGGUCHlBIDwGkG2Gfe
         A4rDkYDp+d0VTzEy4CP33i19oHIdsITQp0JJarNcvFsSjxS/A7lW1uDlGosDoy1/KCHx
         X/u+pAvviYmuNz4UwHwXOo7tGsWqs3zGAequwjY8Lq0bPBOetyd+wxFuegcQ0gF9ZGau
         eTNA==
X-Gm-Message-State: AOJu0YyqhbAKiKdd6kOZ1o5JjWMI85CkQTfTDuV5k3LT3UTG5bkX6WZf
	pY0ninxnABGg2B9qhLqD5eP3gAjgCbDcRkaUIZwCf0cCpkNlnNn7zOTpGn/zpg==
X-Gm-Gg: AfdE7clDgkhTbwiLWSPPIUBe60ocpOR2R5To3krEOKEI1oq7OpwBAC3PU8aZG0dQw2S
	ZNxVPRK+M8CIlzB+QUozx9ClcvSIJdM8XaeQhfyHCwG9bFJLjDY2I/vVMPgMiD1kYbp0pTcIN6s
	6ES94kksZluWHQiO3mTl1iAFYV4827iDaZwjqZhyQr8aaZOFc2m7/opBBWCcZPKFyJDxHXKsnpz
	/8A30cqsR0dcebzWPt85GzKHiF7Mz6xic2wNSo91VyQrg2SpMMQRQMn0AHZodP6c9V9NcNPKC49
	BQ9FUrA9boEAdBLguVKEqjp/JYPiP7YyGWXt682rjywz9CxinTEmcMS69RsEdleW6RkZzsEIQSd
	0/fS/T0QLiELcPHL8OCu/UVj+Lat9YbyU/SU+g6TAjtsMPt+UJ2hQgPAK6+43ZX/FYmKtQmlsuL
	7rlZLf2Vyf/TZljLIb3KTuFf9kKkWnjohYPq8mvdoTUPbPNOPgKoFDLS1kALzz9OgmGd+NFDRhL
	b3Uvw==
X-Received: by 2002:a05:6214:ac2:b0:8f0:efd0:d5cc with SMTP id 6a1803df08f44-907783a2186mr48168456d6.33.1784313313256;
        Fri, 17 Jul 2026 11:35:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:35:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 04/10] sandbox/seunshare: make -W/-P .. check exact
Date: Fri, 17 Jul 2026 14:34:18 -0400
Message-ID: <20260717183424.20324-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given the strchr(..., "/") checks to prevent any pathname separator
characters from being embedded in the -W/-P names, we only need to
further check for ".." exactly via strcmp() rather than a substring
check via strstr().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 1e7822e5..37a24c57 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -881,10 +881,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if ((wayland_display &&
-	     (strchr(wayland_display, '/') || strstr(wayland_display, ".."))) ||
-	    (pipewire_socket &&
-	     (strchr(pipewire_socket, '/') || strstr(pipewire_socket, "..")))) {
+	if ((wayland_display && (strchr(wayland_display, '/') ||
+				 !strcmp(wayland_display, ".."))) ||
+	    (pipewire_socket && (strchr(pipewire_socket, '/') ||
+				 !strcmp(pipewire_socket, "..")))) {
 		fprintf(stderr,
 			_("Error: -W/-P must be a socket name, not a path\n"));
 		return -1;
-- 
2.55.0

