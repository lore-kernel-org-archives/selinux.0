Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47737F005
	for <selinux@vger.kernel.org>; Thu,  2 Apr 2026 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113648; cv=pass; b=OHczdW9nitIDCH31w2UiBv0vZ+VjtbIE9Wn3/FWk0gTRsVYMqxTLrlBK5uFBTsl/4EgwQi2tB5Iku3RrdF9q68VjimSuHUeaywiCVooqZCvtRb6IbgF3O+dGGslrWy/3uA69W9h3WzuWMUpndu2YGLC83whclvqpblVP1Joaw78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113648; c=relaxed/simple;
	bh=23YM5lfCJ2bPIIPfV/qgY0UYitTrr3vUEgWaMeKeUP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwA9f8Ogc70fvrHeVdVsSObIqXi5jtHmxpYjfJWYZC1KeedGMnX/hFzX1ujE4jMykpl+nb0mI6325SurEx0XEL1alQ/9Fzqo1K5LhRVnJQ/bLLXi1/w29/wf+yQjWLTJAXN7TLnmwHL2kaCaWKVE6s1O4zHMQuuTYc4gmohHQkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTlZQ5TM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIRWzBAt; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTlZQ5TM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIRWzBAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775113646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLsWpaf/krQ3Xn4RvZo2lhaIX5N1UDIbRXu+g97AIf8=;
	b=eTlZQ5TMJE6K1QO8sACW5undtTYAkGUbulYR3SyUsLLzpPdFuuTwxYYK3P5LLPHmZZloKh
	yPF5GWX1onvooM7582NNqIo/EHy7NWBnQwhl9NdEV9IlCtCjzoH2vm5segj29MPWpvW5gz
	VSOTXkuZDAAehdHD0Ql4rH025gBwLAE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-5Zzkg9oUPkudiYScwD9NvA-1; Thu, 02 Apr 2026 03:07:24 -0400
X-MC-Unique: 5Zzkg9oUPkudiYScwD9NvA-1
X-Mimecast-MFC-AGG-ID: 5Zzkg9oUPkudiYScwD9NvA_1775113644
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0c30b51bfso12776305ad.0
        for <selinux@vger.kernel.org>; Thu, 02 Apr 2026 00:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113644; cv=none;
        d=google.com; s=arc-20240605;
        b=Ur5Swi2i3GKhTbtS4tzKJ885ymOk76b1hW8P6Xt+hCidG/ksyY3dD9xOQM6C+o0QB1
         Q5Wuqrt2cxizGLK/M0qpZBfiHVUiaQK5bbwCmSIFksU9sZRRtCO4pVWz+QET7F1TUEu6
         k6jCrWlIbMnkn1ImAb3EhhCjaLm9ZxJp+AB1HX4NZVQ6V819y87bsRtPjI0ifpkvppSZ
         AF3W3GE2pG1BHF9R+3nxvkMxh42AVdf7OfKLTVYXyQYPSUaLoQTb/czlnFsDP7bTQfGS
         4b+P9It3Wg5pJjAxM96GEpIQyHBzkleIlHLhXrqYjHvLCt5c9MuiWqe/MkMlK05vbfP7
         aReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLsWpaf/krQ3Xn4RvZo2lhaIX5N1UDIbRXu+g97AIf8=;
        fh=LWoJkQLWL94W/tKWLtIVIRDILPlsqq+t11tHPyfXr/s=;
        b=C5vuzVndxjMTJRoGTzo0DorNAj6H5CYaPYiON4NP3F8jJtcPCIJEgJDmRvAEAd0jh6
         DbNGf+pPcNsmyh3PpChhQdE3eas36V+c1OVcu0RbHHfx+rkWWe/j94AcFB+aqtacJ5NK
         S5P/umdqwwWRDWaOKB+nEzOkt3cDDibYhnHKqh6jhbR2/UAbW6xUw/LZyMMITwJsXPR2
         nvRytpbC3in+RZBW72Teck/4eNjszlGtjgLdFTQzzCEXvU4nZCGTVIb3ZzN6zvPVqmWy
         DOlXkgXNhRqPD8uw0BMbtE/SjjxGnlRaT48XeDvGu8LHAUJ+80uRxOIoNDjW7uK7u2aM
         qCjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775113644; x=1775718444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLsWpaf/krQ3Xn4RvZo2lhaIX5N1UDIbRXu+g97AIf8=;
        b=iIRWzBAtGnID7Ycmkh7UXdWjvOuyKAsjaJFHZKJPKALbwja8L1xzjWltlyPYtbiygp
         P+3bfFLskIdqRWUKy+p57g3z8uWorjLweREiT3l1cS//mMwfnDzDFEnXuEMciepFwqdy
         sQDPDoGhOqsbZ5uygAKiMDlmXwKokS1AqZCYqyQ/P4TZ/2RafINw/6WBwmcWzi8oyu7Z
         ozIwhBQaHxRDWCJhjR0GEcDqS8wu+/U6SGJMcB940TnI7zMrFV4VZKVaoBGLNU4EsvbJ
         NcT0QrY0H14MlDmU9OoGfLXuYM0FLqQOgdrY6RVtafGHxeKi0YW0kcx9VzuiKgK7pBe1
         XyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113644; x=1775718444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLsWpaf/krQ3Xn4RvZo2lhaIX5N1UDIbRXu+g97AIf8=;
        b=ispMRlyyypGSqTwFQc3Vi2x5NixJreGQYvDd6o4Js4TBt0JB0KEbI/AOM7zDjK5TRu
         u64f0rCBSj3+UZ1xyUGkxz/nnoZupsH5KVPZBg8yh/RS5+qrHr9akEviOtxKSo6GBYFd
         snWWgRDoHYu6DRd7LnYGZT3btWr6D7jaZIVDUHwu7lxetXfo+sCxS8gRH/nxKYjQTFDI
         J4hRpLN8r17SWeyJYrZ1VkFSDR/YUcCFjItYTD6DUWBDOgPxdfXHq/+NeB9GCNhq2HAw
         GXDKTld75NzcMOuobiDmpgJlgppeT737TMBISoYQNmaPpGG2icd5806Rk4pcFYEWu5Yw
         Sz4Q==
