Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D9433A0
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723358; cv=none; b=RR/m1hVqmXwG7pnGFpFoRYgSDb6/MHnR4Bguv3YyQ8UIpZhb8JxrR760xwxsf4dacmlNv6E3V1CZtq4U5Cu71qgQ4VrgtodIhskEjKQANGGLs48seEQaCAejnqNDnMNy/j5/mJf3LdMwjo3PU4gyNO8uYcNbiTTg3P88yj+g87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723358; c=relaxed/simple;
	bh=GIsUoXCF4w6bhulBcLuYJxvoCfXgnz+HGVXHzzN5o28=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rnIHzUuA1Q9zgyi3Jifo5ELSRKwWLnir7m54TAh4W/3i2djG5iA4fQHVrKdfp9JQM54q1LJ3Exgw9hx6d7yI8eagxhWuJN67nDMzC2Iz+TUg+GPt5hY1yu2kyfoFyZNbvDRbXrbx5q00ZSQmYGpa1RWliywgF2ihW+CoZZi1Fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gR2jo+8+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gR2jo+8+"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfddb70965so8463283a12.0
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 08:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732723355; x=1733328155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIsUoXCF4w6bhulBcLuYJxvoCfXgnz+HGVXHzzN5o28=;
        b=gR2jo+8+DQfEdwC4DDVg35fchr7VGKwEitvRYDqaqFC8toqM92hr1XTwzK/IeBDTV/
         f1UXkJFQ0J5e952Adq3d2UOLrG8JwxEDeE20WrNxDqm6GmeWfGZWQPa46xjwEtihNAsk
         2nxK6QYULCQgQx3Up13/nY1AOfujPn07HLJ39lpJJB6Ru3WPlTAx3qIMSF//PEaBTHSh
         9mEVNsSXCr6xrGMLRFEtIwbhNRDok2h7xVWO5buAW7JPg1Fx4LG0oR3sis1SOPg4RjPN
         FI5/w+B8pE0Kpwly9HuDVHlfPhK2awIjygwch4IHXGRM4I2n5Ml+2eUhxZA1ebjmIPHp
         VIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723355; x=1733328155;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GIsUoXCF4w6bhulBcLuYJxvoCfXgnz+HGVXHzzN5o28=;
        b=wNDU0JZRolGWF1zHr0ijStw9Qb1lKZlakJbpYdEhgjIlVIgi8otZFvTJPSCA7rbE5u
         duPHipIhvx3dIbNxB0HaOFhjTUBedQipCRwrqu3vJpx1+2bhV0Sv9CU1yq9ObB/rVJb+
         u+k7cL6Z5vC3AHm7DRAmr1enI0gE54gE5cxEhpasIn0hlBaTXO0/frSlSmjVt/zm6e7G
         ritEqOwq0u0ZB4k15xOREPpn9PoAhYWEtQvCQn4bwwXlcM6AkwfiaRUlmt8lkkoR5VMf
         0mwVuw/zQur4teMmLVs9MweEYMhCy41DYimaIbZG4rH+qPSdKp7pj7YAM4lKMQU3jLm7
         ZGkA==
X-Gm-Message-State: AOJu0Yz2ecBmmbpKVZwIypv6GPZJrPQwSJB0e0FvCAjoxxsGqV4wQ4/o
	oxE4AC9I/z6TZPeczuVjwB9U1EyiQhFzPBOt4nRaw4HhjlKV88cA
X-Gm-Gg: ASbGncuyyfJ57TtvZ/ekDOFnRAwHKRZ26TJsIdeKcmtH2F1+CnSZANUvOCe//QOtwE+
	Wj2IZss0746n9ZqJOHm3NjyZv4OydgDwn/8S526r90ba1+pdgeqvc653sSjeGSkE1fTi7vnkRgl
	QS0GG/TySnvQnlQkrz8qttfLCdvgQJwZs3Il83QqgQeEjSXOmh6IcednTB8uSWGRP5fJKkNkp7T
	wdx0xLrt859luevrFZ/URZQjQU9IEHqgB6O6KqwnBcxtZ/e7yB+Xr9edu6hZmA3jahS/BRA0QXx
	DaKzA1I+5BDl/UfbUL/rE7Kb5IbP
