Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E6C433EF
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiB1U0M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiB1U0M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 15:26:12 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D0F5716F
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 12:25:32 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so10456741otn.2
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UlWUtGv0nWHGInsSNBFl5+5mdGQJwcdBXJDR5WjOp5s=;
        b=nANxAwl1KcYdoD++c8ITKx/nElfDiI7z1kfmvgVz9QH0+Ol7qg7Lvp5JBtb7QlaBFf
         UJzzJWg7xWIMtuJzksMJG7suE4Ifnfi1HymKQsfIUkDHUM/+sDjczOz7Dxd7bT4lnzaP
         l6IkeKtcxJ/cMmy+ONxFPY3fEaciIkHxAMyXS+VIDOL2XJLBZmr4iNfVokAgA+yFB22M
         geQqlrbXd1HbEqdyAYHvv3BkzRYLUVaaHUYiKtF331gM3jl52yUdNaPYWvNX1iZQflBK
         QneGIt8qNBJCjHD3nxp43jWtzQh5Ienl2egTaID7+l3mtMXmXLeCyootMhG4Ukm/V8Sk
         GnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UlWUtGv0nWHGInsSNBFl5+5mdGQJwcdBXJDR5WjOp5s=;
        b=fA2wYa0Dqx6erR1qO6mNMb8Lceb9IKE34HdLZ6nuE/0fxnzIpv11v72rLmir87OR0r
         p/+7H4Mr0oJa9eGFALH6TZjXAwP4VV+oUpkbYY8Zv8lphIPBPDG2xcUWfzsD0mHtQd/1
         pFnCSLLwQW8t/jgcazrjKHuccSwCNKgXuahfmrXFC3JWdKd0UtrbnCR/8u3S7AyBU8yJ
         8dxRmAe3toKVqJbpdaPbqCzOB1+ABwBb672D7G5JMnIK+q7AfFhDz3hUeWXpk9k5cNn4
         MjwAStK3E561NXzueCYdmLPd1fkKsfZDlUfKAIzTu8RV4Xh8QOpftZgHcYOiUVWECR1S
         l94g==
X-Gm-Message-State: AOAM531XQZl8h63VwJSZPMb9XWMsB33rbyfb2k5UxZZyihNHuJd7mir8
        yxKmW5UT2Ndc4FSl1igZS53vwzl1pgOBDFvQ/wQ=
X-Google-Smtp-Source: ABdhPJyzKscbfaSBBzms3kJsEpiL65qJPVfqWqyyyBdsnPk0nKsb7foqFyRTlKbGpdussfTYRnmJbYHA2kylNzbWZAs=
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id
 66-20020a9d06c8000000b005ad5a1ef79dmr10266812otx.154.1646079931634; Mon, 28
 Feb 2022 12:25:31 -0800 (PST)
MIME-Version: 1.0
References: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com>
 <20220217131415.1195383-1-vmojzis@redhat.com> <CAJ2a_Df=pjCN_Cs1EN_bk1wF_XFuqUVhB_5vjH0oiqCG=xWbKw@mail.gmail.com>
 <d46fe913-04c3-7df1-c29a-1d186d2c3b32@redhat.com>
