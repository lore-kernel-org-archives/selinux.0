Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62B36194A
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683172; cv=none; b=ffcawTGtmQq5qAiA7cxH8/Hpaz/QQmZVrg/O8vKAuDj75UIdTw24UOWTpQjTN7aljqtiZ3Inc2BWsUofLPcfpa/TZFmlmSgzLro3CXm7uxFCzA06qkKTCevgzCVZoqXgoT3irqHtpOjO8s3HEIzmiRUV4ssQWEc6jICpmndQ0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683172; c=relaxed/simple;
	bh=3my+l3PYWeZMFRCIaaE0JNhFutiymOpmnRDdudUrsB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SFQfrCEGPGfhoKr4VO1+Rjr4OO2jNC1t+qBLKCPawc5RZTdl4Dslw9Xt7u67kob+RYRqz4hM9P4X+0DOfi8lQTVPf4NGBDvcaB8B+DpE9td68iGqEIBunECpfDUrMn+oChzIaWrRkkHh4C08HkxIOjhrXkz8lU27DeuMj0jc+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fAxRGkRH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAxRGkRH"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so2199a12.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683169; x=1788287969; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tT3C8RmqnSUSZm6wZr0ulCb4Q+ThIVoSjKYEyKvDdpQ=;
        b=fAxRGkRHM6GMAYnjYpgOrmCqg5HlcID8o2/vi3G//H+uV9EoN9Nt2TEfzziVEIo/G0
         uPooubVqweKOeWBq1QHIx0tOSY3DYUR1aBAfiN/WTMxLm8QMmO67JTAS1891afZ4pkGp
         koJWNE8ElfrjWcXB559t8QKCoqkyulqukQbk0u/7QXf+Gy/E828S6HfLkjw2MV+gdZkc
         CF8sg1I7VJA2msGHCyOVls+X4ycaDxYElL38L/MYRE04b+5AO9935lLtGaIGohg1gMP1
         1i5N43mL/HjdqsINJLDhqcxwmudWaxgp1nSVn7mKTIiK5S7ZP/IeHYkpiJ1+9q9YlWGR
         ZlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683169; x=1788287969;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tT3C8RmqnSUSZm6wZr0ulCb4Q+ThIVoSjKYEyKvDdpQ=;
        b=MzrxcfXPBsinQkUn1lMEmIo61C4npxQkyAfEB+LYRj1a5qliLRxe5xHH6cpoEihTaV
         WJs7G//1+e5jnnsJYM6HpyfZg0o4BCn1FOaerZz85QQOcfxBZaGBTE5PhCggtUqvkKGi
         NsGibMDrbmBasH9QOIY4yWH65Bycr40LcLoLsZxFtLKFzDAB+x2y5YIvGhZQaeynoqg6
         /85alkTAY/F7tOH5YSRPuzfvXfVOMgkg5ayAneCdViilV2gpbNtZTlph+4CB/70TNoFK
         BHTbZWlURoyu3SbPxA9EsHbqNhbJNy9QUCIsdGP/Bf8zVc2zgVwPakmxKe0Pj/+MLhtk
         J7QQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRrjc0ogCkbpPogFAS5lFkCo6bD9uCeYn9wAzSzOyPJQP1K1NH85KMJFZUSg8JeYT5CF1T5DRU@vger.kernel.org
X-Gm-Message-State: AFuF++mN+lSGUaBHeynDSAKmNu3sc8nPvX0Q1CARKdL2i+51gk0MGLuj
	npUpHljI2Per3tEggDUVQ5sN4ynn+XHFDPB80bnej4wOuZaOCaBVpV0X+qBbbDbGgQ==
X-Gm-Gg: AR+sD12EgKAHqDh4RndHkLD1K6vwDIyS2qKiNNnTdqMqIwYRSErEG4oxopx3wvtvHPC
	C53t5D0wgRP9h8tF67KnDIhYCcOWHikzl3YNQYE0xVCCgoH2f8ASBOTBja+aLvsFQWvy+VyQg5L
	oDW5wrXIyzPwf6qKyomZ8wjgJkJrw9AVkCHLzojjyrKfaqY0txy6ORNDhtzqWr5DmJRbd5dV6Oj
	lGz80iGIE+enmPs2X0jW3R+9rak4ViO/lIU6B9JOkV0umFRIcPt4dlT+cvO1kZGn7XIvBz7NZ2j
	Hfv9WdgnotC8VEn+EiuoJcl13A39GHOtLILaqmCmhNCZzx4snsyQRt+nMx4mou9OC6Gn6x/SFhO
	0hBTl9EguVwYXdwW6Irq4bYzcdMDxsgjtyoF+a1oMJ0jfDdmxNIsRcn5tP/H0BevZ4Jmn1meD51
	2HTG4jNZGgfRHdDufBYDP8NZepLL10cN7rrZcmF/Va9Hxl3Vppm4RQ44Jy0aP3ohdcROlH8/kWY
	8YrJsc+kRUB+0MBLNRZamcXF55UoZZN45krRxOD4Ahi6FI=
X-Received: by 2002:a05:6402:b18:b0:6a3:f7d8:3ad4 with SMTP id 4fb4d7f45d1cf-6a5dfca7b3amr1462a12.9.1787683168580;
        Tue, 25 Aug 2026 11:39:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d68f9sm80514866b.1.2026.08.25.11.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:27 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v2 0/3] proc,security,selinux: let SELinux block FOLL_FORCE
 for /proc/self/mem
Date: Tue, 25 Aug 2026 20:39:16 +0200
Message-Id: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFThjWoC/2WNwQ6CMBAFf4Xs2ZpSW0BO/ofhoGWFVUpJCwRD+
 u9SjCePk8ybt4JHR+ihTFZwOJMn228gDgno9tY3yKjeGAQXGS9SyTx21E8LG+wLDRomZSaUUrm
 WtYRtNTh80LIXr9WX/XR/oh5jJhot+dG69345p9H71Yu/+pwyzs5c1+KkckSuLo21TYdHbQ1UI
 YQPKEUY48EAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683163; l=2342;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=3my+l3PYWeZMFRCIaaE0JNhFutiymOpmnRDdudUrsB4=;
 b=CzHbK0+zJQEADKtDDA6uH3pn6OIbkz9AIyUC7L2oco+isP3+dILkPd73rgxSL8Zp2Mfh41/xz
 R/eca/Dd4dYAuMNNed8z8xlHOsoo0c0+4YBDeYEufBVe+D9K7QOAEz+
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

 fs/proc/base.c                | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 20 ++++++++++++++++++++
 security/selinux/hooks.c      | 22 ++++++++++++++++++++++
 5 files changed, 84 insertions(+), 3 deletions(-)
---
base-commit: 2f1baf1fc8929e6c48370be543ad028ac7ad4131
change-id: 20260814-selinux-pokemem-44625557c4d4

Best regards,
--  
Jann Horn <jannh@google.com>

