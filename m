Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393F156225
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528253; cv=none; b=dZ5ASVJTMf6hJPSwAiiodxgJ1pUxM6s6WB+5HVJmWaaYL2xJ0mANebXNrT7VwSSujtaBYZV7q0WulJl9sT/8j0qAcdcnHrS7gWgmUpc6FL9z2E9y0P0TWy2ppz0Cw4fCqRGwtQVvHfzZKzimlmxc3qa5y7fzWwIbIGftiFXj5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528253; c=relaxed/simple;
	bh=zIRI58xBuBMh1zaXmiPQ7j/VrnYKa2El094QUfWG1ZU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CytEx7DGQoP7YqmdIdW93VkmnGB2mV18qXgHWm3RIOOLWhRYFPVlg9jyrSAIyGPA6f/GVJhDIvTNyMPdZBkGU/Js+46j0FGfLvOhx157WH/e4gXQpl9xAQi9/T7Mo6J1MV+OGn9slb5uDydH5ZE5/6NY3eTyI6Wp/gLn725BAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/FrxU93; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/FrxU93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734528250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AKmbvFZy1JquBODaWO35loLIzC9VS6l6inEFG0U16Sg=;
	b=e/FrxU932IiY2Y2HTBWKLeZTGAXgNbdWJm2Lxb0aBi87oWVXM2r7se/0VCG+DCGYhjSVLD
	V37uU6lIhHC6n3K9CpZHxejDXNuIg6FiP6KroawZQo1/FSMqUfj8qNHbxjVr7uRUl0gGKL
	nXHGIDeerZ4N789mq94aRu6HCJKXK+8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-xsJ1N1tpOa2k_TpaqP3pDQ-1; Wed,
 18 Dec 2024 08:24:09 -0500
X-MC-Unique: xsJ1N1tpOa2k_TpaqP3pDQ-1
X-Mimecast-MFC-AGG-ID: xsJ1N1tpOa2k_TpaqP3pDQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 945461954B1C
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 13:24:08 +0000 (UTC)
Received: from localhost (unknown [10.45.224.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1392430044C1
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 13:24:07 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.8-rc3 release
Date: Wed, 18 Dec 2024 14:24:06 +0100
Message-ID: <87y10dxgy1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello!


The 3.8-rc3 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

Note: 3.8-rc2 was skipped due to the regression in regex spec ordering
which is fixed in 3.8-rc3

Changes
-------
* Always build for LFS mode on 32-bit archs.

* libsemanage: Mute error messages from selinux_restorecon introduced in 3.=
8-rc1

* Regex spec ordering is restored to pre 3.8-rc1

* Binary fcontext files format changed, files using old format are ignored

* Code improvements and bug fixes

Shortlog of the changes since 3.8-rc1 release
---------------------------------------------
Christian G=C3=B6ttsche (15):
      libselinux: make use of calloc(3)
      libselinux: avoid dynamic allocation in openattr()
      libselinux: move functions out of header file
      libsepol: harden availability check against user CFLAGS
      libselinux: harden availability check against user CFLAGS
      libselinux: avoid memory allocation in common file label lookup
      libselinux: use vector instead of linked list for substitutions
      libselinux: simplify string formatting
      libselinux/utils: use correct error handling
      libsepol: avoid unnecessary memset(3) calls in hashtab
      checkpolicy: drop host bits in IPv6 CIDR address
      libselinux/utils: drop reachable assert in sefcontext_compile
      libsepol: add missing word separators in error message
      libselinux/fuzz: update for lookup_all() change
      libselinux: restore previous regex spec ordering

Petr Lautrbach (3):
      Update VERSIONs to 3.8-rc2 for release.
      sepolgen-ifgen: allow M4 escaped filenames
      Update VERSIONs to 3.8-rc3 for release.

Steve Langasek (1):
      Always build for LFS mode on 32-bit archs.

Vit Mojzis (1):
      libsemanage: Mute error messages from selinux_restorecon

