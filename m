Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0D7C43219
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiDDVbO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380556AbiDDUZg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 16:25:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144ABCA
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 13:23:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so15274285ejd.9
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hMpZ1i92AzUQbXFyQZ2NlSP8xYByd2N+hlXPKFvi/WE=;
        b=Y7/AwFpQO5/CiqE2LedVrELu3DzWxWPTKwe45mgAkAu7h/nIs3fbS/VxGA26QMA205
         OaA5IkG4CwQSlLOAdDKlE990cN5GIY94tBqzQsa7Pt4vKdrB88Gl8lvK3gU6eyYYIRch
         i73lt2vELotSokNmWIrtXVqmhOQw0bgIsOpUrvLYUAKnXxMEwYVMEZbyCj94ocjpv0xl
         S6WGiHjUmN01olxpXyNittLlrBKmwsN3mNhVny6224t47dQnjE4uSQ9QhOi8jYq0+lCK
         f55Q/+kx8z400q6104l3rTf2fzgq1n7z/HiqfDqmwDyrOhd4t0MVw8t4/9ej4KDxk5TU
         5OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hMpZ1i92AzUQbXFyQZ2NlSP8xYByd2N+hlXPKFvi/WE=;
        b=ljPJrlxlSoWG+R8k3UWKsUoQEAMT+3UZVIG10fCUZlSmdCV1uk4mGlYhBdLfYKew/X
         NG3W2Pd9s13Wg1NFWk4owW1gw2fH9bvjICfH8HWnv0xx4fDF/fTlDWPPf3q9zvHdK7ZX
         +meP6Z8anUTZy9DvgseqIIN+X+5gyuqjlTQ2EbLGy5cF5OG9iZFtIynwAaZeDVQ5xW3D
         we7P95ePcJWKaTusCKNv1Rh46cAFRYCt3Rsn8bnrsd2MSqcjHtUzQn4OWwc6AYL571kS
         fRx/rXqJjQzxMWtswmcim6CI0XlbG2akCvF7xTkYb2u5Llk9XWHQiFB7blcTrEdUYcVy
         n56w==
X-Gm-Message-State: AOAM530Avl9qUpUPHvY7U4a4BiFVQP5Qhs9vTZvX/fmg3Y/6RIu2aROv
        7GlyDEg+H+sYEkG+ns0ecACoEQJCq9wFElCphRXi/bSv5g==
X-Google-Smtp-Source: ABdhPJxZWbQSzH6HVRHrotJ8TAUxEbndwrivCknG1kIqukFxNN/x5BP2th7Ss8S93kpX9E82nO3tA5ssyk2ZvZc1qLE=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr1852843ejp.12.1649103817267; Mon, 04 Apr
 2022 13:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <164617518151.117500.8843073220563946007.stgit@olly>
In-Reply-To: <164617518151.117500.8843073220563946007.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 16:23:26 -0400
Message-ID: <CAHC9VhQarrSeBrcz5RB7PykdbYqujYmz_iBvYxHTrOvnN9A9QA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 1, 2022 at 5:53 PM Paul Moore <paul@paul-moore.com> wrote:
>
> We deprecated the SELinux runtime disable functionality in Linux
> v5.6, and it is time to get a bit more serious about removing it.
> Add a five second sleep to anyone using it to help draw their
> attention to the deprecation and provide a URL which helps explain
> things in more detail, including how to add kernel command line
> parameters to some of the more popular Linux distributions.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c |    2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/next.

-- 
paul-moore.com
