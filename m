Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E711C04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 22:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19D62089E
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1f8aQJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFFWxp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:53:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43771 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfFFWxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 18:53:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so17226plb.10
        for <selinux@vger.kernel.org>; Thu, 06 Jun 2019 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9tPuqXSnLLqDLK9V1P0M5vhpLVYOBP8IPwaJBuXaxE=;
        b=S1f8aQJ6Rh0k4EEU00w4NdE3m5Uhc2QKSDfNJjfAJwS6NdpH4PuH+zQ9CsJBCE2ZBV
         mTFCVBykaMIO93rk4Jc+hFnoQZU5qYoy7oQf11iMgj94DLgZAcsd1lWVCDzlg3xb8d0W
         jbmdE+hTRSfFVNrKMtp4vUG2jbYEqobgH25Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9tPuqXSnLLqDLK9V1P0M5vhpLVYOBP8IPwaJBuXaxE=;
        b=hkoPZVxUPGQdJrH/ANG7QDapX+cIw4NomTCz/YS04BV/SeXU6x+9yKzJf/IiobPmxI
         FXBN64mWqlZPKBIPDLw5uXJ3qjsV70v+y5/FhnrcxIJu4+QvMe/p0zdFd7AH40r7eDKo
         8m757icSH1vPEi4QpsIxZJd5pUFVbTBuuIZUWhEVG6tO9y7+2BBRIjEZ1qxB3wyfljcx
         4aGP5pAkbkdx6iA4hc/JVmjAd0hP3PO10VRK8Qhjr1xocXe8qpNS9GpkAz8aYgxAiN+z
         TQvQ5b2gsUEdTQBTYY9PsYyJSOufnNJGswhJSxyMHkX3VrmTVEoCeBLjpD27CmYoNL9i
         rLnw==
X-Gm-Message-State: APjAAAUpWGbOj4mrJL3z+oRJljTtSSTfqSG8hVlpFNVjUzuyyhaWXzzn
        92eTs3knBS0Ty8KvqzdkFosUyQ==
X-Google-Smtp-Source: APXvYqwl49yrDs6w/vlkudCMHeZXfti4PypjiqEguhgK96oOW05IDR+W3joYb29gLc4fMFwb9bKg2Q==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr52416459plc.2.1559861624700;
        Thu, 06 Jun 2019 15:53:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm202339pff.31.2019.06.06.15.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 15:53:43 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:53:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Message-ID: <201906061553.A3BF62257@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
 <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
 <201906061138.BFE4CFEE@keescook>
 <dbafd99d-aab7-c497-fbe9-fe467b0c237a@schaufler-ca.com>
 <201906061351.B12D10D5D@keescook>
 <5010ae20-ce00-be1e-0c2b-7568282b6b39@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5010ae20-ce00-be1e-0c2b-7568282b6b39@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 06, 2019 at 02:06:44PM -0700, Casey Schaufler wrote:
> I'd rather describe what's in it than how it's used.

Yeah, good point. :)

-- 
Kees Cook
