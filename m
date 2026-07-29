Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102D481ABB
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329062; cv=pass; b=O6TV7pwHNJS1pdi+P0CS7oeYWfY98D24g8+cm1hPVTCl5g3H2RPtKeA3EZNhZd6vqP8Z2ONbcs/co4uM0JkuzTWAyv+aEQ3BDvuGCISv/tdGTdK9NmKziyMjjQNRH82VdyG/muT6FOUCtDWyqWstBvQjZK9dAhjD14810ITQbjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329062; c=relaxed/simple;
	bh=OzbEc/zia+T9J0aPUjd0Ps2BXmce7p9XlHPW7etU3pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JZ37+Vrp6jRxP1pC8z2KFmA3bCl2nqdt6pwqI3UZ8O2hqN8yt0xL+4Rr2dE/5/kiH4ZOd9pCW7Kksol0ZvQtywTsiHiyjKsc/hYeMjz2Cho3WpEgN+/VSIf0/Q2a+2Itdwp252/0UKskp/euJe8IJhGwJsSZHMx9S7fCtRNVBlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9Dh1+sk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue4kjcaa; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9Dh1+sk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue4kjcaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785329049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhnANFQvEZAO1P9CbqAsuS8y4CIirDyPnZxcgj5q2cU=;
	b=G9Dh1+skKtloML6MlHCFMO+xPnznUusUWDrejxMnO184XoWxP+8Ai8zpxmUTOTdFbJsbDO
	hE2IBhlN2ZYp8LXfGtWmbigejqqu6IFdmZuk9ZTu2pCWAzIEvY1ewodzOq5ZITJ3yWdlJj
	z7BrWf98QHjzBcOGHhvOHLvvY0BQGT4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-U6ixnMpTMSeYLLJ_gf-S4g-1; Wed, 29 Jul 2026 08:44:08 -0400
X-MC-Unique: U6ixnMpTMSeYLLJ_gf-S4g-1
X-Mimecast-MFC-AGG-ID: U6ixnMpTMSeYLLJ_gf-S4g_1785329047
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1273327a12.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 05:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785329047; cv=none;
        d=google.com; s=arc-20260327;
        b=YlmWycOKNdfhyw2GmiyZ4/4lQ8Pq1wMWYjOPbl/HBT1LJ9nRon+MTG7shReFC07LZM
         L71cdUW7c2G2xN4HBqy1+w3zx+cHPhqIaBZM1A4BqGt5NvaG7asUtpShg0b6RUQL+Olr
         NVYbCHNI8YbXjVWY8X8PWSXT22Ay7lglF8n0CLdganYPh5zxTDuIHnWGk0wxOoFu2VqX
         8r8A68H5D93WbG/cK7w5dqEuWBYhP06U3TXNfsbNWZ23ZxS+vKgvlvyXH/GliliN0XVf
         OYk7Mq1KgdHrkyjeZ+X5r5KirVUohJH0/SV7WsWumBh/AQcuYnmTVzRKOYU4jFYfLtB+
         yPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OhnANFQvEZAO1P9CbqAsuS8y4CIirDyPnZxcgj5q2cU=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=ZTIjxAyP157NWAv9AOsEfPcoBB/L849yJCOcwcLVjpEOqPPsm4DhVUlTgjtM/f4urH
         ACgs1zZCEaeeompjStucfbtK+DDrwpoeDtxhJNcmj0rm648QEhC9D9xoOfWVuFB4i/l1
         2BMZ+tMxh1EAr/eu1knKmh4amYAMJIZBNmyMepcIwbB0vCdNItrI/nS8tpe2tRIiWgaX
         hKupnwOGMUTS4McikZmY9EVPVIFP/QH8jSD7+HlCYuTQ6pWKltsTbpPOMsMCYKp8KzCa
         pevnT/0teWdOC2ZDXwhocofS3GBitFDbbPVDp5XJkl3sJOfiTGq2qWqs5dAe+hSSU2K/
         dg3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785329047; x=1785933847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OhnANFQvEZAO1P9CbqAsuS8y4CIirDyPnZxcgj5q2cU=;
        b=Ue4kjcaaXsaHhlibJ8nzQXtVioos9vPHIIgjg7OsoBpvUsRBLckuKir5w1CeHoPRdk
         KiK2Zd5Fz88BgyY1+rv85AhQZDVJzRlMhcZgO6JEYWDwsYnj6AMoojdXVhT0k7gdEGhG
         8gnGQagoL5Yootgr+ff/QqT8s2opxX2Qn//0d6AwMORqAglqr91rz17SOf2XHxkSDbIm
         vpEKxHmyhxhYhNwdqN2YY3O+BFhAZdJWV3lL22ZrCqNlUQ9ZFr0MNskyHwSR/Y47nncD
         VZ6pIz9AU7KT9iT7bZjBeMsuZVBlhyqsogV/QUExho28rKC6nGD7nka/DPluzNuw6gc9
         FnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785329047; x=1785933847;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OhnANFQvEZAO1P9CbqAsuS8y4CIirDyPnZxcgj5q2cU=;
        b=qWPGj5i1k7+tTNgQLOGd696QfEQcByqaShH7x0jY31ezJdC3WRNEOlD6CwReYGffGj
         dqOIEwBYUjpB+UR+CyqdzerFWBHoxFscFsmqrUAC/WyPIqvh03mFTBtdiF+wzrxfbncK
         FJ0UoK+UhtwySHZFX2pVu/8h08nT7Whq+CZfwyB6qScaUOCj0vZu/X5PBeo9bOjy3tKN
         Mkzou1rV6mlQX5PRwqnnyqNS0ZfBFwVbEPmAFGKLKMka+WuG4dhj8P8452cm/zMvnYes
         wBTMZy4ZGvYi6fd8twLP854a/7l0MUtrWa3cUxb1P8mDMkg07sTASAadmvnAS4/ctvyO
         K0lA==
