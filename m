Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8B60250
	for <selinux@vger.kernel.org>; Wed,  6 Mar 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752975; cv=none; b=RXrb5K3/utOWx98mSjVk1fu8q659OSD5CCOOZP8s5/IlnzGUCLK6AjTTof5Eg4MfbkTAz/LgouaWF4/UB6Wv+0ijhfBaR1jumxnA6pH4EF7zfUk2zs5zfR1gHZFBLMh4O0vRbXjUrNyzojnQmNZfPwFr6x0JnZQPtsui4BWIpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752975; c=relaxed/simple;
	bh=EKa891PYdxCeg8PsNje420p79AVasDYDEh8urIRDkjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkwD2GptAbgBMN/BIk1/pT/0HcTeKqTDnK6AyMeLwOxFq5Xpiy1dgbVB+hYxYGiFwFplOrKljj9Su7Vy4wnzf5yEIvOBk1UGGyTh3blDOGcHIeM7C2lRPYUlpy6sqUNBA7jQxzhHCmQ3r/rf/WMC73fTwbX0tkVTfTGvwsogckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=H30z0fVC; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H30z0fVC"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso9749276.2
        for <selinux@vger.kernel.org>; Wed, 06 Mar 2024 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709752973; x=1710357773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8oSbGRr4Ns9frdMJw7jUuTf8syQalaEAmacVqE3TO1k=;
        b=H30z0fVC6CpPysAduNGwLlWmH+Df7UpzPEf2ppJUZhEO6iZRRsVqKpjRErK2Bau3WZ
         0uZx7zuZqm8h4r2CtdEOZPO/m8W3vwOWVtiXJsf0t/QCM45LbLMxv5raAvztWJtrMoha
         t8cds84REeUFHeiixfo6toiH7npDIxeh0YRbz/onphkgUcaPD40Fkr1GiSZ29eVSikac
         cBl7zU1rNX4rOKDJMwIqfiSuRg6jUQEf/7j3IOjuH+J/kvpeC5S8R1NmSCohDorhVmWj
         bzul25TeSHA03uhSs7yVLceEVTQ4lRHIHqOxzd+WMQmpzi5qXJAP0oQT8ajpoxORlPf8
         BqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752973; x=1710357773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oSbGRr4Ns9frdMJw7jUuTf8syQalaEAmacVqE3TO1k=;
        b=uY/MNsla2OOkXMZqPoJHidhwb0LQeGubRKC/TzlA6e5vWS322ERfLlm8dI21000kqu
         fZ5VCJF+WohAWQ6DCBtBFX3IhWHKa5JubRDwVKXfSfuUJPyz3qfnA7TSXhl15DnyN2of
         kiV+4Aix76tABwFq0iYk8a2HReIlGyje326zn2D77Iadt7060Db8E7fUtrL4MeyPGrM0
         Ye7cT//CXaKOexsDGRSsuZcBC9l1ZrZIJOnXBJMJXEMsrpSjqt2FOKjxYkZ6KoI/srJf
         LcgTD5wLcAP6T58YOYs2XVU15CRuRuP9u2sx/NxVytNcHA/y1i70pEZmg7fuZYGaJY2S
         YJhg==
X-Gm-Message-State: AOJu0YxmUSQOJFcCCKv5GKsmO26yZGVNOcMAWiUR1Cx8V/p8q3zSzyTb
	FOuoveOnhpI3xyxlQgjp36UN5b7eRP1InIrDmSot1C5EtYMQdcyNTtJTlYmoOZUycQmu3kraxZd
	TPTji82AhlhUZ2bcTMle+XQAiY1g=
X-Google-Smtp-Source: AGHT+IGGNg4CjJNBfjk8Mmi+3leS6qF3AnrrXkVavOg1Eq7q4FnP5n5VnQm0YGNAQPbXFWcAJa0AsOA71rr1z34a1Tg=
X-Received: by 2002:a05:6902:2492:b0:dc6:19ea:9204 with SMTP id
 ds18-20020a056902249200b00dc619ea9204mr13512200ybb.61.1709752973078; Wed, 06
 Mar 2024 11:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306143451.2256235-1-jwcart2@gmail.com>
In-Reply-To: <20240306143451.2256235-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 6 Mar 2024 20:22:41 +0100
Message-ID: <CAJ2a_De2X6Ux5et0kEu7fmfgwZeYtq_OLVNXbX6M4tsbucqvew@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy/fuzz: Update check_level() to use notdefined field
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 15:34, James Carter <jwcart2@gmail.com> wrote:
>
> Commit e16f586 (Fix potential double free of mls_level_t) renamed
> the "defined" field to "notdefined", but did not update this use of
> it.
>
> Use the new field "notdefined" for the check.

Since the renamed member "notdefined" is checked during validation and
the fuzzer calls policydb_valudate() I think the whole callback can be
removed.

> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> index 0d749a02..a3da0b57 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -135,7 +135,7 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __att
>         const level_datum_t *levdatum = (level_datum_t *) datum;
>
>         // TODO: drop member defined if proven to be always set
> -       if (!levdatum->isalias && !levdatum->defined) {
> +       if (!levdatum->isalias && levdatum->notdefined) {
>                 fprintf(stderr,
>                         "Error:  sensitivity %s was not used in a level definition!\n",
>                         key);
> --
> 2.44.0
>
