Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E33644A1
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909044; cv=pass; b=HeMEzU6CwVY71p9rxX0Gvv9Rckxxdzgmzw1U2sZC2gr+sGG+uxAoDTsJO6j7kmMNQjc1zGLR6YhT5LWKgbhq9I9IP/itJUs6Emzu1O0uxvSECNnwHfH1PUNCRSRkPTeuHcn5wvxobLmSk+zXhe8ZVopfW+URRyPJ6V7MK6qsEi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909044; c=relaxed/simple;
	bh=CZjmk+YHrNCg29AesA+DRpqyOdM48kVOaNluPQnN4CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRCmZpbmoLG2d1OsoIKccFxkhxgrZOvdjqbEal6oZcByLqD9vHJvQ/fiPjwcjc2YHQgZQworAcmKJVb02MDFUmWpJx8nZZ9ALQgUkn8kgNyhUGFccOGeSI2iY8OHOpNbn4145SRDr6UFtG0HrzKoGN/uxszzcqN+u0+TZ8DEmNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2/1uWmU; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2/1uWmU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2be75f658f3so65755065ad.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 12:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909042; cv=none;
        d=google.com; s=arc-20240605;
        b=LR2sASmohwhiTrzLlCJqvxFHLegjSnHlDBR4YGejkSltAxx/Dp3gBGjvEYZ12s1ipp
         +1NV/WDt4GMdvolYSFlufbToy6Vf+8ByV3IjdSivyyn02REGdGU9TjShxTUtcTa72G4a
         pZATuotxUyU6CLkajJrz/Lv4n3Y/8M+L1ypqVbiGZ2sTUDQHRRmcGIFu0MIV5NUJi0lG
         BevVE9JVXjIFPKBr+7VaaW0WOwgfGkBzXsIODQmq2HAHAC2deUn4LKDBHfCGgiRkm9Ya
         6cbdnVeyAtv0N6nAD5fAZtnFz3hO82EFsvRkKqzhanKHby8oBIB9FEaocmJp6sAc6yde
         zuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oZWPbILd2RHz8ieImftmIHxJurQJ0dzNOKbn8nZmNgY=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=Y9IDwNHDIK+XEKExA9C6GCDeOQkce+2OcN2vf7oIw/3+3R/BRUwRE77ZWdznP5twQM
         dcNyuzLVY4xN9cTKyQVBR7RorJAF8Cbf7ED+s0Ln/q1+Ayd2TVmdO1+Wu7nA+MgUPjKG
         5Lv3UbOhda4kMQeRsjWNsarN1KUBMG+2vcE+sOqXRPi+3mdmhe/w0wYozkz1MMof5DrW
         IWZm9/FrD8DJ6TU3kfmFfjjMuGNmIfnnX9XJ7cAM2Re8jIWnZY0Vde+RHfEsq8uvJrhl
         oyPzMC4fmCyCPQQKiDSkTWEEHTaL2w2bKfSsJdK5xWeNDZQJpX5q3ja7Ge6iqTD9n/Ht
         RJEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909042; x=1780513842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZWPbILd2RHz8ieImftmIHxJurQJ0dzNOKbn8nZmNgY=;
        b=P2/1uWmUe3hWO9FckzehXvmPVWgh3AUSFkDJ8WFzxXuPY6hVxnujr61iu7tAG8lTWE
         ezDQAI8+ZvD+J3EO52GmmH+xaSg7C2kgSqs2oKZVQqIA8ZK3tIuf4r8hs3mb9x5KvEFG
         bbNWEg/yNhyPP7nckdYI8XNTaU/gRC7IIWJsI3NBxXlNDCggIJhc1aYVOrjbrkkMGhx7
         xXJLHrzhCEhnMXAfuqjHevEfnYNgxCz64D394+HP5TlFATQLfb1lw73rZAkP9eIRTQZ9
         ru1Q+cTYu877iLe442cAT/bmHB7CIF9cQidpEEzrgPFGGEQCuxLgPZ+p/GiXBwZvUMX6
         kBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909042; x=1780513842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oZWPbILd2RHz8ieImftmIHxJurQJ0dzNOKbn8nZmNgY=;
        b=SkV2p+X0BA/d18X3Y+LidpkIoAaabSyhBVctQsU+dYfVF4lMwTW78HcYNzQi3vF6xT
         gIpsPZKHMdSGiPHtbSrjdElNhjYoKSwAXauYSniiNMA/ryiKUaxgr4UuRx7BsBdoBdFO
         NUTr2FGw5DqIEF6MzIAxpoc1kvqqDENxeFG+klMQWxKgQV2L9001+W5+m7m93tgG8JkH
         Aog05ujoUQ25JVALyUBOPCiQE/G2BLE5sts8BrvShIA9NSBwRY57C6U2HZLOgmLN5hvb
         D3F8s+9hViLgKLlNXKWprCHN1U0TDC3GgS+BwsvpVAJEIUNQNWfawvL3/GByx4ngyhl0
         h0Uw==
