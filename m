Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144383DD51B
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322843; cv=none; b=trK4uIO6etjYSySiYFhw8CaajagKkpoNt04FTbYiFUWFepwryuX+BPrUr14f3lVgJDZgGByJY+CsyTFjCKng2M9qlzPb/n2yXX2QtWxKNPRikOGYNrAfQcvQhm+A2lFNiiRzhtCTuvBYUnsVnlJvv4DKxGt31QT1qPrUTHNvVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322843; c=relaxed/simple;
	bh=fxofsHdmd6BkJEpo9p3kJqQZYDhZuQCYsLnci3BLqFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oPmpRRw0TkTRTLUNJElo/AtVYeKQb55C7lw+z1OcXer1Qf1GrkYW9fJ1mplaTR2sIfyLD7t8DLW3P6TVB/Zxg6jKk20p5BMkCm9d2Og67kFSFpWK0WnhYUcYctu2QdVCu0eEWrPE95OUqXYnN8tiIRIuLIRIQJM8eoud/nX+4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDdJate3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDdJate3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782322841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rkn4zzbos1unS8C4hEj2mJH+r145hglcTU4vOHCKF+M=;
	b=eDdJate32lZSOBqpBn1+h19K2cWqFSWFbIfsQQOmhZd4G2Y1N2dw17enJ/6lKYBO4GfNNs
	xuQtl69yXq3Cnl7BCHBhjYAenHbF7j/0602Rv8OpG6qFAPeiHSmPpqMgQ+f+ar7izi+54c
	ntg1jfVyfXysFvxkNtyfUO2vQOv+Qv8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-6TNTeahxNFuF_ypmQq2jSQ-1; Wed,
 24 Jun 2026 13:40:37 -0400
X-MC-Unique: 6TNTeahxNFuF_ypmQq2jSQ-1
X-Mimecast-MFC-AGG-ID: 6TNTeahxNFuF_ypmQq2jSQ_1782322836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A23A1956042;
	Wed, 24 Jun 2026 17:40:36 +0000 (UTC)
Received: from localhost (unknown [10.44.33.183])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B3531956044;
	Wed, 24 Jun 2026 17:40:35 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, Stephen Smalley
 <stephen.smalley.work@gmail.com>, cgzones@googlemail.com
Cc: 
Subject: Re: [PATCH] Makefile: avoid 0 as NULL pointer constant
In-Reply-To: <CAEjxPJ4m7__fzUnv2KP2hqLAzNvEOqn_xkH_oEMxP7hfWpHdkA@mail.gmail.com>
References: <20260623133950.96060-1-cgoettsche@seltendoof.de>
 <CAEjxPJ4m7__fzUnv2KP2hqLAzNvEOqn_xkH_oEMxP7hfWpHdkA@mail.gmail.com>
Date: Wed, 24 Jun 2026 19:40:35 +0200
Message-ID: <87bjczu99o.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Tue, Jun 23, 2026 at 9:40=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
>>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> fts_close(3) takes a pointer as argument; use `(void*)0` instead of pure
>> `0` to please building with `-Wzero-as-null-pointer-constant`. Avoid
>> using NULL to not require <stddef.h>.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 0e465f94..ae8586c6 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -29,7 +29,7 @@ endif
>>
>>  # check for fts_* availability
>>  H :=3D \#
>> -ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return f=
ts_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-=
function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>> +ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return f=
ts_close((void*)0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dim=
plicit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes=
))
>>  export FTS_LDLIBS :=3D -lfts
>>  endif
>>
>> --
>> 2.53.0
>>
>>

