Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76514BD0E0
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446298; cv=none; b=LhBmdBqrGa3o+eI3oiOADbJIfGrV/ox3wHUnr6ogIokgablqgTVJkcRliMql3aAzJHG9XQ+xkTsWmgrAp73Nfij5QLqL2gOrFmEcBlawaGEV59GcT5NXfxXy5xxeOmHejP1b5A1hIdblhU1b5xB+iDiII0koWajNtsuF15BmtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446298; c=relaxed/simple;
	bh=ock/vT94/EPboSV8JRK1QMeei72OLgPlBYSueGhWfj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTL5puJUKGN6o6NkX7q5pYCXMBrBVyiNohKMn5DTz9GBtOgFYNTbE5mNPFG4+NGL47zrUP4HrqFNTHjGiSMJGegyO6rKMeBZ6TpV2jK6S69+hwsatt9auFL1QeY3TSHFYSEdPHId+LrVE3hu8f7RMagz/UUTF5P/d0xYMRWsoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyFfvxBp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyFfvxBp"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53016020b2fso36862631cf.0
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446289; x=1789051089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+Z1ZHGH0zBLPDGpNdAn2afXlGQah4ChnCNAX08DSJw=;
        b=GyFfvxBpmD74mewWRMqzW167FYdKPejIiMgnD59Dq6+OqtNjUrR/UwNG2CV4E8pHSU
         j8W2Yvup3Br2PSsOThXqswLSWRWmyYabMzsPkC10fkBUeoWNxXFOReCKSuhqeY0wYmL1
         r5lEB49wK83+TeyMTFPr0DcyFc5iItZSj3Zd24k6LIC/SzwTzEbhsynIi4UH6jL081Gu
         P8RtN9MfqMWH8g9LHerTGSWzcpfMDJZf5SkXEMc0sSdReaSGfIdpKBYmvW1R2+17BLMt
         Ajc1N/tZz9qkqkIQ6gi5GE/BBb5PA6P6av2ArASPq9fGMTQUFZNwnsw2lxvV9t+hDAf1
         ygeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446289; x=1789051089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+Z1ZHGH0zBLPDGpNdAn2afXlGQah4ChnCNAX08DSJw=;
        b=DXgVMjwd4wBHV7r0hljYhqn/f/bFEcacXZYqnd5S0T062Egsdd9Vt64VyVirGzwHL3
         dq+3WxDCkT8I1jp//cb3MhclrqmHSDXBMdPlshUtQkdBfWdsgZzgmkQ2JI7o8JZKLb4a
         W3Y2NqxNYO35tIC7Ui+S/nt7xNF7BOU7EkGXcwkR+QoYt7eyUp5alkVUZ6ydBh+5Cnpp
         m317zNqI8JMANaVdUVLGKrtcMvQ2DQThzs/W+FcmgtHLvzdWpe9gqyCBP4corWF2Ynop
         WyZfl9+nxnFxT7AiPFwP2hX4aacN3Dj8+mpXAj1DcknKdy6wO/hm4JrAhBIariWp72jP
         DRmA==
X-Gm-Message-State: AFuF++lRmFkiDqZwK3e9Xb9jf41xn7b0qPlncCWEDKFYS799H17Nvw2L
	rSX0oaJ+sNRVvBSYNjfDq2gSpEYoyIrQvBnRO/UANQP8oAL649Kp1ih+jYyA2A==
X-Gm-Gg: AYBFou0CMZD0HW8e5UxU8ffBn/XTOeVuoSB1BkImWXeVnTD8N0SBbOIZ8vFavLuqr2v
	O7LWw6QSwQalMHwAfkWBK+jkJebV+feOE0KxoKbv7C7GGNE7S2syzpmjaLtRf+qIbqfDhYru6WX
	xCzgaRgO3IthS9QwUgYLbI+QgdNDGCS5ZEjJ+nDEZw+4wDlyKly2KDPziICtkgxiHaGuybZ81Rg
	kHwuJ/fa8eiJZNXYxDaSflrmZfbOjJQA2QTQkLFNJNZQM3+8sgqVQjyRK5zrKs88QVea+XNFYN4
	DPz53DRAyecAU3cB//nGzv2DXeZVEqBwIGFpFyyFpPVSpMOYutpa3o6KOuIlpde964Kyqm0UGlE
	Bo02eK9nwBBoVoUjzJicub65kB32omP4vfh8c9NCbDqFu3MbvjHHLW5GPcZpKWUz4rSY21WhVGu
	ipHLYXrUGcG9wZQXMGNrbnljBOB50IVyhHgDoVr1gQYW0HjhB+ypROczF0X4iyz5hDGZC98v7CX
	cH2/aUY5w+miU17VZnpBTudBfuPsERG4kCmnU+EhzttrphfKI5D/LgZh9FHMQrj
X-Received: by 2002:ac8:7f93:0:b0:530:178a:9de8 with SMTP id d75a77b69052e-53036cc63a6mr150052461cf.22.1788446288786;
        Thu, 03 Sep 2026 07:38:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff0e44sm44115851cf.5.2026.09.03.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:38:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 0/9] libsemanage: add ro-store-root and configuration-root search list
Date: Thu,  3 Sep 2026 10:34:24 -0400
Message-ID: <20260903143433.19810-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the second half of addressing:
https://github.com/SELinuxProject/selinux/issues/33

The first half can be found at
https://lore.kernel.org/selinux/20260903142600.19723-2-stephen.smalley.work@gmail.com/

This series adds a ro-store-root option to semanage.conf for defining
a search list of one or more read-only store roots that are then
searched for all read operations when there is no corresponding file
under the writable store-root. By default there is no change in
behavior.

This series adds a configuration-root search list to libsemanage so
that it searches an ordered list of configuration roots for
semanage.conf.  This list can be overridden at build time via
-DSEMANAGE_CONF_DIRS=. There is no change in behavior as long as
semanage.conf is found in its default location under /etc/selinux; the
fallbacks are only used when it is missing.

v4 drops /run/selinux from the default semanage.conf search path and
example ro-store-root config since it is not required for the
stateless use case and it introduces the risk that any domain that can
write to var_run_t can inject files that will be used by
libsemanage. Distros are free to re-add it using -DSEMANAGE_CONF_DIRS=
but if you do so, be sure to create and label /run/selinux correctly.

Stephen Smalley (9):
  libsemanage: accept a list of read-only fallback store roots
  libsemanage: add semanage_module_find_path() and use it for reads
  libsemanage: list modules across every store root
  libsemanage: read the active store through the fallback list
  libsemanage: create the writable store skeleton on first transaction
  libsemanage: create the store root when taking a lock
  libsemanage: refuse to remove or enable a module owned by a RO store
  libsemanage: search /etc and /usr/lib for semanage.conf
  libsemanage: document semanage.conf search path and ro-store-root

 libsemanage/man/man5/semanage.conf.5 |  34 +-
 libsemanage/src/conf-parse.y         |  57 +++-
 libsemanage/src/conf-scan.l          |   1 +
 libsemanage/src/direct_api.c         | 458 +++++++++++++++++----------
 libsemanage/src/modules.c            |  63 +++-
 libsemanage/src/modules.h            |  10 +
 libsemanage/src/semanage_conf.h      |   2 +
 libsemanage/src/semanage_store.c     | 185 +++++++++--
 libsemanage/src/semanage_store.h     |   6 +
 9 files changed, 609 insertions(+), 207 deletions(-)

-- 
2.55.0

