Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7E3D5659
	for <selinux@vger.kernel.org>; Tue, 21 Apr 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775526; cv=none; b=ZCd3wModbPKck3VwhbwwpmeTz4q7ZsaL8NLmBQCxMsg7ikci7ESEJY+D8DkfU/v7AQ9NBNYu6jH6OWLKhf+K8bzGDNEP7qf4+BcvS+KrRvFeLF0AXWe4b21Ea/6Q2XUCvduUTjDJ9TNFE0aYCLPuqfTnrkP0HUgTrtFLti2UwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775526; c=relaxed/simple;
	bh=H3gOlQKumAABRLxD/VfDQjp6VcWHzCT+fVawLWVbSVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FahAyPiTFyAete2ihs5fLLLjNEr7M3EmhKf8/IDLWhN4lbjWic7EEaRJrZzh2wmIoRDQN2/CKrIGCVPUPUB0F/EmhYYKYj3xJmZ3hE/l3sdPB15ymHKWomfIOaAhsvzP1PA6ZAvPi3NeDTcBNAiiTM9Q+NYjSYTep/Lgy+VgkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b90pgmGG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b90pgmGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776775524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EErRR+shC2/Y+rWjtXFfH+yI7waqzApbqU85UGFhb+Q=;
	b=b90pgmGGnsEejfvPdBe7DQT8K+ozylPIwITXjSlPjXyxcAP5CLIfTMQ2pN5c/toWEWM4E6
	6KmP1B8OGUGd6l8sYY+51qEtS0Hr2jyxnvu0d1tfRnBwF6ZrOCLbtIPxSG6Wu8Ai9JUYQx
	XkeauPHaeLhhYo24AGZqG2cqkLC62H8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-CuJTXwTXP2y0otH7bx69ew-1; Tue,
 21 Apr 2026 08:45:21 -0400
X-MC-Unique: CuJTXwTXP2y0otH7bx69ew-1
X-Mimecast-MFC-AGG-ID: CuJTXwTXP2y0otH7bx69ew_1776775520
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D29818003FC;
	Tue, 21 Apr 2026 12:45:20 +0000 (UTC)
