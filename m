Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3C824B7
	for <selinux@vger.kernel.org>; Mon, 13 May 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635387; cv=none; b=qb8BJOFQIGaWlvaMo128KgFNkry0kVC0cFlMmZzrm65Qh8pZ4e92jSZ9lZQSPl0fCEhjBsLFrUDDOOFADhr1cMwGOz6xEQt8X86igT6NhV3kLimMBGO8YuUROnX9Iqoylcd/WMPGlRdh0k0mY+wFkHF0oNL1zIOOUPeGjhYUVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635387; c=relaxed/simple;
	bh=vLna6LECv+0HMYVMV351U1LfIFCPTAckesZrx9GAj1w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Ipe2gb8Q7hwa1SCfLOjytyyzKWq8ZEE9Magot/HKDWVGTEdVNm4xeVZZ7lUrbDcWlnT42cXKiDBXTqHgLNzTaCWHBoMqrLCBdzfLxMhQFcizwvJzDazV4GugySbDIDU3znfL8wK8Vqqu8aCRIQE1jKYfpbDiY9R560e9o5wBzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nl1fCdn4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nl1fCdn4"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792bae4137bso490046785a.3
        for <selinux@vger.kernel.org>; Mon, 13 May 2024 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715635384; x=1716240184; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb8wPi+KZnMkYbJ5IU839Hv5TQgYYO/fRuvxhtwV9Vk=;
        b=Nl1fCdn4vNLjDW0JrhbwdNyd5hqtJ91fLHjMaAXEfwPHY3eRodW4By2snmqymVIqkT
         IICv61VZwCMhSD4rhFzlhPEZMDbtP7mntDE0jyqmlSHrzYTiM+iREM8S8gdT64e4qbJf
         hn5Z4BU2flzODRXxRcFOSRnHRVF80EVozSDi/DVPCKKn6kbVs8glrATxWxqKGSWQwp7m
         4ZsU20ZKs+FHVSNcs7NjjogJYXn7bSHwLjXVEZynQ3kxdN8RHkyUdkkr1/K3JvsnIuGK
         FsC1JFUuZTkGULQ55XLFes/bhN+/cNXjMwS/Uz7MJmjo0mg1F9y/I9WD/p15Zm8rVaP1
         WKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635384; x=1716240184;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb8wPi+KZnMkYbJ5IU839Hv5TQgYYO/fRuvxhtwV9Vk=;
        b=LvSr/UXkRy7hMf4AjH5zKvAxaMcaYhGIwXAulzOFh3WQyZNIoKSAg9Grmj/VlOQ36i
         CTMhOTC32gOtdlMz1AYTFbrcYiuI+OMr0Sgt28KIfNuYNCvnL42LgOIRBWkYefwfMwQ+
         FWvE2sWdlJlqfiCxZuUyvSlT2IrB+Sffqr8ZgeF5WLvZy16BrN+oYTJzk6mJh8b0jBLJ
         iju58X/59k6ZQw/yXUp+4r8xocqo9Gh2lAV5dTz3HDfNmCq/Gj895RjyHOz+Q/RTVGZ9
         0H6q43EA9vv0DUNNPccOMtAswYaVWziiO6xLlFr43KZzfB1UNmPkkTYy88aAb0RX4Fm5
         5PrA==
X-Gm-Message-State: AOJu0YyR0dQHlGoDjjH3kAtvRNBPkRCe7bn3oweCLpQNXC2WYGKTr8rP
	GV0ZDoMXKOjZqXzZUhQCsWDZD4UiKuXdTjvWvI4n+M4fKZhRSWDcERm6k/U09Q==
X-Google-Smtp-Source: AGHT+IGTl7fHLmqwsnzbbNq35xBGLNS++kzizFC7K2TTwi/qzO/1S4yJ8nsIIASTA+0mcFQVGJ6wYA==
X-Received: by 2002:a05:622a:24d:b0:43d:e71e:9772 with SMTP id d75a77b69052e-43dfdb2b230mr104484941cf.40.1715635383622;
        Mon, 13 May 2024 14:23:03 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e166e3755sm19959021cf.40.2024.05.13.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:23:03 -0700 (PDT)
Date: Mon, 13 May 2024 17:23:02 -0400
Message-ID: <32b581d2da1208a912f4ad200b08bdf1@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240513
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

We've got a variety of SELinux patches queued for Linux v6.10, the
highlights are below:

- Attempt to pre-allocate the SELinux status page so it doesn't appear
  to userspace that we are skipping SELinux policy sequence numbers.

- Reject invalid SELinux policy bitmaps with an error at policy load
  time.

- Consistently use the same type, u32, for ebitmap offsets.

- Improve the "symhash" hash function for better distribution on common
  policies.

- Correct a number of printk format specifiers in the ebitmap code.

- Improved error checking in sel_write_load().

- Ensure we have a proper return code in the
  filename_trans_read_helper_compat() function.

- Make better use of the current_sid() helper function.

- Allow for more hash table statistics when debugging is enabled.

- Migrate from printk_ratelimit() to pr_warn_ratelimited().

- Miscellaneous cleanups and tweaks to selinux_lsm_getattr().

- More consitification work in the conditional policy space.

Please merge,
-Paul

--
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240513

for you to fetch changes up to 581646c3fb98494009671f6d347ea125bc0e663a:

  selinux: constify source policy in cond_policydb_dup()
    (2024-04-30 19:01:04 -0400)

----------------------------------------------------------------
selinux/stable-6.10 PR 20240513

----------------------------------------------------------------
Christian Göttsche (9):
      selinux: reject invalid ebitmaps
      selinux: update numeric format specifiers for ebitmaps
      selinux: make more use of current_sid()
      selinux: dump statistics for more hash tables
      selinux: improve symtab string hashing
      selinux: use u32 as bit position type in ebitmap code
      selinux: pre-allocate the status page
      selinux: avoid printk_ratelimit()
      selinux: constify source policy in cond_policydb_dup()

Ondrej Mosnacek (1):
      selinux: clarify return code in filename_trans_read_helper_compat()

Paul Moore (2):
      selinux: cleanup selinux_lsm_getattr()
      selinux: improve error checking in sel_write_load()

 security/selinux/hooks.c          | 58 ++++++++++++++---------------------
 security/selinux/selinuxfs.c      | 36 ++++++++++++++----------
 security/selinux/ss/conditional.c | 18 +++++++-----
 security/selinux/ss/conditional.h |  2 +-
 security/selinux/ss/ebitmap.c     | 50 +++++++++++++++++++++------------
 security/selinux/ss/ebitmap.h     | 38 ++++++++++++-------------
 security/selinux/ss/hashtab.c     | 10 ++++---
 security/selinux/ss/hashtab.h     |  4 +--
 security/selinux/ss/policydb.c    | 24 +++++++++++-----
 security/selinux/ss/services.c    |  3 +-
 security/selinux/ss/symtab.c      | 20 +++++++-------
 security/selinux/xfrm.c           |  7 ++---
 12 files changed, 145 insertions(+), 125 deletions(-)

--
paul-moore.com
