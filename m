Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792512396;
	b=3m7T7+UIbGImwglmI5SG/7CCR4YBiv7q4I/oligHKqZqmLa5DGoNB9W/B2bhEZWrR+ge
	 BGVoeS+i6ZXVTJiMGmxsU0L+FubfWln1KPHsz+iuvbJ6SkcYIWxrqmoIzDVnCwxKuCrQw
	 P8thxNMv9sMIkCm+8wLbY1f27k4R0mVxGX6dkNwB98psp9uebp3CFSbslsheVy8uVFFKe
	 J7/bM/Zq+a3snuQwooteuVFMG4rAeqtRSZUHTNCS9i441cUBS9ygnpiNFGIJIDtxWBQBg
	 WvzT46OqdqKb2JQIW/VqxiGVfcCMaz9gU9StzjRtqp73j+AzKxlswHKSjXdLB6pU7GQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5GAEdXONfRm+e1eMz7MVyYNsu6CIKY9mfKDEZMJJqBw=;
	b=0ENJZiHduIQamHh3cn3A1l2SRb0fUkxy/2jdBTXtHBCL0B0la2/nh/hJcP+b3+qqbpow
	 gPnmQSmVA1IbgMF4X7I+LISBLSSJ7WgY4g+3xyYQYeh+2C3acuLlbPoG88VtztW9J+SmQ
	 ElHmBlxoZGBQsnxwepze4BAbg64EhgrM7ZxBxXppr7eI7739YbYHNtosvZhFuyFIasmvK
	 Kk9SksYa408hSGS1/d4C4yzs8t5ZPvI+98O3xtqB53uMeVW41iWlptv3rAU24axL29VZK
	 BL2OkXeWrDEKsIsXm67VEwsBuZOIVsNC5eyvZZ804RT/XKyg6wxA+VxSvRI6zT5J9KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3F2uRbm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F2606A31E
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 16:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3F2uRbm
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-679e6ab6471so781171d50.0
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 09:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792512395; cv=none;
        d=google.com; s=arc-20260327;
        b=O1vn7/ixP+4Ucp3xY8K67TwkKjedSYvVJE8ZVKvA2+KnpjXIm5hYpvE4crgmx9YPc0
         sXFICp7TyVoKYyXjrhtDdWYkhDAMio3jRySjzlzm0R61QMbjiP1rsZ256hF9BOVJwmq7
         M2g7IkJJRQMW+H3HBdroT9KFj+Y1GjQDRfb93Ow1cZ+sWnPDPLMcfpT0MwDRR8lyIpF+
         oM+BsoICMJTQmje83hDOC8qC/zfAgH6HOkMwcWynN1rx+73ZGDV+GYAHeewyoetMfLiA
         L8iQ6+1eWr/4shSLOQ3YfMv+j3ldQUreSlRNqLGsF+Kn0aVQoadR1pgafjw5NFeVWXFJ
         DHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5GAEdXONfRm+e1eMz7MVyYNsu6CIKY9mfKDEZMJJqBw=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=aiGOPuie5IzzPTEglCGSyHjH4EzkZ1uq13yEYuTBnCzSWj4e3xMDIgGH0gU+FY5YWz
         qnxaDKOb1Kv9VpgrxniivXePD0GRXjYhM9rOi/BmGARODK5/cF3V/MGVb9/gwVGN7+97
         8XNmoJ48uauJfs80PlSBj9duD7ZfcMpIXh1XI0Xh+GNqiiWQzCs0QSEKht5LQT4hwK5B
         Qo56hxuxm0PYX1/UTe5tcxvlN6SxFj8Si59mCOAVAY1umm15qz/ftw28se5VH0IJ7A/W
         jkmpzD0x5lnDUFUCezMvAoKR7uACO4e2jrBrjlavsg5OZXjTgkcke9SPdDqwFNO7riP4
         IFqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512395; x=1793117195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5GAEdXONfRm+e1eMz7MVyYNsu6CIKY9mfKDEZMJJqBw=;
        b=F3F2uRbmGZOvZtpH+vai2OUrjPh7XV/IayOVDPCk7s6NwqsKKRoycQQ3AosGZPGa/e
         U/OO3dFt58A3ZCW/1KIPZPtTGkLDqBUPCruz+8lKal7mEf80UCxLEpXAZ4j5/sGJueGA
         wCJPUiNyJQI9EXVvIw4uA1hf2PVhTQn3RMkNSFouZKwv0jI0kCUdbHkPbT8BcolE+I1O
         9F/6BQz/zPRG1kZbgzr/4F8HGAj82qJl/aZFA7t7nvpb5CCMbgz8EuUybYWEYnilgB/6
         AUVCyaJTCaJWXt1BUsENeXJx/AAmweEGxo6XBTOgKYm3JyCDeFWO7Ph0CQ8Kz36x/T+/
         R4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512395; x=1793117195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5GAEdXONfRm+e1eMz7MVyYNsu6CIKY9mfKDEZMJJqBw=;
        b=LLBlPgRdBYSgJmkRla+KkyvxNkDfmq/S8y4ClCbaKTljQiVNv3PG0sJnH3sHmSx/cc
         l2rl8fqsaeGsbpKWNiCTL4vVl1Yu2Rao65tPiAaupJCBlYNbMFop02j5At4HdQqUbM61
         BMyJKMeeqm9iO9DGFvVR2yrn/zqfu+kQeShxGdWRLTaJmVdt7Np1yYJywxXHKJdb20kc
         S68hawSHJKTm8WjbKJafKx0a79is84DkgsZwyK50EA+roiDjvHQiZ6BDioz0cgEM0LSX
         uNCO2anIc3XMMwu+s40FjF2noxnCvrTEBaBL0vrJoJGD6E7GwUjMtLeecicRqVgZgGfA
         /gGQ==
