Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035D369236
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915560; cv=none; b=YY5k/I4sx/BCQ6QHIL7NMV5Y3pMZ/c6VAf12DsszT5BCczGaR5Evj6yyqBGMx+dzicRAZoFkZsXtOjwpQHV5its6DBb2HWxR70Vw/CgvMhSP8AdaRA+TCgiWzpnCanGDm8xj7PJC9epZ7fNU5FF6VjgEF3QPSk43rO8/LEVG+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915560; c=relaxed/simple;
	bh=o9DGjwmJY/zVe2+d4/CE5+i8XHvtPC9MwLNWmlyrb5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tubCblMXSKHHDzrEHgFQgOkAsF5fdqicuJ+S4J+KqwXauaTlL2kFaiM1OFr2ZGSWPyDm6wHDcjVz3LsdsEuYz7/SFFDx26fX2jnmrOP287qAHlMh5S9F/jinWidDKvwQDLUnxYClfwFSqp789guzr+5sFJJkkbY4x941r6CXwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGiiOCNn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGiiOCNn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so7725536d6.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784915556; x=1785520356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFITSsZv7uKGmjNcrel3RxjzyEB/6DhvpVPr3DmL/Ys=;
        b=ZGiiOCNnHuVpx6uZYG2VeHiSMwmgz+H/xw/fu1h/Erm7gnO1oK8jp8IJleffMjMN0t
         /O2WBARFY2Yt7INjAD1Fkma55jKkepHWYQ7LVBFucZE0/i/gcmut+l8DuUanFbCgqK+C
         lT264PQAqZSsfnwV1AKbyjeiP57IuIYFUkeOkoeD+1AxeEjKvvyy7oFbOOtuJ3yh2zPs
         hyZeoaYVmmgT9ntKaDPp0LrMH8JT08WNyVifO7nAh+bIkXaSbaO5PfVqoNO7USA6aAQF
         n7XuUz0UrmZZQDM1r0RPdaA/k0xJt+P7OrDSXH0tFcRKAhUywojXsqwOaNnIlFpXu+OF
         eKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915556; x=1785520356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFITSsZv7uKGmjNcrel3RxjzyEB/6DhvpVPr3DmL/Ys=;
        b=RPNAha5p3qBah9xDLFoFeps/fRI56HQvUMW5VOIoJGdwLkYWoGc9eJj0VnXmM06ZMk
         cAUCuEc9SEYy51ebJwnJTV9GWX5e5YZBLZC2qAYdDNHpr7Vl0glVYo/n/IUMu2FskzW0
         o4HQYxEjQ30GJjmihdoaNtVMUxOWDv1CHxKz5WoFsupQikqR0l1xdppFRuCY1s2IMdJ3
         g95lE8GWEAH16FPZcC9iN4rI0y3aq817a85IGD5lN21Jof7c89HUSHuKi26JRU7tKT7z
         f51IS3PtwokNVx3Co/mGxD0zYzNK7iR0F0F3XqIWXYeHyDH0dd7uh3mKKO03N57hA/9v
         J8Rw==
X-Gm-Message-State: AOJu0YwVS5xO0QE9HXGJvuo6xgOZjOtXAKDTwvqf2VYJBL1VPbBOknal
	ejLJzarQy/D9hZiBFj2JPUsheloMAMemXNPvPbDe+EosKKjMfRYb/uNpdMpMOQ==
X-Gm-Gg: AR+sD133iZ9yqdzJx0rrqGdhQ/OC/z1PmQcIjWNOakCxomjsbKlkHVzw8YMbtdh6dM7
	bxkZkpRSNMK26pnIr19Bh8XVxDQWMKn0nrcZ5o48lFcM+41vE8HRERi0ChZgl0TjPx1RiISoWa/
	mPMCJSZ4rfdQ6OAWKpsQB8eiItp8tdc9x6s0qE4cwcnfYMsYtG/csSc7OFV1ylhofYnK+kvLPHf
	DSJkhQKt1uRvYjGma1X++EsMha+enk1E3UgUnvpayvQG+RuGtHa+l9j6tLqGu6h5SZX/KPw8EOA
	SR2G2g4k7ihMwJ8iZnJp5znA5UgNcJU2DK+snLKEbWRammHmv/HjUlqpE66WxDlTEe5oGYOa16b
	ta9jPLR0sEyyNl31DKNF3hg5OYN+1o1rlICthuiUKEoF/MYHz5+is914yT8lEUC884u+jNnAqwB
	iiarM6Pb0xi5/MaligOQLeXmSpEcKX7Zc2vYJKm8PNpZ1LHMQFsEkZqAVcmmLQ6xH1Ri76FreUT
	HRlPA==
X-Received: by 2002:a05:6214:4283:b0:8ea:184f:c15a with SMTP id 6a1803df08f44-907ca28df1fmr107683876d6.17.1784915556017;
        Fri, 24 Jul 2026 10:52:36 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e8522e7dsm3327106d6.6.2026.07.24.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:52:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	cahu@suse.de,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] python/sepolicy: add a pyproject.toml file
Date: Fri, 24 Jul 2026 13:51:01 -0400
Message-ID: <20260724175059.18960-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
References: <20260724175059.18960-3-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a pyproject.toml file for the sepolicy python module.  This
required also updating setup.py to avoid defining author outside of
pyproject.toml, and I further updated the authors to refer to the list
like libselinux since Dan is enjoying retirement.

Fixes: https://github.com/SELinuxProject/selinux/issues/505
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 drops the dependencies since those were breaking, presumably
because the libselinux python module is just called "selinux"?
I remain unsure as to the correctness/completeness of these but
they did pass the CI fully.

 python/sepolicy/pyproject.toml | 15 +++++++++++++++
 python/sepolicy/setup.py       |  2 --
 2 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 python/sepolicy/pyproject.toml

diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject.toml
new file mode 100644
index 00000000..d33e78c8
--- /dev/null
+++ b/python/sepolicy/pyproject.toml
@@ -0,0 +1,15 @@
+[build-system]
+requires = ["setuptools", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "sepolicy"
+version = "3.11"
+description = "Python tools for SELinux policy analysis (sepolicy, sepolgen)"
+license = "GPL-2.0-or-later"
+authors = [
+    { name = "SELinux Project", email = "selinux@vger.kernel.org" }
+]
+
+[project.scripts]
+sepolicy = "sepolicy.__main__:main"
diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
index ca0396b5..5c4f2e5d 100644
--- a/python/sepolicy/setup.py
+++ b/python/sepolicy/setup.py
@@ -8,8 +8,6 @@ setup(
     name="sepolicy",
     version="3.11",
     description="Python SELinux Policy Analyses bindings",
-    author="Daniel Walsh",
-    author_email="dwalsh@redhat.com",
     packages=[
         "sepolicy",
         "sepolicy.templates",
-- 
2.55.0

