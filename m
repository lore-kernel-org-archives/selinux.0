Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1A388881
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191902; cv=pass; b=AzA74iNqqMJD8xygVvU7XgGZy4U05az9fOOLMNurJr1wNdcYVhf4Ie/kYIQEJRXEYw/ZYcpV4n91LU7oK33/NYK4hQivgC56p6MLIAjGZmwMnC7mihFsv5BSKTRs5OZIhVVf093KJxx+QzCV2OE3GV8jDizCtDWmoJHjNC72mxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191902; c=relaxed/simple;
	bh=pFID29gRcdazLkH/8HXWOAP+MWIcyG9N5G9TJhsONOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ43PIFG7b1NGRSUT2KxxHvPaZIlOi3aghBnGXpLyyhKInp8U2FTK4d5LraAN4ik1S5XtUvBA/7c5V1Z6lwGZrxVSI5+FWXBFeNRPiwJt1jYQITrzEb561BorRLlGiXvXcJWkaTuisW+FOwTbOjh2E3kM7SJ3t/JDf4fXTp1xOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgMErFYf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=etyUZSe+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgMErFYf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="etyUZSe+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785191900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGkIxpOfCqetdc/GnzSPXY8K0xKEjPdWzwva8DXaIJ8=;
	b=cgMErFYfJRQOi6u+kLIlq54EgNMuOFXeTT+8XQUiaC5jKK2yQHnG3aKG0qduMnjb3I/Cxi
	yz2l7tj56PZIKXcsefcPPcJdYDUUCCb8gWKyvsY3Nm0KCH3Ji2OQYt0yblkUaDduYoxxLd
	Df+sk6jRp6MTj0m1L+hObsmvwG7nzfE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-CnNG4r88NmehzKPIdFFCFw-1; Mon, 27 Jul 2026 18:38:18 -0400
X-MC-Unique: CnNG4r88NmehzKPIdFFCFw-1
X-Mimecast-MFC-AGG-ID: CnNG4r88NmehzKPIdFFCFw_1785191898
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so332974a91.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785191898; cv=none;
        d=google.com; s=arc-20260327;
        b=lnHrBzjPL77/e+tfv1Wv1JPj9sF6QKbe3no7EZqvLPr2SCcV5qRroG4aXwOa8jYlAR
         okrG6KncQDbADqSulLxaYZLVqBsT7NTUfDELc/SX6mBh1p2orAR1YTLSJTu5HoklhcRK
         qg/BoqWPKXh91KKSyMulXBkw1f3y4DO2Nx2MeZXhxmDYHt3qTgdIGHnASoiKHZZ+wEz2
         o6RENxQq6xsySSGWnY2Zov4xRvdkbwlnmaSYPrSwxObyOQK4xtBGfPDwkkmgyqkZr3fs
         GkQ2IPrred8oi7Z8DvxeuEO1lAYNk2amTWW2mZAgmTnNumdSbsNaYKrdUw2Te8xDc3It
         7xTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qGkIxpOfCqetdc/GnzSPXY8K0xKEjPdWzwva8DXaIJ8=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=Llt93bjH6VDLNs8d8KxxHFDYyJsu4dP4wMOmlepZGsErMianX7sCu1XueA8dx/cTyQ
         9mlUOP3g4TdZr5tEP5jXc8/WLGM5HvAy2LAgFT57Q8OGKnF4A5D9Q6MnxOeMiTg42X/U
         v6PI61fyrVuuI7pBC3g1ngt1iU5Qlc6wmBm0nBJ15i9N6HRLjUQUDfHu0N8P8Lek/bqe
         TyXAbyTqBHvJceYTlFjeWjt5V3MsVb0EdXBto+0PwBWYre2+E7NBxppdWD9t4RLm/r/L
         8uB1v4j6+6oeJ4JcMmooxCjUDVBi762EtdBGbZAyaXuoSua1EpcWKq3hEdE05EwPJ1kR
         Uqvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785191898; x=1785796698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qGkIxpOfCqetdc/GnzSPXY8K0xKEjPdWzwva8DXaIJ8=;
        b=etyUZSe+MxynZvadUtWlPeliJeaQMifTZlmmzi5KPMowesZIz8okQ10QlL8b+HnYLN
         wMCwEZshYVSFndfP6Y81qp234NDchWOV9KdekqZyn3eV3+dEgE11NvjzIa1RqQsPJIIS
         z0q01LH5SKwWqLxCjV/IaGMz3y9whN8sV62p5a5W4Y1R6OxvacVl2K71Yo/j2+rwxbVq
         9vwTTCotIdoL3gi79S14gXXHGWFDLHJ9Mv8zqjzJhQwJoFmI0JzPEhDYY2OCrRit5Noq
         A7pW3TWbNVVSM+RMpIjrreFMWOVRaQNDb0efmFqeC5O9IXoen/TAaO0V2iZBNIXPYQBp
         lL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785191898; x=1785796698;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGkIxpOfCqetdc/GnzSPXY8K0xKEjPdWzwva8DXaIJ8=;
        b=mcZgGiiplBctfqRw+DSkYnGWQc8bGXuL0EOdGO2PFTfs6ZOxMXFBjEnvG/Q2pmRLtZ
         USkCNTJtzctFGD18MwIKt7xu0bl9NgXQdoyg8D6ctAk8VsUg8dSFCsm+2lyHjsZQj3Lh
         El++GAVCV6V5jXu/GWvddErViV9kQtbfBavVEHMGKQrmgpqDhitES1KC1jGCNrYmgyhc
         hrZb/N6mRq/v7L6tcPUzZ/A2S3ub7V/H7ka1WuvlqH28eUI1NpiYQcnv2MG8afdpsXce
         sYApyhG7coQOmjN+5WkkHdRPi6BzecmURr1WTl4BeyJhrsfaIhvyDpjthV4iUN1/E4A4
         RDZQ==
