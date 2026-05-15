Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05438E8B8
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875927; cv=none; b=R9MqVsXXy9vKe16K7ubfKHPKIweGr9XnO9NGoN0lZTvrw4aAyef1meRcQJTBqoDfNZ3c+BnS5KGqqAK4w6PuAEqTfzZF+dLYrw44MaFhBeLXyOLo/8eC0IyKPVTRywEx9dC1Jgut4qzyF86RTmUKxNyHq4cc9O1ajCh6TnBM3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875927; c=relaxed/simple;
	bh=Ly+ZwBawLhkfdgQDGDpJyqGJZDeHc5mgi3Y4gcw1Bqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUKDzOXUHidH07fH2j7JFUwjIA7kIZKo7hR//kycf5OOLqvYUsqxilF7vsONLWvPq69QfXoMfG+ZvVzvgtHdb27GyAmNSoezGa2lmog+XJRKd0S2QWEbp7guRUvmbJ5DyXCqNjq/vIPCyPDDdiTd3IWns9QpXWqZlnOzwW8ExpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=poM6pgZU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poM6pgZU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso3632921cf.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778875925; x=1779480725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD7DW9Me00pyfmPvpMMnVLU6TTku6Z+38r8LwN3sQjk=;
        b=poM6pgZUs7IeZ8TPcuMENDL0pY0NJFw4tYlMxJs5JUfmtShu6MNiauAHQetF1nh5na
         eP1SDZ6zSNNTBbIXUqCUTpYtpfVJF8CmBGJyCdJ1ANwjloMqfd24VUJLVO0S6buury9n
         I1rrRvwYdlVR6jTvyXe+UXWR8NJD66+RZh581EmjjDrjVXCH87I80JIjfMqJPRJla/bB
         yzFGK4Jrd+WIo9qBLhCJoOC9sqRd0WNpesXl6l3snMx4c7EvoZh0qr54csHvobrYgXIL
         a7UUDyTdM0wFpf8ZfDDbgNxilJ8NFxmym5JinG0AypsogsNtJfYYzK3f0FzLYELvbiqK
         nMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875925; x=1779480725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rD7DW9Me00pyfmPvpMMnVLU6TTku6Z+38r8LwN3sQjk=;
        b=OrX1YgNelO5T/Y8m154c3NAwOoPLfuKtvjytYJBHjNiNbzq7kgMa1r/ZHrLcWg6jKA
         yc6pJV8PzW6Jz/hTmDAxdXUjoXuztouZECNbiDs4NMVYlb7EfqZwF4Vo8ta5hUwI/Dga
         T62WTXM8UO4catcRjJIX8S7+OmoHx6uizctZeRrqkQn7Cr1ObXykPBrvqBMJKrFidgt2
         zEfVfcg7oW1GfL80glNRDupKAa5xt0RFNK3XntU3RcG4d1yBq3mar0zfJ+nL6p36W4u+
         B8Pgub2MmDSJuO9nBrtymvQa1ZS6oB0lgxDgm+rVcf18O99pyAmH5bTOT0TS0nApuvf7
         ppDg==
X-Gm-Message-State: AOJu0Ywk0hqmdqlToTs0urgbbBuaSptumZdtSh57wC8hsLJvE7aLPr5P
	iuzFMYaZ4shAaIzdmYzD0JghGVqgJBtGXYol4zY8hlxwArchLuhV1itzTwRA6Q==
X-Gm-Gg: Acq92OEhBr5iZpKJImpfAQmR2UW6fcjh3HB7WxeYtyCQzw5HDo+/7JV4rchXLib2iw5
	C+G2y2x52RiyeZctDeRMuhQoHEN21QSzvy6kmtYhrV8IQQ8WGfCu0CYiEy9htnEMlxqOnZNWP+s
	AiCsERKCsfZWWqy1gT12Nv1UMz3UEiX1ilSQ1Z4vCQN2PgkMg1XrkiMZPnMCb0GjKH3hVX4+SzF
	T9F+SweKnOTvzfh2OSgvwyrYYIVE5H1MLjRb38S+Bk/vSobQjjnTJGw4p8TAhdbD/YjqadGzsH5
	PNAfMsoeI+fgAUuEnrpiR5Q8KCFC0Rv+dVrkkRHFu3EII9bRdPw3Az2FcUW0WTPZxWJkEUOJxja
	okA4awmVUNtCA++VKGd2JdoLe3y7JKwG/92s3r9i9wQjh/h8z6XudQ5GIhd3JacXzz+DnEplQ8v
	GMzUAWP+H/xV+siPJZII1uiPob1ahDIISEHuKzWI50e2POQVaG2B3BUgOcgWrfKJQwV2031RpKK
	gLRSPWaxp2+tfiy5ocVOPHBANRC29178YT20JkeuAUMSWuPzP8fYFs=
X-Received: by 2002:ac8:5ccc:0:b0:50f:b13e:b746 with SMTP id d75a77b69052e-5165a1e4662mr81495231cf.44.1778875924644;
        Fri, 15 May 2026 13:12:04 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca1188c2c3sm32200826d6.5.2026.05.15.13.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:12:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] python/sepolicy: update for modern python builds
Date: Fri, 15 May 2026 16:09:53 -0400
Message-ID: <20260515200952.35857-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515200952.35857-2-stephen.smalley.work@gmail.com>
References: <20260515200952.35857-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup.py build is deprecated and no longer working on GitHub
CI runners.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolicy/.gitignore     |  1 +
 python/sepolicy/Makefile       | 10 +++++-----
 python/sepolicy/pyproject.toml | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)
 create mode 100644 python/sepolicy/pyproject.toml

diff --git a/python/sepolicy/.gitignore b/python/sepolicy/.gitignore
index 32fb47f9..80824997 100644
--- a/python/sepolicy/.gitignore
+++ b/python/sepolicy/.gitignore
@@ -2,3 +2,4 @@ build
 tmp
 *.bak
 sepolicy.egg-info/
+dist/
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index ccb22fe7..4a4a3512 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -14,11 +14,11 @@ BASHCOMPLETIONS=sepolicy-bash-completion.sh
 all: python-build
 
 python-build:
-	$(PYTHON) setup.py build
+	$(PYTHON) -m pip install build wheel setuptools
+	$(PYTHON) -m build --no-isolation --wheel .
 
 clean:
-	$(PYTHON) setup.py clean
-	-rm -rf build *~ \#* *pyc .#* sepolicy.egg-info/
+	-rm -rf build dist *.egg-info *~ \#* *pyc .#*
 
 sepolgen:
 	ln -sf sepolicy sepolgen
@@ -26,8 +26,8 @@ sepolgen:
 test:
 	@$(PYTHON) test_sepolicy.py -v
 
-install:
-	$(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+install: python-build
+	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject.toml
new file mode 100644
index 00000000..dc72bc8e
--- /dev/null
+++ b/python/sepolicy/pyproject.toml
@@ -0,0 +1,23 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "sepolicy"
+version = "3.10"
+description = "SELinux Policy python bindings"
+authors = [
+  { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
+
+[project.scripts]
+sepolicy = "sepolicy:main"
+sepolgen = "sepolicy:main"
+
+[tool.setuptools]
+packages = ["sepolicy", "sepolicy.templates", "sepolicy.help"]
+
+[tool.setuptools.package-data]
+sepolicy = ["*.glade"]
+"sepolicy.help" = ["*.txt", "*.png"]
+
-- 
2.54.0

