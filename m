Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB0C4332F
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiLLK1B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 05:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiLLK03 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 05:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D2DEDD
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670840738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXrwMfFkH0GhKcgVnrPj37bvmDlpzL5LQFmRP8As2wk=;
        b=UgdxWifWsgeN/uqZgrDBPQOy9Y7voMXoxVAg3Y9hk/nYL/MVYEjIzsIqzZrkZoHAzMWNqb
        BsqYuf8v/cRoOcpjbZqITmr05RrhjifdXI6t12wP1L2CnE110TdMthPlLn5z0tyY+8EDEQ
        fbTQ9hJrGeTbhf9n8pXHmi24GPILy5c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-mVFn-yksPniAGDFiQ3IR9A-1; Mon, 12 Dec 2022 05:25:35 -0500
X-MC-Unique: mVFn-yksPniAGDFiQ3IR9A-1
Received: by mail-pg1-f197.google.com with SMTP id 84-20020a630257000000b00477f88d334eso7331604pgc.11
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 02:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXrwMfFkH0GhKcgVnrPj37bvmDlpzL5LQFmRP8As2wk=;
        b=waxtVvRx43weiFRIM2lvhHz2HppjOs02QOOszbIYBj6R8OAcYKzVy+gHIyd79hNRhE
         AumgYEXeLanhg/MbqHTlp8iro/B555WctsRuJKKMDBOt2XzGjmIqBDdUuxmsTHLXprHj
         mBo0yNNypH8CBPgDvznAJuvINOpowtKb19e3HQ/445sE2RykFDKyA6qoCdNkzECtANkH
         A+iAyi7RNXMXmokqoUYzB/S7zjfnGE9ePvGtePx2UP1kwZfDAQMmkdM+DHf3ZtEPhvEI
         xcmP6eV5md6GgI+KhYSPlxz8k9SwVT3P8u2wI531LyqY7VWusQv231PtZr+Z3iMJzlzc
         D6tQ==
X-Gm-Message-State: ANoB5plZhZejWX+glhbGPeLQapjjyRua8FPES2eSFeIXhq0enBRIfkZa
        c50a6X7K8ZIjdbCfOGLHxGGMPc8kLtBU0he//j0UlnNDuE2emp2bLsGYmt0lyQGnuB5xRh9f0sj
        nT0B+GfBVDElrFSHtavLYL2yiZKFaCCGR/w==
X-Received: by 2002:a17:902:8604:b0:188:d78e:16ec with SMTP id f4-20020a170902860400b00188d78e16ecmr92163439plo.154.1670840734307;
        Mon, 12 Dec 2022 02:25:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7fWG7nXTZs6du7MsNiX/Ogn9Zq/14MmGP+uUwqarUdtDhul/1uyV/gtBD93XG9kXgV8S4DcK+bAWkiBSCe8kg=
X-Received: by 2002:a17:902:8604:b0:188:d78e:16ec with SMTP id
 f4-20020a170902860400b00188d78e16ecmr92163436plo.154.1670840734047; Mon, 12
 Dec 2022 02:25:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQhYuxwiTcr1=tXrznGpDHBTLC-x+1Sm-u8vXEabMjbpA@mail.gmail.com>
In-Reply-To: <CAHC9VhQhYuxwiTcr1=tXrznGpDHBTLC-x+1Sm-u8vXEabMjbpA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 12 Dec 2022 11:25:22 +0100
Message-ID: <CAFqZXNtNY3XxGd7zqP1wZxiFhtZYNyp0P2eF6=FGoZ+mCHmpWw@mail.gmail.com>
Subject: Re: BUG: selinux-testsuite failures in tests/cap_userns
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 9, 2022 at 8:16 PM Paul Moore <paul@paul-moore.com> wrote:
> A quick heads-up that the selinux-testsuite appears broken on current
> Rawhide, presumably due to a recent addition of the user_namespace
> object class.  I believe a small tweak to the selinux-testsuite policy
> for the cap_userns test should resolve the problem.
>
> % (cd selinux-testsuite; git rev-parse HEAD)
> 77352e748f006c343d602e4be03ae0d2cfcca831
> % rpm -q selinux-policy
> selinux-policy-38.2-1.fc38.noarch
> % rpm -q --changelog selinux-policy
> * Tue Dec 06 2022 Zdenek Pytela <zpytela@redhat.com> - 38.2-1
> ...
> - Add the user_namespace security class
> ...
> % tail -f /var/log/audit/audit.log
> ...
> type=AVC msg=audit(1670612746.925:1138): avc:  denied  { create } for
>   pid=11865 comm="userns_child_ex"
>   scontext=unconfined_u:unconfined_r:test_cap_userns_t:s0-s0:c0.c1023
>   tcontext=unconfined_u:unconfined_r:test_cap_userns_t:s0-s0:c0.c1023
>   tclass=user_namespace permissive=0
> ...

And I have already posted a patch to fix this shortly before you sent
this email :)

https://lore.kernel.org/selinux/20221209130220.451845-1-omosnace@redhat.com/

I plan to apply it later today.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

