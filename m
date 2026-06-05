Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75753416CF9
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676712; cv=pass; b=EyBOOtiHc6O+8/JOaKVt1KXo+ofbfobJs56vkWtJzf8oP1s/wZVD8NgrpDPtVy/kt0uW4CfcGPLjwjAFGsLeddg1F10+nHfWjSLa/BYAPn1BEQrkkBpkMYMDihw+9mTNcdWpdIWL70zFELsbL66lvZnTm7nOdz4s3u05lDGpCNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676712; c=relaxed/simple;
	bh=Erzxq2fydajUoUK0AWLJ/JPI2kwOv12ZyiRRt+y+5Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1bAdf/cjZp5Fu/+SFb3u5Wg4x0nKxeJ72tTRCE7S+xqkj/ZEnG8OlCDqrjJBw64DJjve81RsiXhScjXMXL0JS+Ncm7e0zPiTnHFAEUMqL6xA9N8LjvJiJZTQL7DuQawqbHcvOI1B6uJWMj1A7eQL1K9JLs8KmA4nqPZE4bDMhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utsi6+SZ; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utsi6+SZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so1514704a91.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676709; cv=none;
        d=google.com; s=arc-20240605;
        b=lvofs6wphpnFiO9QLmfD9M8wEJurVMcDYNiI291nXkZ2qNCQqKTQWWJ356srenk7j9
         gaCpQJKRvVONnJXnnuJt3k4kVK5Q0em8gPu0DX3Q2mkBqf0M5BUpYiOvfapZTVJ8Apjr
         6ESesHLsZDn8MQ5Q0Yngb88N1EVfMBqoy278Cp23g8FNGRRTLllNnYOrmP3vfaTEcH/D
         7BxaGONbMiMRhVwTNONGgKqD6eZqfGo/MzGwaJXTYkmGrK5NnXPbquayDb7KJnt7jD2K
         ZyncSSHFgaNA5TPDJmKTstDuQjn13fqlHHmbtDEtbB8332PIKOm0mqdpQhC03D3eOorI
         PC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFXYU3lDfPjaRGHSZ1NnckAjAn9F5wLMaGlSOe8dXW0=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=Wx3HoHSSlArHDFpkE4DXyK3kk1AkB2znNE7OACOHgfsAYyu3mwV0rz3uCh/nZXbaEU
         Oap5uAVTN4zT6CcG1jxjEFJy30pZoJXBqFpuK9xjjKcX+qgFg2gu/KGiXOhugBgn24RV
         bSiGUh9xyX0aVhQcBJTiA+bgtPFjAIbc7iZP3RhkfUIVkPv7coa4l/gLL7GaAk4xJXlJ
         Yqc8MhKFpt9xJrDnc2IH6XcFMv3xbPHslQyAQ0o0xTRzZ4mOIeYSfSTss0x1xCfVYM++
         OhNPUboWURrvRliYyz7n6yjSzRbbQM7A9A1w/hk24hcJd+u2K3eeUogQCtEeqVtQabyM
         8Gew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676709; x=1781281509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFXYU3lDfPjaRGHSZ1NnckAjAn9F5wLMaGlSOe8dXW0=;
        b=Utsi6+SZJ2hJBUNNDevGAba0qV3HCOWyZpV+VMmPbbYSgoSdD03fHqFMkkY1KrYIWg
         cVEeJtdM9lx6d2+To7kmjfV6HJa5bh1ZIWRHq1BPq2RdCAxcHfmtWqWPCfREPlVk7gUx
         +uEcKfZD+TfSse/PmDY9SGMgKWUgNTejq58aH+7AZmwZqAqssKzt7ntIVZuj4ROOQoHM
         4QvcaAyU8sPkmVFTKhrWDQrHpmcocwyDnhEDS4S45BdOn1VJ8okdwePjnHjWvkencFyb
         axISvS/UCW2+Hv7tO3zdx+jHRWmkqh9lDpgrD35kU6B79HGvtnmg98PIzpkWHl/3O83l
         d3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676709; x=1781281509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFXYU3lDfPjaRGHSZ1NnckAjAn9F5wLMaGlSOe8dXW0=;
        b=E4DRLZ6xbkoWiAG9rTBfCt38RoWS+nNo/1XmFuA/7S8Z9Mlehkjg2B2qgydhYgxsQG
         DnynGGXiPV8n6gP+gr3K0himS9qatkOepn/HJ9kygneC1jKCu6Xzq8TBTizqm4qJ0Ncw
         3UfN7NoBqio9Jw0JqmEdnHtXSUBGRXWMc6oiRes5dkmYGLXtCO1UC1comlpHIVWtWItK
         nGxa75a/vy41OpVL7FsRrfA3eXZMbGQi4qgjvltsfuHjPdudayXodd2PikKi66/IYHZ9
         FtwkWsgDK0K96HGZg4dkzbw7lLP/phAqOb1uo2oBnKJiaLd2Fc8vLLZNw1J5gYLpx+fg
         0Z0A==
