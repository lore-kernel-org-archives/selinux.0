Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923916BE3A
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981197; cv=none; b=T9qgkmHDOVqDYPm35GQDlFtBTlWe/Qvmaqih6BIWSSJVbPTTNA/jpQzMog+EI8iaSbdutZxICBAjH7xwd8V9WTSsrjlGskT4I0tKYNWBkQHpb6LSXkoIFbbBfP6/TzAkoUCILN/WHCCZSrs/3CUnrwjN4YG3nHl2xeuQ+2Bglzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981197; c=relaxed/simple;
	bh=hNrlbtCKZXhihWuQ5khp6qGwD50he97exNwkB+3QyQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQYIlwQeAfan0bNG9c9WGFgCjBDy8tDAqfyngiYoeG4Z9pT9JO1IDjmDr6h+oDGnvgJ9eblCKZmZXp/ZXr7wLi0Zqcpx4ZFX57OSGw2YAfiAESyMrAP694nVUlcUOfSUXCgN++81/vz/8JuchSuC8U3MyqQrZ8BbwR4/S218peU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KWxdqRQ3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWxdqRQ3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3001e7d41c5so1360181fa.2
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 21:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733981193; x=1734585993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O+CLRqH6bo0+SkejrDnfuKjYLK9OI+F4FVOLEbF+4IM=;
        b=KWxdqRQ3NoeEueDvjuaTI+O1r9hsIf8dkj0p+UeDHsadrLDd57zNWnvnD7nb49HT8F
         HXPKD5ak3hxg2WLIjFSKufOpRDxfhoidvJoIazR7tOsMsf9qsWTfELFnL7f4YCkOEAWM
         MAdPQiFEIR9VhlZ74ua59Y9ifWLqOmg4Jo8ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733981193; x=1734585993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+CLRqH6bo0+SkejrDnfuKjYLK9OI+F4FVOLEbF+4IM=;
        b=UuYRTO2n6nGYqVuDUA/MyKfXdrbl4ds3NfpWoFJP337POSghdZHnUw3pWxQC2ibGLd
         gwie6ioB+hEcPI6hAtid2Cl5ppIwOorxZhn3pz6J0SRDk4h85K++G0dx9parDEX6zNga
         ZqDujfyd1bUnnNlo7ocP59mT6EEUCD6XJRNPfTWOrS49THxVEuZ+888ObzEikl/3O0sn
         Zf0LQqj3tXDLovZ+XQRGJNCQMw+yjQqSlWyUXzcAhKh11b+OQYJqRVMj3vlpK9xgb+z1
         ISnhIlvawE7rp8dGPQ9YLGAlv1dUlv0BfwM5B/RNxFzXu4Pu6JAWMvfoWkyFUIgQvXRm
         PdCw==
X-Forwarded-Encrypted: i=1; AJvYcCW77NjFutfp3gjy07bOI0hbgqCRjduKNiSGGCc5Rol3MKt9yR88KXhSSNMDp55Y80rYEmZTr7Bb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6MfTHtGjO+MB7G73CyBo0wJXbdp7nSPH2SHJeewKJ5qh6daz
	6jW3gisWwaTCfCtnmI3z7AbGnBFnuukbmIvXLwuElaHY53bFwH9ZW+Ynr+5Zc7MUkJxeYjX05jv
	KwHzVxaswcd8+q4IhcURmB+fwQsvH5E+APvU=
X-Gm-Gg: ASbGnctoSNu5euYtlLH8a4aBM5i222ovmMwL0lLfIH7MQkrj42GqVPdHIFw9MVXkdQc
	lhlZ2eOn+QSlsbe9LsUjxadU0DFEeNp4h+0u5y5gi4aQLJLG+ACRQn1WefpV7ObnxOJ4=