X-Gm-Message-State: AOJu0YwvKzvoUpKiInw54BX/DQKlfTyin0ePTpJLC+aG7ufzAI+nmQLH
	cNf6o6Yh43MPiWQdp9AHSd+sKC6YiVPidZdJioVgLsiljeZbSh1eLgSwuozg8Bfw5O1lDsdt1xR
	2Z7iqD3Mj93Mj0PV0XYpdkNqVD1fhzXd+m/8a
X-Gm-Gg: Acq92OGtSphaPXoJC7wXv8RvnBPIoN7pceaBa8hE9E4k9rYGwTBTOFeOU9+jNnjigXU
	aBKdwB87U3k0v8bBPGNHzt3qtHGZIquIR12U4fpraLdbti2CYZ6pdErSdNL5yOrhHAXdAcexlZY
	R9nYDRr8Jp7PtgVuzigWgME8vouA47aHlQCFmWxsFNnEg5Xw5DY1fv/L8BayvN0RCBSjWR+txVF
	C9c1hQsDttO+rUPnct3Tg08zGPsD1asriLoqU5gNxINC61kcu7Y3XMwrDTHIQXpfzNS/hBgVJw7
	AYx1LUO7sPThyAA5Ug==
X-Received: by 2002:a17:902:cf4b:b0:2bd:ba44:6c07 with SMTP id
 d9443c01a7336-2beb0702610mr271070495ad.16.1779909042316; Wed, 27 May 2026
 12:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527153953.27606-1-stephen.smalley.work@gmail.com> <20260527153953.27606-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260527153953.27606-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 15:10:30 -0400
X-Gm-Features: AVHnY4LbxW161is_ksn2f3Q06lpntgSlyjUAIocp1jpc10irixbDgDB3HZ-a1u8
Message-ID: <CAEjxPJ58g_jq7EZn0kSH8-5mkiNo-rcUxxuzbfZHS4xxg5pk0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mcstrans: fix error path leaks and NULL-derefs
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Fix several error path memory leaks and potential NULL-derefs.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  mcstrans/src/mcstrans.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Merged.

>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 45935540..5056f86e 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -235,7 +235,7 @@ static mls_level_t *
>  parse_raw(const char *raw) {
>         mls_level_t *mls =3D calloc(1, sizeof(mls_level_t));
>         if (!mls)
> -               goto err;
> +               return NULL;
>         if (sscanf(raw,"s%u", &mls->sens) !=3D 1)
>                 goto err;
>         raw +=3D numdigits(mls->sens) + 1;
> @@ -439,6 +439,8 @@ add_word(word_group_t *group, char *raw, char *trans)=
 {
>                 return -1;
>         }
>         word_t *word =3D create_word(&group->words, trans);
> +       if (!word)
> +               return -1;
>         int rc =3D parse_ebitmap(&word->cat, &group->def, raw);
>         if (rc < 0) {
>                 log_error(" syntax error in %s\n", raw);
> @@ -485,6 +487,7 @@ add_constraint(char op, char *raw, char *tok) {
>                 }
>                 if (asprintf(&constraint->text, "%s%c%s", raw, op, tok) <=
 0) {
>                         log_error("asprintf failed %s", strerror(errno));
> +                       ebitmap_destroy(&constraint->cat);
>                         free(constraint);
>                         return -1;
>                 }
> @@ -513,6 +516,9 @@ add_constraint(char op, char *raw, char *tok) {
>                 }
>                 if (asprintf(&constraint->text, "%s%c%s", raw, op, tok) <=
 0) {
>                         log_error("asprintf failed %s", strerror(errno));
> +                       ebitmap_destroy(&constraint->mask);
> +                       ebitmap_destroy(&constraint->cat);
> +                       free(constraint);
>                         return -1;
>                 }
>                 constraint->nbits =3D ebitmap_cardinality(&constraint->ca=
t);
> --
> 2.54.0
>
