Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BA235079
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083660; cv=none; b=Y2aM7sQITw/fed1irT+EJr9pS1gW5MyyGa5SjdflWMMj8qk6bFyX4c9mGjVE243Ne3xA1pESfhxcIZA/eKMTlxN4UulocGvqldd5qttlVOndjn/15/922Z137gIvL+kYL5bi3PiyGnSsC9DHXpBTvcI6y+qA8Vmz5MBkHqVDx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083660; c=relaxed/simple;
	bh=FwZUPbG8ivJQhJTYp8fDYMXg3NmuV+UkuJyu+XL9MwM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u3xonGmRekZ4X+00LGLJvBTM7xomMgwntc1M+2onSlrm/LPuyIQXwf1TDNooHcFql1xtIZOQYj50uzKdEOXC947dO3oNsSu3tB94SRVgLcfvR9xjsnCvf6qh03W+jO9PTzPgKlUxZMJr9Xtumsvs4pYbIjaDLXUBEY2K6rJGVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEkPp5lQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEkPp5lQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752083658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rp/F/euGuNKnLYtf23I3ANSX1CCETJqTAmaE/XIQku8=;
	b=WEkPp5lQYYUzvUbkp16Knrb7w1ERBHYvOFj23z96pTjLXQsC0rJQuic2hwW3xhdoH9Xbfu
	py9k7cFRuj6FznN2+hzqnxFiDfpOgd+YxMzwh8MjPkh6D7t68D09XiK52SMmz8L0H1Gkpk
	WwDPPi1zXuv3L3zNliRi8bMzoL0YFNI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-zoWL5SNkPm6BVBU9L7c6BA-1; Wed,
 09 Jul 2025 13:54:16 -0400
X-MC-Unique: zoWL5SNkPm6BVBU9L7c6BA-1
X-Mimecast-MFC-AGG-ID: zoWL5SNkPm6BVBU9L7c6BA_1752083655
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4DDC1944A82
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 17:54:15 +0000 (UTC)
Received: from localhost (unknown [10.44.32.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B64181956089
	for <selinux@vger.kernel.org>; Wed,  9 Jul 2025 17:54:14 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.9-rc3 release
Date: Wed, 09 Jul 2025 19:54:11 +0200
Message-ID: <87y0sxgsho.fsf@redhat.com>
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

The 3.9-rc3 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/releases/tag/3.9-rc3
https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/bachradsusi.gpg

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me
know.

If there's no blocking issue, I'd like to release 3.9 next week on
Wednesday.

User-visible changes
--------------------

* Bug fixes

Shortlog of the changes since 3.9-rc2 release
---------------------------------------------
Alyssa Ross (2):
      libsemanage: add missing libaudit private library
      policycoreutils: use pkg-config for libsemanage

James Carter (3):
      Policycoreutils: Make pkg-config work for more types of builds
      libsepol/cil: Fix copying of declarations
      libsepol/cil: Expand class-permissions in deny rules

Petr Lautrbach (2):
      sepolicy: use multiprocessing 'fork' method
      Update VERSIONs to 3.9-rc3 for release.

Thi=C3=A9baud Weksteen (1):
      libselinux: Document thread caveat for security_compute_av.3

