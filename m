Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5D4582E0
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195791; cv=pass; b=YOoz/DrD2ShVgiFUmRhdXmesV4/T0tb1AjQHieY9OEymFXMi1Oz1dEjxfb4KL8L+RJWKKr/kWr4b1Z7YAyfamEk08707WISOxBj41SUzn0M2IcqKXn+nY2sF5tuHTv4YPCzFTCvYppgpwQY4k84VSZ8tMJSKGkBCf/fblfZNJDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195791; c=relaxed/simple;
	bh=HpIwSlF4PwTCCzz7pUQRjBYm2zoVQYyyEdt2+F0PPBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhzYCct4w+tZa6WRQ0UQDEvRVdXJOYelj0xSdDkzBNx08OvlkS+zPHIZgE3fG2Saq9oVYsWy55HYZUv/iu0HuWMqri1cDG/Yq6trDSm/ohQWJEGUdHGA6hLowfLHRdz8zm/AlK9dN+VADMU0iKY9IsySw2+4m356jzV7fxG6PHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk1GjLLU; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk1GjLLU"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b1b233ca8dso746482eaf.2
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 10:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195789; cv=none;
        d=google.com; s=arc-20260327;
        b=Ed44yYZTopXEGonI30ppekWvZ32BnBCSjNhrUcMMUoO/1FxRqZRLZW3R0BoBs3zs7q
         z37/ZnMNWk9quN2C1+W9m4s808OXwil3V1xSElweKYRzpx1D3l0edOzWTTpdUTZhbAZZ
         n8zLTDAMigrVZqaBGryDhMVwGTQypQnwYxGHljyiuTUuEtV1BxEejO47O6z/Z2GYYcuO
         ved9zpBc49UeJrYbeg8S+Vflg5Q61k0syFFVGy51klU6BhaT7g1jVp7L68JOmP3O2+0P
         hzdI9e2tPSeVXDjnYbQUfUTnSLF3LoylATZScf5kt6L6BMKM9nHVPdDSRItrky4GI4Oi
         n0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HpIwSlF4PwTCCzz7pUQRjBYm2zoVQYyyEdt2+F0PPBw=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=CKcSX5I8aahcRuEY/xmzJj0gHGbDwG70NPeoKB0B2iYAHCl1VLis7pXoanuDzDefkJ
         mV4XapUCPWs0UvhE6L3WjVzbhqq9cHKciTEOqeHOsn+oeJsc66wz7kwOJ2k0CflTwzMA
         wFa2UTEwpskPT43hwTzeOHFc3VKngKHFJTjl7t388qZ+v+8nXOW0NDWfC0//MqQw/aTR
         2DyOtAZcov5E5KZ2Tnv1mTV4J2DHb6020SEEj+QAX1troSPsOm3/Rswq7Crvx5S4dVcE
         x49FkAWqi/RG6Csls7kSFpqE3csxDQYSs77UTw0C36NySf0ihQSjqL23+C7ntbwpDSUf
         AM+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788195789; x=1788800589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HpIwSlF4PwTCCzz7pUQRjBYm2zoVQYyyEdt2+F0PPBw=;
        b=Dk1GjLLUKHrmfY2cDXbOKUZBjfJ4mRElny7xynhS6GcOy1+oDncco6vi26ZsBCWL6i
         GSh2tZzAg+PD4xmrdy7g3UWXWd2s553lGR39FZzKTx94FMZDmT1npFz2/jRX3r6RO6kA
         VEorPR52hROqTSRWuEp+Hq3gb6fnc5Gg0U1wxfhfGrx7ZSPPbqH8WRT1cwP4xsbPQxm4
         WnbweC54YbNH2o6Oa5W4JyaF0fv/jL6S4V6MyOpuhMN/2qNebRLxtS3gFh4Hj9w399/6
         6LTUS4330hmIP4SK3HdFsSQEBNtSOWBI1B7StH3gz32XsXm94wascUYdf6o6TKWZVpqK
         fHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195789; x=1788800589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpIwSlF4PwTCCzz7pUQRjBYm2zoVQYyyEdt2+F0PPBw=;
        b=LjaGWQIwV+P/Z8gTGUm/oCGLC6wUDe0JwvGQ8L4uiciJuH8kze4FNFniY/KJEN2SRv
         TwnFgvmIs1M3Mq4WU75bcTHCKjGcWPEilEdJlCD5Rd0YIMxiCQRtJgrhxM1Akc9W28ux
         Ua/uqHiYn0dkMb3hLn+owH6MmeOrGn3WBS26vs6RpRcyC0jzBFZWVp30o6yU5nPdUEHx
         Juggmi9lV81x5UX6Tm2127GwUpL5PqX/eyACpNOqF8e6DDQ48hvtKYZW7R1IPfoMnuJE
         ReJn3sgaBkqWlcWaAPDTfXmHZRmqqVSVT5Wl968dBGQpX2/bqpV5lCQqvDsX5t8qZ4wB
         uLsw==
X-Gm-Message-State: AFuF++nb9bbgbRLXuqEd8gSFjgBFAGJkLFTSxEqiFM4rpfzLIsQxXgCo
	ETUUyvoYPgha7up8+XM+bCQ1sj0tafvUw1xMVSMWHIP32X17b4juXF101X2VGY4/K9wsT09eIdb
	1mkaU77ftYugqovyRsC14E+FEbGB8Vd8=
X-Gm-Gg: AR+sD13oW2GE+wF12N0K9q/E+/znrHs87GBre8H6o5bpF5Mww/eN/kWpZnl3rJD04Jq
	EKaOalpxNjaD3b04jqket9vAGE+ANwl2AfSIJWdRmsOBDQ0OXE6mhA7CIWcOr+DXEOZViNCh67z
	yR6+x7eHvHj/6GcRuSxgT7SI+Sx/07+NnRy+KqotNycZ2zItUGyNeRZCNY0JLyDiG1SAQL7zxTH
	CEaOWfFHhElZXKNMf4w7sOY+LtC4TCiT2W9OX9VX2kUi4PhnHHqLjp1Jhik1ttPM0Ydh3bSoMrY
	6r4Ml3Nx98UK1m8W4tKwNwAAjnXfSvPgDCi/g35IZxJG
X-Received: by 2002:a05:6820:1a08:b0:6b0:19bc:fd14 with SMTP id
 006d021491bc7-6b1c674b4c4mr24882887eaf.32.1788195788576; Mon, 31 Aug 2026
 10:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831154352.49412-1-jwcart2@gmail.com>
In-Reply-To: <20260831154352.49412-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 13:02:57 -0400
X-Gm-Features: AcwNN1Wnc_qHzGXLwJ-Vdeq0845dfE4pxSGMaka2JQqs3WXzQc2ym4NbhoXgBfU
Message-ID: <CAEjxPJ7pvujwdMYoCxyiw=1F9jq2-66HFz_fyUkbDOuMKcaAww@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: Check for mls constraint expression in
 non-mls policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:44=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> In a constraint expression l1, l2, h1, and h2 all refer to levels
> and should only appear in mls policies.
>
> Return an error if a mls constraint expression is found in a non-
> mls policy.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
