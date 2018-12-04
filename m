Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42760C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088072081C
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 14:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fjfeRnG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088072081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeLDOqA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:46:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37933 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLDOqA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 09:46:00 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so14743094ith.3
        for <selinux@vger.kernel.org>; Tue, 04 Dec 2018 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g32YqTA80V6kUsfx+TbEyMJOZvuwJB1QJlsNROCRuVU=;
        b=fjfeRnG2tSePA6vDhDxv9wsQGy4eOWo4RR/eL+AHMYNkP844nH7JeykS4onSFSxMjq
         gM7jAb4y+BSJ9222KtucEpAu3XkeJgf4CUOKT9A+3mQf4FeKZw0g2x6lRkiTP8JsOElA
         c0fN2p9DnRxY4Z+gjK0P8UUxRKO2PmoTu0qfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g32YqTA80V6kUsfx+TbEyMJOZvuwJB1QJlsNROCRuVU=;
        b=IbkU/ZAs0xT8cRdo3mmbcy8mrEOB03Oo6ELggc3vmNPq7UkaH3QTRXnbNEkY0bxp3T
         meQQ/1PmknSid/33HfPtlRzmI5fEkE3YeVlzc+b1tRSaOtDclltin+K3IbZdmlRowefe
         Kb7PXPw7hK0xVRjM1rBHP1RpJYs8S+CgdMl29aOYhn/wRTilrRLua/LezlKHMTgRTieo
         SSGAQgVbFB2jiJ3xdlGipyiPLzpkN2lZurfVG7Iya9KFPNs5LWmZSppWKZWRdlzucNX/
         VypO/ev139tu7qR88SNtmTIkQpAp1bTFdtD1egL//BGT8b+furQA6DWy7buoTn781flH
         WtEg==
X-Gm-Message-State: AA+aEWb2rpVbnfcZ92DNZg1aQXuz6YN2rpSAv1lI1AdExzFHyV03IbQe
        edduE+ZVTeVxSqt+D2Csqi5pNYInjKTlpC5S+1afwQ==
X-Google-Smtp-Source: AFSGD/UKGia79uPg6xLcuayor1AMNGZV2YnIRQHmXYZRlKJ7tNZ6/uJT74/CEViZI8zJDOJA1B08Ya3h5rkmDYLSAwQ=
X-Received: by 2002:a02:3da:: with SMTP id e87mr17254771jae.78.1543934759464;
 Tue, 04 Dec 2018 06:45:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov> <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov> <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov> <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com> <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
In-Reply-To: <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Dec 2018 15:45:47 +0100
Message-ID: <CAJfpegujwNpWL5Eujrb+=EQF8OMOkO03yq8ZZSkfhFfwQvhGKQ@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 3:28 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 12/4/18 8:32 AM, Miklos Szeredi wrote:

> > My proposed sequence would be
> >
> > a) check task's creds against overlay inode, fail -> return fail, otherwise:
> > b) check mounter's creds against lower inode, success -> return
> > success, otherwise:
> > c) copy up inode, fail -> return fail, otherwise
> > d) check mounter's creds against upper inode, return result.
> >
> > So, unlike write access to regular files, write access to special
> > files don't necessarily result in copy-up.
> >
> > You say this is an escalation of privilege, but I don't get it how.
> > As DWalsh points out downthread, if mounter cannot create device
> > files, then the copy-up will simply fail.  If mounter can create
> > device files, then this is not an escalation of privilege for the
> > mounter.
>
> Yes, in that case there isn't an escalation of privilege for the mounter
> (I acknowledged that above).  I'm still not sure copy-up of special
> files is a good idea though:
>
> - In the case of device files, there is the potential for mischief by
> the client task in misusing the mounter's privileges to gain access to
> otherwise unusable device node (nodev lower vs upper?),

The mount flag "nodev" on lower or upper has no effect on the overlay,
and never had.

> - In the case of sockets or fifos, what useful result do you get from a
> copy-up? Accessing the copy isn't going to yield the same result as
> accessing the original.

This is a misconception.  Overlayfs is a filesystem (that uses other
filesystems as backing store), but it's more a filesystem and less a
vfs hack (and trying to completely get out of the vfs hack business),
and copy up has no effect on I/O being performed on a socket or FIFO:
it's the same object before and after the copy up, and it's a
different object from either the lower or upper nodes.   Same as NFS:
fifo on server is logically different object than fifo having the same
name on any number of clients.

> For executables, this copy-up behavior might trigger a lot of undesired
> copies of non-executable files from the lower dir into the upper, even
> if we ultimately end up denying the execute.

That would only happen if

  - task is allowed exec on overlay
  - mounter is denied exec on lower
  - copy up is allowed
  - mounter is denied exec on upper

In fact in the model where upper object inherits context from overlay
this is pretty much impossible, AFAICT.

Thanks,
Miklos
