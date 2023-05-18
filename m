Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF8C77B7A
	for <selinux@archiver.kernel.org>; Thu, 18 May 2023 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjERSOb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 May 2023 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjERSOa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 May 2023 14:14:30 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31844124
        for <selinux@vger.kernel.org>; Thu, 18 May 2023 11:14:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6238ce8d8f9so7653256d6.3
        for <selinux@vger.kernel.org>; Thu, 18 May 2023 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684433668; x=1687025668;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5gqmWn7blbu4ZeYGOiVDKvlS4DOirhMTBZspU6kuuY=;
        b=Mijv4iZA2RIKwBC6SizwpKdopiAIhj7FE+zjqY3OAzLt2/0GEHYPO6GIMkD0IrsNyG
         hgbCZws2tbbFVW2W9TyYvVLMT9Q8RyjPhiCvbR3LWaEKkPJKGzzKcYIJ9JJS4gZ589rK
         05bFC44ubaya0vUJG2WlZ1aEr/Ugqlivmz1IsrA5/M6V/5f5oX2DiaoshcmySQpshl+h
         NgbkAiHpRzVft3TJ1SeFbthf4gqbhhw+GJypvdBm8igCb7zDR3WaR4OxEEIwVR4vvt6w
         oV5WWqlPk2FC23rjnN7Fgz1odLewi5i11xEZJqK+CdLvrQN3brtfifox9RUW6841IC+A
         Ed6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684433668; x=1687025668;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5gqmWn7blbu4ZeYGOiVDKvlS4DOirhMTBZspU6kuuY=;
        b=bc8uc2KxRt7kbcWzdbKgHWOZhbIemknSo+NHFVk2OOGXjXIWCwANV18WLhgS89NTn/
         7FEDJR3pTKFDU5OPOKLjH60fcNp9QCFyIhfGDdy2rmx6KSRbKjUj0Q0Hw1rsZdKrXY1j
         mu1MmwsAEY8mSPKI1TaEljBnY9es82WNuQY/TIEF0aASco2vTjwlHZt+P8Z7RbFLbb35
         1iOd1Hx5+JpL/GmmF9lQrmFOim2kCzpJJLJdhjUsM0GKI98hUZ+ZOyENWB6y2dj3u/T/
         M0M+cf9Ygx7gOJftYX01aBVH0SghVi9Nu8w2+Unl9mzn9jdAkRWFUNfOToo1gOJd5kSF
         Ekfw==
X-Gm-Message-State: AC+VfDyDrt9/3JM6CywjWP+eCALa6AMbTwMLYHuLLLADNAtp6HVfYddR
        2XdA8G2ClHx57aSiiw3jOq9z
X-Google-Smtp-Source: ACHHUZ7VR/8hB+ChfPxVJ7Hiw5ib/VRlDvpkl5iTZdSVOqdWq300KobxH21in+x289tyWDhNZRqRVw==
X-Received: by 2002:a05:6214:5013:b0:5ed:fa66:bf6a with SMTP id jo19-20020a056214501300b005edfa66bf6amr646092qvb.52.1684433668271;
        Thu, 18 May 2023 11:14:28 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id d7-20020a37c407000000b0075772c756e0sm555036qki.101.2023.05.18.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:14:27 -0700 (PDT)
Date:   Thu, 18 May 2023 14:14:27 -0400
Message-ID: <047950defef891a64a43101adfa7ae7f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: make header files self-including
References: <20230512092157.41850-1-cgzones@googlemail.com>
In-Reply-To: <20230512092157.41850-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On May 12, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Include all necessary headers in header files to enable third party
> applications, like LSP servers, to resolve all used symbols.
> 
> ibpkey.h: include "flask.h" for SECINITSID_UNLABELED
> initial_sid_to_string.h: include <linux/stddef.h> for NULL
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>     use raw flask.h instead of ../flask.h
>     Link: https://lore.kernel.org/oe-kbuild-all/202305121044.Q88iF2NQ-lkp@intel.com/
> ---
>  security/selinux/include/ibpkey.h                | 1 +
>  security/selinux/include/initial_sid_to_string.h | 3 +++
>  2 files changed, 4 insertions(+)

Merged into selinux/next, thanks.

> diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
> index c992f83b0aae..875b055849e1 100644
> --- a/security/selinux/include/ibpkey.h
> +++ b/security/selinux/include/ibpkey.h
> @@ -15,6 +15,7 @@
>  #define _SELINUX_IB_PKEY_H
>  
>  #include <linux/types.h>
> +#include "flask.h"
>  
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  void sel_ib_pkey_flush(void);
> diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
> index 60820517aa43..ecc6e74fa09b 100644
> --- a/security/selinux/include/initial_sid_to_string.h
> +++ b/security/selinux/include/initial_sid_to_string.h
> @@ -1,4 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/stddef.h>
> +
>  static const char *const initial_sid_to_string[] = {
>  	NULL,
>  	"kernel",
> -- 
> 2.40.1

--
paul-moore.com
