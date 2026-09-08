Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299D256C8B
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878650; cv=none; b=skPMx5eL7WO/uncfWlncXioDBuQG5SqEQFWkRLKKBHrYhZ43tIhWdXgIC9HijXLfp9DnUAmqWkt0KveboeIAr9LdJEozPXrW7aw0K60jqFiSyRROMnwpjXrlwINu/W2cGKU05eov2P3FbjZ9Kvj9eh8Q10xXxhBmJUms18Pp33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878650; c=relaxed/simple;
	bh=rt8rj7s4OhQkV4Qi0yx3CmXqsCXkMzPZT2cISQHGyBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBfL/atVKG/xSVFyQlwCOhGxuT8iVyea/U4soN/DDzNbP0S/2pMLaU8l0VOX1/a/lfcXsW0jHbSI+tlLTZm8WYbMhZ/ljFLoYl/3wacq5e53fvWmyMwLuN7mRtHH3R/oxm0ZQnerIpIoabzBc6K0J6nkrCbcyWGhqR3EcJTUYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogl9O492; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogl9O492"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90d7fa95a58so49337656d6.1
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788878636; x=1789483436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E4QNwCwpJjnreqi567dsZZUbvqZn9p33WU+5dLKDDNQ=;
        b=Ogl9O492/H+4ugkj7gPY1xPbbtYpPQ0QlA9gnOjlATVyqI6X+ySL99iU40EbYQV45Q
         KAPXxrvIVbzH/wHdrQl54hzkPpfSp5911hC6GqBf6bnNCH+ubpCiamiVs7bBtE0QR8cR
         /TQ+EQKXY273/BQGw00A8m3JfaaTvYzx1jr2YbkzjdexT1Q8bLmpOAZ/ZyG5VP4rYjxc
         9qWQ4OMa7wK/mAJ7VgOOpIYh3ooRH5RupRFqN6EXuLjCE06M21oLwb9TFq1f5wzjO+eL
         6nARXwmnDnpM0COX48vkjEevmj9mH6YQu2C8VXfrGT6eYbYlqgi240shs2bLjhj1yd2J
         MbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788878636; x=1789483436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4QNwCwpJjnreqi567dsZZUbvqZn9p33WU+5dLKDDNQ=;
        b=HymX6RNU+AkFtofK5zM6+XEU9WIGM+zAmxBxfDjcd08zPz3dOrxEC6gp356eqQbmk/
         uv27zkfjnuuSBAcwB8VFMKdNT89P8ArlLTrv/hWIyNXU5zbj8BhfzMKy+gVBnv4Nkuof
         wpnLv8CB6KYrf8o4upickyuNeFYhngwpYJQMXs3DquX53iuCSVLD3N7zsqHgZ8MTX9Db
         m/16YCGimR+5oHLzs1EhYcleRyR93Z15KppTPB3Xmid6aHcZG3Xx9xHjo7/q3955VsTa
         Ry143PbG9yxp/9aHXm6b2wiu05VUjN7yz0PnbbmXC0QvKXZ5WHPHsIAGX39NiKTDM9Zr
         RVbw==
X-Gm-Message-State: AFuF++m/Ey5Yq9Z398zJExgkELAiNMKqZ0ZQzsiVKw22H0L03Bltq6lD
	0XgH/MNK3zFSY2r758cP/KRlfjnh5FkcvDl/iIfyRf3g2Jk71TO3LBEvouXfnA==
X-Gm-Gg: AYBFou2qiixOGpwTzYma+BNNwzl//I0RJiMEW7aouPVYDAZ49yJFV/ckd6+07VNL1Ev
	AunUODF1XciVP/rr7PzylpmHwXXVW8MRhy1oAU1k3+hVM2sgmdyabXx8HX2HkBpNfzl3MiwDcTq
	QbKFc1sprA3z3Twsc+X/B/A1Va939luPKgBhVAMr2YQj4Keyp1ancjKIrkWRA5qd+pWv75Y7HQQ
	l0hYT1K2uPkd6TrtlXRDGI4n2j8vDNy4AYoJNW33IC1/4qAVC+dg7yhaOAo5AJDAUVwIrfAhuL1
	5V4QXPTjh6/DCVfAMROaPtMCxM2K4ugg+KUVYUpXRD1JE3IZGtovtSTvw1pn2GKCXDUyWp3Mkkn
	KRg6+Gw8AEqJHrtBTX4XfzFRgvYHCM9JXsLyStr1dOBxUXi8RFE8e7pFEkhQ8k67T8Yyg6Jb5AG
	FvPXrIwi/CGTos9t8iKLLZrWCM8HqHOeUX6zDw7OnzJ668bNd38p1+QMI5UUN+uO3fBoqWbeu+B
	HBDcwdqIK0vciBasAkWRITEHRK6DIyDMR0m2urjdc2XJXfs+oho8bO19Sw49jjODQ==
X-Received: by 2002:a05:6214:62f:b0:910:3451:5801 with SMTP id 6a1803df08f44-9103f0adf64mr386601966d6.31.1788878635463;
        Tue, 08 Sep 2026 07:43:55 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406b0f51sm118355486d6.42.2026.09.08.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:43:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: treat genfscon lookup failure as non-fatal for booleans
Date: Tue,  8 Sep 2026 10:43:41 -0400
Message-ID: <20260908144341.17206-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinuxfs.c:sel_make_bools() labels the inodes representing policy
booleans based on genfscon rules in the policy. If there is no
matching entry, we fall back to assigning the well-defined security
initial SID but propagate the error back to the callers. This ends up
producing a fatal error during policy load, which can halt the system
on first policy load if enforcing. We do not treat similar genfscon
lookup failures as fatal elsewhere in SELinux, so follow the same
approach here.

Link: https://lore.kernel.org/selinux/RvCmRlQYQ3uewSzEeY0utQ@coker.com.au/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 292302eb60f3..7ff2ba6623b9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1277,6 +1277,7 @@ static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_
 			pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
 					   page);
 			sid = SECINITSID_SECURITY;
+			ret = 0;
 		}
 
 		isec->sid = sid;
-- 
2.55.0