Received: from localhost (unknown [10.44.32.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 902C1195608E;
	Tue, 21 Apr 2026 12:45:19 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Vit Mojzis <vmojzis@redhat.com>
Subject: Re: [PATCH] mcstrans: Fix translation for uncached entries
In-Reply-To: <CAP+JOzRs-+oW0jXiEGpPz4qg=mDix_9=tXBMMmkJ9P=wPyA16w@mail.gmail.com>
References: <20260216194829.3372622-1-vmojzis@redhat.com>
 <CAP+JOzRs-+oW0jXiEGpPz4qg=mDix_9=tXBMMmkJ9P=wPyA16w@mail.gmail.com>
Date: Tue, 21 Apr 2026 14:45:18 +0200
Message-ID: <875x5kh481.fsf@redhat.com>
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

> On Mon, Feb 16, 2026 at 2:48=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> w=
rote:
>>
>> trans_context:
>> In case the raw context is not found in cache (find_in_hashtable returns
>> NULL) and the context does not contain a dash (dashp =3D=3D NULL),
>> compute_trans_from_raw gets executed, but the translation (trans) gets
>> freed immediately after caching, at the end of the "for" loop.
>>
>> untrans_context:
>> Same as trans_context, if the translation is not cached and "range" does
>> not contain a dash, compute_raw_from_trans is called, but the
>> translation (raw) gets freed right after the reverse translation is
>> computed and cached.
>>
>> Also, fix the README for "nato" example and add README for "pipes"
>> example of setrans configuration.
>>
>> Fixes:
>>   Pipes/NATO examples from /usr/share/mcstrans/examples
>>
>>   $ /usr/share/mcstrans/util/mlstrans-test pipes.test
>> untrans: 'a:b:c:Restricted Handle Via Iron Pipes Only' -> 'a:b:c:Restric=
ted Handle Via Iron Pipes Only' !=3D 'a:b:c:s2:c102,c200.c511' FAILED
>> untrans: 'a:b:c:Restricted Handle Via Copper Pipes Only' -> 'a:b:c:Restr=
icted Handle Via Copper Pipes Only' !=3D 'a:b:c:s2:c103,c200.c511' FAILED
>> untrans: 'a:b:c:Restricted Handle Via Plastic Pipes Only' -> 'a:b:c:Rest=
ricted Handle Via Plastic Pipes Only' !=3D 'a:b:c:s2:c101,c200.c511' FAILED
>> untrans: 'a:b:c:Restricted Handle Via Galvanized Pipes Only' -> 'a:b:c:R=
estricted Handle Via Galvanized Pipes Only' !=3D 'a:b:c:s2:c104,c200.c511' =
FAILED
>> untrans: 'a:b:c:Restricted Handle Via Plastic,Iron,Copper Pipes Only' ->=
 'a:b:c:Restricted Handle Via Plastic,Iron,Copper Pipes Only' !=3D 'a:b:c:s=
2:c101.c103,c200.c511' FAILED
>> untrans: 'a:b:c:Restricted Handle Via Iron,Plastic,Copper Pipes Only' ->=
 'a:b:c:Restricted Handle Via Iron,Plastic,Copper Pipes Only' !=3D 'a:b:c:s=
2:c101.c103,c200.c511' FAILED
>> mlstrans-test done with 6 errors
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>> ---
>>
>> While working on this patch, I also noticed that s0 is treated
>> differently in the mcstrans code (as also noted by [1] and [2]).
>> Could anyone help shed some light on the reason for this?
>>
>> Thank you.
>>
>> [1] - https://github.com/SELinuxProject/selinux/issues/191#issuecomment-=
566124541
>> [2] - https://lore.kernel.org/selinux/0f7263c2-b16e-2979-cc55-9454a402b6=
a4@gmail.com/
>>
>>  mcstrans/share/examples/nato/README  |  8 +++-----
>>  mcstrans/share/examples/pipes/README | 10 ++++++++++
>>  mcstrans/src/mcstrans.c              |  5 ++++-
>>  3 files changed, 17 insertions(+), 6 deletions(-)
>>  create mode 100644 mcstrans/share/examples/pipes/README
>>
>> diff --git a/mcstrans/share/examples/nato/README b/mcstrans/share/exampl=
es/nato/README
>> index b8b30bf7..7d75e0d6 100644
>> --- a/mcstrans/share/examples/nato/README
>> +++ b/mcstrans/share/examples/nato/README
>> @@ -1,12 +1,10 @@
>>  NATO example test setrans.conf
>>
>>  To use:
>> -mkdir /etc/selinux/mls/mcstrand.d
>> -cp rel.conf /etc/selinux/mls/mcstrand.d
>> -cp eyes-only.conf /etc/selinux/mls/mcstrand.d
>> -cp constraints.conf /etc/selinux/mls/mcstrand.d
>> +rm -f /etc/selinux/mls/setrans.d/*
>> +cp setrans.d/*  /etc/selinux/mls/setrans.d
>>  cp setrans.conf /etc/selinux/mls/setrans.conf
>> -sudo run_init /etc/init.d/mcstrans restart
>> +run_init /etc/init.d/mcstrans restart
>>
>>  To test:
>>  /usr/share/mcstrans/util/mlstrans-test nato.test
>> diff --git a/mcstrans/share/examples/pipes/README b/mcstrans/share/examp=
les/pipes/README
>> new file mode 100644
>> index 00000000..3963d300
>> --- /dev/null
>> +++ b/mcstrans/share/examples/pipes/README
>> @@ -0,0 +1,10 @@
>> +PIPES example test setrans.conf
>> +
>> +To use:
>> +rm -f /etc/selinux/mls/setrans.d/*
>> +cp setrans.d/*  /etc/selinux/mls/setrans.d
>> +cp setrans.conf /etc/selinux/mls/setrans.conf
>> +run_init /etc/init.d/mcstrans restart
>> +
>> +To test:
>> +/usr/share/mcstrans/util/mlstrans-test pipes.test
>> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
>> index f18f9da9..5ef6a0b9 100644
>> --- a/mcstrans/src/mcstrans.c
>> +++ b/mcstrans/src/mcstrans.c
>> @@ -1578,12 +1578,14 @@ trans_context(const char *incon, char **rcon) {
>>                         urange =3D dashp+1;
>>                 } else {
>>                         trans =3D compute_trans_from_raw(range, domain);
>> -                       if (trans)
>> +                       if (trans) {
>>                                 if (add_cache(domain, range, trans) < 0)=
 {
>>                                         free(trans);
>>                                         free(range);
>>                                         return -1;
>>                                 }
>> +                               break;
>> +                       }
>>                 }
>>
>>                 if (lrange && urange) {
>> @@ -1728,6 +1730,7 @@ untrans_context(const char *incon, char **rcon) {
>>                                         free(raw);
>>                                         return -1;
>>                                 }
>> +                               break;
>>                         } else {
>>                                 log_debug("untrans_context unable to com=
pute raw context %s\n", range);
>>                         }
>> --
>> 2.52.0
>>
>>

