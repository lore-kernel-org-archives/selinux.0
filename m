Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdrWr3wC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE595
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701706775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=BjELNtUM/9d+2VNJMXif7VxRs4nOqX5QVTBtULuJJmM=;
	b=gdrWr3wCpPBdsnIv4Yhf443y9+/VW6ZjcgrOQSmmhlapxrYdabHuFYXwvFqxZojr7mqfhQ
	4b3ippucfU1L2ARDcj2oeBErIOmCxOB+Evs1AyC7g7KPuTaNtlXO3hRggfIYzi4bybcuvE
	WO7EB4E3E+Y5W0DyCuThkbH0d+BDKAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-rtQs5Rl8MlGB6BwyzgAYZA-1; Mon, 04 Dec 2023 11:19:33 -0500
X-MC-Unique: rtQs5Rl8MlGB6BwyzgAYZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A891A892244
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 16:19:32 +0000 (UTC)
Received: from localhost (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B87010F44
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 16:19:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: setools build is broken by 61f21385004 ("libsepol: rename struct
 member"), revert?
Date: Mon, 04 Dec 2023 17:19:31 +0100
Message-ID: <877cluszxo.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi,

it's reported at https://github.com/SELinuxProject/setools/issues/110

While the API change is described in the commit message, SETools is not
ready for this.

I haven't found a way how to use COND_EXPR_T_RENAME_BOOL_BOOLEAN in
Cython code so that SETools could be built with 3.6 and with older
releases.

I consider this as a blocker for 3.6 release and therefore I propose to
revert this change and leave it for the next release together with the
proper (if possible) fix of SETools.

Objections?

Petr

