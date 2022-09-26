Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42084C07E9D
	for <selinux@archiver.kernel.org>; Mon, 26 Sep 2022 21:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIZVlL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIZVlK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Sep 2022 17:41:10 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C9792E7
        for <selinux@vger.kernel.org>; Mon, 26 Sep 2022 14:41:08 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12803ac8113so11009980fac.8
        for <selinux@vger.kernel.org>; Mon, 26 Sep 2022 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W2AVF3IGelKGE+O6YLBHQ8tWi3g6mJkr5cv6X06x/ZQ=;
        b=6aXsPvMgfNuAhY7nf4b80qGVj30jS3GN6+kmYE+l8WxLNcXR0qp33I83B4i24lv7Fz
         mUUQ8a6tkxU788DVvVkmhUJ2hqB4SPAzLK/8pE9gGoOnaU+75R9aqgoeC7Onb4f7xaIG
         DeN9SK35Ar0bw5QWVTp7vSSOttU9an6n36B530xOwM6/seUd4yRpb/0NhSj4VFDC43b6
         KMRYUIn8Z5L/TChWIX4ob6oko2AtJSGrFkPNFp5uT0kFz7QLMZ7qbFy+kXjNeQxWZb49
         BOXd4tOe68TFTsHEZSuoMegqO829r9Cs+QjWPP2GVHRsCHM6h820rDPguTQtIgGfuDMp
         KTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W2AVF3IGelKGE+O6YLBHQ8tWi3g6mJkr5cv6X06x/ZQ=;
        b=f0Derik4FwtfdgO74aUc0FT6jsbHKfNfH1fsE0qLqslxRfIQKtIIlOCByFJICKrhV7
         PdIEiAS1Xl2CEChj9jmg3Zn6HfxMZLC3DeBjQrxhFVutVGCLc0SD2r+7DWoVEZOswZHn
         uAxQq+gkSFXgvLqe2YT1XizneGwNIIOZnsVAS/4KX7DAMPrSE5z9l0EPnPAFPmgCcY2k
         bMyaF4fT13AhqO4Xa11kttxcBjPyRe89suHLgx1BlIrQRxV07l99HJQbXVfcgm4GZ+xR
         q3v20Pcf9DGrl2OZGKT59hdxiSy6JyRnS6HZRMBnX3QwRW5yTmwMWJznROFGPFPxe1ZL
         64oQ==
X-Gm-Message-State: ACrzQf2N4Qd8idXMHmPns1RnfV5Yea/cXk9lXRfnpZGWx/N2X+2B/pHZ
        lsca5GA7TJYRRWB6cMlZdyRbD7dbBvCXKN8miOuA
X-Google-Smtp-Source: AMsMyM5ddqL9vX0pfl5XNLm2esVeK5dvvP3xtrKw8QvdMX76AdtU9zEfdzazGl5PnsTx/WOg+bWyeV8Du22Q5xvJt2g=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr441021oaa.172.1664228468189; Mon, 26
 Sep 2022 14:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
 <875yhe6ial.fsf@defensec.nl> <CABi2SkW4P+s-+5X7UGYYp1tUtT350_7UfQx_KYqHAyYe31ORWw@mail.gmail.com>
In-Reply-To: <CABi2SkW4P+s-+5X7UGYYp1tUtT350_7UfQx_KYqHAyYe31ORWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Sep 2022 17:40:57 -0400
Message-ID: <CAHC9VhTGDJjFm-3abKtXia-k5jyz7ngV+ZcUkof-=Vt1toLyBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, groeck@chromium.org,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 26, 2022 at 2:03 PM Jeff Xu <jeffxu@chromium.org> wrote:
> Thanks for details about the unconfined_t domain, this is one option.
>
> IMHO: between permissive domain + audit log and unconfined_t, there might
> be room for letting each permissive domain decide its own audit logging
> strategy. The reasons are ...

I'm sorry, but I don't want to support a permissive mode that doesn't
generate denial records in the upstream kernel at this point in time.

-- 
paul-moore.com
