Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CCE23DE
	for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643927; cv=none; b=k0uaZk+KcKTfmWv48EM3K85zBcwKU3yvy7nMKXLMrscVy7gmQxD80vMMqyxeaYMICvSzk5LjZ+iieeIyI5X9CmoJ2vb12X9VhWZOCBBjgMJFabed8Kc8fF4scru3btxlL5WFezrgropaqhZo4/GiZLhvt0fn0HLZDoYNApTotwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643927; c=relaxed/simple;
	bh=ZPUglHO44F/41+tCasK8F9/8viISZYNngvZ6WKJfbB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKfetn32sm/UuT/GOdyLxApWfsevhrU6CcoppTE2iXHerFAMnjXNqf9kgSm99MmvGAEm2C3k3xmsxZllmRecDJBzxHhi5/oSHImKpVEbfbiPYHUZSvNMcPxBAXR5eAUEEJN3xZNnwv5NROHJH7Zoc8N9K0TPpD3LeG35QNDfKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWm7mmY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWm7mmY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721643924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFFT3qX60z1cc7uLNRarz1Ra+VI/UgoIZO92sIxHYMI=;
	b=JWm7mmY/1z/uoWY9tjBSi5LXkMocNGl52tl2Tirjs7ZlgK1boFhIRz1OPQzqWXwhNbNhsp
	hIzcsdCJ+ZX0XIJELbSKjfMJMWh9gKvNxvTmOw/M8bbj8kszbe1AOHsv6Kh5NywL9D4jsT
	fyIyHp21g36q9QPAPb+G/po7HveVn9I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-XqypTvahPT6UIMsueWjhoA-1; Mon,
 22 Jul 2024 06:25:22 -0400
X-MC-Unique: XqypTvahPT6UIMsueWjhoA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 124B11955D54;
	Mon, 22 Jul 2024 10:25:22 +0000 (UTC)
Received: from localhost (unknown [10.45.225.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 637271955D45;
	Mon, 22 Jul 2024 10:25:21 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libselinux: set free'd data to NULL
In-Reply-To: <CAP+JOzQCu0srfss921Ew42oHxsaqRYGiTs56_h9j2Yfw0cYGjg@mail.gmail.com>
References: <20240709192346.913107-1-lautrbach@redhat.com>
 <CAP+JOzQCu0srfss921Ew42oHxsaqRYGiTs56_h9j2Yfw0cYGjg@mail.gmail.com>
Date: Mon, 22 Jul 2024 12:25:20 +0200
Message-ID: <87le1tyb8v.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

James Carter <jwcart2@gmail.com> writes:

> On Tue, Jul 9, 2024 at 3:24=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>>
>> Fixes segfault in selabel_open() on systems with SELinux disabled and wi=
thout any
>> SELinux policy installed introduced by commit 5876aca0484f ("libselinux:=
 free
>> data on selabel open failure"):
>>
>>     $ sestatus
>>     SELinux status:                 disabled
>>
>>     $ cat /etc/selinux/config
>>     cat: /etc/selinux/config: No such file or directory
>>
>>     $ matchpathcon /abc
>>     [1]    907999 segmentation fault (core dumped)  matchpathcon /abc
>>
>
> I was able to recreate the problem and verify that this fixes it.
> Acked-by: James Carter <jwcart2@gmail.com>

This is merged now.


>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>> ---
>>  libselinux/src/label_backends_android.c | 1 +
>>  libselinux/src/label_file.c             | 1 +
>>  libselinux/src/label_media.c            | 1 +
>>  libselinux/src/label_x.c                | 1 +
>>  4 files changed, 4 insertions(+)
>>
>> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/la=
bel_backends_android.c
>> index 49a87686de4c..5bad24f20d73 100644
>> --- a/libselinux/src/label_backends_android.c
>> +++ b/libselinux/src/label_backends_android.c
>> @@ -260,6 +260,7 @@ static void closef(struct selabel_handle *rec)
>>                 free(data->spec_arr);
>>
>>         free(data);
>> +       rec->data =3D NULL;
>>  }
>>
>>  static struct selabel_lookup_rec *property_lookup(struct selabel_handle=
 *rec,
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 2732972e61cf..59c9f2ef3442 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -942,6 +942,7 @@ static void closef(struct selabel_handle *rec)
>>                 free(last_area);
>>         }
>>         free(data);
>> +       rec->data =3D NULL;
>>  }
>>
>>  // Finds all the matches of |key| in the given context. Returns the res=
ult in
>> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
>> index 852aeada8ff4..bae065c12a55 100644
>> --- a/libselinux/src/label_media.c
>> +++ b/libselinux/src/label_media.c
>> @@ -183,6 +183,7 @@ static void close(struct selabel_handle *rec)
>>             free(spec_arr);
>>
>>         free(data);
>> +       rec->data =3D NULL;
>>  }
>>
>>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
>> index a8decc7a0093..ddae4f6c22b6 100644
>> --- a/libselinux/src/label_x.c
>> +++ b/libselinux/src/label_x.c
>> @@ -210,6 +210,7 @@ static void close(struct selabel_handle *rec)
>>             free(spec_arr);
>>
>>         free(data);
>> +       rec->data =3D NULL;
>>  }
>>
>>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
>> --
>> 2.45.2
>>
>>