X-Google-Smtp-Source: AGHT+IHAeJI7wtDWg2gW6dk/4wmdJdtE1R8xJdajPCO6PgYxrWyNJc2omV++fG6W7rM5AJ+8wm23tg==
X-Received: by 2002:a05:6402:278d:b0:5cf:e5e3:e0b1 with SMTP id 4fb4d7f45d1cf-5d080c5b390mr2834965a12.29.1732723347553;
        Wed, 27 Nov 2024 08:02:27 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-000-142-203.77.0.pool.telefonica.de. [77.0.142.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b1a9dsm6252174a12.24.2024.11.27.08.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:02:26 -0800 (PST)
Date: Wed, 27 Nov 2024 17:02:24 +0100 (GMT+01:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Message-ID: <52901ead-a61d-4f6f-8c80-da61b05043af@googlemail.com>
In-Reply-To: <CAP+JOzR8M2oe1mZiixO-6Pt0gW8E6qrGtv5fkyhk==NkfrcU5Q@mail.gmail.com>
References: <20241125120827.97332-1-cgoettsche@seltendoof.de> <20241125120827.97332-2-cgoettsche@seltendoof.de> <CAP+JOzR8M2oe1mZiixO-6Pt0gW8E6qrGtv5fkyhk==NkfrcU5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libselinux: use vector instead of linked list
 for substitutions
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <52901ead-a61d-4f6f-8c80-da61b05043af@googlemail.com>

Nov 27, 2024 16:14:50 James Carter <jwcart2@gmail.com>:

> On Tue, Nov 26, 2024 at 5:45=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
>>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Utilize cache locality for the substitutions by storing them in
>> contiguous memory instead of a linked list.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>> ---
>> v2: drop unnecessary check for zero length
>> ---
>> libselinux/src/label_file.c | 127 +++++++++++++++++++-----------------
>> libselinux/src/label_file.h |=C2=A0 20 ++++--
>> 2 files changed, 80 insertions(+), 67 deletions(-)
>>
>> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
>> index 4e212aa4..c91a91f7 100644
>> --- a/libselinux/src/label_file.c
>> +++ b/libselinux/src/label_file.c
>> @@ -1120,28 +1120,27 @@ static int process_file(const char *path, const =
char *suffix,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> }
>>
>> -static void selabel_subs_fini(struct selabel_sub *ptr)
>> +static void selabel_subs_fini(struct selabel_sub *subs, uint32_t num)
>> {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct selabel_sub *next;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (ptr) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 next =3D ptr->next;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(ptr->src);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(ptr->dst);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(ptr);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ptr =3D next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (uint32_t i =3D 0; i < num; i+=
+) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(subs[i].src);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(subs[i].dst);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(subs);
>> }
>>
>> -static char *selabel_sub(const struct selabel_sub *ptr, const char *src=
)
>> +static char *selabel_apply_subs(const struct selabel_sub *subs, uint32_=
t num, const char *src)
>> {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *dst =3D NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int len;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *dst;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (uint32_t i =3D 0; i < num; i+=
+) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const struct selabel_sub *ptr =3D &subs[i];
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (ptr) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (strncmp(src, ptr->src, ptr->slen) =3D=3D 0 ) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (src[=
ptr->slen] =3D=3D '/' ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 src[ptr->slen] =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 src[ptr->slen] =3D=3D '\0') {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((src[ptr->slen] =3D=3D '/') &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (strcmp(ptr=
->dst, "/") =3D=3D 0))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 len =3D ptr->slen + 1;
>> @@ -1152,34 +1151,38 @@ static char *selabel_sub(const struct selabel_su=
b *ptr, const char *src)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dst;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ptr =3D ptr->next;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> }
>>
>> #if !defined(BUILD_HOST) && !defined(ANDROID)
>> static int selabel_subs_init(const char *path, struct selabel_digest *di=
gest,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct selabel_sub **out_subs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct selabel_sub **out_subs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint32_t *out_num, uint32_t *out_alloc)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[1024];
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FILE *cfg =3D fopen(path, "re");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct selabel_sub *list =3D NULL,=
 *sub =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FILE *cfg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct stat sb;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int status =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct selabel_sub *tmp =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t tmp_num =3D 0, tmp_alloc =
=3D 0;
>
> Sorry for replying to v2, but I never received v3 (I can download it
> with b4). It doesn't matter for my comment.
>
> tmp_alloc is never updated.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *src_cpy =3D NULL, *dst_cpy =
=3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_subs =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_num =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_alloc =3D 0;
>
> Near the end of this function, we have *out_alloc =3D tmp_alloc, but
> since tmp_alloc is never updated, this is always going to be 0 (unless
> I missed something).

tmp_alloc is updated in the macro GROW_ARRAY(tmp), which modifies the data =
pointer tmp, its size tmp_num, and its capacity tmp_alloc.

> Thanks,
> Jim
>
>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg =3D fopen(path, "re");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cfg) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* If the file does not exist, it is not fatal */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return (errno =3D=3D ENOENT) ? 0 : -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fstat(fileno(cfg), &sb) < 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (fgets_unlocked(buf, si=
zeof(buf) - 1, cfg)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 char *ptr =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 char *ptr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 char *src =3D buf;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 char *dst =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 char *dst;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 size_t len;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 while (*src && isspace((unsigned char)*src))
>> @@ -1207,62 +1210,64 @@ static int selabel_subs_init(const char *path, s=
truct selabel_digest *digest,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub =3D calloc(1, sizeof(*sub));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (! sub)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 src_cpy =3D strdup(src);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!src_cpy)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub->src =3D strdup(src);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (! sub->src)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dst_cpy =3D strdup(dst);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!dst_cpy)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub->dst =3D strdup(dst);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (! sub->dst)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rc =3D GROW_ARRAY(tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (rc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub->slen =3D len;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub->next =3D list;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 list =3D sub;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 tmp[tmp_num++] =3D (struct selabel_sub) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .src =3D sr=
c_cpy,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .slen =3D l=
en,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dst =3D ds=
t_cpy,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 src_cpy =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dst_cpy =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D fstat(fileno(cfg), &sb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto err;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (digest_add_specfile(diges=
t, cfg, NULL, sb.st_size, path) < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_subs =3D list;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_subs =3D tmp;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_num =3D tmp_num;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *out_alloc =3D tmp_alloc;
>>
>> -out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(cfg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return status;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> err:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sub)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(sub->src);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(sub);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (list) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sub =3D list->next;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(list->src);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(list->dst);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free(list);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 list =3D sub;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(dst_cpy);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(src_cpy);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose_errno_safe(cfg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> }
>> #endif
>>
>> static char *selabel_sub_key(const struct saved_data *data, const char *=
key)
>> {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *ptr =3D NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *dptr =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *ptr, *dptr;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr =3D selabel_sub(data->subs, ke=
y);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr =3D selabel_apply_subs(data->s=
ubs, data->subs_num, key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptr) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dptr =3D selabel_sub(data->dist_subs, ptr);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dptr =3D selabel_apply_subs(data->dist_subs, data->dist_sub=
s_num, ptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (dptr) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(ptr=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr =3D =
dptr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ptr =3D selabel_sub(data->dist_subs, key);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ptr =3D selabel_apply_subs(data->dist_subs, data->dist_subs=
_num, key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ptr;
>> @@ -1307,23 +1312,25 @@ static int init(struct selabel_handle *rec, cons=
t struct selinux_opt *opts,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!path) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D selabel_subs_init(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selinux_=
file_context_subs_dist_path(),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rec->digest=
, &data->dist_subs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rec->digest=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->dist=
_subs, &data->dist_subs_num, &data->dist_subs_alloc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (status)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fin=
ish;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D selabel_subs_init(selinux_file_context_subs_p=
ath(),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rec->digest=
, &data->subs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rec->digest=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->subs=
, &data->subs_num, &data->subs_alloc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (status)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fin=
ish;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 path =3D selinux_file_context_path();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", p=
ath);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D selabel_subs_init(subs_file, rec->digest,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->dist_subs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->dist_subs, &data->dist_subs_num, &data->=
dist_subs_alloc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (status)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fin=
ish;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 status =3D selabel_subs_init(subs_file, rec->digest,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->subs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &data->subs, &data->subs_num, &data->subs_alloc=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (status)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fin=
ish;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -1391,8 +1398,8 @@ static void closef(struct selabel_handle *rec)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selabel_subs_fini(data->subs);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selabel_subs_fini(data->dist_subs)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selabel_subs_fini(data->subs, data=
->subs_num);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selabel_subs_fini(data->dist_subs,=
 data->dist_subs_num);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_spec_node(data->root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(data->root);
>> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
>> index de8190f9..436982bf 100644
>> --- a/libselinux/src/label_file.h
>> +++ b/libselinux/src/label_file.h
>> @@ -67,11 +67,11 @@ extern struct lookup_result *lookup_all(struct selab=
el_handle *rec, const char *
>> extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, cons=
t struct selabel_handle *h2);
>> #endif=C2=A0 /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
>>
>> +/* A path substitution entry */
>> struct selabel_sub {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *src;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int slen;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *dst;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct selabel_sub *next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *src;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* source path prefix */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *dst;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* substituted path prefix */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t slen;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* length of sour=
ce path prefix */
>> };
>>
>> /* A regular expression file security context specification */
>> @@ -159,9 +159,17 @@ struct saved_data {
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mmap_area *mmap_areas;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* substitution support */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Array of distribution subs=
titutions
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct selabel_sub *dist_subs=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t dist_subs_num, dist_subs_=
alloc;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Array of local substitutio=
ns
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct selabel_sub *subs;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t subs_num, subs_alloc;
>> };
>>
>> static inline mode_t string_to_file_kind(const char *mode)
>> @@ -811,8 +819,6 @@ static int insert_spec(const struct selabel_handle *=
rec, struct saved_data *data
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> }
>>
>> -#undef GROW_ARRAY
>> -
>> static inline void free_spec_node(struct spec_node *node)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (uint32_t i =3D 0; i < no=
de->literal_specs_num; i++) {
>> --
>> 2.45.2
>>
>>

