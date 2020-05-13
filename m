Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81406C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 17:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE12205ED
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo99nK4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgEMRhZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732731AbgEMRhZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 13:37:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E37C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 10:37:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c12so21155088oic.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUxu78Nb70lSr24SCy5LSgSV19MY4Bi9ySsdRUKgMIc=;
        b=mo99nK4FQt2u2up0SrHG+txveLzSHnCo48YQDy89vY9xmrNIyoI0UrAcsTOhnkQ8wZ
         UfTjppSQcKQVRUT6qLuto6ooNC6pmJ0fVxLkDLk9zxn/Bn0oaGryo1trBYqMflvQgjDt
         GRK/fsKe7qMPVz3B/EAbFhxFSNTC8K0Y1n62YSEpIqX4X38F1TN0Wd32Ngc4pVf7w0vK
         n3j6+PKXhOfn7Vny0jNz8rqOloX/29XVGvvV1Z78SnzjxuaiVQvc9zfbvl7w1LoY9W94
         8VOyl60g9/1Hrvpzd/ZrzJGEf41ExC/vByubLZs3PKISEQlqzHR037pfknPEnYY2fVFL
         QgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUxu78Nb70lSr24SCy5LSgSV19MY4Bi9ySsdRUKgMIc=;
        b=kWiM2wOokQcay2cK5J/p15/kyYf7c3JXSyCGtVdjNWywgVwn6JVLh0PzzlScaTu3GO
         SdXzRYkar8oJBzCLHAnmLrAYDnMgtA9dJh6xXbjCi8w0zWeZPJvGLITH5p05NP0WmczY
         QsTHu4cA7SdSZFSMkwbt/dQ4y17f3TjEFKUuKklLe6PpHsrUWqPq6i5iuppeJAp1KeQQ
         Q99vJy5XAwCs0wxoqNngSJMhdzrm/Ld9sxKaimu9xDfFulgXqJJvFcHMWD/nM6/oLBqF
         dBDnB4LNszYyPFgnqIRjAAVyLlriAx5LKDkX2ndIgTpUOKxAq703jIvqlQuJkV0izKVx
         GdhQ==
X-Gm-Message-State: AGi0PuZJ2UoHwXaORa1lTfJPfMx44+2ad1HTxAb8J9K32J9AhDyEk6Wq
        iC9WB9GWa1M3ZTc8AfZJhrfUllgQ22Be99agTbxZyuo0DZ4=
X-Google-Smtp-Source: APiQypLUYAzF2m4uodVTtQWApZweigjQIwup+DWWNnxKfYi9x0eaVL1wD1FWhjpI7N1AnTTAgMmp5CLxV6dfa+x9+VI=
X-Received: by 2002:aca:4155:: with SMTP id o82mr29394123oia.16.1589391444779;
 Wed, 13 May 2020 10:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200513144329.181671-1-plautrba@redhat.com>
In-Reply-To: <20200513144329.181671-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 13 May 2020 13:37:13 -0400
Message-ID: <CAP+JOzRsdSmdwUFAOpPRvggRkHyrazx6-ZYBMZ9NFHHjiexvUA@mail.gmail.com>
Subject: Re: [PATCH] secilc: Fix policy optimization test
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 10:46 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Commit 692716fc5fd5 ("libsepol/cil: raise default attrs_expand_size to 2") was
> reverted and attributes with one type are not expanded anymore.
>
> Fixes:
>     ./secilc test/policy.cil
>     ./secilc -c 32 -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
>     checkpolicy -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
>     diff test/opt-expected.cil opt-actual.cil
>     11a12
>     > (typeattribute at01)
>     21a23
>     > (typeattributeset at01 (tp01))
>     25c27,28
>     < (allow tp01 self (cl01 (p01a p01b p11a p11b)))
>     ---
>     > (allow tp01 at01 (cl01 (p11b)))
>     > (allow tp01 self (cl01 (p01a p01b p11a)))
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/test/opt-expected.cil | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/secilc/test/opt-expected.cil b/secilc/test/opt-expected.cil
> index 73ac9045f23e..14033f9be4dd 100644
> --- a/secilc/test/opt-expected.cil
> +++ b/secilc/test/opt-expected.cil
> @@ -9,6 +9,7 @@
>  (category c01)
>  (categoryorder (c01))
>  (sensitivitycategory s01 (c01))
> +(typeattribute at01)
>  (typeattribute at02)
>  (boolean b01 false)
>  (type tp01)
> @@ -19,10 +20,12 @@
>  (type tpr3)
>  (type tpr4)
>  (type tpr5)
> +(typeattributeset at01 (tp01))
>  (typeattributeset at02 (tp01 tp02))
>  (allow at02 tpr1 (cl01 (p01a p01b p11a)))
>  (allow at02 tpr3 (cl01 (p01a p01b p11a)))
> -(allow tp01 self (cl01 (p01a p01b p11a p11b)))
> +(allow tp01 at01 (cl01 (p11b)))
> +(allow tp01 self (cl01 (p01a p01b p11a)))
>  (allow tp01 tpr1 (cl01 (p11b)))
>  (dontaudit at02 tpr2 (cl01 (p01a p01b p11a)))
>  (dontaudit at02 tpr4 (cl01 (p01a p01b p11a)))
> --
> 2.26.2
>
