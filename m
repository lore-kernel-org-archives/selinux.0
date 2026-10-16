Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AD3BCD3A
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144966; cv=pass; b=tIt+c5phsaw4tln+L7Jr1IsxBleeDLZc0+Bbf16cVrGFm6h/Ox9/1TAZ8YMDHV9eljILK7xKF2TzToLozpXGcnOU73GN2iImmkF3+r9iu1n/XRyOT4nj6qYKozRYwNFmuvCXdao6C8zn+QGxCYIkavNHoUf9CDlxd2tTQfbDu7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144966; c=relaxed/simple;
	bh=myIoa+6xH+60laYVFiLz/FD32bhv3wQpAOWpkd3/DS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=V0F1Iz77rCmuuCgdKX3JND/tCndyBqZJlc2lwE/7StCzGgkKtZrAWksA4pvtg889S4dIeq49rCP0ikxszMOHrOiE+UtrwIF9ifM19UuyPe9uF8ze/LC+9dyySt0qTfjMToN5yVu0x3b8x7SDxB2xH/ZV6kjAtXKA2BYKn3wXT2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mviop+Rz; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mviop+Rz"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8aea7b7ca0cso48636847b3.2
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 03:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792144964; cv=none;
        d=google.com; s=arc-20260327;
        b=hF9MMQu4+ECDwlACUAb2A9sxfz5d8sp9jyOoO9IailA8V0Ji7MBTlFc3iGhylIVgr6
         Fx7YjvEXa7NMwPELQDhZHc38KQ96fJtS/TKvL7xgeMpUiKOue7MtPe+5zJUwVYjvFLvQ
         qcBeSdzqtF79QWUb09mJx+0l4xl5/SO+Bh1i2XQYRliAe8aF7ivqtlq5cpuOiiwPzKum
         i5hobHbDNiv5EbmaqjEcQRNZoMRmOtAvSWjFClZ0ws+oI8xXHOqhMlE4MUSVL1iFzmA4
         rcY5JP42nqUDO3AW/gri/gpDSn5rulpXB78g2TpdkwwYwU/wgtj4/QDkgY/jlS+QyWOE
         b0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cYXmWfOHvC/lT8X9H+DNoSAXwyO5Mb0jG3Ug31iaM0c=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=qcZjqDx3UsiWS35xzrZOe6CUJUIFx01Bqo3d68qBo/w1RUkyd3jcT5e+mUls6es4Gy
         R34HYemCJP4OZIZ9V0eCK5f+qy7tXfO7Fm7hTmZSwsuGNkMznzoxwtUvLyRCcm0P5V8m
         MrOP4o6t13BNMKdvzBCHNbgqB3G2B/rFlEC7prFPC7h653aqB//p6tYwHiNcDEoZdgKJ
         UwrTIRTF9T0HKbsrfCgyu3MMjAJ7/U7t+xW6ipXbRyZ0aYwSrvejeAuvVFgGKllefLkC
         5EnvylP8YqUtArqIH77iTLO2KjLOlN+d7EEEc1tpA8ICA4xxogKccvRaZg3mokKFFIU+
         gwGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792144964; x=1792749764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYXmWfOHvC/lT8X9H+DNoSAXwyO5Mb0jG3Ug31iaM0c=;
        b=Mviop+RzeE4JZeQA5FeL9SjaqECQNgGsluA/D/b854kyirEHUrefG99AZOLifnGSAb
         U6Do9NJxQaf2Kt8irUxrCGcTGvNd1YpkNA7Z84MEopq5QL24t6jzIO1/iNNEtjvCBcls
         15Eueryc0o/bV1Y26dgHUEMSb/ALy6NXam7dHusFlPo5+NrVfYsO7Mu/hN2L1iIUdS8h
         qGA9tl7iIMHB9tLAApn1RLM9S/7HLC24VLI0D4u180DLXRbXdogvTlivf+gtsx3WHE0D
         UKEu591US7H35zLWrpKw+69l5mH7wcUKAGYeu5DQmYzs1wskNzCRDX+Fpt7ZocVPxm2x
         7G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144964; x=1792749764;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYXmWfOHvC/lT8X9H+DNoSAXwyO5Mb0jG3Ug31iaM0c=;
        b=g3yp30kyAUwNA5PqwoV64unEejw4YvNB6ZSYzjsaeRjRdfpLO3MpN+DHoS05G8zLRk
         eTiag0FUJgEZiuNCaGcDUlxp27RHPQZqBts6YCiex+gADN7fwnhprQ7fCNDTXdJhH02X
         HmWa7eQ8n6JpaA46kTRKugE4bEjN4kzrtx9+vR7ULt5iV9eZymg+gnmHsincMTJIPuqW
         fjLyOYTyc4sQJniMFPI7MMZKJly72nJA0QVkRQxIkFRKVeDjmvajFc5D+HhTvK+4pJNF
         PBUZtcBhUkimRF4YsN0CqLGLBaXhEpXpzOzSFYdNxuRWvEANjqRVZm7l1VA/EcNJ3LQ/
         rg/A==
