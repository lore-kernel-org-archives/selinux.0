Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1FCC10F14
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A205423433
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 17:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbhAVPtb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 10:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbhAVPsZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 10:48:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF91AC061351
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 07:47:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id l9so8312168ejx.3
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzvPRUfibxBK9mBmS5xTCJ+zr+srTirmfMsi/vkO5Rk=;
        b=xOEkzNH5scs8vlRDvOctOEzrDkHdsEEJBqmdl8k6iVyaapBTZ1/bfl5cco3UnwAV6A
         i8hltshWBYfo/5ywBzX7X+45ZY8VqyDprKG7lMHIQrsObmoCzYxHdGKM6LgAvBo6vY93
         yx2QiZTcu7mmotb177A6tsbnkxkirsbGwrhfW5TxGGpq3tLstmrWDKbVj7Zu7HcEDrEA
         J03A6+w1EY/0oKfiEu5ni73lQcBOIoo7BGuuwUCV2altQAW+OytAwO9v286GWiRCUYcG
         334yaGlkHQVEcYG4z32Msow6HyIOjXHoCT+Kj0PpGtxfaoJtnY0EYDIUL6/ZtpjLIbIu
         +auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzvPRUfibxBK9mBmS5xTCJ+zr+srTirmfMsi/vkO5Rk=;
        b=o6Et+0b2osWelz+KDyXOrEPO0MGH6darbfsMmCyXzp/a9rGJDKkjRr8k6BNz5ojclY
         sgJUToKAfE7VBy+ltnYCHpURCJnuJoYofdvNyG0u1nbl4xe/MvHxF5Fq1+mCVFv6GvHL
         Gw8py2vecG+DIQiI3HESmFTN6bew+KEwG/xsBq3REa6hfxJvyWadHz/ohnkFynqHnP5o
         4DrlS9Pyyxddqk8KvonanIpPXNtyUiqrs/eSU8Nbq8gSm4D/QC58JSwwdFUyRpkrDrb9
         C6nCEIRr1fxmWR/sSUk4Ghqy8yQDiCB3C52tpkpbcr1LDivfUvzRcwAIjpyN1atrPXFw
         vcMQ==
X-Gm-Message-State: AOAM530KOkpypIfBAxmn563tVCRO9ORDswPM01AE6io6cTkrQR42TO1i
        mJV6YjEqtmNkOLdVISOGs1pWaOuNn24YqpciwdUQ
X-Google-Smtp-Source: ABdhPJzx8nvR83tauU2c6IZSLShYbENetwZ5CQOxXYGd07EcWq9+V/o6x6pKAR0g9tMt/gmxRTKuzp+NuyiYxcBrpRw=
X-Received: by 2002:a17:907:c01:: with SMTP id ga1mr3252567ejc.488.1611330458292;
 Fri, 22 Jan 2021 07:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20210122102748.38776-1-omosnace@redhat.com> <20210122102748.38776-2-omosnace@redhat.com>
In-Reply-To: <20210122102748.38776-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 10:47:27 -0500
Message-ID: <CAHC9VhR20WJM=KQPuzt6YzSmKbj8hKoCLJg9gESQzt6GXto_Eg@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/2] check-syntax: use 'command -v' instead of 'which'
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 22, 2021 at 5:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In minimal environments (e.g. Fedora container image) 'which' is not
> installed by default. To avoid the need to install an additional
> dependency, use 'command -v', which also does the trick and is a shell
> builtin.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tools/check-syntax | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
