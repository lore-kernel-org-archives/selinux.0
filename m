Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85483C352A3
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5449F20714
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjj6E3eT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBJPA4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:00:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726627AbgBJPA4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581346855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crlMAz7ofSaWCZiPkkdJHIdTUX9iQr+BqxnFAvkK2JY=;
        b=fjj6E3eTPlIW9JpqjdwqswHo9MJXc8Eg5cn3n+TVBEJrt9dyOISwZZSBMoLj0/GAx0OQOm
        Zk+xS9af0pe3tQzLoIvMPgDFo9mEbzlZCFZ0RrAjH/8vgB7v36KM2buRM13cHiML3NGavG
        ljs5KAItOjR4NCv57kWmgSOXtfSbd1U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-_lBKeX0RO0-Ptt76wMxPPw-1; Mon, 10 Feb 2020 10:00:39 -0500
X-MC-Unique: _lBKeX0RO0-Ptt76wMxPPw-1
Received: by mail-oi1-f199.google.com with SMTP id 21so4407103oiy.15
        for <selinux@vger.kernel.org>; Mon, 10 Feb 2020 07:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crlMAz7ofSaWCZiPkkdJHIdTUX9iQr+BqxnFAvkK2JY=;
        b=Vp1tWqSORQMMTijoGbZmADwN1n5RnGsWH7XtbIbNBa5DUVtGFoSmsoozNjSUn3hFE3
         pwOx/agA6fzX09kqpNI6epKxN+Fe5vXcvMQMOWlB+aOcjj0krFkG3VLvDBRcMM8ssB0l
         ulZRDBMuGOgUiQtweDRPqViasLZBhju8oqewmyBftworXF+Ko/kUBNrdOIIAfNsRVg14
         PEDwkj4Lm3Rzs6lC8XfUQI3ts9DFOizLL9P7NA+j0vGWUk5iUh4Ib0tTFIC5cpZzXtpo
         cz1IjcsoCRJynUm4HjzRXLuHsBCCbeOJE1jsNrJpBlLbLt8aFPmqpenHDIlr8j4z9h5L
         rsHQ==
X-Gm-Message-State: APjAAAUPDPAyc+/QtmTLUi0WvKExKFVhsAisJTxOb7R4cCK9CLH3MYAm
        rnZDJpNVcQWd38OtfeWtCsi0Ki6eSsL8zspuBR4rW7JNkPADrzDRhzhj/Vn+Qw65QKYvSGCpWnF
        dFz27vqElOkc8gr7cEufl+LMV0bVWcEgbsw==
X-Received: by 2002:aca:1108:: with SMTP id 8mr1072943oir.127.1581346838874;
        Mon, 10 Feb 2020 07:00:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7C2UZ85wGKzNWFnJq9dgI3c2l4ZIYV0f12QMDSM1hlBFTsoV71sEjUJO2lAuGSvYWipLH9pHsnbbHwnOEFlI=
X-Received: by 2002:aca:1108:: with SMTP id 8mr1072920oir.127.1581346838513;
 Mon, 10 Feb 2020 07:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20200208073607.21229-1-plautrba@redhat.com>
In-Reply-To: <20200208073607.21229-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 10 Feb 2020 16:00:27 +0100
Message-ID: <CAFqZXNufhUP7XJ1p0Te_AjVKZJpcyRi0QFyN4YdePkFZ6k3-iQ@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I haven't looked at the whole patch properly yet, but noting what I
found so far (see below)...

On Sat, Feb 8, 2020 at 8:36 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
>
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> v3 changes:
>
> - check return values of context_range_set() and context_str()
> - do not add duplicate entries to reachable contexts
>
>
> libselinux/src/get_context_list.c | 219 ++++++++++++++----------------
>  1 file changed, 103 insertions(+), 116 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e46589f30..cc39f8c6a96c 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c

<snip>

> -static int get_context_order(FILE * fp,
> +static int get_context_user(FILE * fp,
>                              char * fromcon,
> -                            char ** reachable,
> -                            unsigned int nreach,
> -                            unsigned int *ordering, unsigned int *nordered)
> +                            const char * user,
> +                            char ***reachable,
> +                            unsigned int *nreachable)
>  {
>         char *start, *end = NULL;
>         char *line = NULL;
> -       size_t line_len = 0;
> +       size_t line_len = 0, usercon_len;
> +       size_t user_len = strlen(user);
>         ssize_t len;
>         int found = 0;
> -       const char *fromrole, *fromtype;
> +       const char *fromrole, *fromtype, *fromlevel;
>         char *linerole, *linetype;
> -       unsigned int i;
> +       char **new_reachable = NULL;
> +       char *usercon_str;
>         context_t con;
> +       context_t usercon;
> +
>         int rc;
>
>         errno = -EINVAL;
> @@ -180,6 +158,7 @@ static int get_context_order(FILE * fp,
>                 return -1;
>         fromrole = context_role_get(con);
>         fromtype = context_type_get(con);
> +       fromlevel = context_range_get(con);
>         if (!fromrole || !fromtype) {
>                 context_free(con);
>                 return -1;
> @@ -243,23 +222,89 @@ static int get_context_order(FILE * fp,
>                 if (*end)
>                         *end++ = 0;
>
> -               /* Check for a match in the reachable list. */
> -               rc = find_partialcon(reachable, nreach, start);
> -               if (rc < 0) {
> -                       /* No match, skip it. */
> +               /* Check whether a new context is valid */
> +               if (SIZE_MAX - user_len < strlen(start) + 1) {

You need to also account for either the null character or the colon
(not sure which one you missed).

> +                       fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
> +                       errno = EINVAL;
> +                       rc = -1;
> +                       goto out;
> +               }
> +               usercon_len = user_len + strlen(start) + 1;
> +               usercon_str = malloc(usercon_len);

Again, you are not accounting for one of '\0' or ':' here.

> +               if (!usercon_str) {
> +                       rc = -1;
> +                       goto out;
> +               }
> +
> +               /* set range from fromcon in the new usercon */
> +               snprintf(usercon_str, usercon_len - 1, "%s:%s", user, start);

The second argument should be just usercon_len (assuming you fix the
above) - see snprintf(3):

"The functions snprintf() and vsnprintf() write at most size bytes
(including the terminating null byte ('\0')) to str."

So this should always result in a string with 2 last characters
truncated (followed by a null character and an unused byte). Or am I
missing something? Did you get correct strings when you tested this?

<snip>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

