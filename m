Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8E3F23B5
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814828; cv=none; b=cZrHUbarBVAxPSgdckR/IWBY2yeFak56blpZ2FVtzHGPgGilwY3f8RiafzdR7Bx5jSYwpa+HSIWqM2x9u3gE/0tw1ZKiEA2CLaAxghmy9UR1mbx1jrxOm2U5VQSa5ZBdKkeBlZO9Zy0TVrB1+2V28Hhzi8uaEQ9Y9oBf1P3vPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814828; c=relaxed/simple;
	bh=/o20sFF/mtTU8L5mYAb/n1KYsEh2ORlv2YG9SP+nOdE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bexzxths0uTN59C4r5atOi7rPB4E36ULc7eHzsZ3TTTN++4zm5M1LT5wR5fxJFjCcQIP7CtSTewpAeu0p86kVSRyKCBl3SkHuDVf/Xot4e5TmAU6gEs29qKj+/TZUJRm9s1kyQgSffnQNBABn/x06IRB4VjSiThQyDI/MhmmWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8G97Q/Y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8G97Q/Y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b5e50eb70so63185e9.1
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814825; x=1789419625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D+b4993ZhKzGPpJvQnPmdXZLIrwAdhGEw0qUUSYMGJs=;
        b=j8G97Q/Yun04nv+mVy9UmI4y4g6OFoQnGAPup0fZ972NWDE5hVU3KHEO0D9QIDZ6dH
         uG/1x1gKrjpWYSbSRlAq+hOX3YhYHzntDhMft8TUMO1jqyy+zlhGXgCdx50rXSrqiN1W
         4Qp0rUCvkCsFF1qUqrz+LFsCkyWEs2IVLg4b2OrjStMSGmIqSuN8TBFMhB0Z1irfmBCW
         HrS2AaxMeNy2PtaCbuL7SKrbI0RfBwRjNHG1E7Tb4Bf+XHXJNsXihml5lbDpEaSL/5zF
         tkzIhf/ADIOyT5AjkrfXx0YPO7gGWBlIA9oKE0U/EosSYuQcz4zCRuvn+zs7nTiJrxJm
         /ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814825; x=1789419625;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D+b4993ZhKzGPpJvQnPmdXZLIrwAdhGEw0qUUSYMGJs=;
        b=O6DbbMjI3OvcpQh2/kOdi5ESdzePOm089SMxdP+8FAtJVGYbMH8Dbqr6peAEmdC7yo
         kVlnkBQjYmozUW5cW2LNNWHcn8M0WzOLAGBQugsfNVADwCuFN/FG5YyJ8IsqFgaWPAKD
         anvadHm6gT7kQsPouSKmDhMQg1DPBVE1yWZ1+IXHw1k9LpVczsSz3i/67uBxeKJxvsAx
         NWQXoq1PX2zI3PGWLM+fRHbmvy1Oe3xgigjcJm93jJwiTiDiN9xTOhI8hKHVXxTLWxh3
         8rQPGpxj4uBXyBgxjz2tiFR+Op9bOvTR3whjndNPwvqotZHlvsrobfocBiY3qGvywi/a
         vcjQ==
X-Forwarded-Encrypted: i=1; AKwUvByuS+RCReQ2X0y+1zErYBLQi4IcShtEKcWVFy43L0KePs8y/js1pybYbyNhZyVpEjGQegMC5fuL@vger.kernel.org
X-Gm-Message-State: AFuF++mpY4Kzt4WihMnJeir4Jpl7HhKBO0xeQgHOWVPhAXrcQ1Kdyt1H
	yZiD7WKN8qRj7YC/lHi1IKAy+hSFc20Is9P3YBkvZ/09qJYWQn5uk6jLQnuf6DCMCSuRZTmvXPY
	zxN+0XNRG
