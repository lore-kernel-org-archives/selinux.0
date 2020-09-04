Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E45C433E2
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F5A20665
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 20:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="h32Q4YBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgIDUI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgIDUI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 16:08:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0CFC061245
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 13:08:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so9053285ejb.1
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1NHBybIhhCgKygMIm+6vgzAeFtMl/WTsqdcpjKpwac=;
        b=h32Q4YBytASnxn5blRD/WS352YmK7qhV1eHdYsbqXhnKcnKXSXfNhvGstUvGRPpZvV
         /Sw/Gml4+ZhRAY9tkH/pJGFHanX6xsiERdJQd4vRNEdcFFgqhglELdOEQUHt1UiTqe/T
         FfUaOF/Kqn+EbL4jky2LCqUZ6ogi8ox++oC0e9FMOyaw9o/62qgyo6rQpwXuSSD5g7tt
         CPe477QwNU1sXwtJ0XeAGlrBYF8h6vbZRAlistBAX53tTaIXS5ouuwxPRn0l0JCLoIhy
         /qeMuXNb/JKhebx3X9BJRchNqVjKGoEIR9svHxM2bKTUFdE4+SnEhH0C/v/eTycGACEH
         JMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1NHBybIhhCgKygMIm+6vgzAeFtMl/WTsqdcpjKpwac=;
        b=h12D5hpemy0b5u5kW0oufZeJuYhVsOUM2dy0YHpZe0kQPfqgq29UDrxp6r+Wrgf5Oh
         yjwMNs1jtOFNWHA20haMeuxYbQ/cFvzwXxdt8Yb4XKVdElG3zmw7wJezq7wmobZbv/mH
         Ib9e/wE+1Pt5YLqJGk1qpYXsvsnbkrq957ehskNLe4N0XEn2QvnNa0ZiLXak/M+nHtP7
         ZR8nptH++3vwYI8vPR5kqjipQPU3+ylX8uFyIa+AXbuQKA0QbiOz0W05SLgV2n7ngsuy
         WSdjKMF/12oNvEekyTPMyrxt48GgfCP+35eq7lTu2+Vd6R7WV9d762IebuV4jTr8mtsR
         LYzg==
X-Gm-Message-State: AOAM531EyGhcJilbfgkHLzecpiLIxTYUvNAG3qCUctRkiRzYDkMnXCsv
        qivU7pTXYnFLuFJrnRsMobl+nzuia1aO4sLs8Bem
X-Google-Smtp-Source: ABdhPJw8DsKmpE1p7scVjs9No/PHLwUznrGrFAiZkVjDZcbKE9M8l7G/4K28wUYYMuWLjg3q2rzP8DFmhYc164iH/CU=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr9192671ejn.542.1599250136524;
 Fri, 04 Sep 2020 13:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-6-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-6-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 16:08:45 -0400
Message-ID: <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:07 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the data used in UDS SO_PEERSEC processing from a
> secid to a more general struct lsmblob. Update the
> security_socket_getpeersec_dgram() interface to use the
> lsmblob. There is a small amount of scaffolding code
> that will come out when the security_secid_to_secctx()
> code is brought in line with the lsmblob.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  7 +++++--
>  include/net/af_unix.h    |  2 +-
>  include/net/scm.h        |  8 +++++---
>  net/ipv4/ip_sockglue.c   |  8 +++++---
>  net/unix/af_unix.c       |  6 +++---
>  security/security.c      | 18 +++++++++++++++---
>  6 files changed, 34 insertions(+), 15 deletions(-)

...

> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index f42fdddecd41..a86da0cb5ec1 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>         kgid_t                  gid;
>         struct scm_fp_list      *fp;            /* Passed files         */
>  #ifdef CONFIG_SECURITY_NETWORK
> -       u32                     secid;          /* Security ID          */
> +       struct lsmblob          lsmblob;        /* Security LSM data    */

As mentioned in a previous revision, I remain concerned that this is
going to become a problem due to the size limit on unix_skb_parms.  I
would need to redo the math to be certain, but if I recall correctly
this would limit us to five LSMs assuming both that we don't need to
grow the per-LSM size of lsmblob *and* the netdev folks don't decide
to add more fields to the unix_skb_parms.

I lost track of that earlier discussion so I'm not sure where it ended
up, but if there is a viable alternative it might be a good idea to
pursue it.

-- 
paul moore
www.paul-moore.com
