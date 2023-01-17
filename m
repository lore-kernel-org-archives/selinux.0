Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F5C6379F
	for <selinux@archiver.kernel.org>; Tue, 17 Jan 2023 16:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjAQQoY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Jan 2023 11:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjAQQoO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Jan 2023 11:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37795166FF
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673973807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWt5ED2TX8Y+jHtlDvbwbjj4isKx/JC0m/i4ZrbL8+M=;
        b=Tga3nETCCJ7ZR5TsZ7ELlZn9+uwMFm6DKWXMWICWQ9g5QhUWQZxx5n+Wys6Oy9KEsZ86zR
        ujfr3DIi/fXIIwOoZfOo1OD3vrTHFSX8M+R9Z64wBisJwX5RHZOLiDwfxNvbx1fnpgJN50
        JujbILj+uMNx2Sokl7gM/OVIxVNPyR0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-GCZ319XGM8aBGpHfiNRmPg-1; Tue, 17 Jan 2023 11:43:25 -0500
X-MC-Unique: GCZ319XGM8aBGpHfiNRmPg-1
Received: by mail-pl1-f200.google.com with SMTP id h2-20020a170902f54200b0018e56572a4eso21889871plf.9
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 08:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWt5ED2TX8Y+jHtlDvbwbjj4isKx/JC0m/i4ZrbL8+M=;
        b=rcR94i+Yr2gJbCc1DVjbZrOBOrbsC1QKEnIneKgZ1lAN86RekinA8cf/xjSUuRO553
         hFBS0d4kFm6zbwHxtFjNXZy96DIGHkV8nQhSqZn+gM4YX5/iPbmCCn1J4OVDlejDGpTb
         SNNt8z2UBeTzY+7W5A4lEKqeMdZCUpI1xIXAtqxYT8I+NvTKGBjcECj+rliqUu8cbHcx
         MxnNR7THtWrMLjXiKaNKCl+dTEXpn/Vyn11rRv/IVqwhAl3o7tfp6dzp8oGXKXl1pYnz
         0GoEfF/+LUJeP7JNem1UQKAnxxmqj0ZbdwQB/WJN7hJZBErUR3iY2wiSIPqo8tPLHMqN
         nQzg==
X-Gm-Message-State: AFqh2krXUpQVd7mFHnuvbVEbyNt4JdOmg7MO2L2jdWvVmYPajlzTPw1J
        JP6UADTDD6/aNtm2TKYbyz5Spz7j9jRZaWJN9dwc0btTwjKudaU2gS1RufFNFhUBND9v1sdzoYN
        qDExwFsksIQYbLvwf7B+LqMwA74PjzIMjIA==
X-Received: by 2002:a05:6a00:290e:b0:58d:a3f2:484f with SMTP id cg14-20020a056a00290e00b0058da3f2484fmr325484pfb.4.1673973804579;
        Tue, 17 Jan 2023 08:43:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv9phqhgdozHVk487P2aA6AyOURnMELOkGvjqAbLy/vKO6hdBq9Mo6fx+Q3o1CxWeQW4vE7cdJoe1O1g4O3YwQ=
X-Received: by 2002:a05:6a00:290e:b0:58d:a3f2:484f with SMTP id
 cg14-20020a056a00290e00b0058da3f2484fmr325478pfb.4.1673973804297; Tue, 17 Jan
 2023 08:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20230116214626.28955-1-cgzones@googlemail.com>
 <CAFqZXNu-Wg=JAsAFHFW9J3DBV-7BYL2960SJnEpaP3VzOJn+Bg@mail.gmail.com> <CAJ2a_Dfrs9H5hkzK+_uGzLyL27rMBkTeJYAXoddRPO2mRsB2ow@mail.gmail.com>
In-Reply-To: <CAJ2a_Dfrs9H5hkzK+_uGzLyL27rMBkTeJYAXoddRPO2mRsB2ow@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 17 Jan 2023 17:43:13 +0100
Message-ID: <CAFqZXNtZSHsYPfVvx3uMQB+fs-NRYFfipdK_0V5_7riReYE_hA@mail.gmail.com>
Subject: Re: [TESTSUITE PATCH] policy: drop usage of files_list_pids()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 17, 2023 at 5:13 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Tue, 17 Jan 2023 at 11:00, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > On Mon, Jan 16, 2023 at 10:48 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > files_list_pids() has been superseded and marked deprecated in the
> > > Reference Policy since Jun 2020[1].  In the latest release it has bee=
n
> > > completely removed[2].
> > >
> > > Grant the necessary permissions via raw rules to support recent
> > > Refpolicy versions as well as old ones without the replacement
> > > interface files_list_runtime().
> >
> > It seems the permissions aren't actually needed, at least on current
> > Fedoras. Simply removing the call passes the CI:
> > https://github.com/WOnder93/selinux-testsuite/commit/d0883a56d2583800a1=
fa79490097e73b842cec17
>
> On Fedora the call of `auth_read_passwd(testsuite_domain)`[1] leads to
> a call of `sssd_stream_connect()`[2], which includes
> `files_search_pids()`[3].
>
> There is no indirect call in the Debian version of Refpolicy though:

Ok, so let's keep the rules then.

>
>     type=3DPROCTITLE msg=3Daudit(17/01/23 16:41:13.404:577) :
> proctitle=3Dkeys/keyctl_relabel system_u:object_r:test_newcon_key_t:s0
>     type=3DPATH msg=3Daudit(17/01/23 16:41:13.404:577) : item=3D0
> name=3D/var/run/setrans/.setrans-unix nametype=3DUNKNOWN cap_fp=3Dnone
> cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
>     type=3DCWD msg=3Daudit(17/01/23 16:41:13.404:577) :
> cwd=3D/root/workspace/selinux/selinux-testsuite/tests
>     type=3DSYSCALL msg=3Daudit(17/01/23 16:41:13.404:577) : arch=3Dx86_64
> syscall=3Daccess success=3Dno exit=3DEACCES(Permission denied)
> a0=3D0x7ea1b2255068 a1=3DF_OK a2=3D0x7ffd39131fb0 a3=3D0xa9ab59f33f82d0d9
> items=3D1 ppid=3D4569 pid=3D4593 auid=3Droot uid=3Droot gid=3Droot euid=
=3Droot
> suid=3Droot fsuid=3Dro
> ot egid=3Droot sgid=3Droot fsgid=3Droot tty=3Dpts1 ses=3D1 comm=3Dkeyctl_=
relabel
> exe=3D/root/workspace/selinux/selinux-testsuite/tests/keys/keyctl_relabel
> subj=3Dunconfined_u:unconfined_r:test_key_t:s0-s0:c0.c1023 key=3D(null)
>     type=3DAVC msg=3Daudit(17/01/23 16:41:13.404:577) : avc:  denied  {
> read } for  pid=3D4593 comm=3Dkeyctl_relabel name=3Drun dev=3D"vda1"
> ino=3D390346 scontext=3Dunconfined_u:unconfined_r:test_key_t:s0-s0:c0.c10=
23
> tcontext=3Dsystem_u:object_r:var_run_t:s0 tclass=3Dlnk_file permissive=3D=
0
>
> The tessuite passes nevertheless, so one could ignore or explicitly
> dontaudit them.
>
> An alternative would be to call the interfaces conditionally:
>
>     ifdef(`files_list_pids', `
>         files_list_pids(testsuite_domain)
>     ')
>     ifdef(`files_list_runtime', `
>         files_list_runtime(testsuite_domain)
>     ')

Yeah, I'd prefer the conditional calls, with a comment explaining that
Refpolicy has renamed the interface.

Thanks,

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