X-Gm-Message-State: AOJu0YyIPynsf/XPVRqUrOEaLTiGNdDKg0lUiX6H3xSrRy193AI1zQ7/
	CG+O1tjdK07iCyCl0zpSrInbwJDcSLMt/IYubogwkt24SCqOAv7GNe/az87tkf2hKyID8OwfHrf
	gZOnGgFYDJfZ/hrNoLKxHC8RWKzGlTgaWnA==
X-Gm-Gg: Acq92OG6eKrLpS4gJYbjRyoKgm2kB32jNRWkIN+V+LkhL0X76xsK5yjJuWVJgjl3B+Z
	0LfApluyuoPhPnf0ZMdycyuOkWMf1GzLSAWUbtiNsBtcGp8Znw8pyQTcSx05xnj51jl0F2ClOxn
	VlFzCvPQT2gXHkj2wqWNH6gMiztTpy98OUKa3R/jlWi3sut+UQWnoOE4rcanWP9dTzyxlisX+rs
	Y7IGxv/wK/61xHIBupKBNRlU4Q/IThelu1phkckeAzbxZJnObNNHp/4QOHFAezuKd4pZOx5bJuP
	IYwSfzHCdlLT6j20hg==
X-Received: by 2002:a17:90a:d40f:b0:36a:a16b:5f65 with SMTP id
 98e67ed59e1d1-370ef1f3d01mr4945367a91.11.1780676709565; Fri, 05 Jun 2026
 09:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604171912.263475-1-stephen.smalley.work@gmail.com> <CAP+JOzRJnb+3AegCrUrmf=2eS9Ax+Enm65uFOy7iPqOe+ZfGng@mail.gmail.com>
In-Reply-To: <CAP+JOzRJnb+3AegCrUrmf=2eS9Ax+Enm65uFOy7iPqOe+ZfGng@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:24:57 -0400
X-Gm-Features: AVHnY4K5-4Vr0W8F6Wo81h0OI_KK-4CpIhMFmsX0AazVnHmyCPAZefd9PPoA3Ms
Message-ID: <CAEjxPJ7=LtHp=D660a_G0KTXZLZG7Pe5xW_RBOmaxV3UM2Bteg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selabel_close: only call func_close if set
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:32=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:19=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > func_close is assigned by the init handlers and may be NULL
> > on an error return from an init handler prior to setting it.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libselinux/src/label.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index ad40440c..dcbd60ab 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -394,7 +394,8 @@ void selabel_close(struct selabel_handle *rec)
> >  {
> >         if (rec->digest)
> >                 selabel_digest_fini(rec->digest);
> > -       rec->func_close(rec);
> > +       if (rec->func_close)
> > +               rec->func_close(rec);
> >         free(rec->spec_file);
> >         free(rec);
> >  }
> > --
> > 2.54.0
> >
