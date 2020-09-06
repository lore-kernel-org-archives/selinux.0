Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F34AC433E2
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 03:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F3620797
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 03:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="z4l6wKXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgIFD2H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 23:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgIFD2E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 23:28:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723DC061575
        for <selinux@vger.kernel.org>; Sat,  5 Sep 2020 20:28:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so300200ejb.10
        for <selinux@vger.kernel.org>; Sat, 05 Sep 2020 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0IgnZUyUoGfbZraUIscu29c3A3sScGsdLF190biM3Y=;
        b=z4l6wKXi/yGBo2SHBE/iTCu373TC1u6YTkje9FmJRPe3/LfsEZb6A+cBr97GzUz4FT
         nGpN+0BTBsMk7HQPjOk8aRljbm0hNRV3g2VCncF52YRfQ0qPc0tHb/WISBImmzjcw8ki
         OQyjyzfBGW6hNz6mGNGZzC7dPsZGxhV2qQwk7ajV45STKyEvoDpicykE8/F5du4n22j+
         wHRLkvj91sxkBBq2OYHZyPZ83ASTZ/d5CxE9Lhggz2XkTkbiRfow8rmt1bNbuJ41mv1D
         hWLzRB+lSC6c8Hn4AS/Ac6HEqBjyTRHqTUalL2RTUBV4ZxKgC2KCzXisVZZPfkf/GRLi
         45Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0IgnZUyUoGfbZraUIscu29c3A3sScGsdLF190biM3Y=;
        b=EL2UYOHaohjkoBWmskrUbZguUl6B5l7tvsp5nBTRUlohN51PfhgHvT2sTAZ6/wyFso
         6evCTiS4EEPf2MCHdI+SA7rSytsVxlPeU/9fgRzgshrB8CDrjGAVMJ6Cy/8JC73JR3z3
         huo9ZHc+0tvT13YP3pzjMhSDmMDXo0J7KC0MXMl+9LHzb1xTETlTmzBLiLpMNN+4owy3
         LYgkLWOgBjEm1b2m9KSPmP7THeTYma26o9gDs7mjc3bTO8C2F8PCuUVho2Kc6UccfTgi
         KxOngd6X5C13fldbkDCbtK7nB5GkcttU+Tbh5v1fwxaSogSRXyEtM+ooWag0mnmNQRtR
         Ehmw==
X-Gm-Message-State: AOAM533AdAJXmFiPvBW2orpAx/uqF/0k4FUCZVUaqe8Fv4a6SeTymwEu
        AtfQ8qvpVL5r1UIxjTKoexmyoLJijW2oC2i7arf1
X-Google-Smtp-Source: ABdhPJzP4OcqWMTHX8gja+wmbDgmPTy3466oa2U/qwS83qgEv2/iYRIddsUSymGA/uzzioCH0LFF+C/hnfg9g6+CLc8=
X-Received: by 2002:a17:906:15d4:: with SMTP id l20mr14513986ejd.178.1599362881963;
 Sat, 05 Sep 2020 20:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-19-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-19-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 23:27:50 -0400
Message-ID: <CAHC9VhSQCbzKToSsD23bWs5=cVh1vgMcpSvj+Bv_bZwfsOUtgQ@mail.gmail.com>
Subject: Re: [PATCH v20 18/23] NET: Store LSM netlabel data in a lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:21 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Netlabel uses LSM interfaces requiring an lsmblob and
> the internal storage is used to pass information between
> these interfaces, so change the internal data from a secid
> to a lsmblob. Update the netlabel interfaces and their
> callers to accommodate the change. This requires that the
> modules using netlabel use the lsm_id.slot to access the
> correct secid when using netlabel.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> ---
>  include/net/netlabel.h              |  8 +--
>  net/ipv4/cipso_ipv4.c               | 27 ++++++----
>  net/netlabel/netlabel_kapi.c        |  6 +--
>  net/netlabel/netlabel_unlabeled.c   | 79 +++++++++--------------------
>  net/netlabel/netlabel_unlabeled.h   |  2 +-
>  security/selinux/hooks.c            |  2 +-
>  security/selinux/include/security.h |  1 +
>  security/selinux/netlabel.c         |  2 +-
>  security/selinux/ss/services.c      |  4 +-
>  security/smack/smack.h              |  1 +
>  security/smack/smack_lsm.c          |  5 +-
>  security/smack/smackfs.c            | 10 ++--
>  12 files changed, 65 insertions(+), 82 deletions(-)

Minor change suggested to a comment below, but looks good otherwise.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 2eb71579f4d2..8182b923e802 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -106,15 +106,17 @@ int cipso_v4_rbm_strictvalid = 1;
>  /* Base length of the local tag (non-standard tag).
>   *  Tag definition (may change between kernel versions)
>   *
> - * 0          8          16         24         32
> - * +----------+----------+----------+----------+
> - * | 10000000 | 00000110 | 32-bit secid value  |
> - * +----------+----------+----------+----------+
> - * | in (host byte order)|
> - * +----------+----------+
> - *
> + * 0          8          16                    16 + sizeof(struct lsmblob)
> + * +----------+----------+---------------------+
> + * | 10000000 | 00000110 | LSM blob data       |
> + * +----------+----------+---------------------+
> + *
> + * All secid and flag fields are in host byte order.
> + * The lsmblob structure size varies depending on which
> + * Linux security modules are built in the kernel.
> + * The data is opaque.
>   */
> -#define CIPSO_V4_TAG_LOC_BLEN         6
> +#define CIPSO_V4_TAG_LOC_BLEN         (2 + sizeof(struct lsmblob))
>
>  /*
>   * Helper Functions
> @@ -1469,7 +1471,12 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
>
>         buffer[0] = CIPSO_V4_TAG_LOCAL;
>         buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
> -       *(u32 *)&buffer[2] = secattr->attr.secid;
> +       /* Ensure that there is sufficient space in the CIPSO header
> +        * for the LSM data. This should never become an issue.
> +        * The check is made from an abundance of caution. */
> +       BUILD_BUG_ON(CIPSO_V4_TAG_LOC_BLEN > CIPSO_V4_OPT_LEN_MAX);

I like the BUILD_BUG_ON() check, but for reasons very similar to the
unix_skb_params changes I don't really like the "should never become
an issue" commentary.  Granted, it is unlikely, but I don't think it
is wise to thumb our nose at fate.

> +       memcpy(&buffer[2], &secattr->attr.lsmblob,
> +              sizeof(secattr->attr.lsmblob));
>
>         return CIPSO_V4_TAG_LOC_BLEN;
>  }

-- 
paul moore
www.paul-moore.com