X-Google-Smtp-Source: AGHT+IFV93rTmNwzAk1XZbKiE5Aroq295aEkFK/JtMMGtloaDjOl8vjnUfppbjHLIE0lTrU7yS06aKTuDffDXieuPU8=
X-Received: by 2002:a05:651c:507:b0:302:1c90:58e4 with SMTP id
 38308e7fff4ca-3024a203c65mr4993551fa.16.1733981192766; Wed, 11 Dec 2024
 21:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org> <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com>
In-Reply-To: <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Thu, 12 Dec 2024 14:26:21 +0900
Message-ID: <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I would like to hear from the policy and toolchain folks on this idea before
> we go too much further with this, but I did take a quick look at the patch
> and left my comments below.

Thank you for reviewing this patch. Could you let me know the relevant folks
who could provide feedback from the policy and toolchain perspective?

> > +static int str_read_with_padding(char **strp, gfp_t flags, void *fp, u32 len,
> > +                              char padding)
> > +{
> > +     int rc;
> > +     char *str;
> > +
> > +     rc = entry_read(&str, flags, fp, len, len + 2);
> > +     if (rc)
> > +             return rc;
> > +
> > +     str[len] = padding;
> > +     str[len + 1] = '\0';
> > +     *strp = str;
> > +     return 0;
> > +}
> > +
> >  static int perm_read(struct policydb *p, struct symtab *s, void *fp)
> >  {
> >       char *key = NULL;
> > @@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, void *fp)
> >                       if (!newc)
> >                               goto out;
> >
> > -                     rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
> > +                     if (ebitmap_get_bit(
> > +                                 &p->policycaps,
> > +                                 POLICYDB_CAP_GENFS_SECLABEL_WILDCARD))
> > +                             /* Append a wildcard '*' to make it a wildcard pattern */
> > +                             rc = str_read_with_padding(&newc->u.name,
> > +                                                        GFP_KERNEL, fp, len,
> > +                                                        '*');
> > +                     else
> > +                             /* Prefix pattern */
> > +                             rc = str_read(&newc->u.name, GFP_KERNEL, fp,
> > +                                           len);
>
> More on this below, but it isn't immediately clear to me why we need to
> have the special handling above, can you help me understand why these
> changes are necessary?

Sure. Thank you very much for the comments.

> I understand you are "marking" the wildcard entries with a trailing '*', but
> since we are calling match_wildcard() in __security_genfs_sid(), why not
> fully embrace the match_wildcard() capabilities...

Currently, genfscon rules perform prefix matching (e.g., `/sys/dev` matches
`/sys/devices`). Directly using `match_wildcard()` would not preserve this
behavior, as it does full match. To maintain compatibility with this existing
prefix-matching behavior, the trailing '*' is added.

> capabilities and allow arbitrary '?' and '*' wildcard matching if
> present in the policy's genfscon path entries?  If we do that, we can
> drop most (all?) of the str_read() changes and simply check for the new
> policy capability when reading the policy, yes?

It allows arbitrary '?' and '*' in entries. The purpose of the trailing '*' is
to keep the prefix match behavior as I explained, which does not conflict with
user's metacharacters.

> >       for (c = genfs->head; c; c = c->next) {
> >               size_t len = strlen(c->u.name);
>
> We don't need to do the strlen() computation in the wildcard case.
>
> > -             if ((!c->v.sclass || sclass == c->v.sclass) &&
> > -                 (strncmp(c->u.name, path, len) == 0))
> > -                     break;
> > +             if (selinux_policycap_genfs_seclabel_wildcard()) {
>
> We should pull the policy capability check out of the loop.

I totally missed it. Thanks. I will update my patch based on your draft.

> > +                     if ((!c->v.sclass || sclass == c->v.sclass) &&
> > +                         (match_wildcard(c->u.name, path)))
> > +                             break;
> > +             } else {
> > +                     if ((!c->v.sclass || sclass == c->v.sclass) &&
> > +                         (strncmp(c->u.name, path, len)))
>
> Shouldn't this be 'strcmp() == 0'?
>
> Did you test this change both with and without the policy capability
> enabled?

Thank you for catching that. My testing was insufficient. I will update this as
well and retest.
