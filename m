Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B94190676
	for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615408; cv=none; b=pRAmwRlp4AkNaWTOGoWuxDVRuak0I2xSpiw7vvm/sardXCYCjw3uZW6sdq6hfNxHWuH1saX+rdN0wbZsbLp0zQ4W043pLADOaB5nFQls/iy78H0trXJSBHfRhTvTs7BJMjeyxaWH8+0FtTJvsKWkhvEaRSEhYjXvK9+VIji/LsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615408; c=relaxed/simple;
	bh=EQdkWRBjSbxhZfrnOpmOL2Xn13DgFY7HbeJnVfVkCcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VgBAFXVWdMRiACehi4KLzYZri3RFKvImJLQkWlTpr4i20Jpy6s2bPPUhb/p6Kq8q9psqpVxPDTGE4eKt1EEAPW3hqE+sdmho/sZ+wIDcC9K8BWz25nvW/55ZrUrVi9+tvjc3vYI2SV17I4P1HOmPN6Xrg5SFGOjtqCx5GmZwHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5RMTD3A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5RMTD3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718615404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RpuzXhmUFo0CTdm8AbUQUMe4dMBAxQrx5u0juFzO9TY=;
	b=G5RMTD3AxwA53YCA6D+cauQsyOM9r52EAP1Wf3PN5kp2fmuCcXKZpTdO+tDDNw5LH14g0m
	vYLSVx/ypt6xIwLXRzPR3tKklynUzGTsYJB0waeQrGuOvL3WfjfNbqUtASw9ybdMFsiWu6
	DkacPhkTFhyw0tKDdtdq42o9Az9LzuM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-fZuQWM8ePhC8EwWk9w96Mw-1; Mon,
 17 Jun 2024 05:09:57 -0400
X-MC-Unique: fZuQWM8ePhC8EwWk9w96Mw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39CF319560AE;
	Mon, 17 Jun 2024 09:09:56 +0000 (UTC)
Received: from localhost (unknown [10.45.224.224])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A96381956048;
	Mon, 17 Jun 2024 09:09:55 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>, James
 Carter
 <jwcart2@gmail.com>
Subject: Re: [PATCH] libsepol: Do not reject all type rules in conditionals
 when validating
In-Reply-To: <CAJ2a_Dderor=tkxK9YDNN9r_xb-rpcSHXJcBiCf0nMuhakBUoQ@mail.gmail.com>
References: <20240614194500.631810-1-jwcart2@gmail.com>
 <CAJ2a_Dderor=tkxK9YDNN9r_xb-rpcSHXJcBiCf0nMuhakBUoQ@mail.gmail.com>
Date: Mon, 17 Jun 2024 11:09:54 +0200
Message-ID: <87bk409bq5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Fri, 14 Jun 2024 at 21:45, James Carter <jwcart2@gmail.com> wrote:
>>
>> Commit 1c91bc84 ("libsepol: reject self flag in type rules in old
>> policies") actually rejects all type rules in conditionals in modular
>> policies prior to version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).
>>
>> The problem is because of fall-through in a switch statement when
>> the avrule flags are 0. Instead, break rather than fall-through when
>> avrule flags are 0.
>
> Thanks for spotting this.
> I'am probably going to look to enhance the downgrade unit test for the
> next validate updates...
>
> Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>



>
>> ---
>>  libsepol/src/policydb_validate.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_va=
lidate.c
>> index 9746f562..2043e437 100644
>> --- a/libsepol/src/policydb_validate.c
>> +++ b/libsepol/src/policydb_validate.c
>> @@ -1076,6 +1076,7 @@ static int validate_avrules(sepol_handle_t *handle=
, const avrule_t *avrule, int
>>
>>                 switch(avrule->flags) {
>>                 case 0:
>> +                       break;
>>                 case RULE_SELF:
>>                         if (p->policyvers !=3D POLICY_KERN &&
>>                             p->policyvers < MOD_POLICYDB_VERSION_SELF_TY=
PETRANS &&
>> --
>> 2.45.2
>>

