Return-Path: <SRS0=eYI8=NZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6DC43441
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB9A2077C
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 19:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aWCRmaSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB9A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeKOF5Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:57:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40665 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeKOF5Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Nov 2018 00:57:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so12429073lfe.7
        for <selinux@vger.kernel.org>; Wed, 14 Nov 2018 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wCqR4cG/Fn9pBqjTG2Omp9Gji+YkLWbKaf8oEi57n9k=;
        b=aWCRmaSu8Dh5PbI0QeDTHw+mhTFv4a+fviQ3hyTYYcKQTVpAg4PKYNzwlADoiw9oWb
         HrItIX79o71WYVQQBtE7GTlwKE3K/qHNxn9CHw352RDrvLv+1DpeL9QKxiOz6d5DU2dW
         jmPA+qaD+xPrDLpNCIeGq7LMYKTL+wMiJBc/eATA+9PsaO923WeaoBrRkc1gOQrhT6a8
         6L7WJv57MKmIjjXA1pD27OlBbnk1oXnPJsG//aolSYJ5F+VUdRpByF04CP0bKKed4J3V
         +mzSY5XQswcnWRRp5GIF2rHRxr9mocvFlVvZDT48Xp45dOYjxoK/fh2qnBfHFFh0wrJ9
         vNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wCqR4cG/Fn9pBqjTG2Omp9Gji+YkLWbKaf8oEi57n9k=;
        b=j7VoXw3dbI3ZUtL6iklWDvW7+sXlnrFELpdbN6vtTpMvF3sGwUr9hNftabyweHlqv8
         yni+ooqAbsWnwO6ZbjHv1+EtYSIF5uU34Ve3dRL0bmIY3oRw3nRGywKMVA4VnldEzWyi
         Tee1X/2jvvljZgZweHe5dphJdbsf6ipFj6vXrs0E56Vni5PpCPFnMJERGn4gcxjW/Ymp
         MfKHp/MDhdcFBPpIo9HU+hPB7gmWUz6pn8fFijHdJwChGwKfHL20bQs82fntwn7VgpIl
         U7kNS26AUzFDQtNwh45Uk+4sfhaAL75RNtTJtkS2H7pedAbIteqxeRNXlVw4vb0/wVWz
         +LTA==
X-Gm-Message-State: AGRZ1gLFBnoMDoC29rBym3DpHFejWT75i8vxwMWtH7X6UpA4zNpEjr2t
        2yf7lWPO+SWtOoSvbECViJ2wCpeq4ed4/Lt7LEXuvpM=
X-Google-Smtp-Source: AJdET5dV6dredcyl4NNDKGa2+fMlUIO3TKbyV3xwH+BlQ/03pI3vhHhTpFu8uwT6/RBlvlVlgDtqKet6lOsTVDfXsjQ=
X-Received: by 2002:a19:f115:: with SMTP id p21mr1756375lfh.20.1542225158394;
 Wed, 14 Nov 2018 11:52:38 -0800 (PST)
MIME-Version: 1.0
References: <154222484559.17938.2684528385878670936.stgit@chester>
In-Reply-To: <154222484559.17938.2684528385878670936.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Nov 2018 14:52:27 -0500
Message-ID: <CAHC9VhSnu5gHoycu6FO+hAQ=EHZVwC=AsDv1grGzds_k+GoqTw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix non-MLS handling in mls_context_to_sid()
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 14, 2018 at 2:47 PM Paul Moore <paul@paul-moore.com> wrote:
> Commit 95ffe194204a ("selinux: refactor mls_context_to_sid() and make
> it stricter") inadvertently changed how we handle labels that did not
> contain MLS information.  This patch restores the proper behavior in
> mls_context_to_sid() and adds a comment explaining the proper
> behavior to help ensure this doesn't happen again.
>
> Fixes: 95ffe194204a ("selinux: refactor mls_context_to_sid() and make it stricter")
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/mls.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Building a test kernel now, assuming all goes well I'll merge this
into selinux/stable-4.20 and send it to Linus this week.

> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 2fe459df3c85..b7efa2296969 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -245,9 +245,13 @@ int mls_context_to_sid(struct policydb *pol,
>         char *rangep[2];
>
>         if (!pol->mls_enabled) {
> -               if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> -                       return 0;
> -               return -EINVAL;
> +               /*
> +                * With no MLS, only return -EINVAL if there is a MLS field
> +                * and it did not come from an xattr.
> +                */
> +               if (oldc && def_sid == SECSID_NULL)
> +                       return -EINVAL;
> +               return 0;
>         }
>
>         /*
>


-- 
paul moore
www.paul-moore.com
