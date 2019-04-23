Return-Path: <SRS0=RjX6=SZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B16C10F11
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 02:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4022077C
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 02:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO8HomZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfDWC0u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:26:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45114 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbfDWC0u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Apr 2019 22:26:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id k92so11134415edc.12;
        Mon, 22 Apr 2019 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S86gXrlSgrQyw2qeuiu0WrX0qYocZiFr1+s0woZm9Zc=;
        b=FO8HomZK/O5f/PD68nDM7HR939AAXsH7EVJzsKILdUAEDo5c7uk8kDQbOH7KuDZ/ET
         JRHTB+eHL3t4YgxiYYJNwBdXdYxEiODveXOD7gKTXpMLEpBZ3nbhYXpj1IQDsfRdYf9Z
         uxenF1Sd+QP/4rQ3V2WU7SNC5EsFPVFeMra7t57eFQ9Qu7Cu/0I2rHeDpUH+X7PRysXo
         WISldu5drV5WSWEas6Pea6UPdQucFT40NhN0ojo6KMghkLq8VnyHtcnb0XRCo4mItHqn
         v+dubQdpSjyBDmUq4ZuApuag+2Qkc4lkFA5PrYXg4kpj42mSj/Hs7L9WkJHadP90Y5o+
         Xmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S86gXrlSgrQyw2qeuiu0WrX0qYocZiFr1+s0woZm9Zc=;
        b=OdaBg+52OHPC4r//KAzKeTnsqAg9/zOHAKjTh0ThibgSPK063UEzsqO0x34h+SbOTJ
         h+ZLWSPXdDwSNZotOc9P9MMo5M21NOAP+W/sbGot8jcsrRFmSJA/tT8c5jqYhFyNRpp+
         wF85/iyqcI2toZeuZ9h58ZQBG5l4PDvIhQlLnIkrheGEOapDHzM9nf76Xa4ffyr+ZNOk
         gtSM5j0atEcfptUb3DrDMvikgp2LIJTyrXoLTHx3OQUKHM8VCcn0dxhFlxDIkrFVjiCE
         Pmw/UZgStDUmaDlz25Sb2eOYjYUlCfeEg0/4avmvjNBpqaokVAzeujLktW1z8pesEiza
         TIeg==
X-Gm-Message-State: APjAAAVGljWF7KRrTxoZKx9q5GAdy6yN6Pngawd7hJnPNeLwSJ5wJM+P
        Zez1sjwmg7Bd/VTb4L7BqTI=
X-Google-Smtp-Source: APXvYqy7vTeJFZx4hV584nTIwuovl+5aUt6C0rcQyiaO+XgTEZHM+BP5xPeEPvTjkx2xsNGVjeWibw==
X-Received: by 2002:a50:bd85:: with SMTP id y5mr14402988edh.112.1555986408413;
        Mon, 22 Apr 2019 19:26:48 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id s27sm4195061edm.4.2019.04.22.19.26.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Apr 2019 19:26:47 -0700 (PDT)
Date:   Mon, 22 Apr 2019 19:26:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: scripts/selinux build error in 4.14 after glibc update
Message-ID: <20190423022645.GA11884@archlinux-i9>
References: <20190422210041.GA21711@archlinux-i9>
 <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 22, 2019 at 09:59:47PM -0400, Paul Moore wrote:
> On Mon, Apr 22, 2019 at 5:00 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > Hi all,
> >
> > After a glibc update to 2.29, my 4.14 builds started failing like so:
> 
> ...
> 
> >   HOSTCC  scripts/selinux/genheaders/genheaders
> > In file included from scripts/selinux/genheaders/genheaders.c:19:
> > ./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
> >  #error New address family defined, please update secclass_map.
> >   ^~~~~
> 
> This is a known problem that has a fix in the selinux/next branch and
> will be going up to Linus during the next merge window.  The fix is
> quite small and should be relatively easy for you to backport to your
> kernel build if you are interested; the patch can be found at the
> archive link below:
> 
> https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac
> 
> -- 
> paul moore
> www.paul-moore.com

Awesome, thank you! I will apply that for now and wait for it to get
backported to stable after the next merge window.

I appreciate the quick response,
Nathan
