Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F0AC48BD7
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA71214AF
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g66r0h14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0RH3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:07:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32776 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RH3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 13:07:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so1643778plo.0
        for <selinux@vger.kernel.org>; Thu, 27 Jun 2019 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjrNNd6jKuOENqivRCcx96Wx7wxTY+hBV+/1VBbN3mg=;
        b=g66r0h14ua6IfSpYMOHuG8frq0vPDk44KGrnt+3UFVkNg8zjZqzxfhEbybAmhFgbYT
         YC1spOx+z3Bt4uYQ0nMM3NElgCxFC4wd+H6U+3jmeSoPzAUtxH+qwKVjRLbG11LsuHPi
         WGZ9t6GN8fcL7P7D1D/5jV/jgNZuemMWmqA/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjrNNd6jKuOENqivRCcx96Wx7wxTY+hBV+/1VBbN3mg=;
        b=qH93qxw28SnnxyrPM4EW784+d/pT74nd28wo//LzY3EpRYmMVnadlviI3mfgCTZ47I
         76fKtZmjJObifpyeeYhYSo0hL995GxSbW/GSFkZx+9bg9gINDQ8kVtLJs6zEmT53gQ5z
         5dYHxMn5eKNqYWVHkeSKlbN7DlbzIJ3+ZzIJT1lPkAxkfRo5cyFbQb4eRyYBJJMgLJTx
         O3W/orELVq1dWuFU569c6qMGnL1etZ8YUJZBL0rebVMpYvJ7A7APHICSSVKa+59dfioU
         kKq4MlAFQ1i5PwQoEcDRmz9zoBpxpeTKhkLjPE+Xzg+FE/D9DdW0sVMgitRheZA1id/8
         78zw==
X-Gm-Message-State: APjAAAVAIS6vd/TopGiNx0lLy5fEKUWp+m6o6XJF5RRg//2K8rUGr41D
        gHq0k7TUrgb6xaT6J2Fw6q/XBg==
X-Google-Smtp-Source: APXvYqxZtxonPJl/JfomojA7Fc6G0iKNGHkEJuxMqYAK6di8HYz3o7UcLfvPVacLLYrn+NunF/MM/w==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr5790165plb.118.1561655248797;
        Thu, 27 Jun 2019 10:07:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n89sm11405192pjc.0.2019.06.27.10.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:07:28 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:07:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Message-ID: <201906271006.57DE3C2@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <alpine.LRH.2.21.1906271230490.12379@namei.org>
 <alpine.LRH.2.21.1906271245210.13254@namei.org>
 <alpine.LRH.2.21.1906271344480.16512@namei.org>
 <alpine.LRH.2.21.1906271409460.16512@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1906271409460.16512@namei.org>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 27, 2019 at 02:10:18PM +1000, James Morris wrote:
> On Thu, 27 Jun 2019, James Morris wrote:
> 
> > Confirming there's no oops when Tomoyo is un-selected in the kernel 
> > config.
> 
> n/m, the problem is still there.

Were you able to test my fix for this? I wonder if what I found was just
a coincidence.

-- 
Kees Cook