X-Gm-Gg: AYBFou0KwzS5TStXU8wMYOjGoAWizIj3dMZ3wsFX4cxCxaq0SuHkKcMeT0D6Vk3bbTo
	6g5eH/BIlOxw/1g4NlnTsI3G6vEXwDYSF33vMFntZx7sVWR1HX7VEe2yltfjxcCMAY4Dk0xaOMh
	AIXwUg+0I/n9PfbolK100xCJhaPk7ir+tRsS+sbZR7y0Tqm8HKqgfS+4wda6HZDN3RBnlCQiJMa
	aw+AytmcHnMCi4e2l/E7PVVpXatKD1YU8WVX7MLmtreCxXNwtBmuDXOpY+w6TvoRNauRiiS+Sed
	Oh8Dy7elXHBSIiPFGiDIYYuFFgb1Oq/VHzDO0mt6RYEE0cjMSP2DMcQ+pUJ1PRKnosovW++Nn5R
	BgXPO2GKTjbTjTLmgfECVH23dghErHFxWH9O2gQIBdVkaYZFqakQEelnU/AC7UbXaLdbOtlNJ91
	kaGAjdTFVdiQo6n7QlniKGbVi6XYgS9xJ3Mi/1/lL0f0/PkC+aPlrrXjuZSsG5vKp+LRXfJ026x
	WSl8iMs9wLzJUkDuylNPxGZJGq6+00viMUsaI40GWSe0kAt
X-Received: by 2002:a05:600c:4907:b0:499:c3da:6f40 with SMTP id 5b1f17b1804b1-49d010d5333mr1538805e9.4.1788814824871;
        Mon, 07 Sep 2026 14:00:24 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm31385050f8f.26.2026.09.07.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:23 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v3 0/3] proc,security,selinux: let SELinux block FOLL_FORCE
 for /proc/self/mem
Date: Mon, 07 Sep 2026 23:00:15 +0200
Message-Id: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8ln2oC/2XN0Q6CIBTG8VdxXEdDBNSueo/WRcJJKRUHymzOd
 w9sbTUv/9t3fmdBDqwGh07Jgix47bTpQ2SHBMnm1teAtQqNKKGCFCnDDlrdTzMezBM66DBjgnL
 Oc8kUQ+FqsHDX8yZerp92U/UAOUYmLhrtRmNf20ufxt1XL3a6TzHBJZGKZjwHIPxcG1O3cJSmQ
 5H39AegfA/QAFRMVFKwMhWq+APWdX0D0PGq6AIBAAA=
X-Change-ID: 20260814-selinux-pokemem-44625557c4d4
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2679;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=/o20sFF/mtTU8L5mYAb/n1KYsEh2ORlv2YG9SP+nOdE=;
 b=ZmXwRrsF/uOMvXyg2m7GmtJZlNUc+YLd2/rhXAsPu69kHUhI7vrs5qtb/BA9P/iraL5bnyjG/
 PNa4GM+tlO1A+/0obRL7/8fzwsyCzvQVSba93+vtc8dnC/hvGRcnTz5
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The goal of this series is to let SELinux prevent the use of FOLL_FORCE
when a process writes into /proc/self/mem and the system is configured
with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
is still used by current Android devices).

Android has SELinux policy that attempts to ensure that only trusted
code can be mapped as executable in several system processes, but this
protection can currently be bypassed by writing into /proc/self/mem.

I wrote this series after discussion with Android security folks about
the state of proc_mem_foll_force() restrictions on Android.

I'm sending this to:

 - maintainers for LSM hooks
 - maintainers for SELinux
 - maintainers for VFS (because I think they generally own procfs?)
 - some MM folks just as FYI since this touches GUP usage
 - the Android folks I talked to about this

I think this should probably go through either the VFS tree or the
LSM tree.

The motivation for this series is that Project Zero managed to write a
remote exploit for Google Pixel partly because of /proc/self/mem, see
<https://projectzero.google/2026/01/pixel-0-click-part-1.html#whats-the-plan-seth-and-jann>.

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v3:
- pass opened_by_owner as boolean flag (Christian, Paul)
- call security hook independent of kernel config
- documentation changes (mainly to adjust for changes above or suggested by Paul)
- add acks
- Link to v2: https://patch.msgid.link/20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com

Changes in v2:
- change SELinux hook to only check PROCESS__PTRACE (Stephen Smalley)
- rename ->introspection to ->opened_by_owner (David Hildenbrand)
- rename introspect_mem_foll_force hook to mem_foll_force_opened_by_owner
- improve comments
- add ack/review trailers
- Link to v1: https://patch.msgid.link/20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com

---
Jann Horn (3):
      proc: refactor /proc/$pid/mem to use struct as private_data
      proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
      selinux: require PROCESS__PTRACE for FOLL_FORCE introspection

 fs/proc/base.c                | 43 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  7 +++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 security/selinux/hooks.c      | 31 +++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 5 deletions(-)
---
base-commit: 2f1baf1fc8929e6c48370be543ad028ac7ad4131
change-id: 20260814-selinux-pokemem-44625557c4d4

Best regards,
--  
Jann Horn <jannh@google.com>

