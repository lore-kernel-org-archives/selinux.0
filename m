Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583582E7F2C
	for <selinux@vger.kernel.org>; Thu,  4 Dec 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764848396; cv=none; b=G+Gk+s7bFdwpTOMcVca4aZK9Jj6rvEtgjYrRpGcJP5kFhnpwOon4xs4U3AFktTYNcnLlzm9he2OeuDOnevfB7x0ISMCZaBI1iHchNAXFOKe5tAZGVAZuoS+5/18v3NbrN12MHI2o94ipQecPUtOlA7/QSbdChLkzmh+42qhcRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764848396; c=relaxed/simple;
	bh=aWjk9wClQSk3hMoywNv0dKWrgUXVbjy6J5pgUZRsLRU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=F8LYOiQbi0iPKY+O1NsBaBicDkJ+ZM/ROj/uTLTztdweNztafPG0rZ7lSFqe+Np3CKCjKsKIRKGzU6fT0Aa2LSz2803yYAk4Yqih8sp8cJNgU8I9eBvCxMVKGvwckIBcHoQZMvkVpwvSg3Am5jRopVpLUQBBFESIf9p4G7+ovWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRTPzSRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRTPzSRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764848391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nz4tpGsf2JemOn1tKc/nfLsj2/UOs/7BXLvcTMqfvGU=;
	b=QRTPzSRPTfBfAi42GMcNsLE25aYRaBXZg+/V3RuYeECLR3d4d19mAA2vNGTIHbYSHch4jv
	wBUfiFTQ2NKovU3FgTotfy5/jnzjRCwheyxjhwM95XaQnRh4RWwMfBI8mX99ie2FXM89Vo
	4N6Rj5INdvCZgByCjJHu1vXVjYFov+Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-mf5sKE98NnWranGEaUMfwg-1; Thu,
 04 Dec 2025 06:39:49 -0500
X-MC-Unique: mf5sKE98NnWranGEaUMfwg-1
X-Mimecast-MFC-AGG-ID: mf5sKE98NnWranGEaUMfwg_1764848388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4A718005A4;
	Thu,  4 Dec 2025 11:39:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 159E8180045B;
	Thu,  4 Dec 2025 11:39:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhQOW8a_pTKS+Mhtu2LEFCPRhEzuhLsJOFHNTNUNUELChg@mail.gmail.com>
References: <CAHC9VhQOW8a_pTKS+Mhtu2LEFCPRhEzuhLsJOFHNTNUNUELChg@mail.gmail.com> <cb4293da-41dc-4586-adca-2859944905dc.ref@schaufler-ca.com> <cb4293da-41dc-4586-adca-2859944905dc@schaufler-ca.com> <866a132a-b6e2-4e40-aba3-d8b733184672@schaufler-ca.com>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
    LSM List <linux-security-module@vger.kernel.org>,
    SElinux list <selinux@vger.kernel.org>
Subject: Re: set_security_override_from_ctx()
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1986475.1764848385.1@warthog.procyon.org.uk>
Date: Thu, 04 Dec 2025 11:39:45 +0000
Message-ID: <1986476.1764848385@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Paul Moore <paul@paul-moore.com> wrote:

> I would suggest sending a patch to remove
> set_security_override_from_ctx() since there are no longer any
> callers.  Send it to the LSM list and I'll merge it once the merge
> window closes.

Fine by me.

David

