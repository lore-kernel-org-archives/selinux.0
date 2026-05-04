Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD73537C8
	for <selinux@vger.kernel.org>; Mon,  4 May 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890364; cv=none; b=RBswaKKYO2b4E/hQBY+TiwyGkCVdufce45Nw3oL7o0wzQZ3YDT3ayhf5KrZjgpL3GT4l0ow208qn3/JiQop03Opz4S2I+PrBYE/rEydR6nDPh6D7k9e7AodO39uaQ3YhjseKtYdn9EiknK5GZQDINgPiCzcI39c4HPWhBGcvxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890364; c=relaxed/simple;
	bh=Udq/d7i8XODyMIaKiI07CEKBOoYdj0rw7069jhzjWm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O51uhiKHBD3rdws6IQ1Xrrhi/uMDDQtUfZawBG9f28DDXqQ7kGFw1G4z1kzRGpe3X6WxU5Y/4pWZAc/PzfpPTiNldrO8NH9XQ7klIIJcymErvKSNIO7nkWwR3GZO2+L/bFldIYIgoX6tX88pYKsqJl1rksUEFdbhT48sVFFkFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhYdeY+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhYdeY+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777890361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ax2oHJTRVgwd2UJ5mOAMfI4fFSF3yGnRSZOfoNiTCE0=;
	b=RhYdeY+7oiAY25Q9EUDllgduXed55DNYN/CuLq6zfCE1N+f2tCTOG1+OupM3LIIcYx6RgX
	oBX284Wk/97QZSvD+dpJJKVGc70Ip2yO+7adySWaauY5IyX6xhGwExKtHxvuC6qr9NylXj
	IUV81Pd+DUzIf/zM9QigvVmAs2fYKV0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-Eg3gRyWxNYmumAlT6jHnJw-1; Mon,
 04 May 2026 06:25:57 -0400
X-MC-Unique: Eg3gRyWxNYmumAlT6jHnJw-1
X-Mimecast-MFC-AGG-ID: Eg3gRyWxNYmumAlT6jHnJw_1777890356
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED5BC19560B4;
	Mon,  4 May 2026 10:25:55 +0000 (UTC)
Received: from localhost (unknown [10.44.50.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7491D1800480;
	Mon,  4 May 2026 10:25:55 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, =?utf-8?Q?Thi=C3=A9baud?= Weksteen
 <tweek@google.com>
Cc: selinux@vger.kernel.org, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] libsepol: Fix off-by-one error in cats_ebitmap_len
In-Reply-To: <CAP+JOzS0p2d=43EiumHpe9ESQTjaYuk4tAhyD8Er44p7HUAjgg@mail.gmail.com>
References: <20260330015148.1482594-1-tweek@google.com>
 <CAP+JOzS0p2d=43EiumHpe9ESQTjaYuk4tAhyD8Er44p7HUAjgg@mail.gmail.com>
Date: Mon, 04 May 2026 12:25:54 +0200
Message-ID: <87pl3b8o99.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

James Carter <jwcart2@gmail.com> writes:

> On Sun, Mar 29, 2026 at 9:51=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
>>
>> In cats_ebitmap_len(), i-1 was incorrectly used instead of i for looking=
 up
>> category names at the end of a range. This resulted in an under-allocati=
on
>> of the buffer for the CIL representation of category ranges, which causes
>> cats_ebitmap_to_str() to fail its safety check and return (null).
>>
>> This fix correctly uses i (the current bit index) to look up the name for
>> the category at the end of the range.
>>
>> Proof of Concept (PoC) Policy:
>>   class p sid kernel class p { f }
>>   sensitivity s0; dominance { s0 }
>>   category c0; category c1_very_long_category_name;
>>   level s0:c0.c1_very_long_category_name;
>>   mlsconstrain p { f } l1 =3D=3D l2;
>>   type t; allow t self:p { f };
>>   role r; role r types { t };
>>   user u roles r level s0 range s0 - s0:c0.c1_very_long_category_name;
>>   sid kernel u:r:t:s0 - s0:c0.c1_very_long_category_name
>>
>> Reproduction steps:
>>   1. checkpolicy -M -o poc.bin poc.conf
>>   2. checkpolicy -M -b -C -o poc.cil poc.bin
>>   3. cat poc.cil | grep userrange
>>      Before: (userrange u ((s0) (s0 (null))))
>>      After: (userrange u ((s0) (s0 (c0 c1_very_long_category_name))))
>>
>> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Was this supposes to be Acked-by?=20

>> ---
>>  libsepol/src/kernel_to_cil.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index 06cf4498..49040ae4 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -1018,9 +1018,9 @@ static size_t cats_ebitmap_len(struct ebitmap *cat=
s, char **val_to_name)
>>
>>                 len +=3D strlen(val_to_name[start]);
>>                 if (range > 2) {
>> -                       len +=3D strlen(val_to_name[i-1]) + strlen("(ran=
ge  ) ");
>> +                       len +=3D strlen(val_to_name[i]) + strlen("(range=
  ) ");
>>                 } else if (range =3D=3D 2) {
>> -                       len +=3D strlen(val_to_name[i-1]) + 2;
>> +                       len +=3D strlen(val_to_name[i]) + 2;
>>                 } else if (range =3D=3D 1) {
>>                         len +=3D 1;
>>                 }
>> --
>> 2.53.0.1018.g2bb0e51243-goog
>>

