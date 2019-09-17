Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97647C4CEC9
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 13:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5517921881
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 13:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="Gg49Eenh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfIQNUv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:20:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36181 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfIQNUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 09:20:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so3522474ljj.3
        for <selinux@vger.kernel.org>; Tue, 17 Sep 2019 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6sQw9SpTnTmE4gjIBwkVlVLus4AahHV9s6wg+CGPZ0=;
        b=Gg49Eenh6+GmevfVQ0jxmPOYBKwQJq+e7zl1nfhYZOu8xKyLg7FjwbQX3/d0ByBQbB
         OXrfBbS0rDsjzJoWJD6I8pe9crB7TLYszOnBGCGA/veLnzR4VBKbFWCeVIZBhUjYgWBM
         5+T0yIApFAQR2dP781wA5JXf/FcL1x4ag+KMqJInsccJ9D2Io05xEXUJTKC+euqSWLWy
         JGX9rHDfWr6HQeDNCoYU3JBunnwMkBe4HXSXf36YpsV60nVZvmk9w9jqp/ACAOhS+0vD
         37JfGPBn5t4X3Kt/vzmX4AF3Jlp8QtllcmZrHmBn1YQEmhwbNOCN+nXkpVnI8nsc7FLV
         Dd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6sQw9SpTnTmE4gjIBwkVlVLus4AahHV9s6wg+CGPZ0=;
        b=XfoyAv10hzOou+dh6f3I3q18BT3Fm86cf2yxztSeQFDSPgXU8cg86sZmjpQCjIz2dW
         4cYZ+Ydlo1zMC2PAwNWFoeX7cjWsqRoRs3rfgTnbIv+siIFC0SVQ8pmh/lMJPIbMZMzP
         ++Y4VVgm7ler/JdV4aXYA9ybvQuFx8pjKaU45pHpaUjlAA+oaGKP8gcnIpL2BxA2K1ks
         eUoCZXsmS5tACKXnbASIQ8RTBxX/gmQ7x8wtis1T6qmBpYIuJ5fxoQvfXBeZj3FKm0nH
         01kgKxzgK9UG+qa7yXLUyw/Tt59tufQJ8oDHppPEqz+TmpUETh/JE8IY5XDx3EzeuLIG
         Ws7Q==
X-Gm-Message-State: APjAAAUFuEBN7GC0CYVtpvyA17gllEbZiiQF5NInWdZ/bYyrtFuEhz4e
        Nik2QCb5xia2RB5Y2ZClLzL3NZdQVSvQjI9kKhwwZsFjAnM=
X-Google-Smtp-Source: APXvYqy4yL+fuNnqGOiRI3foO4KZL+sUmxS6ll+EbVo8bJFmXd+WlgfgN5xYX6msefEiFkv4q2shX/u9FN24Uxnr0y8=
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr1920312ljj.30.1568726448237;
 Tue, 17 Sep 2019 06:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190910195353.973-1-mike.palmiotto@crunchydata.com> <088debd8-0781-99ab-48a9-30bfa2e7a776@tycho.nsa.gov>
In-Reply-To: <088debd8-0781-99ab-48a9-30bfa2e7a776@tycho.nsa.gov>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Tue, 17 Sep 2019 09:20:36 -0400
Message-ID: <CAMN686GeYV3HcOaUAiu-yg7kiy1ybFCH=6pMG3b5AE_AOutTEA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix string conversion of unknown perms
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 16, 2019 at 4:01 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 9/10/19 3:53 PM, Mike Palmiotto wrote:
> > Commit c19395d72295f5e69275d98df5db22dfdf214b6c fixed some handling of unknown
> > classes/permissions, but missed the case where an unknown permission is loaded
> > and then subsequently logged, either via denial or auditallow. If a permission
> > set has some valid values mixed with unknown values, say `{ read write foo }`,
> > a check on `{ read write foo }` would fail to log the entire set.
> >
> > To fix this, skip over the bad permissions/classes when expanding them to
> > strings. The unknowns should be logged during `selinux_set_mapping`, so
> > there is no need for further logging of the actual unknown permissions.
> >
> > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > ---
> >   libselinux/src/stringrep.c | 28 ++++++++++++----------------
> >   1 file changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> > index ad29f76d..85579422 100644
> > --- a/libselinux/src/stringrep.c
> > +++ b/libselinux/src/stringrep.c
> > @@ -276,19 +276,15 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
> >       char *ptr;
> >
> >       /* first pass computes the required length */
> > -     while (tmp) {
> > +     for (i = 0; tmp; tmp >>= 1, i++) {
>
> Remove the redundant initialization in the declaration now that you are
> doing it here (which is better, I agree).
>
> >               if (tmp & 1) {
> >                       str = security_av_perm_to_string(tclass, av & (1<<i));
> > -                     if (str)
> > -                             len += strlen(str) + 1;
> > -                     else {
> > -                             rc = -1;
> > -                             errno = EINVAL;
> > -                             goto out;
> > +                     if (!str) {
> > +                             continue;
> >                       }
>
> No need to bracket it when it is a single statement.
>
> > +
> > +                     len += strlen(str) + 1;
>
> Might be clearer as:
>         if (str)
>                 len += strlen(str) + 1;
> And just let it fall through to the end of the loop otherwise - no need
> for explicit continue here.
>
> >               }
> > -             tmp >>= 1;
> > -             i++;
> >       }
> >
> >       *res = malloc(len);
> > @@ -298,7 +294,6 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
> >       }
> >
> >       /* second pass constructs the string */
> > -     i = 0;
> >       tmp = av;
> >       ptr = *res;
> >
> > @@ -308,12 +303,13 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
> >       }
> >
> >       ptr += sprintf(ptr, "{ ");
> > -     while (tmp) {
> > -             if (tmp & 1)
> > -                     ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
> > -                                            tclass, av & (1<<i)));
> > -             tmp >>= 1;
> > -             i++;
> > +     for (i = 0; tmp; tmp >>= 1, i++) {
> > +             if (tmp & 1) {
> > +                     str = security_av_perm_to_string(tclass, av & (1<<i));
> > +                     if (str) {
> > +                             ptr += sprintf(ptr, "%s ", str);
> > +                     }
>
> No need for { } around a single statement.
>
> > +             }
> >       }
> >       sprintf(ptr, "}");
> >   out:
> >
>

Thanks for the review. Fixed all of the above in v2.

-- 
Mike Palmiotto
https://crunchydata.com
