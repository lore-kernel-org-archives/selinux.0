Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FA4A99AC
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949941; cv=pass; b=GOmQ8GkKmqoD0Wm8GYQbY6rFodRIOVc/c7m2i6dfKwcYV/r9rkbll2ObHI00PAXOU73GotMtoxYLkxAGVG2+KD81OfBpbgq3ryWZ36n6Fg5m/cC0W8SQzzJSQ9fKKuSdH97B7vsiHluNHnJR0ErofO5S81szhDo1juxE8TLqbfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949941; c=relaxed/simple;
	bh=Jcins/QUmW2erxrBLIkKMSFm3SXXaoaNiO1GT0nrbLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxCvxHOlTVBlPzPAAfC2uRVnCpppCFhieiLx8uZynR+yo2zCvtH4pV8a5VZsr3yOPh6oBmJ59NX5Y9DMd5pqLNQjATIMQbqejsTDne5pZLqx8FcnkQOaiqQXWQSR8Hb54bJi2UjIYc4YJ4AdI9SPK7ztB0K6dgqVUp9uAm6JEdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/a/3C62; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/a/3C62"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6756d2aff02so4104338d50.1
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 07:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790949938; cv=none;
        d=google.com; s=arc-20260327;
        b=okBOsshro5v01SfBKVJvegbzucm3rNijUkA97ZqfnQuKFhyLXsQR4AwHhtLRP6PZdk
         OcfMdbZBz8hbo2zxpFgQ7TnzAYQRtNFqpkEz6vNhYuCiQIzvEXnG7n1bswET0jsAh/GY
         o5AjWuobc9avw1vmJP88ENBoEIlHgB/5wfOmCUVTEGw6CH6Xw6kcL9OtMFx2JsSNhzxm
         /FWs8DVQulbCsoPGrHhPK1SWM95FmQtGRoNQXyZpXTCcD2Xc1zo5XWR3n93JaS2tWvcz
         5+RP5jSgKFzjEqkAULpQjKgOD6ipEz8wZnoJmglcoewqweCOpDuLjPF1ZSfWqXn3vewS
         zJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jcins/QUmW2erxrBLIkKMSFm3SXXaoaNiO1GT0nrbLQ=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=YtpiZUMxfCTkFW3Utzk9wkdle/z5+O4OiyWT/5m69H6gkSoqkkwWM5hGYNWEL9CXr7
         Utazr+QL1wUiCLTUweu0wjFPm7Ntz+EaS20gsuPkJr8QP/fq8Ei6u3hN9DUWlaAfk95k
         2F1xkEDFcFzvMS3SW7Tfu/xXxzo3wXptzYNcFMnkvmTYcqndm4e3ELVNLw+9v0C8RIha
         wtSvLHajHo8rPX9PY7r2c4MHpZP8kUm8ibW3PNzv1nsLMxfMmdRu5r7nEAI4c6Mgy+CI
         Meh/bS0ThBVwc4CKoK6X5vOEb97BVk3W3E31AoJqwkKQu9jDosr52qC6hGZ5rlF/QloA
         DqEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790949938; x=1791554738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jcins/QUmW2erxrBLIkKMSFm3SXXaoaNiO1GT0nrbLQ=;
        b=Y/a/3C62kuR/DYsYHb2P0r8GuGhlIUTUYTDJFvTWM1o2oPivu5CIfzMYWr0Ldgbn+E
         6uG6JkJM0MqGptu2fMjzT0FBm/rzQ+HcPOU/6wEkrJjohgT87bnP9CAMlsYOFi8BE7gW
         +c7kofGQnYk7FnMoVUibFmA4orxG+DwB3D8TGyRy0FOT4QBmstqEb++s3lxvXXQfoeY/
         vJPAzaBzVkBnaa0i4GfJLM2mWav17Kfr/Ja9/GOK1GrCveGKZv4AbjTWemtxWfARlRDB
         xaioFGttkIXnqeeuSKb7qBvh/ghxp9lhVwnmrzv5kYvLN+PNBL73y0GxqkoY4TZdxsGK
         8wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790949938; x=1791554738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jcins/QUmW2erxrBLIkKMSFm3SXXaoaNiO1GT0nrbLQ=;
        b=f9h9T+7zxYsAOw1QGGE2WKok2avyqciPfzIJ2v+1u2gDfwZGjmOmmPZIVbTy1796RS
         ZXI26inRP+1MiCL/r3pcmnu4KWpLyBvFZXpifHSZ7M6Xsz9IJVgC4gRgdGnxRVHpZyMS
         NeJfTY0cvr8IUM60fyRrWDs1GX144Vu9VvdDfGYWwfXlUYBqN/SlFA7LnzR8vkEuX2zV
         tpWJf0z/i4o0BlXTJqQoi93IaaZ6XUSF8pm/XMBhVLP4rjevKF8blLkbnxyQn6qL5KfM
         mf2LUW9lyRmgyevJC9rqT9Wv+whbQH4xq5mmvBCEcnbCaGXPaamXFYEPT/fif5iOYGKO
         lfgQ==
