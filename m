Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7B1DC99A
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975441; cv=none; b=H+A9JiFB65L+3EOEe8k+FUi0xWfUyuejCzChADWiwd+2d7ghmbxMa9fli3ZoE5eBDWjadxmyVf+1p5X9mQ980ATFYlyVOQuxuacJvt+yQlX0U/R6FKkHhsp2NhwLzE1w7WgaDQ+lCVm2EXhATGPVjK6z5bvGlWfzVcIdF66qf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975441; c=relaxed/simple;
	bh=BW1k2kSY/H6GnbEA2RR7LsJLpVTcWd447IMjxfUJo8s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IhDwEwYvGyisFlQ2jG3iINPFLXsOaVCVLdHTg+fHLs2z6v4Bvf34JIYGBKn9HHpAtVqHU0eo+bD/HPikxU6lDr/ER5uLaZeb8Dzd4hTk8j+xoLmEy7XW0pLKAA3pGjPzFwqtdffW44mL06LHGUHHEmNtiH/AiMCt7fjBtIu/U/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WurEj1w7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WurEj1w7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736975439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TaboB0GEdnFkMDOVwBpt+f3shxmrWAGNoAGGu7lZo7o=;
	b=WurEj1w7Mu98ZFbWctSkPOG+5l0MdUrXiAHyQYTe5whZO3LNZt6pfHY78w+tynNNWP4WSy
	Spx+tpOps02svC8hiMxAJHyisx6GtBWjpYGqTQ1wvCDw5h24XlNA8xXM7Rgo2sfywtiA4K
	tTyqBpsMeArXrp8/EpXz0OH975OmW9I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-qtWIPlz-Nuizx1rq1xikLg-1; Wed,
 15 Jan 2025 16:10:37 -0500
X-MC-Unique: qtWIPlz-Nuizx1rq1xikLg-1
X-Mimecast-MFC-AGG-ID: qtWIPlz-Nuizx1rq1xikLg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A44631955DCB
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 21:10:36 +0000 (UTC)
Received: from localhost (unknown [10.45.224.36])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26670195608E
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 21:10:35 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.8-rc4 release
Date: Wed, 15 Jan 2025 22:10:34 +0100
Message-ID: <87msfrwzp1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello!

The 3.8-rc4 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

This is supposed to be the last rc release. If there's no blocking
issue, 3.8 will be released next week on Wednesday.

Changes
-------
* Code improvements and bug fixes

Shortlog of the changes since 3.8-rc3 release
---------------------------------------------
Christian G=C3=B6ttsche (10):
      libselinux/fuzz: readjust load_mmap() update
      libsepol/cil: free nlmsg hashtable on error
      libselinux/fuzz: handle inputs with trailing data
      libsepol: fix typos
      python: fix typos
      libselinux: set errno in failure case
      checkpolicy: check identifier before copying
      checkpolicy: remove unneeded queue_head()
      checkpolicy: do not consume unmatched identifiers
      checkpolicy: clear queue between parser passes

Daniel Burgener (1):
      CONTRIBUTING.md: Drop dependency and build instructions

Petr Lautrbach (1):
      Update VERSIONs to 3.8-rc4 for release.

