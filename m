Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FC5FEE6;
	Thu,  5 Jun 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142165; cv=none; b=LHe2ph7uyxmkQEPMFtQCeCZB29DJmGyhnNOhPqjZFoZ5I5+YwXenbiQSQtjJVJD9oiHNnvdu0YMfhgpYIecFuy9YKygwBImjTQb4M+ipXkb6ydF2VZ3MYN4cu3RhUlcy9NcCePeef8FKrfEQFpP+AklY+yuJoBZQXmcWLvFPa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142165; c=relaxed/simple;
	bh=7tGewupCuQBqdKn9SQizRgoVU1H9Un7H9t2++GGjIC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtQdRoq2odHMb6vs754rjkjKOgYEQQv+NUCSGBmwXGubGpNgHQIyW5tNiuwhTwEvRp5rUfJf4BQDfW+g2JPEHsnLdK+QDXr7k1moX7PVgOZ0jChSkVACxAxbwe+5ZoiMEdsl+W4P/Wf5vQENWDW1EgJ8H6IXpOugzqXT+CgtfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI3IuqLv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI3IuqLv"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7cf749ef9b1so119137485a.2;
        Thu, 05 Jun 2025 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142162; x=1749746962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ+Il9aAD6diUGB7Neeip4HTyqHqME5qHPELbp8CA60=;
        b=QI3IuqLvdEXP+/p1f5r1qfWh1ACs/eE1c5iff9vraw9QxgGblfJOwD3IWq6EGr+rOr
         cS6n08wxpjuPSVeKdFnCUvaIVBH73wsiq2TKNQeBAnJG9C0C/Q+y6WCX1/6oXW10OWDq
         5WSMz0tHRahHGD9DO5tij/SUtAnfCOrWXyyzLNbO64ENNLKXVjxI/1FbZ1XHWIMd+qPl
         GmkvLWIQI9I9sm7WJVwU2275521sSOIq0yZIe5kKEPmPlgVlo9oINLKzYw5tCNR17tNV
         mZyrRf/YmVyBsV/QD+XU2ztFC+Un9iqYlS7arEph/y8d9iQpXbXtHnrrlxV8bQZDEB47
         QWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142162; x=1749746962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZ+Il9aAD6diUGB7Neeip4HTyqHqME5qHPELbp8CA60=;
        b=noxelnwgF6FHYZ7LqnR5+bMY9Icql6j5pVlYHMtJbRlmQ753w5aNcQxllFL/f2yELX
         AVensWAS6CfJYAtkhKuqbEYpNX2GM7jX0Hj2KvCts9VViivmCnU8dgtFs1Yhn9e83v9o
         hnI4GKgCZYdZs955rzMF0ySuEYoupMdc5kesZB0o+nZpE+yttSTS+WLAVcvtLdPHOk5N
         TH3Wl23saICkn2zLWLq/r2RR2oQO8jFSheMOgMS8+RsAroQZAWd6sXMUINuuI5NW9rna
         sLR8NDMfcPhiLKvSqxU33YPkl+wLsftWhxJCL42gPBtFU5tpz1GnEJ2nD3FlSp5IXcRI
         yH1g==
X-Forwarded-Encrypted: i=1; AJvYcCUpCnjQYSjd6Lxqs+J3JB3bBizhlqKfXrnC2clyTfqGcWJOsXPofCjsTrmYZp9IoD8bN61Gb86zuUa0ykg=@vger.kernel.org, AJvYcCVWRaHvNPYpT2qh8Uc71LZVU9wGSSO3Lbj3m5RM45Qhlv+BLY3k3DMvM3U9FoB9yZBwpmsPUVpKxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSTWYHvbQcUZvXiDUHyRiOeSRBSAxPvlaF8aEdEdBDTULp/iQ
	zw9xMVdvdNUita+L/4e33gydGs/HLA0JFa4WB7ITTEves3f+kci3zo60
X-Gm-Gg: ASbGncviogVPhMOH8zMWFXV+DglWW8Wo6Y93JfjIHiw7RrcGFO566PMu8MI9ORKaW/S
	ONms2G0lS+AQ9FOxX/hn7prbxeKPJUBi3P3fgxR+XA1By0YEXm9USRttYXVYqKl4FW9X7Y0Ftd0
	eMuuuZvdvZ8Jp+pOiWGy/qpiOqeYi8Hrg6e/FPG+rTDZ8PPXuzl8HHEmXZm0Gv9vV1ZpDtjxcGu
	RaBtC/ozBW14yDN6Ir9NT0HNXE2Zog1hyJjTGKYVuIDcFVDJ0gwl4yUKV9tU6jKpDnTwYlphIdN
	sgKwkafipnpP2nl7JRqB019MkzPoki9e7i3A/A19ozBlDRAsxZgSCXG8Pqb3Zh0i5tjwJhDrKgc
	96xyCVQIFxJyskapUTxEQtkFwoxfaEJOBzYkBQBFZSzYryJ1Ao2RHusuqrxQceoyyTyFANAvUIB
	f2JSznkWmUFh+s2w==
X-Google-Smtp-Source: AGHT+IHe3vt2go/OOgl2GI6BQk7hcOjCIbNL1/ID7wPPqS+IDxFQZAy8JKCzvLgV1CGKdAfiWRJ21w==
X-Received: by 2002:a05:620a:800c:b0:7c5:431f:f5e6 with SMTP id af79cd13be357-7d229887bf5mr42084485a.33.1749142162406;
        Thu, 05 Jun 2025 09:49:22 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a115aabsm1276882885a.60.2025.06.05.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:49:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: brauner@kernel.org
Cc: paul@paul-moore.com,
	linux-fsdevel@vger.kerne.org,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	collin.funk1@gmail.com,
	eggert@cs.ucla.edu,
	bug-gnulib@gnu.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] fs/xattr.c: fix simple_xattr_list()
Date: Thu,  5 Jun 2025 12:48:52 -0400
Message-ID: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
include security.* xattrs") failed to reset err after the call to
security_inode_listsecurity(), which returns the length of the
returned xattr name. This results in simple_xattr_list() incorrectly
returning this length even if a POSIX acl is also set on the inode.

Reported-by: Collin Funk <collin.funk1@gmail.com>
Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
Reported-by: Paul Eggert <eggert@cs.ucla.edu>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 8ec5b0204bfd..600ae97969cf 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1479,6 +1479,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		buffer += err;
 	}
 	remaining_size -= err;
+	err = 0;
 
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
-- 
2.49.0

