Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B830B501
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585219; cv=none; b=ixK2ypkMImgR4PPvBwDVwnlOEKmCTou2WO2MRUFPGKK9dL2/fN1GswsnFcHR/t3yR0J9syVfDuQt2uhfnjVm3Bhf0G2M/wh1MIfJAFMmegi4qzQoe6TMw0bMyOhjQODu9xmE1ltinQ1ucNB9MJsCHn19J80nZqvj3UdwZMJQQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585219; c=relaxed/simple;
	bh=wUoUqvWEnZrStREnPY4+zjixEreD3KHKI0SfkShpUhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScbQ4c6MXfk87qSQgaCrc31qJjcRv3xG2xoWB/DQhKj895WGxAteHHcT/bMW17nK8BGUGhfjbwDZuryFzDz0saIYxixFrGYoOH8FVofjgdDH8LwV3kwK2kHCWVx9YjHJAmVK05H+W1JjTed6Y0cqomm7QLLItH/bhQZk1LvCx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWdQOgEs; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWdQOgEs"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51776b4de37so6531621cf.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585216; x=1781190016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqU5Sq7lZFwHa5S8qWgCFv8NJdvqPESTRPHJIW7C5GE=;
        b=DWdQOgEsjvVvbIcIpD1qTclWzv9hSCVkcq0Fl0X0vjh6mLd19ZyafsqHvB+I8shdfS
         /4tl68MWFQoUd41QNgptG9zOpptpgXtmmqlPiZ+CfCK6lcQ1ob9M63ec3rMm+A4dTqG+
         0dzdzIaHu8n+4AiO0Km05VbnoU6SzOMCCYHLTDOQEIqDGSJsw4DdLwkQBN3l+fETDjJ1
         v2PabPsKt9oqX0OXZjGFhM2zLcVgZaBuUN+VX8f07Mr9klA3Ljsp1fOQtoBjq0e2aPG7
         lC4+wULYxKGNZc9UlB3VBNq32TpgvJRCwTAU+alx/6IvIZGhj4jIKmdE7X4hrUXggy53
         dZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585216; x=1781190016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqU5Sq7lZFwHa5S8qWgCFv8NJdvqPESTRPHJIW7C5GE=;
        b=T9wU3aIcOUpPBDXw7mi8EGCN9aknsJPZFMJPZqSiKMS4UuLhCUUa8LN/GAl+Dp06eL
         3sghg5i5AKJr3Yl8ukewSu+op42v2BmPx4jQC/nHwFB3hEK6yuoevehHRg4O4lEmpJ6D
         Z+JF+ekuWRyP03UVABDBexdfiMX9b6tSC4v25SBysZfRB7gkeBB0yiDbQ4J+W/Z1beyY
         Y0jIEah8rdBt0mIwRMGe4W8jrBGagYlnoqdjl5Ed9Uf7/B47OV8MbtZU6l0ZD67ssHgF
         4JLFkXQmFN9287T7leQsixs56U/OuyoiaEhoCU3Llkib9ROLtFqSOE5vxs6oLk0lhT20
         lNag==
X-Gm-Message-State: AOJu0YxFwbN6B66VfuFXsb5susohwLWwdZBAIRJyWz8U951tkDBcHl4L
	DrTksLoNE0YphTYgQuogGCZg8RjYonXDGhSXejBVPJryrwWAzPcTsoRaPFh2wQ==
X-Gm-Gg: Acq92OFTjM5ggCG10asiVa/u00NgYMXUePG9MpPMP5Pm0V6I/FjKo1jINB2sqiNcZfR
	5r3wy3f4tkFjWjUAY7ARedvOIqzyhKYpq3t763WbERzvlSUX4cGpQxX0TAjdzpOgnXZ69r+lX4V
	7an2ahrix+ngRbDcijHfz7kHNU+AVzsjAXrd+xfzuhafRn9t2A89afj0x/dZ7jsejqiNND4HweS
	0+tmql0DJRj3s5YCpkYHoUVmjkGbm6HXaxn4RGSVY/06T3WR32pB2K0hM7iSjMsp1iGgXzhWNIK
	0BIQqfcdbgVTyE0XT1kf3pB+Dm4uqg6AiMXPO3VV1j5iztyFxX3X3QWPxZje0ipLEUNm4fTbEVC
	tHCFQZoPo0t9ko5+mGz9wEwgBz1QP4di8Tc2j8QbuTy4ffv1iegYWYRhRX6/WsJH7VjOxPlhRD8
	0wmHWGs9mIe0BRYN6w0XgWMrB7rKDWrnrV++w0HyBcKIqgcc63QswR3zsG
X-Received: by 2002:a05:622a:8592:b0:517:82f4:a2fa with SMTP id d75a77b69052e-51782f4a930mr75509541cf.17.1780585216205;
        Thu, 04 Jun 2026 08:00:16 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dcf367sm55086091cf.25.2026.06.04.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:00:15 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] Have clang-format ignore auto-generated files
Date: Thu,  4 Jun 2026 11:00:01 -0400
Message-ID: <20260604150001.15944-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .clang-format-ignore files listing the auto-generated files to
ignore taken from the .gitignore files.

With the exception of libsemanage, place the .clang-format-ignore
files in the same directory as the .gitignore files. For libsemanage
which has a .gitignore in both its top level and src directories,
just place one in the src directory.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Use multiple files instead of just one in the top level directory.

 checkpolicy/.clang-format-ignore     | 3 +++
 libselinux/src/.clang-format-ignore  | 3 +++
 libsemanage/src/.clang-format-ignore | 6 ++++++
 libsepol/cil/.clang-format-ignore    | 1 +
 4 files changed, 13 insertions(+)
 create mode 100644 checkpolicy/.clang-format-ignore
 create mode 100644 libselinux/src/.clang-format-ignore
 create mode 100644 libsemanage/src/.clang-format-ignore
 create mode 100644 libsepol/cil/.clang-format-ignore

diff --git a/checkpolicy/.clang-format-ignore b/checkpolicy/.clang-format-ignore
new file mode 100644
index 00000000..f6b7b435
--- /dev/null
+++ b/checkpolicy/.clang-format-ignore
@@ -0,0 +1,3 @@
+lex.yy.c
+y.tab.c
+y.tab.h
diff --git a/libselinux/src/.clang-format-ignore b/libselinux/src/.clang-format-ignore
new file mode 100644
index 00000000..001f20b0
--- /dev/null
+++ b/libselinux/src/.clang-format-ignore
@@ -0,0 +1,3 @@
+selinux.py
+selinuxswig_python_wrap.c
+selinuxswig_ruby_wrap.c
diff --git a/libsemanage/src/.clang-format-ignore b/libsemanage/src/.clang-format-ignore
new file mode 100644
index 00000000..c3d35d46
--- /dev/null
+++ b/libsemanage/src/.clang-format-ignore
@@ -0,0 +1,6 @@
+conf-parse.c
+conf-parse.h
+conf-scan.c
+semanageswig_wrap.c
+semanage.py
+semanageswig_ruby_wrap.c
\ No newline at end of file
diff --git a/libsepol/cil/.clang-format-ignore b/libsepol/cil/.clang-format-ignore
new file mode 100644
index 00000000..3eb2902f
--- /dev/null
+++ b/libsepol/cil/.clang-format-ignore
@@ -0,0 +1 @@
+src/cil_lexer.c
-- 
2.54.0

