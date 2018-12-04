Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9FFC04EBF
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF702081C
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 13:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cHHQbr3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF702081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDNcZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:32:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34587 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLDNcY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 08:32:24 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so11348593itd.1
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZ52Zx/KCfQfQv21h5YNtPxuM09B4zF9M/ZuuyDoMrQ=;
        b=cHHQbr3Mmns6BUJ03hUGsrgk7GRKkG6Von1EliWGWTqBXlvfyOwXM2TcedI0YUsskS
         VYUTvu8sUJVjnuQE+Du3QnulF9lmjI2VyV0KDbSOYQaKbVcTpnqVOBtuRplOI2vnOVbV
         PpoS92cfzrjV9LV7xqw+b4q+n/ckrkmGHzeiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZ52Zx/KCfQfQv21h5YNtPxuM09B4zF9M/ZuuyDoMrQ=;
        b=PvQRpm7GHqx8wWUnY3ECKyOWnQxHz0Req5RyUJ38sL1UMtY51R3aTFUewLpGq9tORS
         1xo74m+pUkPutKQ+aUUn8PdAB7/P/RtiLtOrr81VE+u+FSmK5yYsUFqi2lDpGeAxGOr0
         pc2KO/GEIHNfxik4tEksOtWjpScR3Ge57wJRjWapRqn5WD7s3561nHM6CrI155cPqeRq
         L0TvK+rDyoi54tkD5GZ2zzO0Ep3HYWzhJcwEPXW3WQv8ll3/F5fLbLTY+TZJle+kqsPQ
         8nfD/lNyT9AL59FFasKwvNlWfQzlxD7rMjk5oU5eDr7zQmaoRD59XKf+LjJdvbAg0SOg
         yRpw==
X-Gm-Message-State: AA+aEWbLXDRU+Ex1ZFki6As+HlmDnv4yGIC24MkcTnS9bAGxIfE5qRbS
        bagr/hymzdurJbpi67PUSyd+CN/5G/jmyZPXE0YIkQ==
X-Google-Smtp-Source: AFSGD/Vyz5Dob3rk694nj8Nf4wxqhzJyVj9FoqYO8dzY5j6+Lmt5e1Uo8L66POWXo7oeEbsL7fvP6hftsIBYa8syTGg=
X-Received: by 2002:a24:710:: with SMTP id f16mr10278314itf.121.1543930342005;
 Tue, 04 Dec 2018 05:32:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov> <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov> <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
In-Reply-To: <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Dec 2018 14:32:09 +0100
Message-ID: <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
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

On Thu, Nov 29, 2018 at 10:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/29/18 4:03 PM, Stephen Smalley wrote:
> > On 11/29/18 2:47 PM, Miklos Szeredi wrote:
> >> On Thu, Nov 29, 2018 at 5:14 PM Stephen Smalley <sds@tycho.nsa.gov>
> >> wrote:
> >>
> >>> Possibly I misunderstood you, but I don't think we want to copy-up on
> >>> permission denial, as that would still allow the mounter to read/write
> >>> special files or execute regular files to which it would normally be
> >>> denied access, because the copy would inherit the context specified by
> >>> the mounter in the context mount case.  It still represents an
> >>> escalation of privilege for the mounter.  In contrast, the copy-up on
> >>> write behavior does not allow the mounter to do anything it could not do
> >>> already (i.e. read from the lower, write to the upper).
> >>
> >> Let's get this straight:  when file is copied up, it inherits label
> >> from context=, not from label of lower file?
> >
> > That's correct.  The overlay inodes are all assigned the label from the
> > context= mount option, and so are any upper inodes created through the
> > overlay.  At least that's my understanding of how it is supposed to
> > work.  The original use case was for containers with the lower dir
> > labeled with a context that is read-only to the container context and
> > using a context that is writable by the container context for the
> > context= mount.
> >
> >> Next question: permission to change metadata is tied to permission to
> >> open?  Is it possible that open is denied, but metadata can be
> >> changed?
> >
> > There is no metadata change occurring here. The overlay, upper, and
> > lower inodes all keep their labels intact for their lifetime (both
> > overlay and upper always have the context= label; upper has whatever its
>                                                    ^^lower^^
>
> > original label was), unless explicitly relabeled by some process.  And
> > when viewed through the overlay, the file always has the label specified
> > via context=, even before the copy-up.

Okay.

> >
> >> DAC model allows this: metadata change is tied to ownership, not mode
> >> bits.   And different capability flag.
> >>
> >> If the same is true for MAC, then the pre-v4.20-rc1 is already
> >> susceptible to the privilege escalation you describe, right?
> >
> > Actually, I guess there wouldn't be a privilege escalation if you
> > checked the mounter's ability to create the new file upon copy-up, and
> > checked the mounter's access to the upper inode label upon the
> > subsequent read, write, or execute access.  Then we'd typically block
> > the ability to create the device file and we'd block the ability to
> > execute files with the label from context=.
> >
> > But copy-up of special files seems undesirable for other reasons (e.g.
> > requiring mounters to be allowed to create device nodes just to permit
> > client's to read/write them, possible implications for nodev/noexec,
> > implications for socket and fifo files).

I think you missed my point: opening a device file or executing an
executable wouldn't normally require copy-up.   If

 -  permission is granted on overlay to task, and
 -  permission is granted on lower layer to mounter,

then copy-up wouldn't be performed.

My proposed sequence would be

a) check task's creds against overlay inode, fail -> return fail, otherwise:
b) check mounter's creds against lower inode, success -> return
success, otherwise:
c) copy up inode, fail -> return fail, otherwise
d) check mounter's creds against upper inode, return result.

So, unlike write access to regular files, write access to special
files don't necessarily result in copy-up.

You say this is an escalation of privilege, but I don't get it how.
As DWalsh points out downthread, if mounter cannot create device
files, then the copy-up will simply fail.  If mounter can create
device files, then this is not an escalation of privilege for the
mounter.

Thanks,
Miklos
