Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035D2F6594
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832085; cv=none; b=kNuwFnjKCdPQTGowctDWHARVgCgLyJ2A0jOzN7lc6sjPq4ixVo6ir+vAptKZ5pP/slvgweaLNAE/t0ZLE8Bv5LL3mU6GHWOQTzsDpY9rQbMc7KTXhPdOCaEajXDTaoQE90nRpQMg7+RQSn4HplO0tAfBZlMmHkUbPy6O7EMD2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832085; c=relaxed/simple;
	bh=vpP1v76ymhBlTeBJnxtL+LmvUFEgFCO5zleWguUlclg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1uyxzxkze0U+XKMcx9EJlSSHf9q+9Uy/fENV+7Hqt5Ioy6x+YbTVFIqU/R8f9y2S+i1aVsOCGpscwTmZtV4goIb7fiY1tEJtb/WrknoAL6bXC/v+PIgypDWzVEIPHn+Rj30RAGX7tchRmQDV7c3GwPbibQIflU4KapL2J5CJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey9imfVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey9imfVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756832082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KgyDEWc6Fod7Vh+A/Nb69jUe7gqAwSO/Sba5OtvHypg=;
	b=Ey9imfVAiM8kXu4YxYipTAxLnq+4YUQmZvxAC/E6bn36qKAGMgydmWWXil+9l5+GnY/pyZ
	sqmDO0M5aVaB9Ic2kIOxkM3akz4+GoZeJ5u0oUBGb/dR1RsQ+OD9s7ZhxSqFbLcW/lC/tg
	CwUP/v1Q3wSgG7w34N5LqjTXWZ9QWYU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-TpeHL1ueP-qqKvPE7umD9A-1; Tue,
 02 Sep 2025 12:54:38 -0400
X-MC-Unique: TpeHL1ueP-qqKvPE7umD9A-1
X-Mimecast-MFC-AGG-ID: TpeHL1ueP-qqKvPE7umD9A_1756832077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5F2D19560B6;
	Tue,  2 Sep 2025 16:54:37 +0000 (UTC)
Received: from localhost (unknown [10.45.224.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DA41300019F;
	Tue,  2 Sep 2025 16:54:36 +0000 (UTC)
Date: Tue, 2 Sep 2025 17:54:35 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org
Subject: Re: [PATCH] setfiles: Add -A option to disable
 SELINUX_RESTORECON_ADD_ASSOC
Message-ID: <20250902165435.GA1480@redhat.com>
References: <20250901143412.2904562-1-rjones@redhat.com>
 <20250901143412.2904562-2-rjones@redhat.com>
 <CAEjxPJ499HdhmsfX7kbchq7JFW07RD6jY5CrZMAAc3wZ+bbjXQ@mail.gmail.com>
 <871poo96ld.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871poo96ld.fsf@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


BTW we seem to have "forked" the reviews.  I made an update to the
pull request, as requested by a reviewer there:

https://github.com/SELinuxProject/selinux/pull/490

I can post a v2 on the list if required.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

