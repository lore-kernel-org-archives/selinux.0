Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95637C11B
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847221; cv=none; b=B2WvopERM6XYP+3HthFQfFn2T/5/a13bUvpFQPuSebDbW/50x4dkHMLBnpTvdB3R45Eqz6jvEmUWdkgdZEqEjrboN1zvhvGBrAj4yxGFsi2EQrJnfJKDk5YUej2gov3Fd9bX/NWPHTTi+28Ez8y0IhXup71/vyOaB6blAjiSopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847221; c=relaxed/simple;
	bh=rGqLDf4bDYjoT9uAXfVWRVbpE1G5pvVtAhn/6RWuo/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSlgVG3tWS9BzeHdP5rhJow8/XNRd7hOn+Jgztq7MTyJuCn0JGtXRTv0FPLSuJpvQiNMsq6beeEjsZEIeRRSlqjZ0mt1IwfEtgoWuI9gzHFmw3U10R0VqfPn/EzKhx+OAO925imeENEV2LKD84sbr+yGmKZYW8gZnzqZQe3ypgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3MRWTTs; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3MRWTTs"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso12401486d6.1
        for <selinux@vger.kernel.org>; Fri, 15 May 2026 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847219; x=1779452019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkW3cjqWSBNKBpV5te1ux4BT10mlOjnwl5+0nRJKw2Q=;
        b=p3MRWTTs4O8fxpGfcxDDPo1T8wCwSDkYygSVFhGGtB70dfeyxqCAHJHDFq0x4C6O+K
         6V9yO0FsHQ/y+kOSBgvVs6URU88+J+Fvq94bZWFOXJZu9HuSYMO00xLtu1J8SLIu5CN7
         95VF163mgM4o0mehbZUen0/GSjoeiItrduYAsmup2JibqPgJY3mwcm6DCrUjIHZTAGaq
         GPgHlg18Mr4PY6B7TMOd08sSgTdMMQKvPJZy9EmBVIjpSI/+rMRGJTip1WHWtAYx7+FJ
         +T7C13d3oAmrKLUUsd2Vt9aTp1OT2u7sttsQkvNll50cOGGQ3Wy+N0aQarK5c5e3GQjv
         1aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847219; x=1779452019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkW3cjqWSBNKBpV5te1ux4BT10mlOjnwl5+0nRJKw2Q=;
        b=m8xgSeGJtzwel5fbTrpHEPwHjV5SKIB7B/sKdM9qyVQS3ZwScIpq9aeG9g34bihw5z
         uQuXV5XEQ9Yc9SDTBRBVnDwHIPEDUGwnKRZy8hq85aurXgJ+WTD6KeIRAERS2l56QOYP
         hdqV1pucgrAsOFqXSq+UTL75FiLztTZdjZLzV35u5lDhDvAoC4SY5IFvPb3iU1JQgsE6
         yQAmGZJ88m3d8XX/IbQSlDBa9HvEKobgijdCBI21s+lCDvGRJ5f9V8rb6njKnTe6maKO
         KRxH9J3FiLfWV2hYFrLo/OKTIPlz6ASE+FlCXZY6NqE2GOacVPAdXleVKmo3kcctwtpU
         C6Aw==
X-Gm-Message-State: AOJu0YzmOHQ+SNMDZSfri5GaSc9J2XBvzKbcd0+6egXJI/rlXZ++UDaR
	4bm46tny3JdIgDheKVtnDOpgXvnxy30Zh/wNpEYw6yoYbc9REPCHUYGE5vvC8Q==
X-Gm-Gg: Acq92OHzXWPvkcVnbhHmeKe8Ka6foeNXS+698kMLuJevo/GbAt8EDnBY9OZMukgJVpy
	fGsVChE5JV0h83oRRvmHeGA71hHo/0xk9n3tjiUYeGRqJ8grxXI7WAi4Kha6roR/PKOd78rxVbC
	O98BzOEFojt7NRi0SMsmiseBKvrWMswedOWDsXA1NAN7WYSHXhsFrTuQWJAS5bc6E8nhasgrlam
	nggNrkfENr6dJDqviMSZyhtNsg4rGZzonej/RDN7p3nbnUwUEbzSnCLFKqkexU33sr1viWLAa2K
	4dctks2dGbJgfMdLj0ZoY5xO9ADUM6IBFVnG1W02ETAg1scQsf6Tq5ZuN7L5lA9vX1gGOFKVMXW
	JhbGZr/jDksqmfJSqdVV8oytjW6cp5gZhc620V9TYx+IET9ufmmLuniYyVT0pFXvK6FxaJd2ORI
	G59IM3OPiXJprZcyWJKL9Io3Wn3/RR6mL2wiBodnhmtkarogw6MHN7S5g5YqRJrFNLcJm/7jaK+
	Hm0M80s9rWfMYa977r7WxfOtvrbF+iBn6JViCjYUGJAPOrqhQB5HRvTxpic23lfIA==
X-Received: by 2002:a05:6214:23cd:b0:8ae:660a:be75 with SMTP id 6a1803df08f44-8c8fba1c06cmr123725066d6.9.1778847218879;
        Fri, 15 May 2026 05:13:38 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908561c35sm50182486d6.8.2026.05.15.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:13:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] python/sepolicy: Maybe fix CI build failures
Date: Fri, 15 May 2026 08:13:29 -0400
Message-ID: <20260515121329.10807-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Current GitHub CI builds are failing with:
python -m pip install --no-build-isolation --prefix=/usr `test -n "/tmp/destdir" && echo --root /tmp/destdir --ignore-installed --no-deps`  .
  Processing /home/runner/work/selinux/selinux/python/sepolicy
    Preparing metadata (pyproject.toml): started
    Preparing metadata (pyproject.toml): finished with status 'error'
    error: subprocess-exited-with-error

    × Preparing metadata (pyproject.toml) did not run successfully.
    │ exit code: 1
    ╰─> [10 lines of output]
        running dist_info
        creating /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info
        writing /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/PKG-INFO
        writing dependency_links to /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/dependency_links.txt
        writing top-level names to /tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/top_level.txt
        writing manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/SOURCES.txt'
        reading manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/SOURCES.txt'
        writing manifest file '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy.egg-info/SOURCES.txt'
        creating '/tmp/pip-modern-metadata-dq7pf_bt/sepolicy.dist-info'
        error: invalid command 'bdist_wheel'
        [end of output]

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 python/sepolicy/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index ccb22fe7..d48c4cef 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -27,7 +27,7 @@ test:
 	@$(PYTHON) test_sepolicy.py -v
 
 install:
-	$(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
+	#$(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
 	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
 	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
-- 
2.54.0

