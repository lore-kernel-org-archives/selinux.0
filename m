Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7F3ADBA4
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132454; cv=none; b=fbd93Q3pyew9Mm9BGZk9RF0n//R1CvaS5ewyo3eyjBIdUKA4ZwlRNCva7Uz/w9w68jgma2LF2KqMmewtlgfvUYSFHGffHr+FVF2uHbjknodK5uroq3aLNLkgdywKp5p/nr0GLOlzoTsFZ6LTVHNprPphRZFJxM0t46rPXXeIDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132454; c=relaxed/simple;
	bh=ganUOdpD9rIsE6FCs0zzqbPKDoHnouItflbJcGNavGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzagJSHPVklJ6FdlGeS2uJLRKkjhrlNEZisCw82SDT/TogLmAGVEHYrRxLRUwuDf0cYolMERuysluIB7+68ONjAwUDwLOzO1Tok3zId+q13Jw9Ad/IYW4TYg+Qe/uB+eg2VPxw/CknqEqbahGMqoyDehYIOfqAtg8db5PWo7gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMT0xQjz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMT0xQjz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed19f4d60so139770285a.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132452; x=1784737252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pj/NVpOhgzYObyjSWrcRi3DVKlQOYX+1iwi0Rcedu1M=;
        b=OMT0xQjzUEMFXPwSJO/DQ/7xIW6GxfzIxC8omv/1UNBu725x4QpB9D0pCgaehdIROZ
         Y0yvPDj9rWIOn7Ua8DKe+LAlsPrdlikYu+o7J4stQxX4VjAoZsHF6bbtuD5OfzqmEKid
         u3tCnOVNhie8o+c3PUoNeGX/ObeAS307tZvqHOIHY66GhXBoNoDGfTtXzDKM1wsjuQ7v
         t2ZNrkypTNFbe+xq7PsbSwKJx8Hs3//0RdCfVHgIyxHHOzW5iCXjaEdTaMA+aWmJLYgM
         eq8bcJ3iwGgqQLas3WW/O/aIm+8LpWzldPQT+TFoCY9zazffUjbt2qXNPr70Iiwywd9L
         DGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132452; x=1784737252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pj/NVpOhgzYObyjSWrcRi3DVKlQOYX+1iwi0Rcedu1M=;
        b=He4zB2qMl5XiMGcWXfPL79L9VrfoJG/g5d8HzqXf53MYiUJK2/SMIyQFYrRzg249pJ
         fC73iZTm2pxaPXdljHWpSeYfJBrGmAIzQWCk1Caa9SIjiWwZFFIOEbvb1nwXBJwbzcgB
         uNcOBahUGMqZBGfGeOVF+clFGRB6W7stx/BZYh+RVugcf3ajEXXV59f/WLwQ0h3z0WBT
         l39RGL5853b+yxoMprv6OFFGSJWpcS9heB/4TMq2OF6+rDtYNh7kbbzna7MgKkLhkOzy
         knY2+b9GN06HkV6t7Zlk6DJvrqcPI91QD1tskp6sGHO/vsSMDUfdvcvnYm5BQxcd7Zbq
         IrDQ==
X-Gm-Message-State: AOJu0YyVPRL5pUSdtNdJzy0OXrUWTn6smbrdc+ejjcTGWCjWW5Q6iJm3
	SMhCiwl/rzoML4+bN7VLHiTUNUDTgnDiR6q+PtJ1g9GZuAAhhhUES877Pj5e4w==
X-Gm-Gg: AfdE7cmHgx+j5sK7hcTeXSpPBI22J9zwJHTyroWke2OPrFp8FQJt7xSYfGeCKn7VLzW
	Bn2y/ciMYG0t6Yhyrj1lx/nZoGfsrKPJbCxCx+ByQ+t5nfBVyaOc1SyvPujvZEMmEXE6HApcPxj
	ZuV+AWFz0tE4tgMKjgQEm0WCRcNCaQWqhWMRY3VJQDZYuk9bjlw847Cm8lijkwq8tENSxamey0R
	5hesbcSHQbWKoJ/4m7LKecbHVAHq4/DUBF6rx/Kr60dhJ1JlNFhYgGDX0WM8Jt6hkJruWmMYfaX
	m7ktZzxN2RRfXLIh9fBAuxRaK7cO0YpJA7ygGPfj4ld8iiHnkhIax6OwPt8zFU4fB4PKsbHQ4N4
	b0rqCUgVyJRnhM3HkVut8be7+AdNZjMpmqnrKwCZBDuhtT13nk/ypS33CD0yYmOSteiskzmqkoa
	H5sw6Vi5g7rTocCR9fQFt5GuIDedvVE4Epzo2iqmgYYGFhTTuCXw3o8nHwrCdDVMlZ1WrZTwM6T
	pHTirXQDumszBix
X-Received: by 2002:a05:620a:711a:b0:915:5216:e5bf with SMTP id af79cd13be357-930a26abe9bmr10313885a.22.1784132452077;
        Wed, 15 Jul 2026 09:20:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 04/10] sandbox/seunshare: make -W/-P .. check exact
Date: Wed, 15 Jul 2026 12:20:30 -0400
Message-ID: <20260715162037.42329-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
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

