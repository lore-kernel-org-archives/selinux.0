Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A8C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009A2081B
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZRz38ezI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F009A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLDPbX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:31:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52787 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLDPbX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 10:31:23 -0500
Received: by mail-it1-f193.google.com with SMTP id i7so15978682iti.2
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPEcasuvIkykLXkz3xtr9n7YEQ3OLRNs55vrLzEo3XU=;
        b=ZRz38ezIbmYM1Vy4OBC0HGw86a9yitfXv6l2IdwijOMZvBf9fQqRRERZQx8dOcNbTA
         0HToTL7CVMABcbqKNZriKVIk89qei+/6Mmgot0pL80NJof8TYPaLyz2TvPIDbliLKeMu
         ZZyq9koLwwA6vv/zgyehhnGpDtxNmhRxWcTW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPEcasuvIkykLXkz3xtr9n7YEQ3OLRNs55vrLzEo3XU=;
        b=ndtmt0et0rP8cn3wXd/edzfvDfOi1dJUXkynhnqOT/GTa0c96ztk2u5KYwKjTwsojg
         f9KKRZJJOGQvc05KPKn5vuhhDSuEdTPn1gaUCFvkDNOlewcMtD4sVbajyoEv5nnnFnPQ
         Mk3NRk+sVejgR5RANP+IVn244sBsPKNczVEzivAf81RHnmRh9AdZexkZtLJKtQYHhm4X
         gnDs1Hmg88eHDpDLjBlv0JBVvwfLXMTM/xQZAIXwwU/CLABcOEJ7kiBUZ7e5pzJJiRRV
         fGa9s4ELk1rQ8/alAhmhrjwji/X6RidqZNqTpHrl7umyfJoPv0tOS20UCsxQlaXx3Nxq
         RfGQ==
X-Gm-Message-State: AA+aEWZZbVmYhTS2Fz5ZK/cvVIH0rf2ZMFV+1cmnHtdRBt/DHKukECWE
        l6Qx3SmPGNl6pIi1Fi/WuIdHNJTyvswPpo36B1v9jCBj
X-Google-Smtp-Source: AFSGD/UTvoLvYDKnsMY5QmvGD9yl9b/XGwRTqgQFC8Of6iT5odDfv56MAHoMiRh03Ri9T+FsiX9MHXQY8vHbWCdGBsI=
X-Received: by 2002:a24:a08a:: with SMTP id o132mr12227037ite.1.1543937482440;
 Tue, 04 Dec 2018 07:31:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov> <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov> <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
 <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov> <20181204151549.GA21509@redhat.com>
 <20181204152248.GB21509@redhat.com>
In-Reply-To: <20181204152248.GB21509@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Dec 2018 16:31:09 +0100
Message-ID: <CAJfpegtFVvq286HAorGLg6ywMsfs51KqaQwFkcuV7Dtu8TLaLg@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 4:22 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> Having said that, this still create little anomaly when mknod to client
> is not allowed on context label. So a device file, which is on lower
> and client can not open it for read/write on host, it can now be opened
> for read/write because mounter will allow access. So why it is different
> that regular copy up. Well, in regular copy up, we created a copy of
> the original object and allowed writing to that object (cp --preserve=all)
> model. But in case of device file, writes will go to same original
> object. (And not a separate copy).

That's true.

In that sense copy up of special file should result in upper having
the same label as of lower, right?

Thanks,
Miklos
