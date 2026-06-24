Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A1223DCE
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329664; cv=none; b=ZwzAfYhJe4vryeGAhAVPivY0rz15kh9+riIkC2GqC0SYWkeC8n157NarJ5Wh7rznD+Wb/U94z9WclH7YglN/GDIql49LESd/pdg6zv/FvofaogmDO7+8CHWVJDGEuGyq9QUf3biSjEaJC2DLEF5omTrvOs2UfYh/05EUvQlZDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329664; c=relaxed/simple;
	bh=LJzlxA6efMp9QwB6YjTs2u51HdKm24nxddkXOanEtBc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KjKv2SftkdNNy4de/HnqEyz6TER8uosXJLi/8to/Jl5IRbmoGB0WZrUViqsCB/SIMTqakXLjpqrv2smVMYPszHJcQYLYEkCyQOV3Tyl3YVHe2fGRYjZ4vT0RlghFtzKbD4+g5Y1tHubYtKJHtQ6aQCcdFW7kuyzEESi8ZA90Vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMZkglR4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMZkglR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782329661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Smuh9+8pkWM732Gim4h1KPS/mjSU9f1wwVdWIPv2z7s=;
	b=NMZkglR432Ol47yzm+1r43+V1cWIT9LOr22Q/e/1/OcAGJenjCjL0ndUzGu/R7EY5g6Ww4
	jRd507tMuFXumMqNBDkN80DBjzPZNzLbeEqQhl0+O/Qh7b1J1ubYchsjDzfwZXLiB/XjVs
	0edVGpU0diHslpwV9H1kFbsoVefHHtw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-7CmFwlMwNWaXuvPzi2aGxw-1; Wed,
 24 Jun 2026 15:34:20 -0400
X-MC-Unique: 7CmFwlMwNWaXuvPzi2aGxw-1
X-Mimecast-MFC-AGG-ID: 7CmFwlMwNWaXuvPzi2aGxw_1782329659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 759E21805A39
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 19:34:19 +0000 (UTC)
Received: from localhost (unknown [10.44.33.183])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6F9D195608E
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 19:34:18 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: SElinux list <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 3.11-rc3 release
Date: Wed, 24 Jun 2026 21:34:17 +0200
Message-ID: <878q83u406.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello!

The 3.11-rc3 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.11-rc3
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

Unless something unexpected happen, 3.11 will be released
next week. Also only important patches will be merged before the
release.

User-visible changes since 3.11-rc3
-----------------------------------
- Bug fixes

Development-relevant changes
----------------------------

- Improved CI
- Added EXTRA_LD_FLAGS for use by musl+llvm builds to pass --undefined-vers=
ion.

Shortlog of the changes since 3.11-rc2 release
----------------------------------------------
Chris PeBenito (2):
      CI: Fix variable use in build-userspace action.
      CI: Add explicit output variable for build-userspace action.

Christian G=C3=B6ttsche (3):
      secilc/docs: fix wrong CIL statements
      secilc/docs: mention nlmsg extended permissions
      Makefile: avoid 0 as NULL pointer constant

James Carter (2):
      libsepol: Check for proper length of addr and mask buffers
      secilc: Use fstat instead of stat to avoid TOCTOU issues

Kalevi Kolttonen (16):
      libselinux: use null character with strings
      policycoreutils: use stderr for error messages
      policycoreutils: use null character in a string
      policycoreutils: use null character in strings
      policycoreutils: check strdup() failure
      policycoreutils: use null character in a string
      policycoreutils: use bool instead of int
      policycoreutils: use null character in a string
      policycoreutils: use bool instead of int
      mcstrans: use null character in strings
      mcstrans: use null character in strings
      sandbox: use bool instead of int
      audit2allow: make error message more helpful
      policycoreutils: use bool instead of int
      mcstrans: use sig_atomic_t and bool instead of int
      libsepol: Add missing comment to context.h

Petr Lautrbach (1):
      Update VERSIONs to 3.11-rc3 for release.

Stephen Smalley (2):
      python/semanage: do not leak an audit fd per logger instance
      libselinux: Add EXTRA_LD_FLAGS for musl+llvm builds

netliomax25-code (11):
      libsepol: fix out-of-bounds typealias_lists access in module_to_cil
      libsepol: cast to unsigned char in ctype calls
      libsepol: null-terminate temporary buffer in mls_to_string
      libsepol: bound category values in mls_semantic_level_expand
      libsemanage: guard end of path in semanage_fc_find_meta
      libsepol: bound type values in type_set_expand negset loop
      libsepol: test type_set_expand bounds negset type values
      libsepol/cil: fix double free of borrowed type datum on error path
      mcstrans: fix out-of-bounds read in parse_raw sensitivity parsing
      checkpolicy: fix xperm complement at range boundaries
      checkpolicy: reject out-of-range extended permission values

