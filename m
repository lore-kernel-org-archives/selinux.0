Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA344B04B5
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443668; cv=pass; b=uMGsKyPiiHtw45VumOWO3O52gvCnpIGEaUOfA4+jf2m7kRUaje0Ee5Il5JCHct7JnGUynKH0zKVrM1KZFzu/71gg7XZ+atUgHkIhb4AeTSZhEapyNQ07lv/wSieGokJ/tXIe9FLztIq9gjyGTyMgeIm8owHXOqvbWr5/cgmqycc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443668; c=relaxed/simple;
	bh=qOTpEDr3G4xwWOtkWFSRiXYIPGcJyDaJLx4xHsZgndQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcrXKLa4XPlwVc2SCENU0GW60ejsrqcUdvpdQ4LufvdJ4j62kVTgeqTJE8WG7t+uWqJhf+zunbL/7OBVDr5JjghILVRJGEETiTWDU3p72a0WOcORWZOKASyNYDO3PiCw7gpZTlrcy5mITUQyhXZsVQ+rfvRFrJ5J7on+Y4/yVaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8lTmS1Z; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8lTmS1Z"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso1234431a34.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 06:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788443642; cv=none;
        d=google.com; s=arc-20260327;
        b=VcK3Rcmg/anXIC5ThH0MglDg3DVQCH6DNPFLCiVVAmqaajhcJnQv5SUvrRIilxQk1l
         fxmUjb/AP9tJ+ahu97pJsvcJqzQFuj6aJ5FJ73X0HsHkrQQy4XHn68U8C+jWnYmPUlcV
         VF3PVZlHZ59jHR5iw82s6ld6qNw3B5B32tYIY1TiFSYjDE0Nixl6osAkgqXR7oD2F1ob
         VUy+YisEPXvkF4hgJqsphZnB/x0P6AkT7rRjblVBC11yOQ1PPngaRZQftMzArhH6CHFP
         WJxtkeUhddVJ2/R4EAi0HlvKyt4o1indlU/Xbn9n4zx9bTcqnp6e39Ia3pKtCkG3+96N
         gMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=osIsv3l2WHNJU1uf9h9o+ZmsD0arEcO/c711UaKp81Q=;
        fh=aUbqRQkq61ZAI0AgKTda9vTeDxp/LdA3hosIEHHauP8=;
        b=kxr3dv0mN6T/vwG/bW2Zv7dQn6uCPUgFfxBgxr97JmdnbayHFEh07TRyn5eBzkdGMT
         XE2a2Po1bet84K+M99O+K8W2u2WH3VV/Z3z837xSkZ0dxMV7FSC3WAAMEbdQiacyT05h
         WUfBxG0oWWa08GuALQHYjYiWSx6re0FmCmtzQsYVa7L1vsTWE728FVm8ykFIJw0tgRMw
         z9COnscQrHKQi4ACNxn/Qvfnu6lrVFNV0YQdHqboVhPj2bXHGsgZvm03GCBKtceyOrHr
         VVuxAG/S+bIsxwkZQpCL0QSnJy8nV80c5tKVMaOdSzp4e1MtAX66NkBXA1lHM1d6BU/J
         GF8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443642; x=1789048442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osIsv3l2WHNJU1uf9h9o+ZmsD0arEcO/c711UaKp81Q=;
        b=U8lTmS1Zc6KCU6kmu1jxQfzb6+IyMLDC1qsjxWbcE0Y0zP4v6M8by+r1vkBUCWHWf/
         lx+tSf3tRuccyYFu+DnUippelUIZRPFKfnG4Ct+swRs0nlexsF5JQnlJk+mZS9dtwqhE
         HttyWH3/k9tbk8el/pKfNvGUsmQy07FLbx9zDUJknao5YUZBcJuZv9mGl9jhQM/Bpinu
         Pwg0FUb5S/SLVFFqJlieCsXSU1yKIfosoMZ2/ZBtQHXxzDLTpipspJ/lt3fxdBcm04Vb
         ErCfkZ6s0OKhob/t8fOaKIk1Idyfm4GewsRpYJYHpQXh5wKzt+0KUq/CAWlppb/ByGAp
         cd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443642; x=1789048442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osIsv3l2WHNJU1uf9h9o+ZmsD0arEcO/c711UaKp81Q=;
        b=W6YCV+Nhjd1OgA/JI9KZ8tv25LvrlpHXkvQ7YklPR2Oy3d9x+ymBU4UYV5LQQXtair
         ZbQZtFm2a974BRZtquj78RseWvrXePd6CS+clMBlx0GMuMNXf2uHwlAhRpt8N4fP7eY+
         e3YsLNecvmLSbawuSdDXl7sUfxwv33ATblKt5QF9oaEoJs/jncTyc0OtfWDgazjfc8SW
         mm3ohue6dqV+XhQZRgiGQ6yYTSUz1KHfkBM8jJgX4pakDVjETZxxkrvaPLdpYyWBBZlv
         ju+nkoeEMPijnpwkUd+eoAiSL6n/e8RN5E6QYOro10S7z+kAJwcatjh7iWZGT1GDTEcN
         V+eA==
X-Gm-Message-State: AFuF++n1RE+1NXF1HK6dQ2NYicw2xjAe1eNGTHKet/E1ks8WkSXHrcb4
	2e7tV0okBAdjUlrxGOtwB5oOO3+wfqK/qYdS9vSfHewlsRtTZit2Mum8x+9zPMKsAdqOFec/MU7
	KGPlb+ik1IWhp/X0g3m6n4wcK/xEE0Zbyjr8A
X-Gm-Gg: AYBFou2/5SYu8ZcH8nxV7rXCoXKkO2UZ7GhLWQgBmnhEKiUL0hS9FtrcqjG3KqEOa7l
	1FwdWSzIbPcDvyDr3uzJ0dFdff3z7yOp6sj7xs6hNoXcOuIdyMdBq+2F6YtvTg1nyBlRhVymjO2
	VcPc7lllzlMbZbrj0MBDgF9trUomKTgBbzF6cwMxDkkjUWk2wVcGpVEgApjwGsZPPc0b+13/Qi0
	kFfFCdzeLK1lEpc4hWcX0nKh8k6IWL3pAxmi6WB1H3mZc0UHvqmZf7DVrFitAWXAQXYrY+VWnIN
	KNU1gMOFfGvaU9olGh41SgY7RWzB1992XwHWplKvu5sU
X-Received: by 2002:a05:6820:1791:b0:6b1:c679:7117 with SMTP id
 006d021491bc7-6b47edd013cmr10260871eaf.4.1788443642510; Thu, 03 Sep 2026
 06:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de> <20260903113538.72942-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 09:53:50 -0400
X-Gm-Features: AcwNN1V4OmkJr4DT61AHt9MYfIrPe2UDATwUTxrd4PYdCazePcVA-hhrZKNmLa4
Message-ID: <CAEjxPJ7Vhr0KYaZaDbUMTv6p+zvneE5fPN8uDUegsVKEb+-_GQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: validate permissive and neveraudit map types
 at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The permissive and neveraudit maps are read as ebitmaps and indexed by
> type value, but their set bits are never checked. A bit that is not a
> defined, non-attribute type is silently accepted. Validate every set bit
> of both maps in policydb_index() with policydb_simpletype_isvalid().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index efa8df26791d..c901a0148034 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -892,6 +892,28 @@ static int policydb_index(struct policydb *p)
>         if (rc)
>                 goto out;
>
> +       {
> +               struct ebitmap_node *node;
> +               u32 bit;

I am not a fan of embedded { } blocks inside a function but defer to Paul.
Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
