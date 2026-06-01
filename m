Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4D1F0E25
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332294; cv=none; b=HiQmOck7HXInt5Uk5TMcrE1tY5AuSdSLPmNr8/k6yQXqXm+asXCMJL01JpJxyA+ZsQTdYbCiwHlQDLyLwEzlKk1jlT08/kgx6m7yy9ODyxUTZ1+wnvv7R39ue1AB+VcJShQPvdQf97CHP0y4gnm+nS0zXHNnoayt3SkehVuUPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332294; c=relaxed/simple;
	bh=aQLEcUXrJcVB5pOsidymZm6IV5QKMkPuue9GaJDvdew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=axLq9TAI5xdjY70KRffkaxc3lNGzvDwaH2e7x588RD3rk5KWgAfMcx52MHE6djaT0ImB9iaHw8v0skXm113B53bFkDGcm3UfUJIVtoBse8r26dNpMOk/j5yYcn1EeRJ/EUAFcZELGWQMQrcKDnbx082q1aZyyjQnIxVoGVf8K90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkjtfpUZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkjtfpUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780332291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=aQLEcUXrJcVB5pOsidymZm6IV5QKMkPuue9GaJDvdew=;
	b=CkjtfpUZFTKESR4Ak0weAKRNH1Pynwf/J/VTKuGflvbkJAWzRL4dT9qcjdstWUJZAUUcBN
	MHJWqlRWKWvMdZXGKdyFpeYey6xVdUFQu0SIe14YsLxPsuc7d9mUKw50Ayp0+CSB7O0jwG
	XbEuD+8HmVlewWGaLDueGP1oXONq1vQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-K5TYyHCOPsKno0qU1PsRIw-1; Mon,
 01 Jun 2026 12:44:50 -0400
X-MC-Unique: K5TYyHCOPsKno0qU1PsRIw-1
X-Mimecast-MFC-AGG-ID: K5TYyHCOPsKno0qU1PsRIw_1780332289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB59019560A1
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 16:44:49 +0000 (UTC)
Received: from localhost (unknown [10.44.48.123])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 427821956095
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 16:44:49 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: inconsistent clang-format
Date: Mon, 01 Jun 2026 18:44:48 +0200
Message-ID: <87o6hu5hxb.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

we're planning to apply `make format` based on clang-format before the
release as followup of commit 0a6b917da08f ("treewide: add .clang-format
configuration file")

I tried to enable clang-format in CI -
https://github.com/bachradsusi/SELinuxProject-selinux/pull/10 but it
fails even though locally, `make check-format` passed -
https://github.com/bachradsusi/SELinuxProject-selinux/actions/runs/26768512424/job/78901357862?pr=10

I guess that there's need to be some version lock of clang-format.

Any idea?

Petr

