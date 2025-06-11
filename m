Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A41E5207
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669012; cv=none; b=WaNObuhpvxrKGGjn/9HU+v5cY6DtiWi9NnLsRmq8PUzBFitOUvx3ioJ25B9LQ1vFOZC3ziqPeJxg+ZHPmWn+1iFoj40H7Lh1pOjd8Jb3ytxIQ3wxLHU5AFrZgGXpSiamHFWIm5Phd4UItahB26mgO9KOstvRZWN7ZNXJcgixsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669012; c=relaxed/simple;
	bh=U0sHkNdzvzXrsT9CHkVj2QBaaYOF4q1+Sqftx0BzIu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A6pMRMlKUccojyldDRRRCp9ixLz4J3J++3esx79XqUMHl2loAooEC8ai9BA5DeAQzzIMvGb516xX/2N/c8R7f0pPHv/RB9VIVyduwAih/91niUCBhduHFmqVbGWfdEgbHLu+MWwQDniYRS+Bf9KZW4VhgzpHOomqJiYJiVVr7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9/Y5oRT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9/Y5oRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749669009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSZd1i4M0P5Slt4trGYeKMstiIxph9nRdj3zDaofH84=;
	b=g9/Y5oRTctqwS4VyU7lsU6WMDTKErQgrofwpmqzfNaVIkA5WIXd+ppfNBjf/7ucu1adixE
	Fv0VlX4NYmk4AfgtFWLgfR69ZJf0mg7vnCNCKVkfR4tZgwdYxlVPMjEc+Z/StEc4eAMayt
	D994yJpz1fi94WfKmqxXbb/cXm6BC40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-5AyhqjzdPUSKFBWNmkRoEA-1; Wed,
 11 Jun 2025 15:10:05 -0400
X-MC-Unique: 5AyhqjzdPUSKFBWNmkRoEA-1
X-Mimecast-MFC-AGG-ID: 5AyhqjzdPUSKFBWNmkRoEA_1749669005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D91631800284;
	Wed, 11 Jun 2025 19:10:04 +0000 (UTC)
Received: from localhost (unknown [10.44.32.71])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C757180045C;
	Wed, 11 Jun 2025 19:10:04 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, James Carter
 <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: Do not inline compile_regex()
In-Reply-To: <CAEjxPJ6g+=N3p83hUXRndvET+4T-+OShvMHipLg0h7fo89iPfw@mail.gmail.com>
References: <20250611182846.236298-1-jwcart2@gmail.com>
 <CAEjxPJ6g+=N3p83hUXRndvET+4T-+OShvMHipLg0h7fo89iPfw@mail.gmail.com>
Date: Wed, 11 Jun 2025 21:10:02 +0200
Message-ID: <87ldpydrhx.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Jun 11, 2025 at 2:29=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
>>
>> Since commit bdcbbf89b9548afd452449835e58e84105a71a9a (libselinux:
>> limit fcontext regex path length), an error would be given if
>> libselinux was compiled directly. (Though, building the whole SELinux
>> userspace still worked.) This is because the flag "-Winline" is used
>> when building libselinux directly, but not when building the whole
>> userspace.
>>
>> Remove "inline" from the function compile_regex() in label_file.h
>> to allow libselinux to be built directly.
>>
>> There are four functions defined in label_file.h that are not inlined:
>> regex_has_meta_chars(), regex_simplify(), compile_regex(), and
>> insert_spec(). The first three functions are called by insert_spec()
>> which is called by the inlined function process_line(). This last
>> function is called by utils/sefcontext_compile.c which prevents
>> relocating the non-inlined functions to label_file.c.
>>
>> Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

I'm going to postpone 3.9-rc1 to tomorrow so this change can land there.

Ok?

>> ---
>>  libselinux/src/label_file.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
>> index d1a0713a..8fcf74e3 100644
>> --- a/libselinux/src/label_file.h
>> +++ b/libselinux/src/label_file.h
>> @@ -390,7 +390,7 @@ static inline void sort_specs(struct saved_data *dat=
a)
>>         sort_spec_node(data->root, NULL);
>>  }
>>
>> -static inline int compile_regex(struct regex_spec *spec, char *errbuf, =
size_t errbuf_size)
>> +static int compile_regex(struct regex_spec *spec, char *errbuf, size_t =
errbuf_size)
>>  {
>>         const char *reg_buf;
>>         char *anchored_regex, *cp;
>> --
>> 2.49.0
>>
>>

