Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD05E573
	for <selinux@vger.kernel.org>; Wed,  5 Jun 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614036; cv=none; b=BC5SNgv+/NA+hEaRwbfHtM0jPFZC/gWyinLVTar81p5i/kDnrl/+C+Tnf+JogrIxMQ4nTuLtZWPn14x3Sdm2nIndbZ0zG+0ccWjbSIx8Mynxfjs20lxa9Oc1s1DnbofnZbbbxT9yzeXKEIgIEHdcCypcrWnZCDfj29k6b8tPDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614036; c=relaxed/simple;
	bh=hOdDR5+dXoLUFoeFBWwlAZe2GTCrYiJCvQLLp6uLolE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjwrdujUXm0SYw4XifME78zGcLi/Em4Bh1udJfHglyWmBBSPg4N9VpdHsuYdu1kRTLoERV1jKWlRVaNJOEBtMFOqGu7pPNn3K11Ah/esVVAXazRBu2YeJ04gKUZ/Vl83bXe/tYiRYQF/A7rTHJEoSjDfz7/EvLmGFK8nsLjc9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgihRUX0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgihRUX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717614033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EaRih2PuViasJkKdBLuYMwNU8zBKZCmDsg8ofWRwydU=;
	b=ZgihRUX0Sbjn4uy66YubKrw0VmjN6c1wlfeuiebYg7eDIdwXRdixmLPyt4B3cJVlgfjWMK
	KEw7zylMzO85hJ9lfRthBPbso+PhTu3MTZ+tSUWosyP8cykJNlEjoOhOmT2DtOw8teUo6f
	m1rBO4g3MJ4+2zcQQrI9qFbaaxwR1Gk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-9FHRpaMzMiiBQgeap7rL2w-1; Wed,
 05 Jun 2024 15:00:32 -0400
X-MC-Unique: 9FHRpaMzMiiBQgeap7rL2w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7169119541A9
	for <selinux@vger.kernel.org>; Wed,  5 Jun 2024 19:00:31 +0000 (UTC)
Received: from localhost (unknown [10.45.226.59])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E09991956086
	for <selinux@vger.kernel.org>; Wed,  5 Jun 2024 19:00:30 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.7-rc2 release
Date: Wed, 05 Jun 2024 21:00:29 +0200
Message-ID: <87tti7cj02.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello!

The 3.7-rc2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me know.

User-visible changes
--------------------
* checkpolicy: support CIDR notation for nodecon statements

* sandbox: Add support for Wayland

* Code improvements and bug fixes


Shortlog of the changes since 3.7-rc1 release
---------------------------------------------
Christian G=C3=B6ttsche (6):
      libsepol: reject self flag in type rules in old policies
      libsepol: only exempt gaps checking for kernel policies
      libsepol: validate type-attribute-map for old policies
      libsepol: include prefix for module policy versions
      checkpolicy: perform contiguous check in host byte order
      checkpolicy: support CIDR notation for nodecon statements

Petr Lautrbach (5):
      sandbox: do not fail without xmodmap
      sandbox: do not run window manager if it's not a session
      seunshare: Add [ -P pipewiresocket ] [ -W waylandsocket ] options
      sandbox: Add support for Wayland
      Update VERSIONs to 3.7-rc2 for release.

