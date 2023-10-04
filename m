Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ECAE7C4E2
	for <selinux@archiver.kernel.org>; Wed,  4 Oct 2023 17:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbjJDRDv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Oct 2023 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbjJDRDv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Oct 2023 13:03:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD82E9B
        for <selinux@vger.kernel.org>; Wed,  4 Oct 2023 10:03:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so7860466b.3
        for <selinux@vger.kernel.org>; Wed, 04 Oct 2023 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696439026; x=1697043826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad9X8tODvlYMQYc8VkCmd8Y6FtHYKbtaoOsScL5rsHg=;
        b=iYyn61eEaJ+LkcA6br2MgbHfkQ61SA2JsLnQbCu3lsq90L2QhhxcSSDpxNkGymfQ35
         WgUMk3NeGs8IgqDk0ounYAZaiwXCyzjTCfI7hqHMOO0f6ihDbnWbgvWsnOV+hlfX13IT
         K97Vnysd/h7VgM5CgVLjvqO2O/IoPCVikqkRJUJqTsfeAkDgHfU4XBtJiuxJCQlCLQr8
         1r/nUJE8LM89uqtCXA+QjceBYul3lVaauGyBWN2S4dqfM1p1+vj8+3/hCZ09TAT7NGUt
         EqefLAycMhqxSF4+b/OXCI7USnlh/P1ee4U+s8Yg+JxYZ1hV2J2mIS8dnVhXthQWl4wk
         ruVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696439026; x=1697043826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad9X8tODvlYMQYc8VkCmd8Y6FtHYKbtaoOsScL5rsHg=;
        b=Yyte5BcFL7NMp6mIzaWup7aEvTWrJrbUVtnZL3tk78DlcRilvpkcahPxiWC9RUbUO8
         n3rMLznMfL5X1cEZVXF01YAtwgF7C2yRREZSdIie68kFAdOBYYl3o3yprKcgfs/dDw8u
         jmrTbFQdrTT2m5wFCopkRyWLa4o8+vbROkYT4cRY2Bs79FHu80A50/X9vZsazEpABbno
         rJ1D7j1sTWWYY49gF9ikWYqyWed+y6xZUR85yXsBy0AJAuQcRQZgm6bIkDQuU1h0Ea8P
         E3375263tpt/K/ylXnRSZcW4K0kWKZM9pygru+oOSA0TO7zgvS6IR+A2WVNTjX+demlC
         jfEg==
X-Gm-Message-State: AOJu0YyzfUEDSZcE93Efgw2/cUZ6jNOuESWRM1dnPTldcM8K7QasrOuu
        DQXJnhx9yUcp5RMhkjopy3Qe6QnhWP6rtSXNtotmBNUV
X-Google-Smtp-Source: AGHT+IFxjr7cQ4owX3n99+iiXaU7pC7isaHcCmHcmsZTJ9wHCvFwpT8U6GDo4+PpOKA8AGOjUCGOIN4rWgTDr3WvGd8=
X-Received: by 2002:a17:906:5a66:b0:9b2:93c1:72dd with SMTP id
 my38-20020a1709065a6600b009b293c172ddmr2475877ejc.36.1696439026032; Wed, 04
 Oct 2023 10:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
 <20230929195617.65120-4-jsatterfield.linux@gmail.com> <CAEjxPJ6Coi8y3xjNiP4GJ2YMOqAn8zHjet9F6LLuJJah9E1zZw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Coi8y3xjNiP4GJ2YMOqAn8zHjet9F6LLuJJah9E1zZw@mail.gmail.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Wed, 4 Oct 2023 13:03:21 -0400
Message-ID: <CALMFcetaFtRJuxBkyPvWTpRF2ojHDhjzx0f1VZmimz65bfKL7Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: avtab iteration macros
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 2, 2023 at 10:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 29, 2023 at 3:56=E2=80=AFPM Jacob Satterfield
> <jsatterfield.linux@gmail.com> wrote:
> >
> > Similar to the list_for_each macros in list.h, this patch adds two
> > macros that iterates an avtab_node linked list (avtab_chain_for_each an=
d
> > avtab_chain_for_each_prev). This has two benefits: it reduces the amoun=
t
> > of duplicative code for iteration and it makes changes to the underlyin=
g
> > hashtable data structure easier as there are fewer places to update.
>
> You will need/want an equivalent to list_for_each_safe() or open-code
> it to handle avtab_destroy() below.
>
> >
> > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > ---
> >  security/selinux/ss/avtab.c | 40 ++++++++++++++++---------------------
> >  1 file changed, 17 insertions(+), 23 deletions(-)
> >
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 1cd4fed30bf7..e8046eda7140 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -223,20 +223,17 @@ avtab_search_node_next(struct avtab_node *node, u=
16 specified)
> >  void avtab_destroy(struct avtab *h)
> >  {
> >         u32 i;
> > -       struct avtab_node *cur, *temp;
> > +       struct avtab_node *cur;
> >
> >         if (!h)
> >                 return;
> >
> >         for (i =3D 0; i < h->nslot; i++) {
> > -               cur =3D h->htable[i];
> > -               while (cur) {
> > -                       temp =3D cur;
> > -                       cur =3D cur->next;
> > -                       if (temp->key.specified & AVTAB_XPERMS)
> > +               avtab_chain_for_each(cur, h, i) {
> > +                       if (cur->key.specified & AVTAB_XPERMS)
> >                                 kmem_cache_free(avtab_xperms_cachep,
> > -                                               temp->datum.u.xperms);
> > -                       kmem_cache_free(avtab_node_cachep, temp);
> > +                                               cur->datum.u.xperms);
> > +                       kmem_cache_free(avtab_node_cachep, cur);
> >                 }
> >         }
> >         kvfree(h->htable);
>
> This requires an avtab_chain_for_each_safe() or similar since it frees th=
e node.

Great catch! Since this separate macro would only have one invocation,
it would make the code less readable without any benefit. I have
reverted the changes to avtab_destroy() for the next spin.

Thanks!
-Jacob