X-Gm-Message-State: AFq9FYJk2eOk3xsqUazYiXBo4m47bVLQMz4OIanRtRrVq9X3F9010NAJ
	/kCHJJW/2hSIzdiqwNs5CBhF9nFDxRwjDZustDbXqaRZ7TalOF231mYSUOrhY+HokU29KC7CKa3
	gIBhK+IGYZainjvtbZjo9PGKYpE2sE4osvA==
X-Gm-Gg: AYBFou2wjpK2Iql6hpsUp0mhyaQRy9KiTL9RqID5p2Wb4loZGV0jELWlOOR0KoC4nD3
	Nhmqs316u/IYjiHMwJLowB+oYQnsZFDlw213baJ6mPo90LQuSXPHmq5fg78f/7ovDbGzoS7wtDL
	m3daMhYUEes0qAgDCJbOM5nyFqvEbFbBlVdfO81Blo/uQeHhaVYFXH5grIYG1KyQsvfANpgOIi9
	dgDnQV34HpLC9ynM5aB+YAygp9p/geTGAZEP8ftNdIwS5L++/4hblGPXbkGpcMRADa1XqNM4Aae
	B+t9ZrMY1q7bLBUy4RqaFRk6OkhzK48H9e5FIjuZ0q3bGlsRdvwx4//Lb5HVUL/89ZTS8nMFFRy
	GN8ecNeoA
X-Received: by 2002:a05:690c:e3c1:b0:8b0:d36c:14f9 with SMTP id
 00721157ae682-8b0d36c1dfamr18789407b3.28.1792144964320; Fri, 16 Oct 2026
 03:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054932.845406-1-omosnacek@gmail.com>
In-Reply-To: <20261015054932.845406-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Fri, 16 Oct 2026 12:02:31 +0200
X-Gm-Features: AclHuK-LXXX7YJjIudh39D_H3H6WXAURTvkh3B_n9APvy2QJqnDK8nCz5b98igc
Message-ID: <CAAUqJDsXw+2GGmFU9cgxkhUQnkSA=rxBmAEsmk5kQ6_7Nw7dsg@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/4] Fix build warnings on ppc64le and s390x
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 at 07:49, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.co=
m> wrote:
>
> This series fixes build warnings on some architectures that became fatal
> after -Werror was added to build flags. It also adds a simple compile
> test to the CI that runs `make all` on all architectures supported by
> Fedora, so that they can be discovered earlier in the future.
>
> Ondrej Mosn=C3=A1=C4=8Dek (4):
>   tests/binder: fix compiler warnings on ppc64le
>   tests/perf_event: fix compiler warnings on ppc64le
>   tests/filesystem/statfs_test.c: fix a compiler warning on s390x
>   tmt,ci: add a mutli-arch compile test
>
>  .github/workflows/checks.yml    | 13 ++++++++
>  tests/binder/binder_common.c    | 36 +++++++++++-----------
>  tests/binder/check_binder.c     |  8 ++---
>  tests/binder/check_binderfs.c   | 10 +++---
>  tests/binder/client.c           | 36 +++++++++++-----------
>  tests/binder/manager.c          | 37 +++++++++++-----------
>  tests/binder/service_provider.c | 22 +++++++-------
>  tests/filesystem/statfs_test.c  |  2 +-
>  tests/perf_event/perf_event.c   |  2 +-
>  tmt/README.md                   |  2 +-
>  tmt/plans.fmf                   | 11 ++++++-
>  tmt/tests.fmf                   | 54 +++++++++++++++++++++++++++++++++
>  12 files changed, 155 insertions(+), 78 deletions(-)
>
> --
> 2.54.0
>

Applied with Stephen's review comments incorporated. Thanks for the review!
