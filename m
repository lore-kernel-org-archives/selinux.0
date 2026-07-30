Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F339449B35
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435019; cv=none; b=m78kGZJNACjQPR8HrsT7spiIGL5NCdEdWJa/ShB02OPwQW+mrjdqCCh+7OJxuh+ygnUyLPOdgIIxuNcTgfMNKIckaxKF9ICGtgLp1HdTZ2MhOz3eErLLo0wBo07BgmlmQSYKT9PkKErt/24+Ceml5oQHc6Bslyvd7qRTos0nzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435019; c=relaxed/simple;
	bh=j4uG85a/lUOWlekw+/37SW+8lcXDbeUugVTGhEIFrNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c+RwlYduXtFlBnonxaVTM/5NosCTo97SwbDTbStMdIhwTq+DOPmF0g+KrTbLrO3fkzZqosScUeyMfsGG/tp/F6RkHMmckM13TUiSi8FFPngpf63ozz5ka6wIML4e99Mp2m8uMO5Wf3b89ut59zlgtksab0zUvO5V/0PdrwRVjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSsF5K32; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSsF5K32"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7621655eso229197a91.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435012; x=1786039812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J+SX8dpZwKLLQ+HLHdBpKmApVdFrMwrn1102lcbc08=;
        b=TSsF5K32AejbDCJcn/YMBtVjqzkong6JGX2vhYbaLeOHfH9HkOtH4up5GFBy5+S6hj
         j0Ncik84ofrqHEJDw0TXEvrYl2YvwzWAg4FOoyPh9gTwVf7B5Ffen91Skpwa4Y8KXI/E
         Lxql/Rb73H6IUHxNYRFEbsJoKWKGZHtqhs8EQ0qfBQWe3NDYUOmd295fZDHNcsC8JVTT
         2iTnq6LO3Eaz9WIuHtcbQA8JFJFiedfx0texYuMq+3HrUYUtOCiFGcgeWf0zvs7PUGfu
         Ps5SzA5e+eIKNYLamcBucKAB3J3LNZcT7G7KOlQMy+npBuSSYOCCXvHejM8a2z3wsclW
         qZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435012; x=1786039812;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/J+SX8dpZwKLLQ+HLHdBpKmApVdFrMwrn1102lcbc08=;
        b=g55cf3ZPGp8z6mYoc4/wGuGvfIri16r/XIAGSNjMzOkRfEM89QQeUjTzwz77fVnwnu
         kxhCMYsxF0eRC4ICUC5AOKF2s8l9mvyceKaseRRrjqi3RV1pXqo9z5xcAHlcFl8V4RPs
         5kBnQsYPSCXffKzM1rStzE2Po3bNsXxwKb0yrIbnhdBNuu1GQp295DI5DJG3NGb7GHeA
         iYmqs9nAxUog7xxCLCHMlR/5HhmSZLGf3oDa6m8oqVWQcYO+uXcfOFqql7S38Wluq7jH
         bNY2yfsAvJ4OqyR9dqEW7+Wig+vlet17VbPE/WQifyJ/djOy9sRn4DH/RUiCaaIQNsN6
         Opmg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5ink/21WSNL/FCDUp+fQ1H18lK5RqVmQdRVskAWFV97Z9xaDM+3fNv8nXyFX8h466j9RsX7Kk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UmFmIoaMEBgJr+sUp26triDbnuzDfOXKmQaPml4WzzBJL32T
	M8WGhFLcgk64EFMfBBX9Pg/tMQnWWpb+BfpDzwgHSvIS34yqQ0WGOFmx5FBsMsK8513h3xgirLO
	piv1KZS2yeNH27A==
X-Received: from dybvk8.prod.google.com ([2002:a05:7301:53c8:b0:30f:45f6:de06])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4b:b0:38f:c71:2342 with SMTP id 98e67ed59e1d1-38f9c00dfb9mr2757140a91.31.1785435012102;
 Thu, 30 Jul 2026 11:10:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:10:07 +0000
In-Reply-To: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <01421d53-c379-4044-9da3-5990186303ef@iogearbox.net>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730181008.3654413-1-cmllamas@google.com>
Subject: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

selinux_inode_init_security() marks the isec as initialized before
checking if mount labeling is supported (SBLABEL_MNT). This was fine
until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
xattrs) and yet leave the isec->initialized. This breaks subsequent
calls to inode_doinit_with_dentry().

Do the SBLABEL_MNT check before the inode security is initialized.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d6945edae7a..09a12eb8652c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	if (rc)
 		return rc;
 
+	if (!selinux_initialized() ||
+	    !(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
 		struct inode_security_struct *isec = selinux_inode(inode);
@@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (!selinux_initialized() ||
-	    !(sbsec->flags & SBLABEL_MNT))
-		return -EOPNOTSUPP;
-
 	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
-- 
2.55.0.508.g3f0d502094-goog

