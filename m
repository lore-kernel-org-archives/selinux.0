Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000291E519
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144293; cv=none; b=blZ9LVsXAIXPdXzqrjKthQ3XQgj+hiXdRykjHWozPH0fiQVXgOpSYvQTrS7el0lCoDEhZE+ae+NLvedEoVLwZR/rQYZHhLYdHlyV5R677N7HtYtkNL1PgI3PVUlfI677kroXoaNdbAbA9QYCANtnbNu/wfDPsuXcL42m0hQx2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144293; c=relaxed/simple;
	bh=vbndi8B0c3Eoko/nCielg7xIDfQCh1WFYXBWNlhK4B8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUWpR2h+uWbaWDxTUTjxMTYUeIr2EDf3kPrkP9ikxWrFymAtyjYlfp1WcJ5Mqljx/6vCl9iKLek5epDG11a8GsG2SbZIqgDC/6kq/si/M+bC1uSBFuDER7xb8KV72OIjhN29ztZ8+WgiFaTzGDXbJKAZfsWp3cIc4VuG/y4h25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/MbTFic; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/MbTFic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=vbndi8B0c3Eoko/nCielg7xIDfQCh1WFYXBWNlhK4B8=;
	b=O/MbTFicTnZsWxbDDMLYholnrSrnfM+pQGrKowrEA4h7UyZiXLYBfmIDsjZyV/ddLeeZjQ
	6Kl2N1t3/r/cwf3bdaQtqAeDYhtSlRlNLNCGkSaxFOobCkJS5hTspGuV+RIQtI+zom8SOJ
	5oU/u17PBYC7UTHR9aorMdXep8llPBg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-iaxMFRaANkyibgwIbV4Ubg-1; Thu,
 05 Jun 2025 13:24:42 -0400
X-MC-Unique: iaxMFRaANkyibgwIbV4Ubg-1
X-Mimecast-MFC-AGG-ID: iaxMFRaANkyibgwIbV4Ubg_1749144282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0441218003FC
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 17:24:42 +0000 (UTC)
Received: from localhost (unknown [10.45.224.97])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77DFA30002C0
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 17:24:41 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Intent to release 3.9
Date: Thu, 05 Jun 2025 19:24:40 +0200
Message-ID: <87frge6qzr.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello,

It's been about 6 months since the last release so we're going to start
the release process.

I'll tag and announce 3.8-rc1 on next Wednesday, June 11, 2025 and
continue with next rcX every two weeks until final release.


Petr

