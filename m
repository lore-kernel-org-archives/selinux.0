Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5448AE3E
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853882; cv=none; b=DU2d9AKfzITS/xGhIVb5TRzmrV0y+jDNZb02gcwq/GgoydXstAHH5EIZ93yFibsLrvCWrYIq0hloMhPGN1HXBOqIlqKPppafeyIUnePRZeWwM7J+ZuBMiH6WTNVv1mQiHXH4Rx1klu6Yf4kOrIe92ixLSFL5W9HPNJQov9HnHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853882; c=relaxed/simple;
	bh=MZxmbM4jrvhc1ytl4OHlo8FVI2Bye2DGwjhSNRsXyW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s+cO70/wRVO8fFXBo6QjQy/SlQ0X8h0T9ptEOG2Xh/MPguoxtn9TISVQxvEGMdFZ24zrwyom4QVqnQ63HU3LsmsGFgNarvexi/N0RKcFYZpiqKTwFfcB4bU1z3t/0LnLCC12sO0DsWdaUqLNDZk4rtsFTOqoiz+8x+6c10SgPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6zEviWo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6zEviWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778853879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfUkK1Fryn5Za+CVUhRoQcgc7l37/X2jrUrYHGZoy1I=;
	b=Q6zEviWohVC4LRsyv1N2mC1XEwSbd4lHIZ7BI8kTZdd4jFt+u/IEBU8g/HTWCwyGGOhIPW
	nlImoRC6DBvI69V+wruiCdDeoFJyRnMOVMtZeA31WbfS2YFQLT477GGwe0kMqD7ZZXx5Uc
	2APDZXfTmS4aBkFcsURYuxmAAPzJBYo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-YYitcMPZM5mFUEJUir-owg-1; Fri,
 15 May 2026 10:04:34 -0400
X-MC-Unique: YYitcMPZM5mFUEJUir-owg-1
X-Mimecast-MFC-AGG-ID: YYitcMPZM5mFUEJUir-owg_1778853873
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 218F419560B4;
	Fri, 15 May 2026 14:04:33 +0000 (UTC)
Received: from localhost (unknown [10.44.49.163])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CA501955F2D;
	Fri, 15 May 2026 14:04:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, Rahul Sandhu <nvraxn@posteo.uk>,
 selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH] cil_reference_guide: update specification for valid
 symbols
In-Reply-To: <CAP+JOzRZm-j1+SP3cuJ+gA_-b8AxwHqivmyv=rsCw+LjF-Z-zw@mail.gmail.com>
References: <20260413174043.3733803-2-nvraxn@posteo.uk>
 <CAP+JOzRZm-j1+SP3cuJ+gA_-b8AxwHqivmyv=rsCw+LjF-Z-zw@mail.gmail.com>
Date: Fri, 15 May 2026 16:04:31 +0200
Message-ID: <87jyt4hiq8.fsf@redhat.com>
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

> On Mon, Apr 13, 2026 at 1:43=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> w=
rote:
>>
>> Currently, the specification has a very limited character set of valid
>> symbols. This does not reflect was libsepol (and by extension secilc as
>> well) accepts, as can be seen both in spec_char's definition[1], which
>> symbol is comprised of along with digit and alpha, and with some basic
>> demonstration (note cil-policy.cil refers to the example CIL minimum
>> viable policy provided by the SELinux notebook[2] such that the example
>> is not polluted with SID declarations, policy caps, and other fluff):
>>
>>   carbon ~ # cat <<'EOF' >mytest.cil
>>   (filecon /[].@=3D/*-_$%+-!|&^:~`#{}'<>?, any ())
>>   EOF
>>   carbon ~ # secilc mytest.cil cil-policy.cil
>>   carbon ~ # echo $?
>>   0
>>
>> As can be seen above, secilc is perfectly happy to accept a variety of
>> characters which are not valid in the specification. Whilst the above
>> example does NOT use valid filecon regex, which libsemanage will later
>> complain about, that does not matter for the purpose of demonstration:
>> a symbol pertains ONLY to what is valid in the language grammar as an
>> unquoted string, not what is valid for the filecon statement.
>>
>> It should be noted as well that this patch drops the backslash symbol,
>> '\'. The libsepol definition of spec_char omits it and this can also be
>> seen in practice:
>>
>>   carbon ~ # cat <<'EOF' >mytest.cil
>>   (filecon /\. any ())
>>   EOF
>>   carbon ~ # secilc mytest.cil cil-policy.cil
>>   Invalid token '\' at line 1 of mytest.cil
>>   Failure adding mytest.cil
>>
>> As such, no consumers should be impacted by its removal from the spec.
>> It also does not seem like a grave omission, so it's probably best to
>> just drop it from the spec.
>>
>> [1] https://github.com/SELinuxProject/selinux/blob/6be1ec3792c11040fd7a3=
ecb1135e54418eb0d57/libsepol/cil/src/cil_lexer.l#L48
>> [2] https://github.com/SELinuxProject/selinux-notebook/blob/9888b84b8e76=
c18c6141812d7ffd9b3e2fad6f9e/src/notebook-examples/cil-policy/cil-policy.cil
>>
>> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Acked-by: James Carter <jwcart2@gmail.com>


Merged, thanks!

>> ---
>>  secilc/docs/cil_reference_guide.md | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/secilc/docs/cil_reference_guide.md b/secilc/docs/cil_refere=
nce_guide.md
>> index bcd34b68..af883232 100644
>> --- a/secilc/docs/cil_reference_guide.md
>> +++ b/secilc/docs/cil_reference_guide.md
>> @@ -93,7 +93,7 @@ Definitions may be repeated many times throughout the =
policy. Duplicates will re
>>  Symbol Character Set
>>  --------------------
>>
>> -Symbols (any string not enclosed in double quotes) must only contain al=
phanumeric `[a-z A-Z] [0-9]` characters plus the following special characte=
rs: `\.=3D/-_$%@+!|&^:`
>> +Symbols (any string not enclosed in double quotes) must only contain al=
phanumeric `[a-z A-Z] [0-9]` characters plus the following special characte=
rs: `` [].@=3D/*-_$%+-!|&^:~`#{}'<>?, ``
>>
>>  However symbols are checked for any specific character set limitations,=
 for example:
>>
>> --
>> 2.53.0
>>
>>

