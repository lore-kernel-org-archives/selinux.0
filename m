Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795C3AFCE3
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218721; cv=pass; b=aBny/aKrU3yXcB7Y4b3l4HjCaqxpaNRxfBt6YAXF3SPtsRz4ojhX+Lou1uCAKPYAK36/xb3dI7ViQaOGJP7L7ieTWKDTN9wAPv5lP7J2b1ulLBGcTrr8/9Zo40GHOlj7QII5UD+Q4gBiOXMH+oL8j2qapa7J88qWy/tUIjZqQZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218721; c=relaxed/simple;
	bh=AE+zVKWD2tW46+mte5bUfqfGFvWe3bnuH5CNPcnuaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKAl1d+AoyTAIBcjxfjlbSAtI28SS3LFzcqiuOM7k6HfcYBqmTEzF1LyeWh+2uTOGYb9JFYc2Cwhmg5YBqSs3p/UcFZQQyQFxqM5g59/prh7ANKlUPVcKBDtIvF++8St8ixhi/Onam3w/UruVgW6069LcfioGGoL7qTm/5On+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxnFvWN2; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxnFvWN2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b4650d5f5cso15574065ad.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218719; cv=none;
        d=google.com; s=arc-20240605;
        b=JocE+/Wfr05waBff9AD8LMNoxMV2NL9j7xrOWixpKxv2s4hGa6oHpsJuL9pU+dil6h
         ukKnDO7v9J2g6WZmg5cJJ1C9+1ItG2vaK+umZs9Rnmy15Ydh/WkSd2am4cp5UDtTYRRb
         xpbUxRUri94TOm6xgry6f+4VoFhj1vbsj13ReHsWPbUu2Sm94hBx6kIHkGuOyfPTzVEi
         QoZk9pxj35Vpw3gTthnvOyYC0OKLe0SB2U6Q+No/DkhZ0DlBgyj15G9Oj0xe41CbfGf6
         HcnRGW+AHiIcwENm8DigFB7YS9jYebq69N7SIf9anFJ/57nT8S8ytVRkSbIKOewu993Q
         GNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwSQxbLGl5HNXY3tzooaCIoJuZBBDwE9V3ee5O2ULhE=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=B2jBS4tOqThXLuzIx0iazkfuFeEMeoCC1wrnWmGuDpGhV/AIaGOkfo0kuAdfEYbES4
         Z1QUZE64r09hr80OqR8LavSuwttIpD1s1wSdaXZGZyV1WwkY0p0UhoVIfYYOpvuFu9S0
         /5TG6B/tSwvJ8a8omIxM84jpIhM7eLzW8H1x9fKvS/WgLHzfT86FFXs8povG5bIfzLs+
         9jZmZL5JbvXe0PF3uVBCF9XNhWGhKJIwFDi2dA3C8n0GNzYthz9d1793W91kgVvU5sSL
         VJZmnLFRqFDomKwGSZ5PPP2C4C5UfQ5UCH0pUKLfQnfIRauNecahydMWRfH6UiREf873
         6PKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218719; x=1779823519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwSQxbLGl5HNXY3tzooaCIoJuZBBDwE9V3ee5O2ULhE=;
        b=qxnFvWN2NvUly8P/p8P/fYmUda8Ss+K6g/4Wxw5JUvlEQDH0C3KVzxxfJue5o6yxL5
         oHoQs1K/IhpcehCOeyAwPz79aG+WJERqUHHbmGnOyuhMxjirAnBmyy7QZ9Fc+GuCsQxu
         EV6/0zfuiS8nZiXpI9KzwPo1uLv9zzarDJiqNaTP2qFExPhSAST+pR8vxOwtwmMKzc1a
         wNa8Oo1PA0JH2jZcTu56ITBmVs4PDhErqtdyuk5ZdxEnX3DNVoF/N5YZOj6Iffip1/L+
         stEx4hGLsA7MKsKVp+2nIa8jr21zIfQprgZvApnFKJLGzwdpARDV9b2VN7XFP8YJPan8
         dnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218719; x=1779823519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwSQxbLGl5HNXY3tzooaCIoJuZBBDwE9V3ee5O2ULhE=;
        b=i1G7GW0CNMRjyTgNMZTrvHo3t2ZgdoXt1D4/+IkGPjeL8lZ5gMKfvNjNQDfaGLZUtq
         JvBf+xyyZVA8BAsUaQ1mQc4nV/am2l4dwEewkRFXHYgOjQC/MFUNi1yYnTzQ+WLdCSb0
         /xnYh+KPbc+28VE7eFduRLHX04hOQCPb2uVEdB+USp0SdEITIm5M370/Rb6YEJPzb1ic
         1qASCg5wEmsnzJU+/r1VKSrrkVN/1mnAnBFE4MjQFRzTTVlZduSKNLe7RMHlArA+2ai5
         ndaY0LUWHqeM355CoeMDHN/OJlnawT7/iajvu0veLNxkTovF4jNRt0DUst3leNdRFDCi
         ijbw==
X-Gm-Message-State: AOJu0YweEWEzh86bj2oybMNaFsFobiLFxKW5cJwSJpx9ZJ52259GNtFZ
	6Z5cAY0LeYHe7oTT4ffwGYvIkL2pCVUY1mLVZ5RDva20SnaWyu483TafBNa2nHaNWvhj5pB3vF8
	TgS6aTqtAZyQ24D6jRTQR6KRiFhE3Zvsaxw==