X-Gm-Message-State: AFq9FYKttTK4NrslV3sv8I0EGchjzqEucA3ya509sFXPFR4nbl3wxdKh
	JWEk4Ce3br60KgwAj4RatNuyagHnG677vgSDbAF+0FSGJOMAEbJ5CX5sDHl4SCNoa1WP8dWdHca
	zRBP+BHMCk5lzFCGdZ3H5r2NruWj0Vts=
X-Gm-Gg: AYBFou2PJ4XHRcwBv53Igeh0RhrhXq/4abpRK7GOwXP7abhG+5BMcGHaMKSRp7krhN6
	jskgLpdceIiJXXVj64DTtSOuqo7ZioN5J1oWrw0cHC9U6w5rcY+p9huh1WiAPj2fhG17yTLBfci
	l4YdTW3RKDUAnl5puPPoDpf0j1xNtqb/XiOh8phbKWQlqvOPD28nFLqgcTJtnucqQmtUBuZC8N6
	w7+0FlWz2dL7/xXfGdAsHzYTDahupsaKa6EK7jYjaJvtZQWft3ldj1vwZh+ZdV+Omoy3Frvz0He
	PM/pQqd97sUYpxMLntt+pv7QUOMZy2wE5cHL9cQ9uvYcf/d5ptTL4vc=
X-Received: by 2002:a05:690e:d41:b0:674:1336:7d5b with SMTP id
 956f58d0204a3-677ac07d611mr844976d50.52.1790949938183; Fri, 02 Oct 2026
 07:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-1-bgrech@redhat.com>
In-Reply-To: <20261001153212.102261-1-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 10:05:27 -0400
X-Gm-Features: AclHuK-FURZT1tQI9DjVgOgbeUqAw2aYZHnYEqkHUsIHP0KbfydSCAts6ofYEiQ
Message-ID: <CAEjxPJ4W5g6_938rr4k7Bmgm9Mq7HpL=CfasPZ4SEtr3YYFobw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests/netlink_socket: skip iscsi subtest when
 NETLINK_ISCSI is unsupported
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:22=E2=80=AFPM Brian Grech <bgrech@redhat.com> wro=
te:
>
> test_netlink_iscsi_socket_t's ability to create a NETLINK_ISCSI socket
> depends on kernel support for the iSCSI netlink transport. On systems
> built without it, socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ISCSI) fails
> regardless of SELinux confinement, so the create/deny pair of subtests
> fail without exercising any access control.
>
> Probe support unconfined before running the confined cases, and skip
> just those two subtests when unavailable, leaving the rest of the
> netlink_socket tests (netfilter, generic, crypto) unaffected.
>
> Assisted-by: Claude Code:claude-sonnet-5
> Signed-off-by: Brian Grech <bgrech@redhat.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
