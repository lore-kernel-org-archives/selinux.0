Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB892356CF
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325681; cv=none; b=RBtaKcldQadGnEuZQi+4Snn0NPAv0k+NZzNFN+wT0h7CpzArrUq0qmJ4/tHANauVtIVoXlmKM9iquSVCAAMomlHRGyi6kWRYKd4AgpW9YqCYUt5FaUdUPGxR1qwvZTUay8zclnlT+2JzUSYp1ruoQkVzPFwn1V4a7c4x4mUZt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325681; c=relaxed/simple;
	bh=QvO1ZIkuBF7sEJBLZmHtjWP20Xp7lWHRWbKELTewswY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gA1nv9dg+OxlCzHWgtheOkmZ2fn40JdQ8ot0LFl1mZKVlkb7pNYPe6Cpa3myQQO3CESA59YP79wSrx0kQ99ZhdJTbk2mT5TGiwhTuRjBGHSmNARdRF4SUluGBorsKhs6xwwKPzsPb3vmkd2Kw/r/OEdIwdUJVZV+BiCSePZ+7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUVhNQ+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUVhNQ+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754325674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyRTSHVdX6j2EnuGWf2zbjfjP3Arx5WQD+mZsdyjPfE=;
	b=XUVhNQ+Lml64KeDVp69aqvlmquCOdeg7M6RTIzX+2Z6AlJnDbRQ6oZ9c4ntMbydum6Vqpp
	PqrHMMen99ppoW9N5z+M2xNsSMyVedJnLD0alml4+TcnNkdC64AW+WNpqnb4tpaQFKa+zB
	DYiTTWxzdrdVzRyQ4Blbv5Dj525wPVg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-YrvoNGpBNTadxTtjsu_QaA-1; Mon,
 04 Aug 2025 12:41:12 -0400
X-MC-Unique: YrvoNGpBNTadxTtjsu_QaA-1
X-Mimecast-MFC-AGG-ID: YrvoNGpBNTadxTtjsu_QaA_1754325671
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38B931955BE0;
	Mon,  4 Aug 2025 16:41:11 +0000 (UTC)
Received: from localhost (unknown [10.44.33.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A58851955F24;
	Mon,  4 Aug 2025 16:41:10 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com
Subject: Re: [PATCH userspace] SECURITY.md: add my email address and GPG key
 fingerprint
In-Reply-To: <87o6sv11x4.fsf@redhat.com>
References: <20250723182550.1065144-2-stephen.smalley.work@gmail.com>
 <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com>
 <87o6sv11x4.fsf@redhat.com>
Date: Mon, 04 Aug 2025 18:41:09 +0200
Message-ID: <87ldnz11lm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Petr Lautrbach <lautrbach@redhat.com> writes:

> Paul Moore <paul@paul-moore.com> writes:
>
>> On Wed, Jul 23, 2025 at 2:27=E2=80=AFPM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>>
>>> This key can be downloaded from https://github.com/stephensmalley.gpg
>>> or
>>> https://keyserver.ubuntu.com/pks/lookup?op=3Dget&search=3D0x578c4211832=
f0a7ea2c5a7c221a46e603f744ecf
>>>
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>> ---
>>>  SECURITY.md | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> I have verified that the GPG key identified by the fingerprint in the
>> patch belongs to Stephen.
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

This is merged now.

