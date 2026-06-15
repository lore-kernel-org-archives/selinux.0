Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419143E5A0D
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525943; cv=pass; b=Jo0AK+r/asyxscBTFKetxJVzfKugqYeK+uNZetGwZQFoMKrNbdoZj0rQ+CeXlhtKftiC47Eejr/5i+SoEs0JbPmWw9WLGraGkfU0caS8ftf4ZENpjk7sKOi0A0F0rA55unuQ4p1NcdJ+tWNYIRfFfgI24rmmyP2PVYJSY4PkgJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525943; c=relaxed/simple;
	bh=c6Q/320opjgnDqOtmTlQ8vDoEXkdT/1PwkX8q4DmfI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfSMXp9z4/PEr8DGr/aim7kFTgl7hQg3aHMYYW9tna4u+NvZIg3Xzwkpf6J82o5Wh04SofwVEDYtUYW2bJs+HFwhlUgCzm+0dKzseSTwkoklbojM+rG6c0srkx+0G7cnDCCcKWcjcFmgmxKMaYfwfGWFEZnIO4ulcw5v0m76/ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPEUES3y; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPEUES3y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c35980fdso33629695ad.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 05:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781525941; cv=none;
        d=google.com; s=arc-20240605;
        b=NxpzxKZ4yyxUznvwFe3ZuvVY1bBD/Q7FBcgLeo800FykygM+Z3WxeSIcc0c3l5mSp+
         g3TRmjrbuplS7gfTuJFT4ph0GLIKQK6V19Vio9itUKP/2XJXUiEgq+yRCZVxiwZKmj9K
         iJqQDXCwN+zrbJMkZSwTYeZMmkPXgckK/iZXixJvXZBEryawfbQVHJQZLHeYBsIGxl4w
         URrbmqchHJskrap+9VBbvjMUJTdn2cWYFmNPeTTk6yZ/o9qN1MilWTGJnE4ul4vpDp8y
         S19dSGKOCEnn02y8E2L14zyOqOlcNBdH8QoTMpf2mtDW70Yebs0aQzMlaZOoa2BmQctm
         1hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqiWcy3UMGUJq8ZDbzJgRnJEiE42N5W26+Y/rnYi6wA=;
        fh=9accjBU6DbJpgwv+V0ymJnt3ExE9fwSrDHJJiQ3Xf5U=;
        b=SNQqyVN2wbhudoVKNcBwBgWtfWPRQeShS4i3etlCratFBVPFbOb/T3t9E1hLV/DRGh
         bE+CypABuaRr5uIpRmO0CALxcmio5yE3oXUHRb6jufTD/t9JTsIY1StkUUcDQFESfpzc
         iVZdD6br2yqzdK7bkAks5ByRFkjZJcnAZeuYF5C0tKPCPYQ/kZkgyzBqc61GzgODrcW3
         RVwtgZD2FFXeeQdQAKWmpYov3yB+h7AHc00wzvif6tlnK9fScX+2f3biS+MPVbcieTVn
         bJJ99k1k+GFNxJ395HZhd927lbHzRZppQDTmoTnx+LyP2lSTQlCMu6c5U3Tc2Uw2IDmj
         DKWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781525941; x=1782130741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqiWcy3UMGUJq8ZDbzJgRnJEiE42N5W26+Y/rnYi6wA=;
        b=GPEUES3yZAstTSzulN+emBBfy31TKGHAAYy5Ge8i2uETMdkui8TS352KUdG5DXeMZq
         QTNtr3Vgy6XVEioUFNzC0eI8bE/dqVPwJKJWCmlsyjxLet/5zZbqm1SUSg+o6RSdM0Lr
         66wNotofownSqBEc9jgJoP9atjjvefndRqYmqRiAp36F7YVOo082gA89h2gjngIWnK6K
         476GQ7dwAnEpje8LMoSEZxOr/lxNQEO/tbM/C866Yq71tJ9qAu1U9yOZbchkBMerf9hJ
         9R51ZiMEazQNqhDwVUU4gAy1cWTOAuYAbWKk/FJUfkEkE0SvpBbwSzlDq9rPUJiFW1LS
         i3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525941; x=1782130741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqiWcy3UMGUJq8ZDbzJgRnJEiE42N5W26+Y/rnYi6wA=;
        b=q4uLxuebcmFUfxbzLOBPE8xyPNYyXdPK2mZ491VIx2QAjtQ/OcpSH4siTBMZ1QSc0a
         sWWrko3OybfU7YwJLkVEuwybLPL6A28rQL34UPiiXaCZZ8WZNqb/RXKiphOBTN5MOrzV
         +6GvCkvyDms0Jg0eKlwk9uz0RR8wJg+qydKtFgPcTdhyUuLMhhNJLko7Q79KmOQ7IqP+
         Iaxhnq8ZBb8qyzGPKMUvK/8zIiKHaKxy/f5vwhKr85D/YBqJeIl86VxTTyF+u8uspQXO
         sq0OBdYDP9CMrPNzRcoPGhcx2g5M3so/ut2ZaCpFc4YxmgFGNHfju9dkFiP0qjHDvGJn
         ANEA==
