Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993222BAA2
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043174; cv=none; b=UTD/4z0+Ja59WabqsUfLdDdacNyUjRf9WYJpngmrvtCZqm2k+T3dfLkgYPGeoZSx3Ve2cW4UhHAt2QYS0VIOoFr5qayWgb8SYF6EUOKdwCbZxJ3FEIVrK2YYhTKUR4fUcmRMAucNRrmoz0m8wY8sw+TD5Bw6j0xvvhK8+h6Xf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043174; c=relaxed/simple;
	bh=4JN1cmZNskkDwo/r4JjLOrdzN7ZmaFVER1akUOnqLR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Id5M8tJch5Tf85CbImyFv8tvQ9kz1PTQdKRle+NQsP1r1bMALNoGJYBgBIVjZ043OFYEA8GA2XtFtdKVz7/sYmjE9AvXLfa9bFkX02deo1OQkHFyhruhna+jrrt7jGxNa0ovngfxRwvdofiV/W1nn+EQSW+JAJMYpRDUEZ/zweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS2ux179; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS2ux179"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737043171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+0J7JGvQTLShJnMPifJuwnMmlOz5UJ6sY12QdxiSOaU=;
	b=VS2ux179PuvvrR1nmg0pNfNCoNBn0sHETJ5jJkAE9F3V/AZnZqoHZttK+BbP3AJZo1dZA/
	tty3BssMxyT7zY5esUK/UGr0Yh0elfn2urrihCaS+e3fLwfLIYe6cjgussN2Hy49vszCnz
	7R+Tfret6VE0wsYhx0ng1of7MBxlqVs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-fSdKxeuoNV2cVjrzwQ7tGw-1; Thu,
 16 Jan 2025 10:59:30 -0500
X-MC-Unique: fSdKxeuoNV2cVjrzwQ7tGw-1
X-Mimecast-MFC-AGG-ID: fSdKxeuoNV2cVjrzwQ7tGw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AF9C195394A;
	Thu, 16 Jan 2025 15:59:29 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2E2019560A3;
	Thu, 16 Jan 2025 15:59:28 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, cgzones@googlemail.com,
 selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH 1/5] libselinux: set errno in failure case
In-Reply-To: <CAP+JOzSiqjUJ1yVft_fmgU_8HoJUdRhnvxFPSwxQeNcmUxbP3A@mail.gmail.com>
References: <20250115131329.132477-1-cgoettsche@seltendoof.de>
 <20250115131329.132477-5-cgoettsche@seltendoof.de>
 <CAP+JOzSiqjUJ1yVft_fmgU_8HoJUdRhnvxFPSwxQeNcmUxbP3A@mail.gmail.com>
Date: Thu, 16 Jan 2025 16:59:27 +0100
Message-ID: <87jzauwy00.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

James Carter <jwcart2@gmail.com> writes:

> On Wed, Jan 15, 2025 at 8:13=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
>>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> In case an entry read from a textual fcontext definition is too long set
>> errno and the error string accordingly.
>>
>> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
>> Reported-by: oss-fuzz (issue 389974971)
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these five patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!


>> ---
>>  libselinux/src/label_support.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppo=
rt.c
>> index 978ba828..57e191c8 100644
>> --- a/libselinux/src/label_support.c
>> +++ b/libselinux/src/label_support.c
>> @@ -45,8 +45,11 @@ static inline int read_spec_entry(char **entry, const=
 char **ptr, size_t *len, c
>>         }
>>
>>         if (*len) {
>> -               if (*len >=3D UINT16_MAX)
>> +               if (*len >=3D UINT16_MAX) {
>> +                       errno =3D EINVAL;
>> +                       *errbuf =3D "Spec entry too long";
>>                         return -1;
>> +               }
>>
>>                 *entry =3D strndup(tmp_buf, *len);
>>                 if (!*entry)
>> --
>> 2.47.1
>>
>>

