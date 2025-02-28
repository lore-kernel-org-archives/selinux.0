Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838C26A1CB
	for <selinux@vger.kernel.org>; Fri, 28 Feb 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747315; cv=none; b=e3VhazE+8IDbBBu0+VtxBUZ5A6Mqk4hRIb90SsD7A50Bu4RD/7aljm80XMwJ7iAFFP2Hr/gxB6GaI+ge1FERweXG1cfx/3cJVWhGEKjPcVLFQTQgp3yu76rSz5wv01GjPa1gkRh4DCbicu7FaDOh4uevoqVj9xVA6fR3fK8PiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747315; c=relaxed/simple;
	bh=RlJ+m0QK0u2N29DBEshzEh2oSE4Buusu1FjBW/QyZ7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4HyFvgoPnQDsMqP6R1HgXwpiE68S0wUrbNo/qS9Rn6hxWiRr5fhytSOdK8/KZqM44/m0NHbsEGhww48SEaRQmLvWSFVe05FXr/+y2JbPEPDjyC673gtYFQRdGyGl8yttC4laliKeZ6JSohiIY3b1y/oB3IQEm+R9eynR7rRSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADNzwm3/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADNzwm3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740747310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=RlJ+m0QK0u2N29DBEshzEh2oSE4Buusu1FjBW/QyZ7A=;
	b=ADNzwm3/c591Yn+XdGp6jU52FafUoh4HNjdQBal6KJkJSGbznnqueQ02ouhpkBVKNXfzTR
	pTzRhpa3k6OK2I8jDTi0kj4KIPYTpAr/Rs2o3aexqku8XWsH2WYTHJ/Re+uOjo1tp7t2oo
	1coEOXsQGKkYT/w6D5yh38L/vriv9EU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-OHI5K7pUP_-zP0cqnePzgA-1; Fri,
 28 Feb 2025 07:55:08 -0500
X-MC-Unique: OHI5K7pUP_-zP0cqnePzgA-1
X-Mimecast-MFC-AGG-ID: OHI5K7pUP_-zP0cqnePzgA_1740747308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE29C19560BC
	for <selinux@vger.kernel.org>; Fri, 28 Feb 2025 12:55:07 +0000 (UTC)
Received: from localhost (unknown [10.45.225.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62A5D180098C
	for <selinux@vger.kernel.org>; Fri, 28 Feb 2025 12:55:07 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Userspace: 3.8.1 release next week?
Date: Fri, 28 Feb 2025 13:55:06 +0100
Message-ID: <87plj2dyad.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi,

there's a performance regression between 3.8-rc4 and 3.8. A fix already
available [1] and acked so if there's no objection I'll merge it on
Monday.

Also I would like to release 3.8.1 version as a minor release just with
this patch to improve the performance of operations on semanage store.
Again, if there's no objection, I'll do it on Wednesday next week.

So if have any comment or objection, tell us.

[1] https://lore.kernel.org/selinux/20250225075555.16136-1-lautrbach@redhat.com/


Thanks,

Petr

