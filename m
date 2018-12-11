Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A3C07E85
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED92087F
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ujScWShj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ED92087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeLKQM1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:12:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33401 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeLKPub (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 10:50:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so11171169lfc.0
        for <selinux@vger.kernel.org>; Tue, 11 Dec 2018 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHL+Nvba+SSuygE2OtgDLRI+oC72JVSQXLOITh5VVeE=;
        b=ujScWShju2x6Yskrl0iuCFDmNoOXB7z+3ZXkESfRR5vlrDVk0F9B+m7UwpGBeF2FCp
         ie1ooEeVx6uzWV4tuAii2mKFVgikkOcqz9bzDZqhNDVZ/wL1Q/eNBnAagGt1rIrG7YvE
         dTNPgBOPNhH/Hc0aoI7Io7UbvZwyHsnczuwYh9Fa1JLiiWdW0oldLuUyI8N8qw+UZzb8
         nGa5jFinJkQOcgDuXFI8UigkpSphFoTTyCH9AIDKuehBZBrBITwhopHMBYwyWQV0k7EU
         /ZiU0NggvtjzzajSk6m+bqTZLCprODHO8uuMoKERdpdR+nEFBvOGlYGsdYX5hIOBy0+V
         d/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHL+Nvba+SSuygE2OtgDLRI+oC72JVSQXLOITh5VVeE=;
        b=jtpuz2TuvyzZ45X0zLukrjKmN4iCgQJbY4W6yIF3QB7MmrkUEmOq1YIfLJOL+UTp5K
         LUyUrFxijBQpxs5e+snop2svBq9X41h01waUYfQr58nZyB5AW5HQ6/PpJsH4+b1cqQQr
         GK7eQcEQu380yRB9hJRdeG2ODG7XNjDGefHGmVpWERmkfOqsoJThww0M2KLJ5T0/74pP
         WKCm7tEUuL6AUPpqKdJeAbl3/jMwoMe92Ggovq6brptlsPWbT5zHj8HfBJan6mMzWM4X
         MWNLt+QWxUY/t2BrzjbBo6Ua4q/3sXew1BDlVcNTtOKi8JXaXuywM9e0rZDcmLl12EMT
         UMCg==
X-Gm-Message-State: AA+aEWb5iPsQdtceSxTkhnvZ+4Pwy8sfbU4mvSQ54aBKc12ViEZh0ErE
        RBATOzVrhAKxqyBYiHPH+ICKI4qUFnJG7/0mEJGf
X-Google-Smtp-Source: AFSGD/XW4RWzDk6ae8Iq3SiINLsYv69jlFEnUrTfX/F4I85Kn5Kc/9/5a/iUYIXxVu6AUjE2kNnUc1ql07EsGFa1Qns=
X-Received: by 2002:a19:e601:: with SMTP id d1mr10042516lfh.71.1544543429117;
 Tue, 11 Dec 2018 07:50:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov> <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov> <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
 <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov> <CAJfpegujwNpWL5Eujrb+=EQF8OMOkO03yq8ZZSkfhFfwQvhGKQ@mail.gmail.com>
 <6feb656e-b1e3-5839-ce5f-669ae5a55b7f@tycho.nsa.gov> <CAJfpeguJoEOEjQs4ZpJQaJXF-xCnevUApzNobwmqNX27KQ4vHQ@mail.gmail.com>
In-Reply-To: <CAJfpeguJoEOEjQs4ZpJQaJXF-xCnevUApzNobwmqNX27KQ4vHQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Dec 2018 10:50:17 -0500
Message-ID: <CAHC9VhSV4a949kvh8Tq1acXzRddW915naWiaG-yqVS1_JyqgEQ@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     miklos@szeredi.hu
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, vgoyal@redhat.com,
        omosnace@redhat.com, bfields@fieldses.org, salyzyn@android.com,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Dan Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 4, 2018 at 10:39 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, Dec 4, 2018 at 4:32 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> > Ok, I concede the point.  Not sure what that means though for v4.20.
>
> I have the revert queued up for v4.20 as that's the safest.

Miklos, when do you plan on sending the revert to Linus?  I just
tested v4.20-rc6 and the problem persists.

-- 
paul moore
www.paul-moore.com
