Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6F3F2101
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660134; cv=none; b=cqGQQvP3Qf0UxMiWf24i94xA5AMdSxjyER2gDOH0ywKWIA+lZnBe1dmKvLUpyrf7sMAeESbHnvAJFCkOjHN8AuuXS9vpwS6pg39msC3C0CY0QaSNEutuKVavRdavePCa8s7muGs2QXwvlVxgfjf/+5gJHW3cufGjPuOdxXC2JPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660134; c=relaxed/simple;
	bh=0k76shGr2oQAFny16daBHbg0eiCx4qb2xUG3aerIR2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDM5ANi5VuEwaBsGNLQRZys9tkU7WdrvlBTquuyq6XANDcQibAj91krk+lQwTktWMR6GVMBvs7AlqYpp4wNl7Aaa+vilE2mftrVHFKMPOsQDQtpO1IjJmqiWOWpPbrBm31CvKHHgeVvjymZMVJLzoP3h4bV7ZsgUNzjil2Yvacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN4lSy8E; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN4lSy8E"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c15bf5000so79622201cf.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784660132; x=1785264932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtDUfVl7E+w3NuCW/Rxsi0/u53d4AXdez+J+Ap1BFHU=;
        b=HN4lSy8Evk4GtlQ/OVNoMma+1fLb0zQthZC20fdDyApDd2gsiDakAJFvWJr5wOWgkw
         DGnwXh9/CxYfwVqY2pR+nk3afA6at25Fo2PwMYaFXufv6aqKhlI7dYoLjj1V0S4R+7O1
         eEfPzoIGKAVEd4zNU9mwHPHwY7knODYyLVvkoUtjuk+1Ss8jtQRNwBomiU8fkuIORQOo
         ySv+L+QIlUn3CcKfN/XhScCg66At0VGSpHpq2rPHlYcYpV1hudVbTKBtwGJha6aeBTwz
         sklKb1fpn1UZCr7DONoz92QLYgjWVD8FWYVALIct6/UA+YCNtEbs1IbIRiSf8dZZOCLN
         haQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660132; x=1785264932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtDUfVl7E+w3NuCW/Rxsi0/u53d4AXdez+J+Ap1BFHU=;
        b=HC5rNqvPCuXppMER3EINF042no/DYyGw+d+bQpCDynoVHpHnSpMjQAYYqNfN2hrHe9
         9whGc467G5mG/GHcTPLf5iGS+8Kz4w/YwXE+KEes3iXwvcbSFd7S2KGlPWGEJ6hAP+0m
         gG6qsodN6vh57grVRlk+D5bWvXPcQyhiRcjjhJ2ZlRJ1NRX6aBOjYuIdnB3bpb1jPfAN
         FC0lgQEa6XS481d6VxpzGkX1v1niDxEUZoJCBz2fefyFbRRFCU/DvDTYmhrrAkF6CHAh
         VPc+Spe0CWfuXhVZI0du61scCHtpVH8Odsune++0WhtvyNGGlpQe7y7yHxci6kEl9j6i
         2Y/g==
X-Gm-Message-State: AOJu0Yw/6b9lrOO5ZSGJQFiddyHJkP19YCWPeuVnqqHyRoNF1/PAcMua
	y+UhYYScvMFP6rc3MuOJZ/pwaX12i/C2GZn1fChXbi2ly13NW+L5mBN3ZkYd+w==
X-Gm-Gg: AfdE7ck3gACak12cr8kqjTi0y2oJKAj+bX3vM9DeNuZr80GqnTi8VtKUuxch7/klH/7
	pnRbHt5HpCc00jOPyydepuuRpvZr8x/bskolI7OplU/o/rrmeuRwtSXW0IA+EairwhPmXdd43p4
	WKF8Ta18SUCeAMpZzkwpLHcKGhuKPoC+pQTcwFL+3+6PkWKo8nx1y66f7Ay38lzviQkmaZa416f
	mPcG8OYukpybaGWUunNnWK8GILT32bD0i/N2FjZ3H7uhJSIq+llDVD4Sebe+S+3zQJlKBhQ5VYl
	naS3uxpwwgwnsQ63Dh5u4qRz50v+w2+M7PlHZwXJHTqD5Lnrm9erK3vrUmx+tMyxjY9d3ECD3cG
	A5ZYfE+fZCXiEjOnSfRldjuv4UQbOCEvsDTQdanqlCInkkW6wXJerNl3n1JBFKNLWdlLVMksCuq
	SNJYkng1vwu9zg0cpGqmZXfYTrBPO+Qch9Tlirw8QTPMUOjs1NYL8wSSf8T8q5cRCbj+3gQjkrW
	fvuSA==
X-Received: by 2002:ac8:584c:0:b0:51c:9e6:ec42 with SMTP id d75a77b69052e-5213dba3846mr197284251cf.57.1784660131733;
        Tue, 21 Jul 2026 11:55:31 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d402cb05sm739601cf.31.2026.07.21.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:55:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	cahu@suse.de,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] python/sepolicy: add a pyproject.toml file
Date: Tue, 21 Jul 2026 14:53:58 -0400
Message-ID: <20260721185357.64896-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
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
 python/sepolicy/pyproject.toml | 19 +++++++++++++++++++
 python/sepolicy/setup.py       |  2 --
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 python/sepolicy/pyproject.toml

diff --git a/python/sepolicy/pyproject.toml b/python/sepolicy/pyproject.toml
new file mode 100644
index 00000000..472faf7a
--- /dev/null
+++ b/python/sepolicy/pyproject.toml
@@ -0,0 +1,19 @@
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
+dependencies = [
+    "libselinux-python",
+    "libsemanage-python",
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

