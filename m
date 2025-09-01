Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7EFC120
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737263; cv=none; b=fzzj7mGz3am2G/CM4+/G76OcXn5R8Jjxmbt5oFJoQt/LDi2pDflDvJJVs6h2PL8HQkgyLlmxPXBGlm6RyA4yKb1aKUnpTbJdUNEEEvVZUeR9jm56OO239QTCWptEdj/SkAYa0nxZuAP90XiKpBowUD8TA0dvoOGT47usD1cfH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737263; c=relaxed/simple;
	bh=8aTdRsg7DZnQD1M2wkbog5jvR5bFDopmYNjPzXqWNMQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N0vGrRsQ9Zplu+Be++QIdGzGLzor9u9/04K0BV/7dEUhAmIMCtNRlVcgHSzzmN66CnIYvHkcJhc6SqM4xYmQxpiPnSDwpd4N4YGBMMt5RqRffPSb/gP5Siy4p37RsNPyMVNb1JNZlIJdPAbXk1H67Fl2p2gsbPJwHoHs4e1BzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuugzHg5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuugzHg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K17HOntwQb0b9ALRvr7GBMZ+GrbhiLAe/Is7X6VMts0=;
	b=DuugzHg5DHjRaTZuZckcufDNIPjX8i8IzLF8Pa3/oj7BnIx2j7OKyDmjf6hwqMBR2iNuRQ
	Gi7yWjDNFwnEJgJv4YQEkJZ32GAFXFOpgSUrrOyYN/xtBevT/47UTqo8C+Th0JLsKvDTK3
	v/kPEueCjXyZ9Nv5nH0eR911Px7CzsE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-LPAKk2D2OLG3bEt4yg6Xqg-1; Mon,
 01 Sep 2025 10:34:19 -0400
X-MC-Unique: LPAKk2D2OLG3bEt4yg6Xqg-1
X-Mimecast-MFC-AGG-ID: LPAKk2D2OLG3bEt4yg6Xqg_1756737259
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D55A81956096
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 14:34:18 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0638B30001BB
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 14:34:17 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
Date: Mon,  1 Sep 2025 15:31:12 +0100
Message-ID: <20250901143412.2904562-1-rjones@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes that have
differing contexts.  However doing this involves building a large
internal hashtable that stores the full path of every file examined by
setfiles.  For filesystems that have very large numbers of files or
long pathnames, this uses a lot of memory, which makes SELinux
relabelling in constrained memory environments infeasible.

This adds a new 'setfiles -A' option that disables this tracking.

For example, using setfiles to relabel a filesystem with 15 million
files took 3.7GB of RAM.  Using this option, the same filesystem can
be relabelled in 121MB (albeit with no warnings or errors possible for
conflicting labels, but for our use case we don't care about that.)

While this is quite niche, reducing the memory usage of setfiles
allows us to do offline SELinux relabelling without worrying about the
number of files in the filesystem.

Fixes: https://issues.redhat.com/browse/RHEL-111505

(I also posted it as a pull request here:
https://github.com/SELinuxProject/selinux/pull/490)

