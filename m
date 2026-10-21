Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792569499;
	b=lUv+kus/PPydmQTSNY7F9kk9/d291q8VEB8j5PQtOyRdzUZO0tLslxbuU7bEhPZGdESn
	 90T8+Vvp8YReTsjj7hqoCYCZ9OGsRvWaQ9e3QBpqvdZ+yXgyFtQnge3cQdDpu/Y6qDD7I
	 VXYO/O1L+GhorKr+UYWc63mw0K9DML5VXnNyuUE5QaRW+Yh+dcjaw6gFhQINaUPcDhrVv
	 gInDQHz3DwUE/6PaUOEhuRDQVtr9lz7LrYOt7yEl3sMaz2bV7djL/HhMCS3yCw4+5wJkF
	 0NGp7r3XrInYu6qT6+g3hXBVNXIg55eguH42lbkdrKaivbx7sZFcE/xb4YVIeM/Wv4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=A/vlnnUyH4OP/Kqr0YuitSLMPt00ntrV5IjD09YVHRs=;
	b=JIvhRhtx0iMW4XuuCdAHwsPPBjTnlZxRe7FwoVTe8dBSmhr67EYCc6BmpdWFuFHz3Nba
	 J0PupszFbMX8MBOThH+GhTmSWd0yYxAJm0W5AjmFa5lAg/3A1jyhy8Chh/+0fR0o3qy/C
	 +YcHPLSspH0Q2pjqweql0f5BeOWWQaD4cxHdzuZ72mMNeydBtxhft45WKWE75b1nzKzZZ
	 MwW3lzAUcTS4t/O+dT0Zg3IkF8Lz7FZttC0j02qZaqa7CvA0MJ3zZBlkARYku/fqJxIq/
	 VAj5+OODcLwjtk74dA/F6F/FXuZu8iQs0jH3xEBXWxxAHE/zImXCp982/jLNiNqUghQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IavqJZH6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDED606A319
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 07:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDED606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IavqJZH6
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso835009eec.0
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 00:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792569498; cv=none;
        d=google.com; s=arc-20260327;
        b=RZxa/cUX13fx+adlG7ZiHYmU52cbXxQiQcwKaGP6hJjRfLphedWRl4CI4JkHPNZbTU
         3qYDkbqDXFaZiWhYLQT2oKEmCGlUb4m+hRkGrjjWA+RMB4hzoa2fZuZm0lFso3OmFPQ0
         Wx2ztDQFywpN66/WQ1zItsBBTPiWdj+HEd9CnGzD6peWoopqM/xpSEMwkEHDGG9PbIv7
         bNeQQ4DBca7jNOrb5xFAflhr/mynnFPy3sbRwO74GnY+0SRNE0r14AIpPJ356UsvAjPJ
         kVBenSN259lgXWPfx3wST/HII2i+mPkHC8cidLwzEYxK/vp1J5tCDbgTpO2RbaMVyait
         HNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/vlnnUyH4OP/Kqr0YuitSLMPt00ntrV5IjD09YVHRs=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=bBKsyMZAeGGrwlM0gktbRAp9NXzV4+42jMagvkY+sItf8BrkaVlhvccd8oRGyn6rZB
         Kf8wEsBrPv0zPSJgWcQPqxogrfUc7rvEDkH1rsqcKYi3boo0B7YKVgx42duBEYZURfTn
         87cbj8D0yvs3MOLEaeMiKQHByizCR3cpodm289X6u0rCr2f5GFe4o21n3nelsK/9jijD
         T+tQyZs4dbbDy1ramjiqbVVN4RItDpcxhBV+B+maeTDj+Y881qk4MXKWBQVLnbHRiKfy
         AmA+G8zG7cwKKiIAEeOKxiFOTZfaWJrHjK6kUbTRd9ApKoPy7Ub7kD4+v9ukLm7aS5xA
         V64g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792569498; x=1793174298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/vlnnUyH4OP/Kqr0YuitSLMPt00ntrV5IjD09YVHRs=;
        b=IavqJZH6HrJJkgLwGqu/PgcherjGX/wfb1ADdjiGtthATtNINW0zfHp26mqE1hGoTp
         0F6lF793pdfOGhUcAX+MucJWU73ROOAG18KABo3aVlE6RWIEsH8USGfFBhP45kT0ozeg
         g4A3OyaEm1BLI0vCGp76/deLkFLAbVO+fyFOz8I95w7FQKwo+7SdqeSyCXhO38z/HKT5
         iwrFfwRIFMmAmfEl6WBL2oJ45x3rG23Mc9bWqCZbcjmAbJ8cvXJw0WpgOZU07iQsCRN9
         RwpOdoLb92XCsRNrZzFFbPPr7GtUrTLaHSY3AFYa7EP+GUapQ+O2Ko5D4pxxW83N0Mq5
         zZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569498; x=1793174298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/vlnnUyH4OP/Kqr0YuitSLMPt00ntrV5IjD09YVHRs=;
        b=XpA9MQBh+tcgHyUMLktBbDPeA/I7o7uYLhCoNjF1A1VXvyMlS/adyBlfoJnM7QrGBl
         qJEPESKrvSi8faHr4rjii0zej8huu/nLdVb9GpZLf+yUYDQufY92dKL3roHbh3JUTX7F
         rPoUX6UaNLsCdjd9Fhvt/Z3I3zEXd1zhy1oq77Ah/h9EKgf31imOEYMC8oQILZeC8LSY
         NljGI/BcxnCyfzshAYw0FBMzj5gkYVUA2mUO3g/0VaM1lmnE153zS3Na+KRdosDNQInI
         fh7jZx0w3JW1LY9zA+6ugd6ztO8dF0k+pSRoJHCKDlcmqRNDuIla7Ufk4SGxZUj1C9s6
         Vw7g==