X-Forwarded-Encrypted: i=1; AFNElJ+LEQpXwGJ76FzavXxvnvhU5jcCuHpC1uRnoArGzM6rX98qNolPy6rnrLQFix17h2w95kvKH8I0@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPOlLEUr0LR7C1XyhXMhpYiizizdGDAcU4rnZpEu3wzmIaCtq
	DukZpFLTi6zINbB6SrFj63YjSR13WWz+2H5/AOUQHi0Arbk/fwNSfo8pEsV5iUR/PCR/5t5xRUw
	9l1hCgzPBdh7RjIXw7qkzq9VjLkIvHak=
X-Gm-Gg: Acq92OHXgUWKHdoypLQZKaGNnO/b1F1QXlcN3QWtyjo3CCeGtWRIXFaHnFd0OKmDHUb
	mTaIZre8sNe/idWS0BHXoqWpP+0F3bIqVb2ixg1nzGk3ke3D80EJDrzHZYj/fKX2KhO+E3s5DdY
	zWi6FcJE9VMGeYTVL+41bRwwGhL0hTm9ckC42shr3rRZt83bOpboQqHPmkl6qHeeJEkNE3DaUfq
	pV7nkudTTGm2P8QGysAdjpniYhnQI6clP77PwabvaUFd9eoc1iSY4iIdAiJr4/kfCaOJNqKi3V0
	lb8ddUM=
X-Received: by 2002:a17:902:cf4b:b0:2c0:c262:b91f with SMTP id
 d9443c01a7336-2c4109ed6cemr160872615ad.8.1781525941534; Mon, 15 Jun 2026
 05:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611130351.15988-1-stephen.smalley.work@gmail.com>
 <CAJ2a_DfUb2dWUMO-1Kr9_8j5swjeOHwwp0n7brfQR3-5vg=HmQ@mail.gmail.com>
 <CAEjxPJ4hhWE_9wAywrdPT4UdUJt9cgo6=ckH6_4=2gnxuET6UA@mail.gmail.com> <875x3kmb8n.fsf@redhat.com>
In-Reply-To: <875x3kmb8n.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 08:18:50 -0400
X-Gm-Features: AVVi8CeF_i7RmGqkBP9fU57MpEEqEbFQFu_QuK0n1b5fXtTjUz6WeC66M8O0N8s
Message-ID: <CAEjxPJ7K-TankL0uBE10mapBCh++SCkSNn4xx7ZEXa4UzuKT_g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add --undefined-version to LD_SONAME_FLAGS
To: Petr Lautrbach <plautrba@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org, jwcart2@gmail.com, omosnace@redhat.com, 
	Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 4:58=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Thu, Jun 11, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> >>
