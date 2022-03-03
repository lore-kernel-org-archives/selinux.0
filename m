Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F88C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiCCSWa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCSWa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 13:22:30 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DF1A39D9
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 10:21:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id u17-20020a056830231100b005ad13358af9so5298417ote.11
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 10:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBWunf/kyrsx1t9n8wZuDDCwYixrCvGwHFOVCQBdSC0=;
        b=RvVJfAr7NnsF/szol48OBMmyzJVtWovxS4P8GIyJ7ywJ73oslbVZxDkb5MA+4tadfm
         Fi0IxC9PaM1cO+DUBRDrlXizW+f/borpYNwk3ki0iXTdOgxBrI81qhlNLL3pfmS/gYwf
         FvBw7RPwFZ5J2y/IeOPYP+P7gcDkIegEajl+2wOdmlx8DxC6T6GkkO8kb1yu7e49c7XN
         qqg3REc/iCygFQETsiP7CUra03f8dH/BXr4Nrbh7xqTEbLaEeGwABNV45yqtV14R5UBF
         6zYq0u3MzqbbDhSMg7ZM0xebYqgmDEODR1v1pfTIiH7mRqN7BXOvZg18SIkvayofruK5
         Sirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBWunf/kyrsx1t9n8wZuDDCwYixrCvGwHFOVCQBdSC0=;
        b=za8zKMgaflKzlIyjvaxw+/sNQH/hw5CN6wxz0je5MfKkMl+ozJyHcealFp704a1xYO
         etNbPHPpuGeuvTpHN7D44o5Tc0qcHnk0fbFbUFl0HRV1PzWfS6v2vPfaL09lEO0CQ4Fx
         JIgfYYBBoDAOwGroR1xrcASXFhZz/uJX2AKayMtsTPMya3iA1VKZ6Dydnry+3h03s6IP
         +auTqxK9rQZk/N7ZY3mSSFvgBrABfvePocxlzFj1jRY9QyGwxTENijwcM9slWSSNA4TN
         7dIGkPEic5jt3o+/7LGivPeo+Oq2ie0b7PoQurww8cqtHX0IH8lNYetiacQZuxF5pnjJ
         aCrg==
X-Gm-Message-State: AOAM530b+dUkSKplchF2dEqoBbqeUh/oq19Al50kwzpjDJ9OQ7XkCWgo
        H6Pw6FSVOh6PqhQArdV4KP5GF+M+mKq79W05dq8=
X-Google-Smtp-Source: ABdhPJyWN+eKxonFCJQhAFU5JsHPdCKOGTIjNZQ6nBOHH2Ny+1wC3+P/pqLpjYc7/57ArHchUn1GRFJHSz1npOgGbOU=
X-Received: by 2002:a05:6830:2390:b0:5ac:19a3:4888 with SMTP id
 l16-20020a056830239000b005ac19a34888mr19941389ots.53.1646331702669; Thu, 03
 Mar 2022 10:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20220222134956.30277-1-cgzones@googlemail.com> <CAP+JOzQ2EJoYb_tZ2LLr8OLuq7owTmQwP8-zzv7uXzy3bqWXAw@mail.gmail.com>
In-Reply-To: <CAP+JOzQ2EJoYb_tZ2LLr8OLuq7owTmQwP8-zzv7uXzy3bqWXAw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 13:21:31 -0500
Message-ID: <CAP+JOzTSSx=XD9hCgE8akUERGbBC4ryyYqNREycSNV9oUjsTkQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: NULL pointer offset fix
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 28, 2022 at 4:54 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Feb 22, 2022 at 10:36 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On the first loop iteration the variables `r_buf` and `reason_buf_used`
> > are NULL respective 0.  Please UBSAN by not adding them but instead
> > directly assign NULL.
> >
> >     services.c:800:16: runtime error: applying zero offset to null poin=
ter
> >         #0 0x4d4fce in constraint_expr_eval_reason ./libsepol/src/servi=
ces.c:800:16
> >         #1 0x4cf31a in sepol_validate_transition_reason_buffer ./libsep=
ol/src/services.c:1079:8
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/services.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 7becfd1b..29723729 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -797,7 +797,7 @@ mls_ops:
> >
> >                 for (x =3D 0; buffers[x] !=3D NULL; x++) {
> >                         while (1) {
> > -                               p =3D *r_buf + reason_buf_used;
> > +                               p =3D *r_buf ? (*r_buf + reason_buf_use=
d) : NULL;
> >                                 len =3D snprintf(p, reason_buf_len - re=
ason_buf_used,
> >                                                 "%s", buffers[x]);
> >                                 if (len < 0 || len >=3D reason_buf_len =
- reason_buf_used) {
> > --
> > 2.35.1
> >