In-Reply-To: <d46fe913-04c3-7df1-c29a-1d186d2c3b32@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 15:25:20 -0500
Message-ID: <CAP+JOzSaaS64P2trL8_VzHS2cNG9f59D0VwyDtP8SqCUdA5yaA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Strip spaces before values in config
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 21, 2022 at 8:04 AM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> On 17. 02. 22 15:16, Christian G=C3=B6ttsche wrote:
> > On Thu, 17 Feb 2022 at 14:14, Vit Mojzis <vmojzis@redhat.com> wrote:
> >>
> >> Spaces before values in /etc/selinux/config should be ignored just as
> >> spaces after them are.
> >>
> >> E.g. "SELINUXTYPE=3D targeted" should be a valid value.
> >>
> >> Fixes:
> >>     # sed -i 's/^SELINUXTYPE=3D/SELINUXTYPE=3D /g' /etc/selinux/config
> >>     # dnf install <any_package>
> >>     ...
> >>     RPM: error: selabel_open: (/etc/selinux/ targeted/contexts/files/f=
ile_contexts) No such file or directory
> >>     RPM: error: Plugin selinux: hook tsm_pre failed
> >>     ...
> >>     Error: Could not run transaction.
> >>
> >> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >> ---
> >>
> >> Sorry for the delay. I sent the fixed patch to a wrong mailing list.
> >>
> >>   libselinux/src/selinux_config.c | 17 +++++++++++++----
> >>   1 file changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_=
config.c
> >> index 97f81a8b..d2e49ee1 100644
> >> --- a/libselinux/src/selinux_config.c
> >> +++ b/libselinux/src/selinux_config.c
> >> @@ -92,6 +92,7 @@ int selinux_getenforcemode(int *enforce)
> >>          FILE *cfg =3D fopen(SELINUXCONFIG, "re");
> >>          if (cfg) {
> >>                  char *buf;
> >> +               char *tag;
> >>                  int len =3D sizeof(SELINUXTAG) - 1;
> >>                  buf =3D malloc(selinux_page_size);
> >>                  if (!buf) {
> >> @@ -101,21 +102,24 @@ int selinux_getenforcemode(int *enforce)
> >>                  while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> >>                          if (strncmp(buf, SELINUXTAG, len))
> >>                                  continue;
> >> +                       tag =3D buf+len;
> >> +                       while (isspace(*tag))
> >> +                               tag++;
> >>                          if (!strncasecmp
> >> -                           (buf + len, "enforcing", sizeof("enforcing=
") - 1)) {
> >> +                           (tag, "enforcing", sizeof("enforcing") - 1=
)) {
> >>                                  *enforce =3D 1;
> >>                                  ret =3D 0;
> >>                                  break;
> >>                          } else
> >>                              if (!strncasecmp
> >> -                               (buf + len, "permissive",
> >> +                               (tag, "permissive",
> >>                                   sizeof("permissive") - 1)) {
> >>                                  *enforce =3D 0;
> >>                                  ret =3D 0;
> >>                                  break;
> >>                          } else
> >>                              if (!strncasecmp
> >> -                               (buf + len, "disabled",
> >> +                               (tag, "disabled",
> >>                                   sizeof("disabled") - 1)) {
> >>                                  *enforce =3D -1;
> >>                                  ret =3D 0;
> >> @@ -176,7 +180,10 @@ static void init_selinux_config(void)
> >>
> >>                          if (!strncasecmp(buf_p, SELINUXTYPETAG,
> >>                                           sizeof(SELINUXTYPETAG) - 1))=
 {
> >> -                               type =3D strdup(buf_p + sizeof(SELINUX=
TYPETAG) - 1);
> >> +                               buf_p +=3D sizeof(SELINUXTYPETAG) - 1;
> >> +                               while (isspace(*buf_p))
> >
> > Strictly speaking one should cast to unsigned char to avoid UB, see
> > [1], but that
> > seems to be not done in SElinux userspace as
> >
> >      grep -REw "(isalnum|isalpha|isascii|isblank|iscntrl|isdigit|isgrap=
h|islower|isprint|ispunct|isspace|isupper|isxdigit|toascii|toupper|tolower)=
"
> >
> > shows 87 usages.
> >
> > [1]: https://wiki.sei.cmu.edu/confluence/display/c/STR37-C.+Arguments+t=
o+character-handling+functions+must+be+representable+as+an+unsigned+char
> >
>
>
> Right, thank you. So, should I fix the patch (which would make the use
> of the cast inconsistent in selinux_config.c), or leave it as is?
> If this is something worth fixing I can make a new patch adding the cast
> to all the calls (except for cases where EOF can be expected? -- not
> sure if we need to watch for that).
>
> Vit
>

Since, we aren't casting it to unsigned char anywhere else, I think
the patch is fine as it is. If we feel the need to fix up the other 87
usages someday, then we can fix this one then. It seems unlikely to
cause any problems.
Jim


>
> >> +                                       buf_p++;
> >> +                               type =3D strdup(buf_p);
> >>                                  if (!type) {
> >>                                          free(line_buf);
> >>                                          fclose(fp);
> >> @@ -199,6 +206,8 @@ static void init_selinux_config(void)
> >>                          } else if (!strncmp(buf_p, REQUIRESEUSERS,
> >>                                              sizeof(REQUIRESEUSERS) - =
1)) {
> >>                                  value =3D buf_p + sizeof(REQUIRESEUSE=
RS) - 1;
> >> +                               while (isspace(*value))
> >> +                                       value++;
> >>                                  intptr =3D &require_seusers;
> >>                          } else {
> >>                                  continue;
> >> --
> >> 2.30.2
> >>
>
