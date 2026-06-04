Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608C4C0437
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593753; cv=none; b=NdpjJLZMs4rhGnSmvbzKzLL9diMuF7bgzkKukFb8siEL3AjzenGppfA3xDdz/fwIXx+MXjhMvs0JKtgB71YChyE+bypO9N3iYUga/DEc+4nGcJXTySUJtYIXcZcV7d2RvqrM+9Z5oYm0zO693HUYzHW4ZecfYvWZfsIFjgx16NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593753; c=relaxed/simple;
	bh=jLss6CFxcFbp2Uhqfny61mDHtJrTkpLd/ueN05ZWw3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XG44kDS6xv+c90y6AyGor5M6U+Tp5Bidhmn+nYiopUd3pAFwS29jO8hD10vkaGQifv7og5LfjlYkDqYv6UsVW4yqHiyzsDn0TjXfGZajAYReu7IjjVcU35HIrewsqCmgGzta2/bxVjLz55x5och+BGNwByO9OoPgyJ52os7ln0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EslPEaS/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EslPEaS/"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cce8873b56so8654206d6.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593751; x=1781198551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bck2qMiezPmOjl/+d4h/q9aSJ08gItr2WlAVtsiaemU=;
        b=EslPEaS/q8MdOkIoozXm5JKQQAIv0tu028QkEVmyqqn8sp/7VWIg3yX2SWOw/C4oZS
         GsW5oQnVV9n4LBsgVnJmsbWwm3O+0q6vJGfazpj6WbbRHmeRs6i3Z6hTiV1IQtX2rbNf
         +bwzIiFVGBjUpmKbuX/lXp3QNirA7o90ZJjRcR24gJCDZX1/NPi053KZ/lfLgaU+RgT9
         m2QbpWmMzNofMBbwMAIwCOImPEoakvt0knqQXFtZ4VC8DrNJUE+uq2YSvP7HF0omYRf+
         t+/fL1Mv6VRPG+HZv28zkx94hwDfn/2RGX6iqFSxFtZSEEuHpPuLjbz1WDsQZDSiMfRE
         mJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593751; x=1781198551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bck2qMiezPmOjl/+d4h/q9aSJ08gItr2WlAVtsiaemU=;
        b=J6HrYfODIed0Ik8XRA+1kVaeU/4ZoVSzEaeX+l/XZtUQAsjL8BDgSKZ+kqrLfWP3nr
         aFzt4FLmmyMguqBNjfkwvncduSTMwUQPTyDW8FTvejmo8HwZwccuOa4t9/Au4Vrmoiqz
         1LLb5wV939pDcA2Qf6TzsWT8ioSKxiWftHJ2WUu1RB4R5XwRMilHO/mh71tOWBo1WArp
         dVkL6WXrT6UT+vbQN1mCGTm2A9dgqwzbYNB88T0j2b1KOL9sPcwHTqLyWQ/qrHFWLNoe
         EN7nhO40aLlgMtIKX3ec+/ssNAETvEYscB/FdLaKSbGrf7p3zrT9R0RV/JvwIX+6xZzD
         pPHw==
X-Gm-Message-State: AOJu0YwJamRtBDMtEDtnJ5H3QNKHilYj3AWyZUrF/Dpth9XC03k8iPPh
	99fTHs2YHvXBavvrJaESCBc1nnbt7gmoQbyrT/YyrBJJ9qST2giNVQlRy+z6hQ==
X-Gm-Gg: Acq92OHKMzj4Nz3lIQnJCBmRmwW/yQW6Ztxc4JLICMw/v4uVvRCRy1Bi2a4e1M9BHnc
	V3bTm6MkdPZsRm/7mTvURYfCRU8HTSep+OVkr4vyHZFihjl3mm4dl75FsM8naROlQHkV7Ylo2h4
	HHl0YbACLsBU+9x8i7DmdAWdFOCBFI0DBQdHt0bMgeDhYmMgYkHKmRsiJX/aQS4i+IRNhbLQG9A
	Di8BBqY9Nxn+7FXqmQ4E2n4YWPZmsfkWF2fLj87oa6LsgS44DDlkK0gAeKIb0TGqU73R9eFiC9g
	yfufPgLUDcV9BsxF676NcpXDD5IBvCFNky8I1bWqMPYrYrj+u9JfqUFWPTN1t5qSr+YC7qquTVO
	nzGfhkGSjyp1kJgVOEQmIU6cfQKvnUZ7pGYLjysWNvcveDF4PJo6IoPEwVhUEKm9Ny/cmH9Gor/
	F2QutrLjlnnjDa1LthlAF2uhhUJBl961I+1qtxSUMvwD40dbOlRGauV0p+6QZk3Zr7mKmmxDpxC
	V4UybDRnS1WIGUvxtSst/otkJFnixaoDvJ5LQ==
X-Received: by 2002:a05:6214:1d09:b0:8cd:b7e4:624c with SMTP id 6a1803df08f44-8ced82ede1bmr65923096d6.34.1780593750977;
        Thu, 04 Jun 2026 10:22:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277070sm55927556d6.48.2026.06.04.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:22:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: genhomdircon: handle NULL bsearch() in get_users()
Date: Thu,  4 Jun 2026 13:22:13 -0400
Message-ID: <20260604172213.263551-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bsearch() can return NULL if the seusers SELinux user is not found in
the policy user list. add_user() and get_group_users() can already
handle a NULL user parameter using fallback logic so we just need
to fix it in get_users().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/genhomedircon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index d953b75f..68382b95 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1276,9 +1276,11 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t *s,
 
 		/* %groupname syntax */
 		if (name[0] == '%') {
-			retval = get_group_users(s, &head, *u, seuname, name);
+			retval = get_group_users(s, &head, u ? *u : NULL,
+						 seuname, name);
 		} else {
-			retval = add_user(s, &head, *u, name, seuname, name);
+			retval = add_user(s, &head, u ? *u : NULL, name,
+					  seuname, name);
 		}
 
 		if (retval != 0) {
-- 
2.54.0

