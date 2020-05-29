Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90274C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B83B207BC
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxchnmcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgE2Nqn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2Nqm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:46:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4CC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:46:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id b18so1967170oti.1
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=anFH82b99956Z0Q/wzeF2/cfbh+c2bL6NQ9bvQo/h3w=;
        b=hxchnmcTdUQWYzhehR7ASuYyJouk2fZamc7vfE4WKHxDGKGVoJ+2ht8OfjqUjNzymq
         /Y5sVEIUIcrkXl+FqHwu5Pw9zXiTwJL8vOne8b1IOCsahyK03q9p5ARFMEjgMbF1YKns
         TBbCEmnxwgKs0e8jwltrIkG1Mpm+s3wxJLXUaj+C22Z5s3nxiY3eeIO7GBxzYUuwTFfe
         Ym62vcjt2/4cmz7mq/RPWCuM7vTqwGWT4KfzbJm+uNRhzbYVFi6+Swro+GsB4HKjrs1g
         Mz1NpvICGpu+p7v75QPTnXTyli3bJ59WAF5Bz2Q2PP6WlBpsc8fSRCmab49xTgPO0iCI
         WX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=anFH82b99956Z0Q/wzeF2/cfbh+c2bL6NQ9bvQo/h3w=;
        b=NLdcl8KVILlC2vpOt3bPGlB4pdjS/XcGTDwNza7HU1OZtb2JeWveFURQTa6INUmoRP
         gN9CtYXCwu6CvWXNFctYm40tEE+j58WIL5BQzp/ubBABOlbIBXSWVP7hcbx326Iyvbqx
         HASh7+DbqWSYEdmo/7/u5jZmELwTEu/TlxifyVFl5gI/XeEe29jMlma+28Yg7sJaYsBD
         w8PjNoYahimjcqXpJuYLxGdk05mUXGYpTv4dpzDMBeRH4KlzRFeCAo6GXO0e7uNtjjrL
         B9qXpHEUwmIMfY7nIg7GXm4SygJXki/KaKbM+5KMTcU+YKpqlQf/qRjj4OQiz6yCc4Ky
         d11A==
X-Gm-Message-State: AOAM531DHeSlZNrD8RvR4mgxhUaiuBcZBmbaXr8TbJN/cV6dD+yd17yU
        strpzzW5/MjpWdQG3UJc6s5Dn58Oc/kozDG5wN3w8FYRxpQ=
X-Google-Smtp-Source: ABdhPJxHljQm9AdFCNiBY4AwXrZPrubo22NPqBB4hy8Z7+rSW7EnT0QdEZMrpjhOtNA7v8/2f9Rj4xGJTcEHuAjEIwU=
X-Received: by 2002:a9d:4e83:: with SMTP id v3mr3277896otk.135.1590760000574;
 Fri, 29 May 2020 06:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR04MB39612BE67CD37ECE829EEEE2A5B30@DM6PR04MB3961.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB39612BE67CD37ECE829EEEE2A5B30@DM6PR04MB3961.namprd04.prod.outlook.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:46:29 -0400
Message-ID: <CAEjxPJ6VLofK4S4AbTkdPuR9aRgBY3u8PMesk3iX7wN50Mz9Tw@mail.gmail.com>
Subject: Re: krb5 policy bug
To:     Corey Penford <coreypenford@live.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 25, 2020 at 5:49 PM Corey Penford <coreypenford@live.com> wrote=
:
>
> This is happening on Fedora MATE, release 31. This workstation is domain =
joined via realm/sssd. Latest updates are all installed and workstation was=
 rebooted.
>
> This only started happening recently enough, but it=E2=80=99s hard to tel=
l if it was a regression in a selinux policy update, or if the behaviour is=
 related to working from home.. I am running XRDP on the Linux workstation =
at the office, and using a Windows laptop using the Windows RDP client to c=
onnect to it from home.
>
> This seems to happen every time the screen locks via timeout on the Linux=
 workstation over my RDP connection. I can=E2=80=99t reproduce it by lockin=
g manually, it seems to only happen when the screen locks via the 15 minute=
 inactivity timer, and then goes black from no mouse movement.
>
> Any further info I can provide let me know
> ------------------------------------------------
>
> SELinux is preventing krb5_child from read access on the key labeled unco=
nfined_service_t.
>
> *****  Plugin catchall (100. confidence) suggests   *********************=
*****
>
> If you believe that krb5_child should be allowed read access on key label=
ed unconfined_service_t by default.
> Then you should report this as a bug.
> You can generate a local policy module to allow this access.
> Do
> allow this access for now by executing:
> # ausearch -c 'krb5_child' --raw | audit2allow -M my-krb5child
> # semodule -X 300 -i my-krb5child.pp
>
> Additional Information:
> Source Context                system_u:system_r:sssd_t:s0
> Target Context                system_u:system_r:unconfined_service_t:s0
> Target Objects                Unknown [ key ]
> Source                        krb5_child
> Source Path                   krb5_child
> Port                          <Unknown>
> Host                          PW948
> Source RPM Packages
> Target RPM Packages
> SELinux Policy RPM            selinux-policy-targeted-3.14.4-50.fc31.noar=
ch
> Local Policy RPM              selinux-policy-targeted-3.14.4-50.fc31.noar=
ch
> Selinux Enabled               True
> Policy Type                   targeted
> Enforcing Mode                Enforcing
> Host Name                     PW948
> Platform                      Linux PW948 5.6.13-200.fc31.x86_64 #1 SMP T=
hu May
>                               14 23:26:14 UTC 2020 x86_64 x86_64
> Alert Count                   4
> First Seen                    2020-05-25 14:57:27 EDT
> Last Seen                     2020-05-25 14:57:27 EDT
> Local ID                      d1ee27bb-6ce3-401d-ba7f-45935ad0c3d2
>
> Raw Audit Messages
> type=3DAVC msg=3Daudit(1590433047.446:422): avc:  denied  { read } for  p=
id=3D12279 comm=3D"krb5_child" scontext=3Dsystem_u:system_r:sssd_t:s0 tcont=
ext=3Dsystem_u:system_r:unconfined_service_t:s0 tclass=3Dkey permissive=3D0
>
>
> Hash: krb5_child,sssd_t,unconfined_service_t,key,read

Fedora selinux policy issues should be reported to the Fedora selinux
list, see https://lists.fedoraproject.org/admin/lists/selinux.lists.fedorap=
roject.org/,
and/or bugzilla.redhat.com against its policy.
