Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3D1448E0
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501013; cv=none; b=UFF1/cIzlyInBtyTppKLIFgAeaGSMv6/oDUpuKWhO+UDl5NAVm/4ft4liBIJb+XG4pko2m3fFLOY+py47fXT+Rija7DfaGPPaH49p03v3XTB8oH8a3GpaQv3BeF9o/f7vdeoDl1efqlotGh3HlB3SYx81Q7i3F9pY7JJTNbnAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501013; c=relaxed/simple;
	bh=FOgrItVWEBT01HFFoAkXvg9fDIUZH1FoLgceU9kmufs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LA6s0HyV3WgbNRWN15VEb+PwYIaXJTdsGZsasJMc91102EmPWvGB48lr/JAlbBYWQrwpr+0BtXGuo7HtBpKY5k8g8RLYtV3TTz5kzLfh98VXNn7u2W+GmV94VYrHd7e/paO97U1DKFb6ILsPxnsEaGpa7NnT7yhOPJQILs5wzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB25jEed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB25jEed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757501010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OgRAR0YgAYNQVDwzT48QiS+eScItgbG7/7voskMZL98=;
	b=KB25jEedX2aTvsnn2/cFLZrjEe8VIkdFohSDRvgFzj6/2jizypsSUzWg2XJX0m+J2ogH5N
	53r6OXkFwBGrDbL7eVWoB79NONs3Y2fwKQKi0rdTZnW4tcmHJybTlkxHFcBsEDgnKnZ5dh
	CcPTji0BFsqgXvNXSL+Dh3kuZ2XZvNA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-SRFlI-5rPnWSxJKHv-8ixA-1; Wed,
 10 Sep 2025 06:43:29 -0400
X-MC-Unique: SRFlI-5rPnWSxJKHv-8ixA-1
X-Mimecast-MFC-AGG-ID: SRFlI-5rPnWSxJKHv-8ixA_1757501008
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2246A19560BB;
	Wed, 10 Sep 2025 10:43:26 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.226.196])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2C991800446;
	Wed, 10 Sep 2025 10:43:24 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: selinux@vger.kernel.org
Cc: lautrbach@redhat.com,
	stephen.smalley.work@gmail.com
Subject: [PATCH v3] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
Date: Wed, 10 Sep 2025 11:42:08 +0100
Message-ID: <20250910104322.328299-1-rjones@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

v2 was here:
https://lore.kernel.org/selinux/CAEjxPJ7nJ7j9HPR8yEeM8ErscZfmUr0imTwUvvwZikAqsP1EDA@mail.gmail.com/T/#u

This addresses the review comments for v2.

I'll note that the man page options are not exactly in alphabetical
order.  It seems like they started off that way, but new options have
been added at the end (as I did with the new -A option).

Rich.