X-Gm-Gg: Acq92OGjHBEr6eLTXt3P17dANW8Gw01RfE3BMk+GnnWpdU2t5qZaBVIO54W5cZKGBf/
	JsmiaXoOd0e8hiUfGZIli06X2tlV7Dy30+V1qdsEqyKDQjeowmIthgZrwzX0kws++XERgMux++7
	O21LI4RTcQ1OpNNwYbiaYij1E83M9IvKQeM+TAXLFdptgsbQdpdb9sM5JHGBEng6Xcnrdr/BLx1
	e6BY70LrLyfi9vpXWuUEtk9/BuCe3iXD5kq1ccuO2mwLkSEx4DimTD26U6kDLMwKU+cE9j3/XjW
	73c1wuY=
X-Received: by 2002:a17:903:3508:b0:2bc:f202:54d7 with SMTP id
 d9443c01a7336-2bd7e9c575cmr221854775ad.38.1779218719003; Tue, 19 May 2026
 12:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163154.449162-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260519163154.449162-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 19 May 2026 15:25:07 -0400
X-Gm-Features: AVHnY4INjgsXNm19g_T9ohojSgsZFwW5DwDbe78X4G59w1CrUYFm7hbz1Jck_B0
Message-ID: <CAEjxPJ5ZDC2zTexckqdt1CNC_Vy7GXfZ9wJPBZNtq3-owmDq7A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: skip per-dirent fstat() when d_type is sufficient
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:45=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Profiling restorecon with perf on a multi-core SELinux-enabled host
> showed that every dirent paid an fstat(2) even when d_type already
> gave us the file type.
>
> In walk_next() skip fstat() when dirent::d_type is reliable, the entry
> is not a directory, and neither SELINUX_RESTORECON_XDEV nor
> SELINUX_RESTORECON_ADD_ASSOC needs st_dev/st_ino.  Directories and
> DT_UNKNOWN still fstat as before.
>
> This relies on the kernel/filesystem reporting an accurate d_type for
> non-directories (DT_UNKNOWN is handled by falling back to fstat()).
> The same trust is already implicit in find(1) and similar tools, and
> a buggy filesystem that mislabels a real directory as DT_REG would
> already break a wide range of userspace; directories are still
> verified via fstat() here for the cycle-detection and descend paths.
>
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 49 ++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 8b6eba0c..2c329ac0 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1040,6 +1040,24 @@ static bool walk_is_cycle(const struct rest_state =
*st, dev_t dev, ino_t ino)
>         return false;
>  }
>
> +/*
> + * Map a dirent d_type to the matching S_IF* file-type bits, or 0 if d_t=
ype
> + * is not informative (e.g. DT_UNKNOWN on filesystems that do not fill i=
t in).
> + */
> +static mode_t d_type_to_mode(unsigned char d_type)
> +{
> +       switch (d_type) {
> +       case DT_REG:  return S_IFREG;
> +       case DT_DIR:  return S_IFDIR;
> +       case DT_LNK:  return S_IFLNK;
> +       case DT_FIFO: return S_IFIFO;
> +       case DT_SOCK: return S_IFSOCK;
> +       case DT_BLK:  return S_IFBLK;
> +       case DT_CHR:  return S_IFCHR;
> +       default:      return 0;
> +       }
> +}
> +
>  static int open_final(int dfd, const char *name, struct stat *sb)
>  {
>         int fd;
> @@ -1189,13 +1207,30 @@ static int walk_next(struct rest_state *state, in=
t *ent_fd, int *rd_fd,
>                         state->pathbuf[top->pathlen] =3D '\0';
>                         continue;
>                 }
> -               if (fstat(fd, ent_sb) < 0) {
> -                       selinux_log(SELINUX_ERROR,
> -                                   "Could not stat %s: %m.\n",
> -                                   state->pathbuf);
> -                       close(fd);
> -                       state->pathbuf[top->pathlen] =3D '\0';
> -                       continue;
> +
> +               /*
> +                * Skip fstat() when d_type already gives the file type a=
nd
> +                * neither xdev (st_dev) nor add_assoc (st_ino) is needed=
.
> +                * Directories always fstat for cycle detection and walk_=
push().
> +                */
> +               mode_t mode_from_dtype =3D d_type_to_mode(de->d_type);
> +               bool need_fstat =3D mode_from_dtype =3D=3D 0 ||
> +                                 S_ISDIR(mode_from_dtype) ||
> +                                 state->flags.set_xdev ||
> +                                 state->flags.add_assoc;
> +
> +               if (need_fstat) {
> +                       if (fstat(fd, ent_sb) < 0) {
> +                               selinux_log(SELINUX_ERROR,
> +                                           "Could not stat %s: %m.\n",
> +                                           state->pathbuf);
> +                               close(fd);
> +                               state->pathbuf[top->pathlen] =3D '\0';
> +                               continue;
> +                       }
> +               } else {
> +                       memset(ent_sb, 0, sizeof(*ent_sb));
> +                       ent_sb->st_mode =3D mode_from_dtype;
>                 }
>
>                 int rdfd =3D -1;
> --
> 2.53.0
>
>
