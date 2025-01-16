Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A422B8C4
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043780; cv=none; b=T9aJhPTHAq/GdlBL+oyx002pjlzBLtF0O2iNAtz7PZiDe3cgkQAoSCqtjdVjV+diXiQTJKsEQ++Eu0sw/atbkG5931LD3+Bd6b7PY+018pEazHRwLTRS44m6MKwcFLSUGpT/Xb7ac0yFVvhLbjUMXwgBqR9NLwCzMo3wcTirbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043780; c=relaxed/simple;
	bh=1hCF2uYmc6JF2Nu8Z6z1+Ufyg7WxH85thgV1P17Qj3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrbS97DZqzbgCPcDe7b43Eacz8KH5LPiiJqpXnrUHTZWhCK1F027kLzuuUMRyy69lgOzIyHvhxEqQrdzQNDZZjzlWN0DIShcUeQFUAb1IYu0UQaU9Eutnq/787XA10Y/S4DPGF1tJjshwz67Jnmo9bkPq7lyhbYpY73D2KvVwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+q9191/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+q9191/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737043777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrwWIb4MkA1fUu0Q7CQ6oqj2H2ZBc6mRteyZG59pGIs=;
	b=e+q9191/IzpYgUX2s5oXg90RkNiGAE6HzNh5Mk0xAg6qolKn20mm+tWuvOvZyEOZ2fhuWS
	rHNBye4J2pZH3GbZRhXmy7/JlXX92a9tCVsoyJb1Z+f0+YVsFykrrXUhHX7d1SPkbCnzf3
	oXST0cCmq2N7szsFjtQFUOlIEnkc3B0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-e8BT28juOLieWo2QLi81VA-1; Thu,
 16 Jan 2025 11:09:34 -0500
X-MC-Unique: e8BT28juOLieWo2QLi81VA-1
X-Mimecast-MFC-AGG-ID: e8BT28juOLieWo2QLi81VA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43EFB1955DCC;
	Thu, 16 Jan 2025 16:09:33 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCB0B1955F1B;
	Thu, 16 Jan 2025 16:09:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, cgzones@googlemail.com,
 selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH 1/2] libsepol: fix typos
In-Reply-To: <CAP+JOzQkEU_TGtL4cYzZAL0tUARjyL1y1jn1MXs6WdOYRwARpw@mail.gmail.com>
References: <20241230140523.60053-1-cgoettsche@seltendoof.de>
 <20241230140523.60053-2-cgoettsche@seltendoof.de>
 <CAP+JOzQkEU_TGtL4cYzZAL0tUARjyL1y1jn1MXs6WdOYRwARpw@mail.gmail.com>
Date: Thu, 16 Jan 2025 17:09:31 +0100
Message-ID: <877c6uwxj8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

James Carter <jwcart2@gmail.com> writes:

> On Mon, Dec 30, 2024 at 9:05=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
>>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Found by codespell(1) and typos[1].
>>
>> [1]: https://github.com/crate-ci/typos
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!

>> ---
>>  libsepol/src/kernel_to_cil.c | 2 +-
>>  libsepol/src/module_to_cil.c | 2 +-
>>  libsepol/src/policydb.c      | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index 2d563e7d..ddca2b62 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -1802,7 +1802,7 @@ static char *avtab_node_to_str(struct policydb *pd=
b, avtab_key_t *key, avtab_dat
>>                 } else if (datum->xperms->specified =3D=3D AVTAB_XPERMS_=
NLMSG) {
>>                         xperm =3D (char *) "nlmsg";
>>                 } else {
>> -                       ERR(NULL, "Unknown extended permssion");
>> +                       ERR(NULL, "Unknown extended permission");
>>                         goto exit;
>>                 }
>>                 rule =3D create_str("(%s %s %s (%s %s (%s)))",
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index 0ede0c9b..ae9a2b5d 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -709,7 +709,7 @@ static int avrulex_to_cil(int indent, struct policyd=
b *pdb, uint32_t type, const
>>         } else if (xperms->specified =3D=3D AVTAB_XPERMS_NLMSG) {
>>                 xperm =3D "nlmsg";
>>         } else {
>> -               ERR(NULL, "Unkown avrule xperms->specified: %i", xperms-=
>specified);
>> +               ERR(NULL, "Unknown avrule xperms->specified: %i", xperms=
->specified);
>>                 rc =3D -1;
>>                 goto exit;
>>         }
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index 0747e789..8443380b 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -1662,7 +1662,7 @@ int policydb_load_isids(policydb_t * p, sidtab_t *=
 s)
>>   *
>>   * arguments:
>>   *   policydb_t *pol       module policy to modify
>> - *   uint32_t sym          the symbole table for insertion (SYM_*)
>> + *   uint32_t sym          the symbol table for insertion (SYM_*)
>>   *   hashtab_key_t key     the key for the symbol - not cloned
>>   *   hashtab_datum_t data  the data for the symbol - not cloned
>>   *   scope                 scope of this symbol, either SCOPE_REQ or SC=
OPE_DECL
>> --
>> 2.45.2
>>
>>