X-Gm-Message-State: AFq9FYLez+3TRRxOYbXAXl7P0yfU0OtDB7ow4+2stfIsRF0o8WOvAYvn
	2nXwVyX46NqI/NAgNlEr8lycAvlenSC1pE/nlmLZdpKCDXXyKiNbT9ybooZTMC02K1tUtVB+om9
	+2qiPtUGKcwk/iV5nWvCBn1uFcmx7Xoo=
X-Gm-Gg: AYBFou37zsZjf+ikeObDqL9TWE8yhB1A3In6jsMCXdom7fpWR2PPXXKcTBemxz9jOzy
	q9DDKmRCT1WscUqekkv//y3SR9UT8HOuRBrjRsjchbiQ3HO/3q0DF6M9dyvKvquIJwbPa/ZyPvi
	nzFzXf/LU9ilZv8YUnfuG57YmNvEh4wghYn5VQThJ6vH6mgZIxFfdA0GfogDVwpPK2M8L+3NUcG
	MJvgLxjY0HljEzr3qklSBW/WLaW4FP2hNAM9GeP1zFeTV1tAbkkw16OChr2ECTHoI0gS+vGF7vv
	RBVXQ+8yGHLklNiuluZb258734HsTNHJBmeZxy84ciJHUZz4m26IKBRFb+4LWcq3ht7OtESJCEI
	uZkg3+bWxeavRFOI/6UIKvfh7rFxSE226EvSl/4hNHMgEjPzQcrPJGdz5Kf4fAoYBL5GF
X-Received: by 2002:a05:7022:6ba1:b0:14a:5284:1bf5 with SMTP id
 a92af1059eb24-190a4a34c1amr2611090c88.13.1792569497860; Wed, 21 Oct 2026
 00:58:17 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020154943.2408020-1-omosnacek@gmail.com> <CAEjxPJ4O08Lp-s_1V5XbmHV4PEX-isgzXTaeDym5yi1jyeKJSw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4O08Lp-s_1V5XbmHV4PEX-isgzXTaeDym5yi1jyeKJSw@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Wed, 21 Oct 2026 09:58:05 +0200
X-Gm-Features: AclHuK-UP1hUYRSQXYhKcqhWtAIy8zXc0i6ExwKmHgfjXiEl_aDJx6GZVn8mEoc
Message-ID: <CAAUqJDuKRgSd93iF9HuJXtFMzD9=qFsmsi9jSL2rQCwKNkPB2w@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/binder: add missing parentheses in print_trans_data()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2026 at 18:06, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 20, 2026 at 11:54=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosn=
acek@gmail.com> wrote:
> >
> > The newly added casts were meant to convert the result of the '&'
> > operation, not just the left operand. Add parentheses to fix that.
> >
> > Fixes: 705ddfdc5ae5 ("tests/binder: fix compiler warnings on ppc64le")
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied: https://github.com/SELinuxProject/selinux-testsuite/commit/3d95be0=
e967bb088aae6989fa283ecd07bc833e1
