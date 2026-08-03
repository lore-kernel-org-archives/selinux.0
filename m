Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5D40DB46
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778852; cv=none; b=rflBt3T+1J/GtBZki2GRIH5BgdqkmIWaK7dHpFVC13oUXxzHaCjht7SsZW6k21exESHQTbf/jAXgAls29aa/Z+5qPMceOsjcItvbSAtdtu2z2j6itH9XOB0zgR+skh/DqwTogK7wSnhmyYGcha9rZCYbXUvgWOBZ5SjvLwSzHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778852; c=relaxed/simple;
	bh=mgP1lmawk5zGuAe0O75qozSZM0lwEHaWETKIC2bXDCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5ttlpjLk4MULrku7PLehddbSy/8MCc5FA2lfmNzM5RUOV2kTwVbEsPCsYGV/MD1oyBgeo8KbGTJTPQNfJR0GpFdKP6FS+lp302AwiA3XotTVCfGqziwiHFKPtMcXoLG/9w8am8/0WQBc+HJg6XgXFZE693OaWN88u15tY4KNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grtyePil; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grtyePil"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92edb12cdf2so231756985a.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778849; x=1786383649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qk/y4PJjtz4FVaBB6GxIlNXBnpLHAh903sxvSrD1gwU=;
        b=grtyePilp/jzPv+yKr/HoUaJRhogPaOwkJf2hLeKAqEFaxjCvqeESKUDGfZcD7+5Ro
         +HVQryK4NB03lJnT3IQQNhNfm2MBb9FhxIhp4gb/QzHFb+NclX6w//yU45dNS77BagyR
         mpsqCawB7aSVK3krhELxyX75k7XtKqiSffSHSe88foy6Qal3j/WMAdDfTNffq859/VY8
         vjn9SbTirbrZsLKQ5niB6xGP3+zwl79kxctn5zW8xt4dhpPZYl9Bc5iGTye5pv0hBRY1
         fKkeD/3PNt4hOWqj2AQjnR18kTWomhG1q5JgsS+LFFzEvOTgj7rh/1MIf0Llod7vXQu+
         8ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778849; x=1786383649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qk/y4PJjtz4FVaBB6GxIlNXBnpLHAh903sxvSrD1gwU=;
        b=ogu/XYHdK2TjLILnmEqTcT1Ql4nL41/UNqTdLwqEUbVlbDHKittrumjE+IrcvdvJ2p
         Z7rLrAPO850FJN785YvFvSTLdP7NzMW+F98zySVYS/OViIi3zeH3DmF9KW4Lz5+zin+Y
         ZXjt3mCguTF7mUz4MH6sD1qMKo4mGCVJJJA8IDjihQZxlQTo2yX8R5nwlB91dC8AjzPe
         VZcpwNW3nFHaCB3uCUHTjHKiGLzoN1RfhTwtz9UggtdZFQeZKAYpRzcFJs/+/3uwTJ5M
         Qffo6EcQsGMPe+DYJjCC1+KnzQTJWmzc9jlILml9bOPD0jTk0j1u4oFHvPD9kmzTYRpH
         6Uqw==
X-Gm-Message-State: AOJu0YxUuwX4TdYkH3tpwc7NIyjOUaDf2HogmleXA79Uzq3IOQskwFSw
	Ze+rxPg6f17QZAGleYhA5FSdO7SloxKpidP5xdc7mT8j1qk2XWfMHGW26dvR3A==
X-Gm-Gg: AR+sD11pUL1AQ5cDTnMr+MMEahYtZIDYcWeDR3Wk/R9aEUyc1T++nQXTCYnD01sK9WD
	cQhFMXe7XDy35m/0fCg5Gj3S2MZq2ViscnhQ6hfwhP1dFR/TIWnwNV0s7A+HsfI/nC+utqGpToB
	DB223vxC4m084e9NJSEH0Ry/l09Mj2Oq83MypnmP8q/Zg1UVbTEuPthXeIyjV6S/hKh0or8MSNX
	MVbD8LDq3fPMa7TCGgNGYps/BAYThjgvucAlxjjtVWGvHQK0WtuSZzNkoINw3rLrI0DQJLr+OYH
	psPzV/zaeVjAX00gBCv+omvNF6e1N8xFPPPHuFzgoyqe2PKqyandzbTDHqXlzB6Lb0RUzaLWDhn
	pHYY8tc5EbW2LacnRMhL7MvJeBUMs3pQR3eBBCHRw+VyVIo572bNwCP+LSo1kt1WfaciUlqWCm+
	h9/ZtH5WXSm2c6RZkRjWkwS5JD1h5d4hLl8WLM4voKP1EmnlY4S7EnTFGeoFCQgGjNsZ7PXtZ4s
	2p1vtaSTF07YYvtVH8LitLH3Fn0mcdjjEl8k0JiIZHdGGBfD86p55ey7yoMkwTB
