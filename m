Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3261EF388
	for <selinux@vger.kernel.org>; Tue,  1 Apr 2025 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506090; cv=none; b=bB7vnjJb8MeEe7ib5KE4zJD31dmpVgOnuqe8muqRumSqt8ivkrkph6X90F7BnP01mdepVwDizhNAkKa90Ik2VUnwiCYkm3QZxFQK3+cBHjnFIxwx7Hr1x7QhmUjIND/u6LzAOzrBnrOgIZRdzeU26yKLIjfSXYClqRx4v7RDzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506090; c=relaxed/simple;
	bh=Y2rNRAmskaEUV9Q4wlz3wLxpx8lz+ZMkWTPRdMCqORc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmKziob3xJ0a+d9z6sTUJcwWYyrlgLcPumUq+4tO1rRhE3hi+zO833LINKcFdNG5OhBbXHtqEEwlnSqbmIJg1XBoYFOty8tS5+oxWoptkUZQn1Od4SvyCaRm4nN0xaUfjjRBK3HJFRzfUml+AqZPXq0WFVb7+Gayxmt9LDLGtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENkZoLZ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENkZoLZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743506087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Y2rNRAmskaEUV9Q4wlz3wLxpx8lz+ZMkWTPRdMCqORc=;
	b=ENkZoLZ3S0oDpZKAJoqGy0blVjcxs00vbexO6HF7L5Q+KSewByjzqyB1KfzIeiUFPNgXX/
	hfqUxrDnAM25x9rtXL7aSO0xP1uPaUxm8YCwt/O6t7o76mTCa1zBADv91dkuGJ9hLM9HDI
	NQ0bLiWxy8F8L4LpWjtMcalGMTtDunc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-WrkucBtVMjal7ZFEtv8UoQ-1; Tue,
 01 Apr 2025 07:14:46 -0400
X-MC-Unique: WrkucBtVMjal7ZFEtv8UoQ-1
X-Mimecast-MFC-AGG-ID: WrkucBtVMjal7ZFEtv8UoQ_1743506085
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CDC3180AF50
	for <selinux@vger.kernel.org>; Tue,  1 Apr 2025 11:14:45 +0000 (UTC)
Received: from localhost (unknown [10.45.226.174])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6A811955BEF
	for <selinux@vger.kernel.org>; Tue,  1 Apr 2025 11:14:44 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: systemd - selinux: relax error handling in permissive mode
Date: Tue, 01 Apr 2025 13:14:43 +0200
Message-ID: <87ecyc5e1o.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi,

there's a pull request on systemd [1] which tries to fix systemd so it
does not fail to run services in permissive mode when the filesystem is
mislabeled, see the commit message bellow. If you are interested, please
take a look

[1] https://github.com/systemd/systemd/pull/36929

@msekletar selinux: relax error handling in permissive mode

Error returned from security_compute_create_raw() means that kernel
couldn't compute target context. Very likely because file context is not
known to the policy, i.e. security.selinux xattr contains some garbage
value and we are running in permissive mode, otherwise returned context
would be "unlabeled_t" instead of getting an error.

mac_selinux_get_create_label_from_exe() is used to figure out create
label for socket units and we fail to start the socket if we can't
figure out that label.

However, it may be necessary to start some sockets in order to get to
the point when we launch the service that relabels (in permissive mode)
the entire filesystem and reboots.