X-Gm-Message-State: AFq9FYJnNxFctWoS5v0V98xjJ0BYeNxWpbpzZgTjw2Z9EF6s8N2ono8W
	A18BoSE2FmFBJWgzAX2raI/pfevYz+hNeCg4/IO87LtfQH0S8PQRDBh6OqwneChtR8GwcCrPIDo
	Mkh+pdb8y4oK/1HeRAqsH/ugbhILISgn11AaR
X-Gm-Gg: AYBFou3//k9matwVI1g3k9NLhZ7amvevgGlk5Ypgb0iJiUls4IUWpOyhhwVGhklr4rh
	eMM3aIfeuD1DPSBAp+oGzuTgSx90OtO9Cl+qlQqiairY/I0GQr/8tUq2TNoUM2VMnu23F4Qn6hi
	QPsevGgqy08ORRpdi9g1t1T1CP6532XlpP6e1WT5cz86WjoE7o+4Oimr0GajLoj0HEr36DzUPcA
	lksX8LgOkG425YIbr5NBjzqegeEFa8rBZBJSaxTL+eoF/e6EZfLoEK3LvOZtLcgGWvdm8zqM0ic
	tZebp4NwOsYBbY/CI/42Owg+VTunPxEmGinYVOroLbXyzFAWw8N5PoQ=
X-Received: by 2002:a05:690e:1287:b0:677:df02:fce with SMTP id
 956f58d0204a3-679fbb89d73mr931423d50.5.1792512395215; Tue, 20 Oct 2026
 09:06:35 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020154943.2408020-1-omosnacek@gmail.com>
In-Reply-To: <20261020154943.2408020-1-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 20 Oct 2026 12:06:23 -0400
X-Gm-Features: AclHuK-7jjDSUkhLUpWhA4AVT0c3uSXp8FRpOC3HajcuEYV-rprbCuCKxZGMsnc
Message-ID: <CAEjxPJ4O08Lp-s_1V5XbmHV4PEX-isgzXTaeDym5yi1jyeKJSw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/binder: add missing parentheses in print_trans_data()
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 11:54=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnac=
ek@gmail.com> wrote:
>
> The newly added casts were meant to convert the result of the '&'
> operation, not just the left operand. Add parentheses to fix that.
>
> Fixes: 705ddfdc5ae5 ("tests/binder: fix compiler warnings on ppc64le")
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Not new to this but I did wonder - why "long unsigned" rather than "
unsigned long"? No real difference, just used to seeing it the other
way around.
