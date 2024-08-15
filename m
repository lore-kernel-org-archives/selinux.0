Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723213B288
	for <selinux@vger.kernel.org>; Thu, 15 Aug 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751203; cv=none; b=HrL3kDizPo8qbBgPBj7PsSM+LykEqcALkpMm+WUhNY8vP7Ns7/4SgJpAFbNgLOQtccAvGV0XDr47d8BlJqIjEOSqVsPbQ8a1GFDb3AjpyJiHJaad8RIYozW/SC3vXyNc8jTzbZt26v1FTTC66NbrUk2DAP5TyKyB5OqPu6gwqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751203; c=relaxed/simple;
	bh=r9BUfohUq44ghTk7Ggo5cn7xGSmzUposKb2aPQJ6cPo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dkZPOke9I0Uoc3RU4elcyl7Elk1Tbm1qlYqHsZ7irFV9YBG5PLa/tAIlPB+hng0kf1+c3KcxWRg/N1MM+i/1svdY3cuTF7WgzKMHyG5YfamRVQO6sdNgF3SU9pjt0CA1P3Vvvr060W9jOwsoaWnhhPrHX0TnjNBdwsW5x838EFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtSHGQFI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtSHGQFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723751200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hscydfmGaytB0tY5NrMFG6FDivDIrO/rS4k+FVJY0Sw=;
	b=LtSHGQFIzHzU+qG+LsU5pK88Xhdn07vu0hyGJQ0ysF7Xpq8ObUPZjA3g8bfGVPtQb+XBIg
	bO9d2R26IMTRY+dSIllWWH52AFWhEBkHoJ+ZSqNt3oSkbOgPSmjzG/nh6XlCdF26rFFyNW
	YEljqec6UhUKGZYuzyDEVdSHxV7zWj0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-ntn8nMOUNz6pSvDV7rlhtg-1; Thu,
 15 Aug 2024 15:46:38 -0400
X-MC-Unique: ntn8nMOUNz6pSvDV7rlhtg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 280C9190ECEE;
	Thu, 15 Aug 2024 19:46:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A56419560AA;
	Thu, 15 Aug 2024 19:46:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>
References: <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com> <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
To: Jann Horn <jannh@google.com>, Jeffrey Altman <jaltman@auristor.com>,
    openafs-devel@openafs.org
Cc: dhowells@redhat.com, Paul Moore <paul@paul-moore.com>,
    James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    John Johansen <john.johansen@canonical.com>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
    =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
    Stephen Smalley <stephen.smalley.work@gmail.com>,
    Ondrej Mosnacek <omosnace@redhat.com>,
    Casey Schaufler <casey@schaufler-ca.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
    keyrings@vger.kernel.org, selinux@vger.kernel.org
Subject: Can KEYCTL_SESSION_TO_PARENT be dropped entirely? -- was Re: [PATCH v2 1/2] KEYS: use synchronous task work for changing parent credentials
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2494948.1723751188.1@warthog.procyon.org.uk>
Date: Thu, 15 Aug 2024 20:46:28 +0100
Message-ID: <2494949.1723751188@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jann Horn <jannh@google.com> wrote:

> Rewrite keyctl_session_to_parent() to run task work on the parent
> synchronously, so that any errors that happen in the task work can be
> plumbed back into the syscall return value in the child.

The main thing I worry about is if there's a way to deadlock the child and the
parent against each other.  vfork() for example.

> +	if (task_work_cancel(parent, &ctx.work)) {
> +		/*
> +		 * We got interrupted and the task work was canceled before it
> +		 * could execute.
> +		 * Use -ERESTARTNOINTR instead of -ERESTARTSYS for
> +		 * compatibility - the manpage does not list -EINTR as a
> +		 * possible error for keyctl().
> +		 */

I think returning EINTR is fine, provided that if we return EINTR, the change
didn't happen.  KEYCTL_SESSION_TO_PARENT is only used by the aklog, dlog and
klog* OpenAFS programs AFAIK, and only if "-setpag" is set as a command line
option.  It also won't be effective if you strace the program.

Maybe the AFS people can say whether it's even worth keeping the functionality
rather than just dropping KEYCTL_SESSION_TO_PARENT?

David

