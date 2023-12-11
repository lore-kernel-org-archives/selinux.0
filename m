Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/eKIPlG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F7C4
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 04:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702298839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=L90sihQlSb4hrbE2Tj/9U21ArPeOnFCnmRzeAkkBlWo=;
	b=X/eKIPlGxeQCpH/kZgGqFoIlykixbHWmwiYZVDeBbek2dUhI4CcPO5RXDb6RiJ0CzZvPAq
	16xolr8JW/WM//bLwSORfdmz1Tz2exV6QqLDI7PPJQ735H+ZEk+O3MdNDwJLvLVjq3xzJx
	HuLNBPjmg5DJRufnrCgIovtXFfl2qBI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-J_sFkHd2Mkya6uFaXnoPug-1; Mon,
 11 Dec 2023 07:47:17 -0500
X-MC-Unique: J_sFkHd2Mkya6uFaXnoPug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E9542825E92
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 12:47:17 +0000 (UTC)
Received: from localhost (unknown [10.45.224.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 103E9C15E6A
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 12:47:16 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Subject: Where's 3.6-rc3 and plan with 3.6 release
Date: Mon, 11 Dec 2023 13:47:16 +0100
Message-ID: <87o7ewsy7f.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi,

3.6-rc3 was supposed to be released last Wednesday, but I got sick and
spent days in bed and so I wasn't able to release it. I'm sorry.

I consider two options now - a) to release 3.6-rc3 on this Wednesday and
leave 3.6 to the next year; b) to release directly 3.6 this Wednesday.

a) seems to be safer and it would allow more waiting patches to be
reviewed/merged.

With b) the release would be out before the end of the year and this
task (release) could be closed for me.

I selfishly prefer b) but I feel like a) would be better.


What do you think?

Petr


