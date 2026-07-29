Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CF3E122F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330728; cv=pass; b=JdZLlrVF1zdOguNWd91apiYEwLDdrni3Q6qi8ynoCaIhal9mcfjkcy5oOdUcU1LieLqxXsx9IIDIoWg+hyHc1Dgmm/9pXbRx+sF6iDTMj5eKiNb+i3S4UZ0UUaZK2R7xsMVGnvV1ccncZZEbcEIJXodclsYLtzgs04p7By1+/oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330728; c=relaxed/simple;
	bh=PCLz+BvBLoj7X4Ds8+HKPQ6Z4trzlgQZOUmU1hfJLu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvfFIy6NsQg8ekUj93de4l2sjd87Ca9yjsAIkzFsLcaEB2Pvfb5cq+wP3KH5gsfx8ELmK23pM0irWcJYoUXVhym7oKDR9pUl5vh8oXmeYExDo0GSLkxT6tkv4FfIGpzlGkIbx7pshyt7MMeQQZMztyO1kB0Ov3HUiHqkKjGXtfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPNHSOpb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S86WXsLp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPNHSOpb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S86WXsLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785330726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//i5BMDes3ALN/+HbmqWEy62/qFCv3V7D0oGBjzaE8w=;
	b=cPNHSOpbensx8iE0FTUIiNK6zO7EGk4emDPQ9ej4981t1H34oKk59sAvYjrprKoKaXx3Dd
	IeqjFQ78KJlSvfghjDaDqhQn151czRXNp7ZHMXq4HMFeIOWP3ANU2rN621X5Z+opsAmZTY
	KP7iIzgT8Bzlxs2sP6MV3KBuTKAAFwg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-9DVnflHoNiuMyVc-hFIZag-1; Wed, 29 Jul 2026 09:12:04 -0400
X-MC-Unique: 9DVnflHoNiuMyVc-hFIZag-1
X-Mimecast-MFC-AGG-ID: 9DVnflHoNiuMyVc-hFIZag_1785330723
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1489726a12.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330723; cv=none;
        d=google.com; s=arc-20260327;
        b=o24HU57CEIH2Vh7Emib7oyuO6koGRN1DdYuVl7cL3+VgRO0M/9zNPdRjPFK8AhPQZg
         E5ahPiLSWJGctfDnsj6QnzHfj1FvKLfw1XyoiZcTzhZYni4+Upc2g6w3gTMrbT6eOBiZ
         uiHLt46uJmSIL4WZ8c7Ka3Ljs10kR7DOzXAoAaaeZbER/ijXZ6aH/hE9eH2B+IEKxuT4
         JBP2u+UqHbEyvIJX/5pWBSm8iaRzJo4jtwq2XLuChjDSZki4VVO5rFeqB0lJAjcpdZH/
         vmGk3DGEVUkHWp7GrCc1smlm8lDflF2K3dg7IEU30vji44f5zQBLAxlZxeVxz5dwYat1
         V0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=//i5BMDes3ALN/+HbmqWEy62/qFCv3V7D0oGBjzaE8w=;
        fh=iARkaIzCJcxoe2asD+wHHANHbue5FnCdLQ6A/NRR40I=;
        b=JvEST9ECzmgNB3H7IJ4MvvVipVHo35iShnig9WZ8mNMorzFcrYz/lcquWF1ylASeuP
         MnGHPYG6BipvPjoeclMWpO55iU9COQoDb0baTdRsSxsIgB49miFUNhzEAQ+rAgqdOZxT
         62rU29b+oPUB6LvaTNrS3sx9yhVam1p5H501T++r7xDIcQgIkM22xwMtnQkmDAjaRqdY
         n28k6EvCLwNTUs/5qoIT3VYNMzBJsqzKiZFMSdES4645E/AvW+xpja9h2YE6ynSgHWxh
         vMtW3kcwxy1Ts/aaxy7GLHNZAKbiNItZ4Id32bNrFALvv2/9Losq4cBMrPWxoFhGpD5W
         NkCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785330723; x=1785935523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=//i5BMDes3ALN/+HbmqWEy62/qFCv3V7D0oGBjzaE8w=;
        b=S86WXsLp7VHr5vDAeiLfRE6RdAos3H5wfeDRsZpNb3340jxPy3E00KG0CzDPIl+laJ
         ws6tBpBSfyAzsyXBVn7lRytohsB9CETYZ8zge0OF7dTlmtGQmm3Uv8BqlOywPn5TBSik
         mdpS8eatc6cJUVDvgkLw94KPkb3zlZZ+k6K+zttrXsDkaV3X0ZdjbbhVcpHbOyDKDfo0
         Q+RhGrdgXChVoQCU83U1H7O2CqXu59u1e1xtr+24dQ3EOQOHz/D/7qMYTBqqY2Q+geSL
         cLxw2S0m8wb2dcOsrtSiiTh+QI1Q8+aSPvw8Q1L0y+unjyo9p3zmEVKpPTXYyDqBavIv
         ay9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330723; x=1785935523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//i5BMDes3ALN/+HbmqWEy62/qFCv3V7D0oGBjzaE8w=;
        b=NZMkIIHuXZN4ZhJyhPF89c/yGd5I8BzNXAGgOgwX4IHVUlb0inqXt23SxdWQyBcXrP
         D7W/5zL5PGa8veo9Drxn25Chws7ki2ULakaJiwmfyBev3oaanIeot2qHOlSXDvYN9TOJ
         YegPWAsn4jKu/7LEjxm3ziUjKoiwKvka0fI88Ommo5r5xHawLhsC9d9UFG4zXf5yUGYw
         6f5YtGInEzzkGdKERFkzx1VCq0ddTCkDOwP3qQoZ9kHwLQlaO34qIHtsQur1+aKNDOYu
         7bzHUyIwBC69wBn51ht1RJxYX634XbboDGmJPNk9GtgUV7utvVE+Jju00dfFSeDQgfjf
         O4/A==
