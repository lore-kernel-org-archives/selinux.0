Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D39C35E06
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7B21744
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3vm7rxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgBYOb5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:31:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46948 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbgBYOb5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 09:31:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so2459736wrp.13
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BfXH0fX94dK8gA2yPUaULhpzkX2ZdH8eg2ZWLLwQjXY=;
        b=L3vm7rxOWkASwf2jcSm++or7eoFT/uX3ls+fmBbQywFNIsQQjywaVSJQ2Ez1ystHVL
         2CMoHIviFO7WRLzqu8/D1p47O15GAMEACwYhLR1iXIayE0YfR4D1DcQakbD5a48jxjSV
         Uhx9rQMv8miyjKevx8F8XnrP7fmziiGCwvppPgCsnHpbX7Pz0ImYqDq+SqA4qMPSexZG
         j1KCpu83gjFG8hXmIQGuwGaYKgRa6Qs7qo7fkQZn7NOaPVrFUTlbKFOBP0OteKiYjTDW
         0zNqfXEfJONH3Dm2ExWSbDVcNmMq+6piAswk8alyiP+6MZhlmzxIML8h8H9OQ4eMoPck
         gurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BfXH0fX94dK8gA2yPUaULhpzkX2ZdH8eg2ZWLLwQjXY=;
        b=bzjZq1xxqIlxJ8vz9GAFFnRM1cNYIv7nBjHsJNLANjUmdL3T/26mTvjdtF//EKsuF+
         0RymdlNiGl0iQkj9rdJbTniMR4VEx5IUzEg9FrcF4FhsDoF+LtTU3fs7jd6+Q2JWb0EQ
         1w3AoHgmuGroRbUz4xd3iAEHrqfY+Ss3nK183afIWkeU1eOkyvtcbqZQUwvD9zyWA2y6
         nkyh+IAADccR+DuqFtKD94lCx5w5Kf3Iyx9fV2vuPL8FoXO/1XAZ5KzOxnQ+VkCZETYp
         zFDI7Fy+IWprJoMCnmvsr9k+npT3GUDRg2cfxameuLi83/TDDz1mOqagft0tjJmF55Sg
         uwug==
X-Gm-Message-State: APjAAAVqKA4fSlYGclPVLV864lCmsKaiWUevwYn9hpUQZFtGd03tSjwC
        Ei9iaQauVFWS+k42JnrkHya+PkmlLklr/Iilw/DRnA==
X-Google-Smtp-Source: APXvYqzYGCrNfLg88sMYRA398aWY0SY0KjK0f1SYQedn7NwdTSQn/vgAdC5CxxR5ny/YP9KEiEx7M68T3BXHlsu8HA0=
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr77480614wrt.271.1582641115370;
 Tue, 25 Feb 2020 06:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20200219202737.18524-1-cgzones@googlemail.com>
In-Reply-To: <20200219202737.18524-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Tue, 25 Feb 2020 09:33:26 -0500
Message-ID: <CAB9W1A2=aXm+Zz_3Bi82Qj8-WRzay6Rx2=3yjHbDaR4rPg2wqg@mail.gmail.com>
Subject: Re: [PATCH] libselinux/getconlist: add verbose switch to print more information
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 19, 2020 at 3:28 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I don't have any strong opinion on the patch itself but am unclear on
the motivation for it.
More generally, the libselinux utils could stand an overhaul:
- a number of them are really just examples or tests of using the
libselinux APIs and not really suitable for end users in their current
form,
- some of them should be prefixed with some kind of namespacing (e.g.
se or selinux) to avoid potential conflicts,
- there is overlap among getdefaultcon, getconlist, and getseuser;
probably should be coalesced or some dropped

I think Fedora renames some of them and omits of them from its package.
