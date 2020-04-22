Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6355EC54FCB
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A3A20767
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 19:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UWSytQjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgDVTj5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDVTj5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Apr 2020 15:39:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CEEC03C1A9
        for <selinux@vger.kernel.org>; Wed, 22 Apr 2020 12:39:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k22so2457830eds.6
        for <selinux@vger.kernel.org>; Wed, 22 Apr 2020 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cquA/gZzmeH49D50PDtpzsvP/R0LJR1uxHcplOx1sKQ=;
        b=UWSytQjmX6nkxkT2xX6dSXoFCbhD2lmebtPfjzNRdBTyw4FT6962Ip4DT8YaLUSxv4
         U3BXU9QSANIslOx/w5hFmCQVEpP/ltGWwgxhepWa7H1/4q/5F8VS2oxTBkvWpEq2/skd
         5vljlNm+LN0OpkMFUo/FkZYOHp68NyEea54VeNlPDRLTcnao4wiXU5ByJya/3S4Aj+Bl
         0pEl7Y/JKFOtVwV1X+BHMFhuC99oQENnU8cVTruhFyObWUnW+tntF8wtdWbt4yMrglEs
         QO3O+msT+6AD9eAuW/pvEj6A88Zgru4G4jIsNnzRjHfklSkiMBkd6cFuPEsP9KiAoaE5
         qeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cquA/gZzmeH49D50PDtpzsvP/R0LJR1uxHcplOx1sKQ=;
        b=sLAyMkiey0q5/uPDZEHgxZSlfl/O11YD7CLQ3ryLCZodFFpqBOUFm5dox2E6BHWU2h
         KqdNYm8Ko7qjS3Vlf2JUGXOlX/ypUfwtQm0XhvHuwxvXNN9G37Mq2PNiG2xlMrtIHPuz
         LDaw1RFCyRPpgwJmOJwfDsTlMwPfvhI2b4IqcDBiqRzhHESaUIETa24Dc2eKXK2IZH6b
         m6HFYWuD7PTOTaGW+3397VDRQ3sDRzIOL2uaTfwYc6437lJH97w6HLAPaqwR+ESa/eLh
         ASrDt0GTN8HY0cWZ1xwBj1P5yQ8BWyM8Fzs15VPUdHQ+EI0E+hCnZ5GigXkP1xbAkQE3
         V/RA==
X-Gm-Message-State: AGi0PubcEtOUJgh95eymEmvp4u8HLCkKmcygoEtpZfsF4Jc5u2JzVrp9
        pIl1hQ2YV5+dqbHFz7e1RE5vXtrVI4ZFypTFIEcgz+A=
X-Google-Smtp-Source: APiQypLnctnWXhedvymwSOhn7KFTt4ztrH8OIqLhE90STPavBgKwlB2Z7RwPgaCXk0RPU+vAj7ScWOyX4pV6lXsUU/Q=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr206939edw.128.1587584394449;
 Wed, 22 Apr 2020 12:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200420132731.1085015-1-omosnace@redhat.com>
In-Reply-To: <20200420132731.1085015-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Apr 2020 15:39:43 -0400
Message-ID: <CAHC9VhR5mz2WdSrqho3mn0V2qY1NosiHtaMQ-ncAbFM2+m9eGw@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't produce incorrect filename_trans_count
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 20, 2020 at 9:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> I thought I fixed the counting in filename_trans_read_helper() to count
> the compat rule count correctly in the final version, but it's still
> wrong. To really count the same thing as in the compat path, we'd need
> to add up the cardinalities of stype bitmaps of all datums.
>
> Since the kernel currently doesn't implement an ebitmap_cardinality()
> function (and computing the proper count would just waste CPU cycles
> anyway), just document that we use the field only in case of the old
> format and stop updating it in filename_trans_read_helper().
>
> Fixes: 430059024389 ("selinux: implement new format of filename transitions")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 11 +++--------
>  security/selinux/ss/policydb.h |  3 ++-
>  2 files changed, 5 insertions(+), 9 deletions(-)

Seems reasonable. Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
