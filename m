Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF003A8FE9;
	Wed, 20 May 2026 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265156; cv=none; b=jsU4i5e1ZnhTqIaDCdVh8UlEnIXvP/qeHmWuYYx6JrNFGZP8KuX/V9eFUAwOdHm4q4m5cYXQhFG4SPuPT2wuBwLyg0dJJvj4CGB4uMpFQoRGoum42hd0IGjr25IXHxAg8zHOqduHZP8dleUICcrWodlouf2SSlF42ICIvDiqevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265156; c=relaxed/simple;
	bh=8sDsVcUg45SCDAbOd4Qy+nlWe7vZVoKzJPYWNem4zG4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nnGyr7EX8xUwfpIYB7C2LIPS//iDrvCZa3NQ4eb4ZJUujy2IdnYkkxCiw+IEuPlJScOp74Iw4SDkf6ZoR6zpfrdRlwX6NWR0emSSKcWHRtWKPEqt914DX2BAMDELRzpevKvVW4V1h4r7+i+MjFddBZuWOQfSZDcryWvT/mn9AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqb6SkS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqb6SkS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794C1F000E9;
	Wed, 20 May 2026 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779265154;
	bh=tJOszf5ccvQ8Uj34Ns+l0JyEoj1luDQ1JSgscLEUjH8=;
	h=From:Subject:Date:To:Cc;
	b=oqb6SkS5YytIpVTUQsjo2xHQ4SS571cAqH37sjtk3n5/2i0pUW5fADVVxvUdkIAgo
	 Ei/YzX4Stje++RmND/Sxw+GgF8GkC2YAKmsKtBKgIidtQ3Lnh/GOV8qbAUxWGtMSXM
	 lArDAXrc0inMaKNgo1ea/d6dZqCLBG03ZFePlkMmRKxUhrbFQqPPJeix9ku4CUhHB0
	 Sb1SCaw6Q9oKG7uzDNy2Bu9C/uFTiFz7SA1od/3QLL1sWK+kuQhsseNWJtZvEY8AeV
	 VAb9otpjpJ9Mf2ht2E7QfZB0sMJDWaA2FxwHg9a7aiS1369hhwS97doRMt9y3pWb2V
	 arJKoZ/lAdSrA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/3] security: replace __get_free_pages() call with
 kmalloc()
Date: Wed, 20 May 2026 11:18:54 +0300
Message-Id: <20260520-security-v1-0-831bd8e21dd0@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG5uDWoC/yWM0QrCMAxFf2Xk2WJXtKK/Into0ugiUiXZRBn7d
 1t9PJdz7gLGKmxw6hZQfonJo1ToNx3QmMqVneTKEHyIfh+8M6ZZZfq4SDlHn9OhD0eo+lP5Iu/
 f1Xn4s814Y5pa3wxMxg41FRrbhLvtXRDW9QtMxMJyhQAAAA==
X-Change-ID: 20260520-security-6cdd60da7129
To: James Morris <jmorris@namei.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=rppt@kernel.org;
 h=from:subject:message-id; bh=8sDsVcUg45SCDAbOd4Qy+nlWe7vZVoKzJPYWNem4zG4=;
 b=owEBbQGS/pANAwAKATkDhibLDv2RAcsmYgBqDW5yZa7B7j3ohKSc2JgmRG/bo7d/2fltrRWB+
 SeIMUzfGumJATMEAAEKAB0WIQR45VhVpZkvn3TRr+k5A4Ymyw79kQUCag1ucgAKCRA5A4Ymyw79
 kfc/B/4uBqwgyaoh4EWczWSCvk4YvrDw+P5GIcZkmNuCZQCZgn2Hx05kpDcm+rYUwU39QhN7JvA
 tgMGPGR88/BwX8R27raP67u6j1ETp4W+lZ1idGU+icFaOpOgkAUJhNMnoaD/AYaSMcNJIZk5CIr
 dg5H160CUyvtcCaHO7sCSGKOxTBqqG1Qb8w0Dw+ZWEDuplwxznqiP/VegbHSKV8nw60H6hitxX/
 +WYSMij90yhsivt8xYrlLro5YpMLv+Emy4CxwBnYAAtGzmsSjY2kRashqG5odUQ+sRifrYPPbgs
 qiubvcrUP21lk5w02frOGk4LnKpN/uDysCVOPUN4MSQ1pdt1
X-Developer-Key: i=rppt@kernel.org; a=openpgp;
 fpr=B8E96E880C4A40C3C1255AA8C532392DE6DA7CE9

This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc:

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/security

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Mike Rapoport (Microsoft) (3):
      selinux: use k[mz]alloc() to allocate temporary buffers
      selinux: hooks: use __getname() to allocate path buffer
      apparmor: replace get_zeroed_page() with kzalloc()

 security/apparmor/apparmorfs.c |  5 +++--
 security/selinux/hooks.c       |  4 ++--
 security/selinux/selinuxfs.c   | 12 ++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260520-security-6cdd60da7129

Best regards,
--  
Sincerely yours,
Mike.

