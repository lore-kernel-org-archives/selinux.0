Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8733B6DF
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132458; cv=none; b=RamI5NPGmaejOfelJ6UOX8+czbnogwhnUe3R7esK6pSw4Efe+us9oH5rqiz1wclXujsq8iwHbkhWZDtiC3idUg39EagU4lqfFdemthd2MUBHgiFjly37nr8aK6Vt+PspJmyO+Qv2Lngs1qO0EmyHR7zZdGCtBMAFVpOc+fganzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132458; c=relaxed/simple;
	bh=h1Wpakb8lm2paihv0uaXwx5G686Fcn9dUF1r0BbTR/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzCVDpee12FilHxakuvH8702ddTUXO+gk6fZmT4MYAmhPR21uWyRIPpSMt6sstqGxdlUKgFaqf/ADmVmqrfu5cFFk/bBXkAWWf28EQxoWZ8s/wu7EYYgkZKc3AnHFXc6OkLu+rN9TiaXl2fO2Z1nVMeLhLz2PT1kpiNCUeFk02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbDjaagZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbDjaagZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e4fd65b2bso177651485a.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132456; x=1784737256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEa8eBReY6Fv68yK9XtJ3qlVRlZT30x97oi77dA14Y4=;
        b=TbDjaagZl2wz2E1Nm9ebDoy+9Yz5pMwKOj377p1aiAf5OdJtWScF6O3yNtfwzuvqsi
         0FhfRB3I1YxyXiAR5lY2QUPjE4ZJnxK5QetFigj4iu/mCIQqittckMxiJiJbFZbi/ycr
         1+NW8qw75qKd103NcZJYGSdFZqUdzI4+3mXCpo/szeGJWoTMNEx7r3mogbbzUnauKCdf
         IkgY+Kb9phIO33+m6A+821nC1MiatDywc0haZE1D4eIZiYRKoM9rtD6UvcSXd4FrVXkw
         in+0tBJh8CBXZvFFNxCKY2SVLomyQHOvaSaPz9xl9OWsOKsO93UJXNNZkI/U7BUxadeH
         4jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132456; x=1784737256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEa8eBReY6Fv68yK9XtJ3qlVRlZT30x97oi77dA14Y4=;
        b=EffMsnh/5O7hKbFIko8QS2UnE9vhJ+BdiIv9oLJFVF7UOscVCDDvaqBk3KcC9ryq0U
         rnrzXIPvFh70PLirVntr3xY2mzgAdTVDQ7gb50mctu3abZyDPpS/AGba+Ni1iPdfH6wE
         Nv9XqVOtKIM/Z538LkbauwKIOZkhAGTK0HoxmUKRg9l7IruU26I/xhnVoTG8Lu3pMpC0
         rCFMoi6We6JIx6Ko8eHjCh8lRXNHycPXjjHXVqnGp+o63ddaZ3adY1VH3uWsk3stwa1z
         /wDO3OMikbsnaJl8sdNzSU5Lu6pdPGO+x3zhTpEonBghbMkzoG3HpxIpHyx5eCsgUv0P
         +99w==
X-Gm-Message-State: AOJu0YzAgX3qW6IKZBFpqOnze8V6rXzOSzL2LaOlkujb3oljOVWKiNDy
	Ae9wQz6fugCl9cK2pHspmcIClOH/PtikIEaKjAqIuVBd39CfcRtWCNeRgT2liA==
X-Gm-Gg: AfdE7cl3Kn82n56Tw4kdGJEm7aZDG2LD85JNspecDcERP0H7jTgHBUyBbCIS7/wfEFd
	axMNE/Y538HWWB+gddkX3w3282NOmsFDz33F+jgIjiDVuSCeBTUJxaTHzN7CahCjarv6VGT7B9f
	Zvd7DMEJjQos/DHkIV16KTbciVuER+4sNvLLWBMY9OylbPeaG5oNH20ZBzoIxvmkOk5WofjnqnK
	Shqd7v7C5ajodC0HU5alF0szUOB/KYD4WGaPGQGumuzC+YPb3tSNGjp4sM0+96MCiDrJ6nlM3OT
	VHP80D4eOSYewJ0BhMlnu9CSk9ELy6VIoxgy1kEq0oYqrzZs0abMLTkPvdFJKuRekM1qfWmne56
	n3MHSQyLMk7B9fx6UnMlAZjKgbqq+LhF9zW1Wk+yJwLIalch3btP4bK6KhbphnpQ6NtXYYilxL4
	+SuPv46/NZkAPf3Z94Bk8HzsU1xVlChSoyjraxvYgBu1YUXiCHP7pI17LT6vvJfxo57r6v+dDrS
	VbmId7UWMkeH0unKm78EYZ3qqc=
X-Received: by 2002:a05:620a:8087:b0:92e:76ca:e20f with SMTP id af79cd13be357-92ef2bb4c55mr1753919885a.41.1784132456142;
        Wed, 15 Jul 2026 09:20:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 07/10] sandbox/sandbox: use slicing rather than re.sub in copyfile()
Date: Wed, 15 Jul 2026 12:20:33 -0400
Message-ID: <20260715162037.42329-7-stephen.smalley.work@gmail.com>
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

copyfile() rewrites the leading srcdir with dest via re.sub(),
which treats srcdir as a regular expression and dest as a
replacement template. A home directory containing regex
metacharacters or a destination containing a backslash
will mangle the result. Replace the use of re.sub() with
simple slicing and string concatenation.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 4e7d56fd..3368a95b 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -84,14 +84,13 @@ def error_exit(msg):
 
 
 def copyfile(file, srcdir, dest):
-    import re
     if file.startswith(srcdir):
         dname = os.path.dirname(file)
         bname = os.path.basename(file)
         if dname == srcdir:
             dest = dest + "/" + bname
         else:
-            newdir = re.sub(srcdir, dest, dname)
+            newdir = dest + dname[len(srcdir):]
             if not os.path.exists(newdir):
                 os.makedirs(newdir)
             dest = newdir + "/" + bname
-- 
2.55.0

