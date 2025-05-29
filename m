Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454E219311
	for <selinux@vger.kernel.org>; Thu, 29 May 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535278; cv=none; b=d5u1kMElwGAHxbgCtnoB4GC/fRTsDkW0iApmdr5uEUu1aUd5ehhwJ/2hD3QQvnKp6bFEja2bpaCkWd++oFlBfN0MJ1o3JPq1VLC4iD4qDHSr/PYkA3xIubQf5ZXhGhxFK+V6Fs7XyRxTGXJlifGe5j420Q8A0D+e1QS1fDEAmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535278; c=relaxed/simple;
	bh=ZvS+YuxUZoY2A8WKjnrBbWBfthQ7VBJt5Vpig/lYtVs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sIovrYtRRtWxzx/wPPTE1L1LdurCSs8cDuSJXbwI6lvtxoUNGD6qQOiARzdpTS6W7xrLHNd6xR2m9vuvV+lXQJVkqHz3Uw9qOM5gSGq+2kaZKvcvPgPUpBiwHRYZu8R0A3iTaWgWvhgNpCbFWIcmb3tPVVzQhTbjQmmyv0J84lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7ZRyrFV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7ZRyrFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748535275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/yDKWIQAVkELHCEpFV01uXgjd7kkLJR6u93+xDqnE8=;
	b=B7ZRyrFVBQrbBHQaYn4/OzBfLOpOBB47rOCkNnbFK/GI18swn8oJQ34y1kdz3NOg8snKqf
	NP+XMJBhwXKo15yKtcP1rI4T9WV5uZxTEjIHjGQ3Kpo+sZm/NjekAl9LWuuJjwbMY3qY2G
	ahOK7xdiibiw9xWwpc4k8m10QzJGCAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-EM72W2gUMqmYveVEJPOuXQ-1; Thu,
 29 May 2025 12:14:33 -0400
X-MC-Unique: EM72W2gUMqmYveVEJPOuXQ-1
X-Mimecast-MFC-AGG-ID: EM72W2gUMqmYveVEJPOuXQ_1748535273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7B4E1955D84;
	Thu, 29 May 2025 16:14:32 +0000 (UTC)
Received: from localhost (unknown [10.44.32.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B50A180049D;
	Thu, 29 May 2025 16:14:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Dominick Grift <dominick.grift@defensec.nl>, selinux@vger.kernel.org
Subject: Re: possible regression with filecon equivalency
In-Reply-To: <87ldqftsxd.fsf@defensec.nl>
References: <87ldqftsxd.fsf@defensec.nl>
Date: Thu, 29 May 2025 18:14:30 +0200
Message-ID: <878qmfbdi1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Dominick Grift <dominick.grift@defensec.nl> writes:

> This worked a while ago:
>
> root@nimbus:~# cat >> /etc/selinux/dssp5-debian/contexts/files/file_conte=
xts.subs_dist <<'EOF'
>> /foo /usr/bin
>> /sysroot/foo /usr/bin
>> EOF
>
> root@nimbus:~# matchpathcon -m dir /usr/bin
> /usr/bin        sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /foo
> /foo    sys.id:sys.role:exec.file:s0
> root@nimbus:~# matchpathcon -m dir /sysroot/foo
> /sysroot/foo    sys.id:sys.role:unknown.file:s0
>
> What happened?

i've bisected it to

4d436e4bf80284ac3b645bad022a9757dbc2dd36 is the first bad commit
commit 4d436e4bf80284ac3b645bad022a9757dbc2dd36
Author: Christian G=C3=B6ttsche <cgzones@googlemail.com>
Date:   Tue Nov 26 11:26:20 2024 +0100

    libselinux: use vector instead of linked list for substitutions
=20=20=20=20
    Utilize cache locality for the substitutions by storing them in
    contiguous memory instead of a linked list.
=20=20=20=20
    Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
    Acked-by: James Carter <jwcart2@gmail.com>



# cat /etc/selinux/targeted/contexts/files/file_contexts.subs
/new_root /
/new_root/foo /usr/bin

before 4d436e4bf80284ac3b645bad022a9757dbc2dd36:

# matchpathcon -m dir /new_root/foo
system_u:object_r:bin_t:s0

after

# matchpathcon -m dir /new_root/foo
/new_root/foo   system_u:object_r:default_t:s0



>
> --=20
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl

