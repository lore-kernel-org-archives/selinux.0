Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A782CDB465
	for <selinux@archiver.kernel.org>; Thu, 19 Oct 2023 20:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbjJSU14 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Oct 2023 16:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbjJSU1z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Oct 2023 16:27:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D3C131
        for <selinux@vger.kernel.org>; Thu, 19 Oct 2023 13:27:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b95622c620so19042366b.0
        for <selinux@vger.kernel.org>; Thu, 19 Oct 2023 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697747271; x=1698352071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXMBydNWgfKvIQZzfKmzDyoM2wdQL8a1Zud7MgoomgA=;
        b=Z6B6pF7kxr+QNK7KqpG73DdoLMXveI7V1w0G+xhFqdcLMOd8awbRzSyTuoni2Jni9d
         tPGDLi/EpCoJMRSTw2Hg4oSTqG+FAZBOyNGO6FqFQ0W32gjiv+sljahZVcmFBZdde/g+
         Xfrmw6slhm9YZkLLtLtlyPb8+AJjYwoQgilm7JIeIS3BwI1I0u1qKJvNX1G3Yh95PKrM
         ii+FRUR4FVig8AeTiWTBU8+VWIqEkMcT9BA5MwT0qVNxCgwYssQT8r1/oXrG94zDueb1
         vGTGmL/6V17lrKSJ0aGYlWOsr1BMF0gRe79klMyrIEK4rER5Sh/7kh5bEFhaBo61/C2Z
         Gamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697747271; x=1698352071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXMBydNWgfKvIQZzfKmzDyoM2wdQL8a1Zud7MgoomgA=;
        b=WeJMXWg/ZoK7fWLSbdjomdBlc6yI0W2UlHphhkNXnM+sfwMNYKtLIsYJbSra+jFtZc
         ao3XDNk02Me3luy8j8g4Mrg3JiCBD7hjozIbw7GHF5jokxiNRm/j9vkLWlAQ19UmyIaS
         YyyZh/qdbTCyff2Yq8sQqIz9BtwNwR4VRSWyumil1/DtWeT+x0CPb+kwfPAB5jQnEw3C
         ePGmK84A4VP7wfTiyYXu4W0Dy7vIZuaQ+WIW5a663GCbnh7JgXdxK6r4lO13QoiS7L9d
         FM3MVMmMDWmUK/zqibHh7xoGshenX5PbyxuPD/yWUKxbFp00FO5wyTRT0CQJha8Hab/B
         xNSg==
X-Gm-Message-State: AOJu0YzqP03l1dYt4Ao8XyEv9uObdfWfFAkRCXr/XhJCJjlpB8Nmrdnc
        u58uKW31r8KeYey9B3ntAhxcfsQWkHRfdLVbnGX1v0Ia
X-Google-Smtp-Source: AGHT+IF8ge/AWv4rkcZTDBYsY7nHr0AGy1o2Yy4ZD+2nsyiRdPXMeeTB2rj3Z0ZHaLVNl18Z4OwcZMmYbC5UdvZvUP8=
X-Received: by 2002:a17:907:7254:b0:9be:ca44:87b6 with SMTP id
 ds20-20020a170907725400b009beca4487b6mr2576175ejc.3.1697747270791; Thu, 19
 Oct 2023 13:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231018175744.39667-1-jsatterfield.linux@gmail.com> <20231018175744.39667-3-jsatterfield.linux@gmail.com>
In-Reply-To: <20231018175744.39667-3-jsatterfield.linux@gmail.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Thu, 19 Oct 2023 16:27:39 -0400
Message-ID: <CALMFceuHTg9hDYd9RgB5y3cUM3wewRppMW1twbeyWLa0gp2UMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] selinux: avtab iteration macros
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 18, 2023 at 1:58=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> Similar to the list_for_each macros in list.h, this patch adds two
> macros that iterates an avtab_node linked list (avtab_chain_for_each and
> avtab_chain_for_each_prev). This has two benefits: it reduces the amount
> of duplicative code for iteration and it makes changes to the underlying
> hashtable data structure easier as there are fewer places to update.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 697eb4352439..f0d448e7807a 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -27,6 +27,13 @@
>  static struct kmem_cache *avtab_node_cachep __ro_after_init;
>  static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
>
> +#define avtab_chain_for_each(pos, tab, slot) \
> +       for (pos =3D (tab)->htable[slot]; pos; pos =3D pos->next)
> +
> +#define avtab_chain_for_each_prev(pos, prev, tab, slot) \
> +       for (prev =3D NULL, pos =3D (tab)->htable[slot]; pos; \
> +       prev =3D pos, pos =3D pos->next)
> +
>  /* Based on MurmurHash3, written by Austin Appleby and placed in the
>   * public domain.
>   */
> @@ -129,9 +136,7 @@ static int avtab_insert(struct avtab *h, const struct=
 avtab_key *key,
>                 return -EINVAL;
>
>         hvalue =3D avtab_hash(key, h->mask);
> -       for (prev =3D NULL, cur =3D h->htable[hvalue];
> -            cur;
> -            prev =3D cur, cur =3D cur->next) {
> +       avtab_chain_for_each_prev(cur, prev, h, hvalue) {
>                 cmp =3D avtab_node_cmp(key, &cur->key);
>                 /* extended perms may not be unique */
>                 if (cmp =3D=3D 0 && !(key->specified & AVTAB_XPERMS))
> @@ -163,9 +168,7 @@ struct avtab_node *avtab_insert_nonunique(struct avta=
b *h,
>         if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
>                 return NULL;
>         hvalue =3D avtab_hash(key, h->mask);
> -       for (prev =3D NULL, cur =3D h->htable[hvalue];
> -            cur;
> -            prev =3D cur, cur =3D cur->next) {
> +       avtab_chain_for_each_prev(cur, prev, h, hvalue) {
>                 cmp =3D avtab_node_cmp(key, &cur->key);
>                 if (cmp <=3D 0)
>                         break;
> @@ -180,16 +183,13 @@ struct avtab_node *avtab_insert_nonunique(struct av=
tab *h,
>  struct avtab_node *avtab_search_node(struct avtab *h,
>                                      const struct avtab_key *key)
>  {
> -       u32 hvalue;
>         struct avtab_node *cur;
>         int cmp;
>
>         if (!h || !h->nslot)
>                 return NULL;
>
> -       hvalue =3D avtab_hash(key, h->mask);
> -       for (cur =3D h->htable[hvalue]; cur;
> -            cur =3D cur->next) {
> +       avtab_chain_for_each(cur, h, avtab_hash(key, h->mask)) {
>                 cmp =3D avtab_node_cmp(key, &cur->key);
>                 if (cmp =3D=3D 0)
>                         return cur;
> @@ -229,7 +229,6 @@ void avtab_destroy(struct avtab *h)
>                 return;
>
>         for (i =3D 0; i < h->nslot; i++) {
> -               cur =3D h->htable[i];

This line can't be deleted. It will be restored in the next spin.

>                 while (cur) {
>                         temp =3D cur;
>                         cur =3D cur->next;
> @@ -307,10 +306,8 @@ void avtab_hash_eval(struct avtab *h, const char *ta=
g)
>                 if (cur) {
>                         slots_used++;
>                         chain_len =3D 0;
> -                       while (cur) {
> +                       avtab_chain_for_each(cur, h, i)
>                                 chain_len++;
> -                               cur =3D cur->next;
> -                       }
>
>                         if (chain_len > max_chain_len)
>                                 max_chain_len =3D chain_len;
> @@ -593,8 +590,7 @@ int avtab_write(struct policydb *p, struct avtab *a, =
void *fp)
>                 return rc;
>
>         for (i =3D 0; i < a->nslot; i++) {
> -               for (cur =3D a->htable[i]; cur;
> -                    cur =3D cur->next) {
> +               avtab_chain_for_each(cur, a, i) {
>                         rc =3D avtab_write_item(p, cur, fp);
>                         if (rc)
>                                 return rc;
> --
> 2.41.0
>