X-Gm-Message-State: AOJu0YxpHQEG/mURuCr2u5y8GJ42PV4EUDHtKgit+0Gz4nWmx4fJkLj6
	URMSEiQu+S5IvZLNz6lymwUsc/j04EQFrZPTI27LFN1w1/a1ecAiPVXQa8ecFVB/VDVtjDdhve6
	Z7PQptts1xFdw0naELY+8FYmiz1nDQmF7J4oFyAoYR9erPGS7SqhKtzA3g9dMb3142ZerY7cO+P
	FyJ2V/U+a5pc7s/BBZVGipIT7QLRv315UghRzASgHCbAR0
X-Gm-Gg: AR+sD11K1QxG/POhPfKeX59pIZXU7R/03A/gIHX8KwT7npZx8JE514YikGoG+oY6P0U
	xt5nE3ZaPNJlO8sdEHcfrJbJgU8QT7bBmcn0pX+kyX4jiMTJI6TfUpir6sxx2mqm2ewZA6esJmY
	/L+us04xFnyrIkTivnuO1uhonaHdImT3IRRJnKT+dyQ42PogeEPBZjz5+IAwI6wJ5ZQN+M9fVa3
	NQirmGioO/2F9XBpw==
X-Received: by 2002:a05:6a21:a8f:b0:3c4:1c9f:d81 with SMTP id adf61e73a8af0-3c8aaf7b095mr8251007637.7.1785330723359;
        Wed, 29 Jul 2026 06:12:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8f:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3c8aaf7b095mr8250972637.7.1785330722942; Wed, 29 Jul 2026
 06:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709130040.76391-1-omosnace@redhat.com>
In-Reply-To: <20260709130040.76391-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 29 Jul 2026 15:11:51 +0200
X-Gm-Features: AUfX_mxH6MCKLt0lYVzgy9KlhUSxngbSepfY8pIQmjaRUyrsdWIqDX20o03tO0k
Message-ID: <CAFqZXNspzXtCaE_oYcTaug18FM+XW_Vh_=R-XAS98dYxYvqfow@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/overlay: verify that execmem is not
 checked for the mounter
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 3:00=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Add a test that verifies that the execmem permission is checked only on
> the process mapping/updating the memory region and not against the
> mounter credentials.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>
> v2: apply tools/check-syntax formatting
>
>  policy/test_overlayfs.te   |  4 ++++
>  tests/overlay/map_access.c | 20 ++++++++++++--------
>  tests/overlay/test         | 11 ++++++++++-
>  3 files changed, 26 insertions(+), 9 deletions(-)

This is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/76f9960cee3f8904=
58c876d5980648ee8dac9761

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

