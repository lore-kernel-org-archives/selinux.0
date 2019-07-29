Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915FC76186
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BE32067D
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIc3w7Q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfG2Vkx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:40:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41153 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfG2Vkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 17:40:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so28685997pff.8
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xs2xbArNjlAd/eCn2GAtVz826B03NkeaFaeSWdY/6K0=;
        b=QIc3w7Q6SEfOE4onxDK4GcywpIvsLDTjmZaELSQ9J/hdWVYisAcYM0OxxIg6wqZO/X
         OCgmhOsNTuxrU3jYBv16oPuN1bPWShF0wz/Mgg4IdW0vs084SrpszRfMQRl1sMop/jSI
         jfJ2agJ9lKHYmlJGzLztJF7l2h/ob2ejI/BrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xs2xbArNjlAd/eCn2GAtVz826B03NkeaFaeSWdY/6K0=;
        b=ty7wwgfRYGJLDrZMFjnmhgbO9VtB5xZ3wkXtmy1zpuklrCihjYTZaRhO8YSASUEuWs
         qEvwHC+iUX9E0F/qBBGcePLhlJ8zeDnk5cYlpu9MCjauqw/EPrHGdO4YKQsRglPxOlgZ
         miTUNWELMC7TnUM75Ul/ZUlOFPNrL6SQyaF2EjSA8xwPchnb7nqSM1hqOBnkgeWqCcyj
         sjg3h3KyaEQygCytL/lCAPsjnnht9I9We79fb2fTv3df7BbDivvp6SUVJmvURGMGwduM
         ZDQDA9vVdAnjdml7UBFse8QuXMaJkQPxvV9ru4Nli1NfWtleyaFvLOSaFLZWbLwlijgO
         gqog==
X-Gm-Message-State: APjAAAUz9e7SuCkKz629vw9thrfMPL7BZWRCGatCVN0ThMMLhaGYhXB7
        y/BJoJoM6BwQr8RnOSIU9bUfLAftylc=
X-Google-Smtp-Source: APXvYqzKH6RZBmU+KlDCxrdOG129tmmQGUFimWAI+UZI9PckG1+NvlIos+RuEhAzbm9fb9+rMII3tQ==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr113021055pjw.60.1564436453046;
        Mon, 29 Jul 2019 14:40:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s3sm23431878pgq.17.2019.07.29.14.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 14:40:52 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:40:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 26/27] LSM: Add /proc attr entry for full LSM context
Message-ID: <201907291440.B073758@keescook>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-27-casey@schaufler-ca.com>
 <201907291018.CD249AD02@keescook>
 <ea34ed4b-1f34-d896-7c1b-a7a5a304594c@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea34ed4b-1f34-d896-7c1b-a7a5a304594c@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 29, 2019 at 12:22:37PM -0700, Casey Schaufler wrote:
> On 7/29/2019 10:19 AM, Kees Cook wrote:
> > On Fri, Jul 26, 2019 at 04:39:22PM -0700, Casey Schaufler wrote:
> >> Add an entry /proc/.../attr/context which displays the full
> >> process security "context" in compound format:'
> >> 	lsm1\0value\0lsm2\0value\0...
> >> This entry is not writable.
> > As this is a new API, would it make sense to make this a bit more
> > human readable (i.e. newlines not %NUL)?
> 
> With the far reaching discussion about what format would be
> acceptable in mind I went with Simon McVittie's suggestion.
> Also note that AppArmor includes newline in attr/current,
> and this way we can preserve the existing value.
> It's compatible with /proc/.../cmdline and easily keesized:
> 
> 	cat /proc/self/attr/context | tr '\0' '\n'

Okay, cool. I suspected it must be the result of so many bike sheds but
I couldn't quite find those memories.

> >  (And if not, please justify the
> > reasoning in the commit log).
> 
> Good idea.

Thanks! It'll help my poor brain. :)

-- 
Kees Cook