X-Gm-Message-State: AOJu0Yw+AS/pM6LmTgj90QH6ZMOsKonFfzKbSYDocVr1Pzs1UZG652Yp
	u9ZqM1UUn6g/QO9+Ocvo1TBL57pqva70z22XZC1n7FquyR38gdqmwLQj2pypOSPavJOxrUrtKK8
	DjEHiMNfJtdWhk9AijP+uRNIbibv4yW3oWMrAIjKe6YFbrpNPBiOTcVgXQRtaR9eGMGQPZL7/Z4
	G7nyG2A1udY1Gyk8cyi2goXVNCQ+Y0fEX+DCsM5EKp9kzD
X-Gm-Gg: AR+sD10eUw5sKVrdzDJ/nwF4ObxZQI1pAwXRLo21dK6RXFKOx6HMULygqYJOuXrHzPE
	aMNvIX10E7dDiSqbTddoRPwe6D8VdgXkeDCngg0MQWp46TkxGpUmxnwAiQ82he2pIXORkpqb1N8
	YmWALlvq0Ur4FFcYsaXzt9EE+ShrQQkJ9Kgsu+XfRaKDVebSEsw1bF5q2PB1iDPIkOpWtNM/B4S
	721ihsTOlsh4/T3
X-Received: by 2002:a17:90b:3901:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-38f66d3373fmr621322a91.18.1785191897616;
        Mon, 27 Jul 2026 15:38:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3901:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-38f66d3373fmr621307a91.18.1785191897149; Mon, 27 Jul 2026
 15:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727152518.2495266-1-akkohli@redhat.com> <20260727152518.2495266-3-akkohli@redhat.com>
 <CAEjxPJ7UXCc3DWaAcpmVqL-Dz5eHCCsHWX+4dYkfw-CUFEhSzw@mail.gmail.com> <CAEjxPJ6kzkE_Or8PQT6bAvNzOOdD4qd5bVyUDAeusfbtc9ramw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6kzkE_Or8PQT6bAvNzOOdD4qd5bVyUDAeusfbtc9ramw@mail.gmail.com>
From: Akhil Kohli <akkohli@redhat.com>
Date: Tue, 28 Jul 2026 00:38:05 +0200
X-Gm-Features: AUfX_myrdX92TgRajsg79469egMjM85oj68qjf_tYO0NNz9ZyYZzeGUJgQoejz8
Message-ID: <CANu4e6NOmvb4jYUvhV==81AR=7JmhEMc-PZ03+pqqWL2hRXKhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy: add robustness tests for large policy inputs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the note on exit 137 (OOM/KILL).
Addressed in v2 along with the non-root CI BASEDIR fix:
https://lore.kernel.org/selinux/20260727223242.2507658-1-akkohli@redhat.com=
/T/#u


On Mon, Jul 27, 2026 at 8:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 1:53=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 11:44=E2=80=AFAM Akhil Kohli <akkohli@redhat.co=
m> wrote:
> > >
> > > Add expect_robust to the checkmodule negative harness so oversized
> > > generated .te and .conf sources are exercised without crashing or
> > > hanging. Also cover a module with a large attribute membership set.
> > >
> > > Fixtures are generated at runtime to keep the repository small. Test
> > > size is tunable via LARGE_TE_ALLOWS, LARGE_CONF_ALLOWS,
> > > HUGE_ATTR_TYPES, and BAD_DATA_STRESS.
> > >
> > > Also fix expect_* to return 0 after counting a failure so set -e
> > > does not stop the suite early. Same bug affected the older cases;
> > > exit status is still non-zero when FAIL !=3D 0.
> > >
> > > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > > ---
> > >  .../tests/test_checkmodule_negative.sh        | 178 ++++++++++++++++=
+-
> > >  1 file changed, 170 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpo=
licy/tests/test_checkmodule_negative.sh
> > > index 6d289a4c..ed7202f5 100755
> > > --- a/checkpolicy/tests/test_checkmodule_negative.sh
> > > +++ b/checkpolicy/tests/test_checkmodule_negative.sh
> > > @@ -136,6 +150,138 @@ expect_fail_unreadable() {
> > >         echo ""
> > >  }
> > >
> > > +robust_exit_is_crash() {
> > > +       rc=3D"$1"
> > > +
> > > +       # Fatal signals: SEGV (139), ABRT (134), ILL (132), BUS (135)=
, FPE (136).
> > > +       case "${rc}" in
> > > +       132|134|135|136|139)
> > > +               return 0
> >
> > You omitted KILL (137), so OOM-kill would pass as finished safely.
> > Not sure that's your intent.
>
> Also these patches break CI,
> https://github.com/stephensmalley/selinux/actions/runs/30291360086/job/90=
061649922
>

