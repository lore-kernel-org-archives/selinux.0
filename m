Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B1C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6F6206B7
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Zm6j1/lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6F6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeLDPjq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:39:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52670 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDPjp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 10:39:45 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so16029389iti.2
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8Usk423ndDeBccwZQwGZOTk5EVc8Nkd0vtAXLOPWCI=;
        b=Zm6j1/lgonn7mxUEQUaaOFqPeS0MG1V9gjBHo3EdxrJvY73h5nDBiZlj9Kqm59GHUU
         9GZzbIikny1ojO4y/4OWvUA0iA9ekcOfIbXU+mhaQ/YwUOVExT3wU8dRYR+YCPLYxEc/
         V93sl1AOVa6hYmaFAHXRYcEfqNPVAqKhtqfz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8Usk423ndDeBccwZQwGZOTk5EVc8Nkd0vtAXLOPWCI=;
        b=n+u9ihYCBdajBV1pScarOe1D+PoBLPtwD0S0qsYy0RD542eNDpGzEKl25kLITa2sTu
         ED+xLCACKIBQ6SfhoxroorJQG4LbK+Ujc1vVidZt7hhulKVHqtcFCeliOSnRZtY8cvML
         XtJt7yymDGKspzhzUd3MOh56ZyNGVLgxILQDOMviJJ108GidEJ2iuHTKcnFLOHm0X+UB
         odPcizrlb/T6VPJ0o1RHEjWDHZuRGQU7ASde86V0xwFZirvx06E6aX36cNdc9i4M4+bX
         UljL8VMiPc+PXhRStMTj+i0wxnMRXlpmmbHmU+hl+o2fbgxAZNW0BDxcSKq0GV+rWzA3
         2gfg==
X-Gm-Message-State: AA+aEWbLkr8gz2HNFNRLjQLYeIVhUbAcyLXwTIUfJTCMcWoSO0W00L6n
        sY9TwpTLSGtNVSW5qMliT/3SISPDWW6gtWSi96jQGg==
X-Google-Smtp-Source: AFSGD/Uukdfxz2wdIR9pmQaC3nXEZWbQqPHsE1lrM9ATsYrO3ENH9cJslrCSclHqhSXdAkgn1H2eskXdT4C7z1LxixA=
X-Received: by 2002:a02:a484:: with SMTP id d4mr18422781jam.77.1543937984513;
 Tue, 04 Dec 2018 07:39:44 -0800 (PST)
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
 <6feb656e-b1e3-5839-ce5f-669ae5a55b7f@tycho.nsa.gov>
In-Reply-To: <6feb656e-b1e3-5839-ce5f-669ae5a55b7f@tycho.nsa.gov>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Dec 2018 16:39:32 +0100
Message-ID: <CAJfpeguJoEOEjQs4ZpJQaJXF-xCnevUApzNobwmqNX27KQ4vHQ@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
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

On Tue, Dec 4, 2018 at 4:32 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Ok, I concede the point.  Not sure what that means though for v4.20.

I have the revert queued up for v4.20 as that's the safest.

Don't let that stop the discussion, though, I'd especially like to
hear the arguments from the Android side.

Thanks,
Miklos