X-Gm-Message-State: AOJu0Yym6KTEdI23k2V8mCfGqmlj7H3Nr7qE6uMxUBVceSlM4mIKOoZ/
	d+F8LGCZw7Mxakxl/bUds2N5kIgeEQ+zZGEJ5WIjL3A9x5MoRv0gBvIb2ZsVt2++c5EL04hdQtj
	TWYtuFdv0DPNnVgQkKP0i0MsUwUNN8RF6bgUT4fJkSLPKLOkSg3DzOWvWvhvC0IpR4aTlolbGks
	6QXG64kpbjfkzUE/fw7XZDIaGySeEQiSyamc2XzDY3LJ4a
X-Gm-Gg: AR+sD12Nrk590fRYg0OcKb6HjkCvePcL4ely0w6ByjCMG8AV66yu/r7RFnDjZchFIIe
	GCoDVc805fACgzCMTJw77sW/CbVwH76UqFKzc16sgsxajrWf7WVyTNFA+tjk0GLnFNdmMmlC+oS
	HRHibMBv2fR4qPSG+HcPhcFdIcltkfzwYcOfHEAH8qUfSyUzHAshUHJQNMsFLA0qSi6jhLKx5rR
	uQ0TFUQH53bqYYbBA==
X-Received: by 2002:a05:6a20:7283:b0:3c6:3c5b:f32f with SMTP id adf61e73a8af0-3c8ba5f5230mr7736342637.51.1785329047063;
        Wed, 29 Jul 2026 05:44:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:7283:b0:3c6:3c5b:f32f with SMTP id
 adf61e73a8af0-3c8ba5f5230mr7736313637.51.1785329046594; Wed, 29 Jul 2026
 05:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729124138.941391-1-omosnace@redhat.com>
In-Reply-To: <20260729124138.941391-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 29 Jul 2026 14:43:54 +0200
X-Gm-Features: AUfX_myrDnGiHqLI8dZoM8yw3G3XbBUpd7X9q6UOWYv0NnTbiGs-6zfW_YI8XCs
Message-ID: <CAFqZXNt0w+gd_8KoPMXNpnGi1VThirgqwOd9z6qQbzrTUycLyA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file_contexts: add test_multiple to .gitignore
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 2:41=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The new binary target was added in a recent commit, but it wasn't added
> to .gitignore. Fix that.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/file_contexts/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/file_contexts/.gitignore b/tests/file_contexts/.gitign=
ore
> index dd877b4..8b95fcb 100644
> --- a/tests/file_contexts/.gitignore
> +++ b/tests/file_contexts/.gitignore
> @@ -3,3 +3,4 @@ test_lookup
>  test_open
>  test_open_base
>  test_validate
> +test_multiple
> --
> 2.55.0
>

Never mind, I just saw Stephen had sent an equivalent patch a while ago.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

