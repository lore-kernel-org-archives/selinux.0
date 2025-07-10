Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DA2BEFEC
	for <selinux@vger.kernel.org>; Thu, 10 Jul 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141953; cv=none; b=pjDOC/naMuDGL8SlWB4X7gcCgcc+YAjb/mhnWfsV6ABAeIWG1ikPhetyeWRdRfL/SQmCvVrC+U02dbmXJ8QDKjlOyMoCKKVN+QC4h9J+6cY/rdVhoTwb2idPLGAJ8A7QwDw4IpFk+sTnoPX/1bMDPZb4H0DXhH4UmS040MrGbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141953; c=relaxed/simple;
	bh=NzZnC0gZvRO8/seZ3xZnndeS8ZHLDqAAupHH+SIWEYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiVXijWXlbLzRSmY/8n8nlnvz7bdH9CzpYgicIMlyHqh+CBDo93C0271CCxXlKVGdDbRoI3c0B3PYkEBZKoGo9MRUUIWJ1yd5iN4Gp9+fJge/g9P6bX7fYwmsnjAmswvPLOS24Wuf1+8cqHvHPJ6IhR27tXbZA1Hg9rhz53B9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZUNAEQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZUNAEQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752141949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5rBqwNJphecBUzvcr/z53rjv3BBjXeCNTAfHcfeEUg=;
	b=fZUNAEQzHYO+YGP9kHNmJVO6reuAJaciNPxq3tpydrvYTiPogxTJUTLuEEzSbGV4hz4MIe
	4fZVdvsuRg4Ykyv8pEzGe3weNpNu77ycS3vewhBgjSRytN0kmTjbITVADklALKmn398x+s
	wNmBrqk2K0xaTWTSfUyA+++WOLEQlRM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Fhu_x08WO7afywyg_5_wwg-1; Thu, 10 Jul 2025 06:05:47 -0400
X-MC-Unique: Fhu_x08WO7afywyg_5_wwg-1
X-Mimecast-MFC-AGG-ID: Fhu_x08WO7afywyg_5_wwg_1752141946
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313f8835f29so1439229a91.3
        for <selinux@vger.kernel.org>; Thu, 10 Jul 2025 03:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752141946; x=1752746746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5rBqwNJphecBUzvcr/z53rjv3BBjXeCNTAfHcfeEUg=;
        b=vqjm/NlPrn7M/Z7cwDO0dvCLOyv3eoA6NMnc8znqwcGg2BRADwkZH32RATVrsUqtg2
         DMqGNnnf7qAdiDNZBNv28SHWMqZD3TA+Sx5r/2lmZ+Ff+HA/ir8DTLztrwcrA4EHtSFV
         lFw3ugYmMwP8xWMBShwIVwU/NtaBTGOEAVRGpRn1EJLXkLwfP5ZwNm3dZpvbo9t1ES1J
         4OHuC+5NoNIGdOE20xwPFBwbQx8T9Zb5/PqCEHYq4j8yye/UYIk5Ry2OAW70Oy44xtyR
         jhttWkqQZtAWidW0e4dXDYWETQgfKIY4oh4WXAWSQgxpgqtjHxaMKmYinLyA32KhENsx
         qeWw==
X-Gm-Message-State: AOJu0YzJ0qA95ADG66lAjKUFAOFpPzeOOEUQaCZAC+VfYbqxg+OjD4P+
	HQKM/vwGHzaZEOoMaBPpifzX8tDzbna80ct8nT/S0fsD7PZT0NTZwu4hX6GUNUpOfJY5C3/Y7kQ
	A9mlsCEzQIfjyCmeo+REXf+MWEG7pn1Cvk6F9GPNDnuUzpyzHpTcFbRdsS8aRWLoFVxoQhZLSOQ
	ESrV7034JpdJc5ISPekCkw4FJT6NaWlrjPlpuK5GJA4A==
X-Gm-Gg: ASbGncvPTUogRGXdY0pR61e3igyuZrxb+4Fkq4PMi6MPv6l1yughIhJB/v7G3aJoIeJ
	g4MnHaMGaPNAFfzGb/kWPw88o1qqWRyn/ymrhf/8CLwMy0rkZzLCeth0l9UFzNWMkLx1dt1NK8I
	oj6vEltf78i51jRvUE/Av470JA6M5Jb0ToDJZaeg==
X-Received: by 2002:a17:90b:4906:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-31c3f00254emr3103804a91.18.1752141946095;
        Thu, 10 Jul 2025 03:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBZ3JnBQjvEV3K+nn9/4TeRz7VhokxZeg/zaiLK+BWwVtkfpwq2YMSTw/9bvjKD9zwz2QJqWM1+/XIjQnFze0=
X-Received: by 2002:a17:90b:4906:b0:31a:9004:899d with SMTP id
 98e67ed59e1d1-31c3f00254emr3103783a91.18.1752141945783; Thu, 10 Jul 2025
 03:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708210748.8782-1-paul@paul-moore.com> <CAFqZXNvDNAtukRPhKFiQmN+koHOevx75qGCK0uE5nWX+afTPqw@mail.gmail.com>
 <CAHC9VhT=BG_3H=JAuJzcWKABM+eHBZYRHjVoeomRnH0OHkR28A@mail.gmail.com>
In-Reply-To: <CAHC9VhT=BG_3H=JAuJzcWKABM+eHBZYRHjVoeomRnH0OHkR28A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 10 Jul 2025 12:05:34 +0200
X-Gm-Features: Ac12FXw1rmvX9kgDHdMOroUFEdMIMNvFRjzAiZIcIdBEWxU71PMzlw5JNah9nGk
Message-ID: <CAFqZXNvxvZO9tOCpxshOLkQy=ogka=ow=njeb9By3MP44HjXWA@mail.gmail.com>
Subject: Re: [PATCH] policy/test_secretmem.te: add anon_inode perms required
 in Linux v6.16-rc5
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Jul 9, 2025 at 3:35=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > I'm going to merge the patch with the extra permission dropped, since
> > it's a minor change. I'm also going to add a Suggested-by for good
> > measure, as Shivank originally drafted the patch. Thank you for taking
> > time to formalize and test it!
>
> A more careful reading of the other thread would have shown that
> Shivank and I arrived at the same/similar patch independently; the
> Suggested-by: tag in this case is wrong.  If it was the case that
> Shivank drafted the patch, you should have contacted him about adding
> a Signed-off-by: tag since he would have been the original author.

Apologies, I must have read past that part :/ You're right, I messed
it up... I guess it's not worth a force push to the main branch, but
let me know if you'd prefer that.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

