Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC12C761A6
	for <selinux@archiver.kernel.org>; Tue,  4 Apr 2023 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjDDQNF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDDQNF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Apr 2023 12:13:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA45170E
        for <selinux@vger.kernel.org>; Tue,  4 Apr 2023 09:13:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so39348364ybu.8
        for <selinux@vger.kernel.org>; Tue, 04 Apr 2023 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680624783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5L0Nt2KM1pyQYAlMfO8zpDajr66WQExbhaVy6906IE=;
        b=BghsXlo3u+Op2c7BM9nVcbQ0Th2E2RAVH5IEzlm4m9d9Y0NFE1HEyIcvX/DVuOIoNi
         iBE8hY/dfNYlNSvzdQEEwy74JAAVAmKzWtsgxw4jJL/2CT+up8lOeBxLkVMpPPoNvjtJ
         1BifshOlXL1VAaA6enuZhIE+gLdW+81fMw8jHcqBMCTwE98xttdrnKAvHEo+se2WFqsC
         Y94TMZj7YjWtUDxMdJ2k3+5lkjtct73p4Kq6w+U/lM7ACLaE5158Px2c0eC+u7gCqYGt
         Fagjcd9ZhSyiHESwEnEoN/GnR+v6pn5Xvc9Djpu6kz2kMUdhEJAIjxMc0ZLqAvLbLTnJ
         N20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680624783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5L0Nt2KM1pyQYAlMfO8zpDajr66WQExbhaVy6906IE=;
        b=e3U4RUaL1rsoUeX2qMLNNK38rj4VWb3H+SJfoY9pNNQpxH+whvnQD0RV5+xaodpV1X
         LIMI0UHL/nWdhTqAp4XOoOZPTPuFYMY1YOAdcXipfBZC4HoA27ZY7xthS4NQJdFu3tTO
         Qkw/W5cGdenmArL9B6W4noNUHKM75j9okZqLal6DmL4lT25Rhchd79LtCL2m145wZL9g
         tdKtprsF6YnrqeRXJVtR5mfZvU7Tsverr16UyBZ3VykBWA3i1XQ3/XhRoWClGMQ6xmGm
         oXbrM/yQTUEXh48K9liwINsdpPHXj2PipOpJsnY7dYw7ZMsN/lbLw9gWzFLg5yc83Ajf
         5Aig==
X-Gm-Message-State: AAQBX9e7SVF4jzhDcj59vu6YqnVx5habU7AWYtoBU4i0a1a2+yoXiNRi
        IkaqNxw7hpWT/fNfFlLc6hnz4b2z/dafGYfff6de
X-Google-Smtp-Source: AKy350YyjrUH3TU+kY4LqUe5oybx6DGpasjULYEWxBdZ+ex6ymOjIjElgt6CmrgZHgxZ1x94IGYzBDNQQQT/v2X3VWE=
X-Received: by 2002:a25:d149:0:b0:b6e:361a:c86 with SMTP id
 i70-20020a25d149000000b00b6e361a0c86mr1908396ybg.3.1680624782761; Tue, 04 Apr
 2023 09:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230403163753.30196-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230403163753.30196-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Apr 2023 12:12:52 -0400
Message-ID: <CAHC9VhSKwkWULzg39hWOaKng3noYCeWeQbO0bUUCR_2Xev5J2g@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop returning node from avc_insert
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 3, 2023 at 12:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The callers haven't used the returned node since
> commit 21193dcd1f3570dd ("SELinux: more careful use of avd in
> avc_has_perm_noaudit") and the return value assignments were removed in
> commit 0a9876f36b08706d ("selinux: Remove redundant assignments"). Stop
> returning the node altogether and make the functions return void.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index c162e51fb43c..ad2afc17b633 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -603,12 +603,11 @@ static int avc_latest_notif_update(int seqno, int i=
s_insert)
>   * response to a security_compute_av() call.  If the
>   * sequence number @avd->seqno is not less than the latest
>   * revocation notification, then the function copies
> - * the access vectors into a cache entry, returns
> - * avc_node inserted. Otherwise, this function returns NULL.
> + * the access vectors into a cache entry.
>   */
> -static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass,
> -                                  struct av_decision *avd,
> -                                  struct avc_xperms_node *xp_node)
> +static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
> +               struct av_decision *avd,
> +               struct avc_xperms_node *xp_node)

Thanks Stephen, I just merged this into selinux/next, but I do have a
couple of small style nitpicks for future reference.

When writing a patch subject line with a function name, please add
parenthesis to the name to help make it clear it is a function, e.g.
"avc_insert()" instead of "avc_insert".

When the argument list spills to multiple lines, please make sure they
are aligned (look at the committed patch for an example).

--=20
paul-moore.com
