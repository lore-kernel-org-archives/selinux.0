Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77F1FF7D5
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725134; cv=none; b=kYhhbZuWWuwRhknvMTPjumlADX+mTGR83VcRyCSniAc4Gd5U6ioRJqauzLyao96mM9gvNbTiIurMgBrrw/gR8+YbsSSA0tvMy/qb91K405zDl/CPDfcbhBKnQ3efNr6qi068CnvpXhrXpr3/vQU3+diI8Kzghr0SZH1mWyWezgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725134; c=relaxed/simple;
	bh=aEeEsKnxO4ssS2+McI7sHUplp06Tnr8j6YrJx9zkITA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2R5F/dww8HkCGLo2X1Ef+aIf205ibKFkIZc98MNWNWZb42Kg4YDCbgwwaacdFw/almBBHP+qHoBZ2fjFGGu2fN1io3UeiRwNBxEBDoHM4HzpcEeVrFO+ww9LXo/3a4YIcy6dkvfcPJSpmc9lbHsS+GqtirBBL/QcY8oQ0LWzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF1tczlg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF1tczlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732725131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0rjRjULsMm6Sw2zzVINIw1xr5YW0Qw+j/UHQz4sKQA=;
	b=dF1tczlgrtQHueOMQxFYpOOD9kiYwPjbCbFRDI+nMNyxI9lf09OWK19vIIGnTl8gSf4V6w
	dOLNDmpImQoZwq0pq8tYxpcO5pCWXXXKAbZJIPJV/P3hcTFKe7WZiPoQ3MLo2/n17LUoiW
	PPk+tjplY3aA8F/c7oa/SMGBXParjJg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-6Bn1GNGPPIyt2OE4TggPHA-1; Wed,
 27 Nov 2024 11:32:06 -0500
X-MC-Unique: 6Bn1GNGPPIyt2OE4TggPHA-1
X-Mimecast-MFC-AGG-ID: 6Bn1GNGPPIyt2OE4TggPHA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AE581953955;
	Wed, 27 Nov 2024 16:32:05 +0000 (UTC)
Received: from localhost (unknown [10.45.224.170])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFF6A195E480;
	Wed, 27 Nov 2024 16:32:04 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, cgzones@googlemail.com
Subject: Re: [PATCH v2 9/9] libsemanage: respect shell paths with /usr prefix
In-Reply-To: <CAP+JOzRyZWgpnoYO0T97F9zr=-DkSEsD9uvYFv-Av+5SN9NeBA@mail.gmail.com>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
 <20241125111840.63845-9-cgoettsche@seltendoof.de>
 <CAP+JOzRyZWgpnoYO0T97F9zr=-DkSEsD9uvYFv-Av+5SN9NeBA@mail.gmail.com>
Date: Wed, 27 Nov 2024 17:32:02 +0100
Message-ID: <87ttbsvdrx.fsf@redhat.com>
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

> On Tue, Nov 26, 2024 at 5:46=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
>>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Consider paths with the prefix /usr for shells by including them in the
>> list of fallback default shells and by extending the check for a nologin
>> shell.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these nine patches:
> Acked-by: James Carter <jwcart2@gmail.com>

It's merged now. Thanks!


>> ---
>>  libsemanage/src/genhomedircon.c | 32 +++++++++++++++++++++++---------
>>  1 file changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedi=
rcon.c
>> index 19543799..8782e2cb 100644
>> --- a/libsemanage/src/genhomedircon.c
>> +++ b/libsemanage/src/genhomedircon.c
>> @@ -192,15 +192,23 @@ static semanage_list_t *default_shell_list(void)
>>         semanage_list_t *list =3D NULL;
>>
>>         if (semanage_list_push(&list, "/bin/csh")
>> +           || semanage_list_push(&list, "/usr/bin/csh")
>>             || semanage_list_push(&list, "/bin/tcsh")
>> +           || semanage_list_push(&list, "/usr/bin/tcsh")
>>             || semanage_list_push(&list, "/bin/ksh")
>> +           || semanage_list_push(&list, "/usr/bin/ksh")
>>             || semanage_list_push(&list, "/bin/bsh")
>> +           || semanage_list_push(&list, "/usr/bin/bsh")
>>             || semanage_list_push(&list, "/bin/ash")
>> -           || semanage_list_push(&list, "/usr/bin/ksh")
>> +           || semanage_list_push(&list, "/usr/bin/ash")
>> +           || semanage_list_push(&list, "/bin/pdksh")
>>             || semanage_list_push(&list, "/usr/bin/pdksh")
>>             || semanage_list_push(&list, "/bin/zsh")
>> +           || semanage_list_push(&list, "/usr/bin/zsh")
>>             || semanage_list_push(&list, "/bin/sh")
>> -           || semanage_list_push(&list, "/bin/bash"))
>> +           || semanage_list_push(&list, "/usr/bin/sh")
>> +           || semanage_list_push(&list, "/bin/bash")
>> +           || semanage_list_push(&list, "/usr/bin/bash"))
>>                 goto fail;
>>
>>         return list;
>> @@ -210,6 +218,12 @@ static semanage_list_t *default_shell_list(void)
>>         return NULL;
>>  }
>>
>> +static bool is_nologin_shell(const char *path)
>> +{
>> +       return strcmp(path, PATH_NOLOGIN_SHELL) =3D=3D 0 ||
>> +              strcmp(path, "/usr" PATH_NOLOGIN_SHELL) =3D=3D 0;
>> +}
>> +
>>  static semanage_list_t *get_shell_list(void)
>>  {
>>         FILE *shells;
>> @@ -223,13 +237,13 @@ static semanage_list_t *get_shell_list(void)
>>                 return default_shell_list();
>>         while ((len =3D getline(&temp, &buff_len, shells)) > 0) {
>>                 if (temp[len-1] =3D=3D '\n') temp[len-1] =3D 0;
>> -               if (strcmp(temp, PATH_NOLOGIN_SHELL)) {
>> -                       if (semanage_list_push(&list, temp)) {
>> -                               free(temp);
>> -                               semanage_list_destroy(&list);
>> -                               fclose(shells);
>> -                               return NULL;
>> -                       }
>> +               if (is_nologin_shell(temp))
>> +                       continue;
>> +               if (semanage_list_push(&list, temp)) {
>> +                       free(temp);
>> +                       semanage_list_destroy(&list);
>> +                       fclose(shells);
>> +                       return NULL;
>>                 }
>>         }
>>         free(temp);
>> --
>> 2.45.2
>>
>>