> >> On Thu, 11 Jun 2026 at 15:10, Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >> >
> >> > commit 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> >> > introduced a matchpathcon_filespec_add64 symbol for certain 32-bit
> >> > configurations but added it to libselinux.map. This was benign under
> >> > GNU ld but breaks lld due to differing defaults for
> >> > --no-undefined-version. Add --undefined-version to LD_SONAME_FLAGS t=
o
> >> > avoid breakage when building with lld.
> >> >
> >> > Fix: #512
> >> > Fix: #513
> >> > Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> >> > Reported-by: Pepper Gray <hello@peppergray.xyz>
> >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>
> >> Personally I liked the fallback wrapper definition of
> >> matchpathcon_filespec_add64() more...
> >
> > I don't strongly care either way. See
> > https://github.com/SELinuxProject/selinux/pull/513#issuecomment-4674610=
134
> > and https://github.com/SELinuxProject/selinux/pull/513#issuecomment-467=
4659036
> > for the argument made against
> > adding the wrapper definition.
>
>
> Could we use libselinux.map.in and generate libselinux.map build time?
>
> Add matchpathcon_filespec_add64@LIBSELINUX_3.8 symbol when bits are lower=
 than
> 64, add  matchpathcon_filespec_add@LIBSELINUX_3.8 when bits are 64
>
>
> Something like the patch bellow. Would it be too complicated?

We would need to match the logic used in selinux.h:
#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && \
        defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
#define matchpathcon_filespec_add matchpathcon_filespec_add64
#endif

Yet another option would be to allow overriding of LD_SONAME_FLAGS or
introduce another Makefile variable that is appended to it that can be
overridden so that the build system could inject --undefined-version
when linking with lld.

>
> 1. convert .map to map.in
> $ sed 's/matchpathcon_filespec_add64/@matchpathcon_filespec_add64@/' libs=
elinux/src/libselinux.map > libselinux/src/libselinux.map.in
>
> 2.
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index aeede2b56e8e..f397967657bf 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -39,6 +39,8 @@ ifeq ($(USE_LFS),y)
>         LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
>  endif
>  export LFS_CFLAGS
> +LONG_BIT :=3D $(shell getconf LONG_BIT)
> +export LONG_BIT
>
>  OS :=3D $(shell uname)
>  export OS
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 9982faada9ef..5cb104fe5576 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -158,11 +158,18 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^=
 -lselinux $(RUBYLIBS)
>
> +libselinux.map: libselinux.map.in
> +       if [ ${LONG_BIT} -lt 64 ]; then \
> +               sed 's/@matchpathcon_filespec_add64@/matchpathcon_filespe=
c_add64/' < $< > $@; \
> +       else \
> +           sed 's/@matchpathcon_filespec_add64@/matchpathcon_filespec_ad=
d/' < $< > $@; \
> +       fi
> +
>  $(LIBA): $(OBJS)
>         $(AR) rcs $@ $^
>         $(RANLIB) $@
>
> -$(LIBSO): $(LOBJS)
> +$(LIBSO): $(LOBJS) | libselinux.map
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(P=
CRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
>         ln -sf $@ $(TARGET)
>
> @@ -212,7 +219,7 @@ clean-rubywrap:
>         -rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
>
>  clean: clean-pywrap clean-rubywrap
> -       -rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o *=
.lo *~
> +       -rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) libse=
linux.map *.o *.lo *~
>
>  distclean: clean
>         rm -f $(GENERATED) $(SWIGFILES)
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p.in
> similarity index 99%
> rename from libselinux/src/libselinux.map
> rename to libselinux/src/libselinux.map.in
> index 95cd53b043c2..9a1b1736aca8 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map.in
> @@ -255,7 +255,7 @@ LIBSELINUX_3.5 {
>
>  LIBSELINUX_3.8 {
>    global:
> -    matchpathcon_filespec_add64;
> +    @matchpathcon_filespec_add64@;
>  } LIBSELINUX_3.5;
>
>  LIBSELINUX_3.9 {
>