X-Received: by 2002:a05:620a:4387:b0:932:dc4d:c755 with SMTP id af79cd13be357-934a07937a4mr2096676985a.15.1785778848837;
        Mon, 03 Aug 2026 10:40:48 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349bc46968sm709024685a.11.2026.08.03.10.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:40:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	paul@paul-moore.com,
	jgsegitz@suse.de,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] SECURITY.md: Codify the maintainer process
Date: Mon,  3 Aug 2026 13:39:52 -0400
Message-ID: <20260803173951.46352-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Zaman <jason@perfinion.com>

Since security issues are quite rare, best to codify the processes so
when they come along we can fall back to this and don't forget any
steps.

Signed-off-by: Jason Zaman <jason@perfinion.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 makes the changes suggested by reviewers and drops the RFC/draft
language.

 SECURITY.md | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/SECURITY.md b/SECURITY.md
index 49c40e97..52ab863c 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -13,16 +13,23 @@ involved.
 
 ### Reporting Problems
 
+Note that issues that depend on attacker-controlled policy can be
+reported as regular bugs to the public selinux@vger.kernel.org mailing
+list and do not need to follow this process.
+
 For serious problems or security vulnerabilities in the SELinux kernel code
 please refer to the SELinux Kernel Subsystem Security Policy in the link below:
 
 * https://github.com/SELinuxProject/selinux-kernel/blob/main/SECURITY.md
 
-Problems with the SELinux userspace that are not suitable for immediate public
-disclosure should be emailed to the current SELinux userspace maintainers, the
-list is below. We typically request at most a 90 day time period to address
-the issue before it is made public, but we will make every effort to address
-the issue as quickly as possible and shorten the disclosure window.
+Problems with the SELinux userspace that are not suitable for
+immediate public disclosure should be reported using
+[GitHub private vulnerability reporting](https://github.com/SELinuxProject/selinux/security)
+or emailed to the current SELinux userspace maintainers - the list is
+below. We typically request at most a 90 day time period to address
+the issue before it is made public, but we will make every effort to
+address the issue as quickly as possible and shorten the disclosure
+window.
 
 * Petr Lautrbach, plautrba@redhat.com
 * James Carter, jwcart2@gmail.com
@@ -35,6 +42,10 @@ the issue as quickly as possible and shorten the disclosure window.
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Ondrej Mosnacek, omosnace@redhat.com
 
+If unsure about whether an issue is in kernel or userspace, feel free
+to send it to both the kernel and userspace maintainers and the
+maintainers will handle it internally.
+
 ### Resolving Sensitive Security Issues
 
 Upon disclosure of a bug, the maintainers should work together to investigate
@@ -57,3 +68,26 @@ lists.
 
 * https://oss-security.openwall.org/wiki/mailing-lists/distros
 * https://oss-security.openwall.org/wiki/mailing-lists/oss-security
+
+### Maintainer Process
+
+This is the process maintainers will follow upon receiving a security notification.
+
+1. Make sure all appropriate SELinux maintainers are notified. Regardless of
+   which maintainer was initially contacted, others should be looped in. This
+   may also include the kernel maintainers if relevant to the issue.
+2. After an initial review of the issue, maintainers will agree on one person
+   to be main point of contact. The response to the initial mail may come from a
+   different maintainer. If the initial mail was PGP signed/encrypted, the
+   replies will also be PGP signed/encrypted with one of the above keys.
+3. Maintainers will work together in private to verify and fix the issue. For
+   larger fixes, this might involve a github private fork within a draft github
+   security advisory.
+4. Maintainers will prepare the fix as soon as reasonable. Maintainers may
+   invite the reporter to the draft security advisory or private fork to help
+   verifying the fix.
+5. We will aim to release the fix publicly quickly, but may request an embargo
+   period up to 90 days if the complexity of the issue requires it or if
+   severity of the issue requires coordinated rollout amongst distros.
+6. Public disclosure will involve pushing the fix to the public repo and
+   publishing the security advisory on Github and to the mailing list.
-- 
2.55.0

