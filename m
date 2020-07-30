Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09174C433E4
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE56F20829
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q48T1W+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG3UEk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:04:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50738 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgG3UEk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 16:04:40 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BA74720B4908;
        Thu, 30 Jul 2020 13:04:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA74720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596139479;
        bh=YPE+I9ZEJip/DLdFnXo/Xe1crHLzi3V6ybUliBj4JTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q48T1W+x1nOBEj0hcOWhn4lqsNeYMH9Myb4bAIILzU8uH1cVuuCYmw5pM7NGiUQtX
         gYeTWUbYNAbItOcYK8W6eaVT+yajSSHjU5egR40XUoxV2mb0LgSuRcoDrd0jBlmnpR
         x1rnxdYAClfs/1zgh0MM7ZY61sMnY7o3mZupn4Fs=
Date:   Thu, 30 Jul 2020 15:04:36 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] IMA: Handle early boot data measurement
Message-ID: <20200730200436.GY4181@sequoia>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-5-nramas@linux.microsoft.com>
 <ea3bba66-9b21-b842-990b-2bf1e4ac2179@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3bba66-9b21-b842-990b-2bf1e4ac2179@linux.microsoft.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2020-07-30 11:02:50, Lakshmi Ramasubramanian wrote:
> On 7/29/20 8:47 PM, Lakshmi Ramasubramanian wrote:
> 
> Hi Tyler,
> 
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> > index 080c53545ff0..86cba844f73c 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -322,10 +322,9 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
> >   	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> >   	default y
> > -config IMA_QUEUE_EARLY_BOOT_KEYS
> > +config IMA_QUEUE_EARLY_BOOT_DATA
> >   	bool
> > -	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> > -	depends on SYSTEM_TRUSTED_KEYRING
> > +	depends on SECURITY || (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)
> >   	default y
> Similar to the change you'd suggested for validating LSM_STATE and
> LSM_POLICY func, I think IMA_QUEUE_EARLY_BOOT_DATA config should be enabled
> for SECURITY_SELINUX.
> 
> depends on SECURITY_SELINUX ||
>            (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)
> 
> And, when more security modules are added update this CONFIG as appropriate.
> 
> Does that sound okay?

Yes, I think so.

Tyler

> 
>  -lakshmi
