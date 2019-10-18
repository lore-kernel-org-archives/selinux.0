Return-Path: <SRS0=WnGO=YL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF4CA9ECF
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 05:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBEE222BD
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 05:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aaMRinkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfJRFW7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:22:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45918 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407641AbfJRFW7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Oct 2019 01:22:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so4815157ljb.12
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2019 22:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMJaEYZh6ao/YRuYTW1CqBcQX7ARqvhEcTOFnS4ulPA=;
        b=aaMRinkpQw6LiO2zd4X3cQb+Nctf2gsz5IEOxo016KpM/rq6GDA+EwYBMhyIhve8Bz
         XuCRBFdalr0Gt4i+8+uBdLq5XUTviyWhIUq1e1aQahJu0aBub6YtaKMLUFVZpa2F8oSV
         v1fHMSG8QTFrYcWb+7fCI8/pVL4M6cwFZNBDo0Tu8wYc8Fo+Ud0Oh7UFd8ad/g5nvMxj
         U+pL9IEo5zPoYVLIO88azUp8GC7UVo+l/KjIM0QNkihGGax2V02VHWW6M3zebpcVzAnc
         ibgoOYulWpDEdejnYOVioV9Zf+YYunL5r2EuM9qHNK+NgIkYzk+mUrsvvUu9uzD6AV6+
         cEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMJaEYZh6ao/YRuYTW1CqBcQX7ARqvhEcTOFnS4ulPA=;
        b=JhidLC4zSUEE5SIieektlkSkdaIQl0X1BtxkrFLeP12cTw6LFVSwmIFDCZP5xqiz34
         ZRPvBZLlAwB6Ns02hienbuv4Wixo3D1dSsAjNtHRDxPuHRjWGw1UhHYUxO7v0gBk0wK9
         aC77ixHx2X5JZ6Av4Rw3iLQs3ZZKwcCLBaipYTp3wLkfhdR0Llsan2pBpXLaIwLN71JT
         bEJptRIYEU0Ox15k/Dc9KB7QIwKqJaeCrsDwSzyxVpcxiqc0Oh+EBIxgTkYid+MTjfxP
         aDkPxtJ2aObNmRDdfu3gipJ6pgnOIWAY2HIdalM2Z9zdK69LgSW5dwz0y+K3smjsK/Gm
         HjAw==
X-Gm-Message-State: APjAAAUf/cx65qh59Ifckox/8O0dd1lZ8uAJnYWgnObOs9URbNuV7CVv
        4S/cxV0VJJQ0FHYmXgk1NoS6UEnG3KM6i/cvIbvSM1s=
X-Google-Smtp-Source: APXvYqyljQdRYDJCo4CyI+XWdj/f9O3v48mSaeIknl6xNUKUjzjYl4lv2idfVSOcRAC+W+OTN7DINzbOivxwBQFN6DQ=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr4397443ljm.243.1571365978341;
 Thu, 17 Oct 2019 19:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Oct 2019 22:32:47 -0400
Message-ID: <CAHC9VhQ86rm86CyNEXM_eXcG7iM7a_67-iE6e1vZcpB7uU3mzA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] SELinux namespace series, re-based
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 15, 2019 at 9:25 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> After a long hiatus, I have re-based the SELinux namespace series
> on top of selinux/next based on v5.4-rc1 ...

Thanks Stephen.

As mentioned previously at LSS-NA, in an effort to get this moving
again I've pulled this into the 'working-selinuxns' branch of the main
SELinux kernel repository and I'll keep that branch actively rebased
against current kernel releases* until we get to a point where we can
merge it all into selinux/next.  If you are reading this email and are
interested in helping with the SELinux namespacing work, patches are
welcome (and encouraged!) :)

I would ask that those of you who are interested in participating send
your patches with tag on the patch posting so we all have the correct
context in which to review your work, e.g. "[PATCH selinuxns] selinux:
make it work".

* My initial thought is to rebase the selinux/working-selinuxns at the
end of each merge window against the vX.Y-rc1, but if we need to do it
more often we can.

-- 
paul moore
www.paul-moore.com