X-Gm-Message-State: AOJu0YzpmPEkoJDoAm9tAf94H98uT1hSCRmZO3KaM2WQwRnOl5GmdxVv
	5qcRF41juquCpEflp/pzg4ErCbkTYFyY5tcUe3RpaVXrtLP+acJ+ytXm67Ni9U2wIWyjdbeEoPD
	GoESnVngLq2FaU+JNko2iQtnpz48yB5f3vWpKHdlA1DELo/WzU1ve89cxx/yW6/jj2EnENq+UDc
	w2NOTsF0sa3Ub2C2f1Nw3/zcTjWCN4ykQ8tQ==
X-Gm-Gg: AeBDieuTK5orbpjAoy16btLLHdTS2rf/rV+s4QZcuwJsXHorrNs3SHGx0GyRRSEQoto
	xQeRLS6qqI5u3Qgiva3rZYJFybtlZT1OTjC46UCN6gkYfnNmBBe4FS8s74zGFFIVTUwK13+W7P6
	eTHseHJsIR/4JJIhN0Yl2G+u9MUrZGbpAnjKrrYzlIcWyXBvNp3IUQt3G8oYSCqBPCtoy8bbgtr
	EDJZw==
X-Received: by 2002:a17:902:ce05:b0:2b2:5428:ead8 with SMTP id d9443c01a7336-2b2699880a8mr65719515ad.0.1775113643817;
        Thu, 02 Apr 2026 00:07:23 -0700 (PDT)
X-Received: by 2002:a17:902:ce05:b0:2b2:5428:ead8 with SMTP id
 d9443c01a7336-2b2699880a8mr65719275ad.0.1775113643314; Thu, 02 Apr 2026
 00:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401144808.35015-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260401144808.35015-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 2 Apr 2026 09:07:12 +0200
X-Gm-Features: AQROBzCrXx0i-Ax54TdcO740fP2j2fI_yK7rT0NmqXs426Qx22XNGc7aU8FKM1c
Message-ID: <CAFqZXNso6L7M0+1OZ1TCE2uqQOk-bPheB4JeGzfaJ4NB31erAg@mail.gmail.com>
Subject: Re: [PATCH testsuite] Test f2fs SELinux support
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add f2fs to the set of filesystem types being tested.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  README.md                      | 2 ++
>  defconfig                      | 2 ++
>  tests/Makefile                 | 2 +-
>  tests/filesystem/Filesystem.pm | 3 +++
>  tests/filesystem/f2fs          | 1 +
>  tests/fs_filesystem/f2fs       | 1 +
>  6 files changed, 10 insertions(+), 1 deletion(-)
>  create mode 120000 tests/filesystem/f2fs
>  create mode 120000 tests/fs_filesystem/f2fs

Thanks, applied with minor corrections (tab vs. spaces & added the new
dep to tmt/tests.fmf):
https://github.com/SELinuxProject/selinux-testsuite/commit/03577f572fea0def=
8f3b7ba86c88f3ed292a6c03

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

