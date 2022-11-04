Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1D4C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 21:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKDVDg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKDVDf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 17:03:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48D11A1B
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 14:03:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d20so8039831ljc.12
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmIip966oKzxaUYxc1+X7fdIX3Vjoo/xOF9csggoJIc=;
        b=hf554R8ZwN3MwKybW6QFloUsdXfJJASgoksNgH4XgsLS1qsjhtiy2MEdJCUM6YE/kb
         lRPzwgETMEkwMQKvGbA7b/J+kgZO0c7VmuBbaRyPOIrXrinqrrn2Jcb0HoCp0z/YBTDU
         lLaqITJYRbgVN+ThxLzPq0RFyNrNW9H/fP+W91DENqbM7Wkg9e5VUtvY/7uVuavo2K4m
         fhd9jVNx5Xx9XCihxz9nt+Juy0hzDLHQri4Do9yt1FrWAXodg2QApWAAdZGNt4M5qPom
         mADUi4RYqvWwcQElavZcIU0EzoDjXNB6LcTZ/5hNwtlH1TY/xp9rOzNy3I5gJMFtRDiz
         kPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmIip966oKzxaUYxc1+X7fdIX3Vjoo/xOF9csggoJIc=;
        b=32Ru9YvkZG5zRPyeNBDMGpGeUlLiFye/l5b4aBffnUqk0uIpXzoOCuDQeM4wruZ0S5
         N4rWnjLPOMIaI7ZCk16ZcJ1nHFmqif99BBu19Ag/ED1dGEn+dEN29RAEVBPQUzPhp68R
         mkELFJN3Fwdtwz7A4JHAbft4LDgpE+di3BzQH1kFefCh1cgspvKjhqa7srZUdACHLm3o
         cJbvUWFts0ZngNJ+RTIN0ikCE/5/YRKCIyPF7C0ESbR3xbDPy1YB4/lemUwk0i299Ec1
         JnvkOAwe3kdL/zExQD9AEJqO+69/jKiwa5HNkEDZo9BKpsHLJ6i+4yHfTmFSRCVGJlCk
         NiEQ==
X-Gm-Message-State: ACrzQf3S1uIjID3+mqS4xpkgExA/C1SZ8wqdnUzhXpIettUyWQ3rjjUl
        e4LsdMMb8lOJ+yNBo4tRghBjHzOkC3XJdaV9fsM4BIPCW3A=
X-Google-Smtp-Source: AMsMyM5FOo4acRoWyMSU9/+7JLN1wagdOQgepngofkEv8bvwGQW4VFH6X+KeHGqPX3+b+wHWAwHuhfWmMp3vysUYo9w=
X-Received: by 2002:a05:651c:1038:b0:277:5452:60f6 with SMTP id
 w24-20020a05651c103800b00277545260f6mr10403910ljm.21.1667595812295; Fri, 04
 Nov 2022 14:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com>
In-Reply-To: <20221024091354.2253669-1-tweek@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Nov 2022 17:03:20 -0400
Message-ID: <CAP+JOzS-H8qL3PU_N0-4ZViXNd1RQdBYM4qprdhxZ2sMu818-g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 24, 2022 at 5:14 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> selinux_check_access relies on string_to_security_class to resolve the
> class index from its char* argument. There is no input validation done
> on the string provided. It is possible to supply an argument containing
> trailing backslashes (i.e., "sock_file//////") so that the paths built

I am having trouble reproducing this. Using backslashes causes an
error when looking up the "%s/class/%s/index" path.
Using forward slashes just works. Valgrind does not report any memory
leaks in either case and I don't see the same permission file being
referenced multiple times.

I don't think that we need the regex solution.

Thanks,
Jim


> in discover_class get truncated. The processing will then reference the
> same permission file multiple time (e.g., perms/watch_reads will be
> truncated to perms/watch). This will leak the memory allocated when
> strdup'ing the permission name. The discover_class_cache will end up in
> an invalid state (but not corrupted).
>
> Ensure that the class provided does not contain any path separator.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  libselinux/src/stringrep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index 2fe69f43..592410e5 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -63,6 +63,9 @@ static struct discover_class_node * discover_class(cons=
t char *s)
>                 return NULL;
>         }
>
> +       if (strchr(s, '/') !=3D NULL)
> +               return NULL;
> +
>         /* allocate a node */
>         node =3D malloc(sizeof(struct discover_class_node));
>         if (node =3D=3D NULL)
> --
> 2.38.0.135.g90850a2211-goog
>
