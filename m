Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24714B959
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972196; cv=none; b=mHogar2CQl68ovVNlZ1xq91GPpXNleuZT8/LdZNpuAnwozw/I9KBZHI4AOjPjb/ttVpk7OqKNEmZqYoKh+nQFooGCI/wzPj4e8L9R8J2i/JUo9qBu/P+JJilhaKXpInWGp8BxTbOqa+4GK3D1WYQZnOMhh5m9xH5zlWepx3Q1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972196; c=relaxed/simple;
	bh=nqPUbKePVB3tIo94LCnPnozg5HiPExnudFIHBRmZStI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLWmdOmhXD6J6AhP9fkL+1bnQNYcoAJEz6KPqvEup66BfYAA3sKEz9LL6WiI+QRvHI406LlUxwImnMBPidc/iU8u230ZYY/g1WisG4Em0LfKJe0csltLqUKE+fnscTdQ84zl7KCfFgsQ4UKhmjRCo/AVdIMeeBRa+toq0+wHN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Js70OGjj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Js70OGjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736972193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqPUbKePVB3tIo94LCnPnozg5HiPExnudFIHBRmZStI=;
	b=Js70OGjj4VvTLZFXbZI99WlWc0jpBiEUhIqsELBIfSRMjC1C8MoH7oP68OxevuyjtrhFkz
	C6nhO/iUZNICzbjJaqiQTADsndgT+5Xj+ciJ9XE+yzLUD98AhfsohrwW7V22QsXWHZ6AF1
	z+kB/3Dfd1hA+OMRHXY5mWV+BvZaIPw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-DMaNnwIRN-SaZqhz4A_b2Q-1; Wed,
 15 Jan 2025 15:16:31 -0500
X-MC-Unique: DMaNnwIRN-SaZqhz4A_b2Q-1
X-Mimecast-MFC-AGG-ID: DMaNnwIRN-SaZqhz4A_b2Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A56A19560A2;
	Wed, 15 Jan 2025 20:16:30 +0000 (UTC)
Received: from localhost (unknown [10.45.224.36])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09E93195E3E0;
	Wed, 15 Jan 2025 20:16:29 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc: 
Subject: Re: 3.8-rc4 or 3.8 release next week
In-Reply-To: <CAP+JOzQfE-=yKC_CdbuerxeDDmFd70D0fDGd4E9u197JaFpnEg@mail.gmail.com>
References: <87tta9xm89.fsf@redhat.com>
 <CAP+JOzQZY4Bji7vD_ZaEQksvUP04-9u+CvRHDWXsHCD8zdss5A@mail.gmail.com>
 <CAP+JOzQfE-=yKC_CdbuerxeDDmFd70D0fDGd4E9u197JaFpnEg@mail.gmail.com>
Date: Wed, 15 Jan 2025 21:16:28 +0100
Message-ID: <87r053x277.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

James Carter <jwcart2@gmail.com> writes:

> On Wed, Jan 8, 2025 at 12:27=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
>>
>> On Wed, Jan 8, 2025 at 12:13=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
>> >
>> > Hi,
>> >
>> > there's only one change merged since 3.8-rc3 but it looks like
>> > there's some important changes in the queue so I'm going to postpone
>> > -rc4 to next week as the last RC and if there's no issue I'll push 3.8
>> > release two weeks after rc4.
>> >
>
> Petr, were you planning on doing the rc4 release today? There are some
> patches ready to be merged, but I didn't want to merge if you are
> preparing rc4.
> Jim

Yes, I'm working on it. I saw that you've acked several patches so I've
merged them already and they'll be part of rc4.

Thanks!

>
>> > Does it work for you?
>> >
>>
>> Sounds good to me.
>> Thanks,
>> Jim
>>
>> > Also feel free to suggest all necessary information which should be
>> > included in release notes.
>> >
>> > Thanks,
>> >
>> > Petr
>> >
>> >
>> >

