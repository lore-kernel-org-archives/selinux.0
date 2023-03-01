Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C5C6FA9D
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 15:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCAP0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCAP0U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 10:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D376BB
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 07:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677684330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpD2SbgTDtTZwWZG/3p3wgldChvS7P9t3TDCh4URJZw=;
        b=Xr9I35LM10TcMkrPP4HbBVC2PohBZQ6oaAvR9YNotZ2PaEjVLyLZYZf9jTQzaKinz8lzUx
        scIPPAlRa5doVO6kzpTw0VoMzVC/wDfdEB6B/pznNEvD2j+ktMmKUW+F+L4i6Uyc8TgvL6
        07CZ3fOWfmEoKpY4Vu64ibUTzhEkQlE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-GRwsLUv9MtSb9AxkU5Ki9Q-1; Wed, 01 Mar 2023 10:25:29 -0500
X-MC-Unique: GRwsLUv9MtSb9AxkU5Ki9Q-1
Received: by mail-pg1-f199.google.com with SMTP id d34-20020a630e22000000b005039e28b68cso540840pgl.13
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 07:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpD2SbgTDtTZwWZG/3p3wgldChvS7P9t3TDCh4URJZw=;
        b=sj5S1bKdzZzbCS4t9P6WNV0AuglXtn83gmswU9oIMugFzWGJNkPcYdsmD27gOwKgkk
         j0nykkA7GMD4v4R8VGZYEhfvCC318JNkznsDgfn4w/RxZCl0w6Rh0Gl035REE8ylI5M+
         ToF0YjymlzvAoW7KAT+cZ1gIVNxdkZKN8Stgh6N0bgfzJlPP2WBz3qXGEXCuxAgFdyRO
         zjUlqXpgtkfMtf9KLsuFpPc0T++0A8IB5lowY1at5WgQvoOceUXumODxFxnSHWc8sGBw
         ML0/PrEt9fpEW0b/XJbR+j/onEIm++n44JyVEDQoJgRRA643MmubWEx3CZEx1bVQiK3b
         zPuQ==
X-Gm-Message-State: AO0yUKV7v8TqM8rTROpHjKYo+mx0WCpuCjfHsIoglxt16qCDSghfhFE1
        X9g7lulZg1M1GXvGQoRmg3uTti1uqMfDiFBFhOBTzIfVYKzMsOSk0yFH34q/25ya16KGDYtCVfE
        sZ4G5weq/5NSnmkFkzrXwbznnKMK+s68y/w==
X-Received: by 2002:a65:6b81:0:b0:503:130c:ac9f with SMTP id d1-20020a656b81000000b00503130cac9fmr2606233pgw.4.1677684328496;
        Wed, 01 Mar 2023 07:25:28 -0800 (PST)
X-Google-Smtp-Source: AK7set//CyQsW9OanVY7NUN7kjAJJMZHB8Dj6OPYRMUFkHO1poFOljSJpPEtOK/qJ2FTmpWQ6ppd7aaKhH2/0UU0ldA=
X-Received: by 2002:a65:6b81:0:b0:503:130c:ac9f with SMTP id
 d1-20020a656b81000000b00503130cac9fmr2606220pgw.4.1677684328032; Wed, 01 Mar
 2023 07:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-3-omosnace@redhat.com>
 <CAHC9VhT8+vFwzZk4ba5nNd8uQJj3JqqJzttV=1pLPO0U82xxXg@mail.gmail.com>
In-Reply-To: <CAHC9VhT8+vFwzZk4ba5nNd8uQJj3JqqJzttV=1pLPO0U82xxXg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 1 Mar 2023 16:25:16 +0100
Message-ID: <CAFqZXNuq5q8CADULnNsJnxbNKLym9FY3xA=0FterBMYMv6adww@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/3] policy: allow test_ibpkey_access_t to use
 RDMA netlink sockets
To:     Paul Moore <paul@paul-moore.com>
Cc:     Chris PeBenito <pebenito@ieee.org>, selinux@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 28, 2023 at 6:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > ibv_get_device_list(3) first tries to get the device list via netlink
> > and if that fails it falls back to getting it from sysfs. Currently the
> > policy denies getting it from netlink, generating some denials. Allow
> > test_ibpkey_access_t the necessary permissions so it can do it the
> > preferred way and doesn't generate audit AVC noise.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policy/test_ibpkey.te | 1 +
> >  1 file changed, 1 insertion(+)
>
> Similar to the other policy issue, it seems like this is a general
> problem and not specifically a selinux-testsuite issue, right?  If
> that is the case should we fix this in refpol?  I think it's okay to
> put a temporary fix in the test suite, but we should also push to fix
> this in refpol.

Basically the same as I said in the first paragraph of my reply under
patch 1 applies here, just in this case we are talking about users of
ibv_get_device_list(3) instead of ibv_create_cq(3).

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

