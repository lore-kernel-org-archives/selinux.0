Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B28C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55420726
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 08:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evocE50s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLIIAL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:00:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58260 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbfLIIAL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 03:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575878409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSGtynd3TLb/XLkXyLh5qyAKRNDxWt2TKLpiphtvens=;
        b=evocE50s24geI8lIOqHjBGMPWgWQLmHvzTPnIZWG6qpSTqLk3POjLs8UwRmowszjI3YYsb
        /tcZMpSNBGkIB51HGynHdtsVAzHKU2EL/VhuJqTlLN+JVTGWRdW9y83wswz5UNBAexRJOM
        kDiypJsWOSvuhpTOXzGnH8yH2Nrha1c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-Kl3NbyOMN2mHN4lKlEyD4g-1; Mon, 09 Dec 2019 03:00:06 -0500
Received: by mail-oi1-f200.google.com with SMTP id v130so3987659oif.18
        for <selinux@vger.kernel.org>; Mon, 09 Dec 2019 00:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=guNKNBfiF7cVJ/py0p3JA10pPIamajwr8qiY5ZeLF6s=;
        b=EXrJLhhIWFf0meqxwHM6enevsuws4mBtgkKENEPL6OzI1+hzvCIzpZK9YFLDLmL8Ve
         nO6I0g8ervUvHaXBtPfSbz++myT8jczPoJkRGapS3HPttpfeTp1np+gjb/b4WY2KXlNA
         HfVnX7lAkYjuCYzaZdo5swQsBtaPxBodBpfNFKp90fQ6dsol2V4w8mCkUimGSxL0ITPU
         i2N514sV+UI4o/CyMsgSUmhzO8eP7adET8seZ2fUzKv/0bO/9A9iSnYCWoPHf5dZ+N2S
         a53LiVlsovyLgh29hMHVunsZ3AeVr2qcvE7KIky8KYq96/ZK/bB7TzEJ1P1sXsIe+lgZ
         l83w==
X-Gm-Message-State: APjAAAWQ/KAexOzUljQAc/m0mYxZAfTqtW3FrkBzmF6Eg5t+v8/Z0BRw
        ns1sS97Uk2iv98wAIdt+je4FfDN+IrnJksHzKXZlt4uBlbGQ4DJq+N/wdQTYyiPupq44FnpLLcm
        hg9/FhggM7Z5sYCETOPWwXQ4V/wsrP6biGA==
X-Received: by 2002:a9d:338:: with SMTP id 53mr10710874otv.197.1575878405415;
        Mon, 09 Dec 2019 00:00:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlQ0EPvir1tCI5d2oYvrM7Irb48kDFiRAGDAgcS5xSV8r5KMN5ff1ZTuNzw4RKpn+Ex9WudMMjYVb/DYyIl+E=
X-Received: by 2002:a9d:338:: with SMTP id 53mr10710855otv.197.1575878405062;
 Mon, 09 Dec 2019 00:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20191209075756.123157-1-omosnace@redhat.com>
In-Reply-To: <20191209075756.123157-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 9 Dec 2019 08:59:54 +0100
Message-ID: <CAFqZXNsf9yNYHSfXQ5B=4YkPQX5a0QsCP=_ta=Gkz-ccPDjZTw@mail.gmail.com>
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less broken
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
X-MC-Unique: Kl3NbyOMN2mHN4lKlEyD4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 9, 2019 at 8:57 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
> infrastructure to use per-hook lists, which meant that removing the
> hooks for a given module was no longer atomic. Even though the commit
> clearly documents that modules implementing runtime revmoval of hooks
> (only SELinux attempts this madness) need to take special precautions to
> avoid race conditions, SELinux has never addressed this.
>
> By inserting an artificial delay between the loop iterations of
> security_delete_hooks() (I used 100 ms), booting to a state where
> SELinux is enabled, but policy is not yet loaded, and running these
> commands:
>
>     while true; do ping -c 1 <some IP>; done &
>     echo -n 1 >/sys/fs/selinux/disable
>     kill %1
>     wait
>
> ...I was able to trigger NULL pointer dereferences in various places. I
> also have a report of someone getting panics on a stock RHEL-8 kernel
> after setting SELINUX=3Ddisabled in /etc/selinux/config and rebooting
> (without adding "selinux=3D0" to kernel command-line).
>
> Reordering the SELinux hooks such that those that allocate structures
> are removed last seems to prevent these panics. It is very much possible
> that this doesn't make the runtime disable completely race-free, but at
> least it makes the operation much less fragile.
>
> An alternative (and safer) solution would be to add NULL checks to each
> hook, but doing this just to support the runtime disable hack doesn't
> seem to be worth the effort...
>
> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 97 +++++++++++++++++++++++++++-------------
>  1 file changed, 66 insertions(+), 31 deletions(-)

Please note that this patch applies on top of Linus' tree instead of
selinux/next, since there are some new hooks there that aren't in
next.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

