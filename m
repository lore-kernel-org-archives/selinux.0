Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA7C433EF
	for <selinux@archiver.kernel.org>; Tue, 31 May 2022 23:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiEaXyE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 May 2022 19:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbiEaXyC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 May 2022 19:54:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A87DE08
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 16:54:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso154846wmn.4
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 16:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yfe2+XKTcLhX3jLZiMDYmqlEu3mYhVaJ01/X/u72oGI=;
        b=N+VCf/9eK+An52L4HNapitnzktWnax3BZEa9yvmLatvhth7Bp9+pQGqpQ7CdtGuQ6m
         beYuHpJQSluM2hImwkOcTBiK8xIzCvDZ31MOjoYVlRD80VfXXoLo5u9cE57dIxarIuJN
         ub1SJ3UsHi47WfjUqtT8e2SvhOZcORO/kA8fU7RdXpkTPfq+uHmvhiXbun6TAKyjVPec
         r3z1e+isVMtWg8U+tZJpCyfB9162pVVCdHZfQI+TZxui7nRHdNuu+xm4fdE6/y8X/fLM
         /zKsxkSRkcbQjc6JD9vaRcaALJtpukWeciEFqlKwed6+26c6aiPgEAprEWuJXgRycKaX
         xdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yfe2+XKTcLhX3jLZiMDYmqlEu3mYhVaJ01/X/u72oGI=;
        b=R//zxntU7qKeVJhXNVf3AoaEWIzwrb5b/OHFfBtYBc4rrQp1abUEbNCoGnzGCc+MuA
         1iC9MS+NKIJhDYJVv7pPyaT6OHY+AJiLDxLc1HJe9/w/nqEQc0A81xUqSFwZ06aTMEE/
         qvHZaY+mPppxpkL9+LNBIuZyhwQNykf+hXRbHmcUwi6wOwNeIFDEp9mGknEdlsVtBt0A
         /o5fArAHNlAEG/alkzJY8fFdNjtpUKo+VObokc6EnUeqk275J6tNDTVldrGpsGkjGeB7
         +EilvmKcJTdbUCYZeKpJXbJhT1xmKzSUk6JTN3lh6XEk0FEo8EKlX9pTFqSQP1jLQxPt
         EaPg==
X-Gm-Message-State: AOAM532GZltHDhr7PYVlGx5NNH2EKX3ZMi4Fe7XFRWfzYzspKZcCzJoU
        E2ENVmUtOROLd79hSptLzgnXIB3YeClkI/L8uSqS
X-Google-Smtp-Source: ABdhPJxE5P8AQWkVDnfF/zthbWs+EPAfptp0F0KveB+CagIRXyMMh8ICgnHwtdr1plmHIMySX+QECM6GltrIJuF/C2o=
X-Received: by 2002:a7b:ce8a:0:b0:397:37c9:254a with SMTP id
 q10-20020a7bce8a000000b0039737c9254amr25825183wmj.96.1654041240337; Tue, 31
 May 2022 16:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
In-Reply-To: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 May 2022 19:53:49 -0400
Message-ID: <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hello everyone,
>
> Investigating the yet still spuriously failing SCTP ASCONF test [1]

FWIW, I haven't seen failures with the SCTP tests when doing my
testing, but perhaps I've just been lucky with the timing windows.

> has led me to realize that the SCTP_PARAM_* chunk handling is in fact
> severely flawed. The SCTP_PARAM_* code paths reuse the
> security_sctp_bind_connect() hook, but that hook uses the current
> task's sid when checking the socket::connect permission, which is not
> correct, since there is no guarantee on the task context in which the
> incoming ASCONF packet will be processed.
>
> The relevant selinux-testsuite test [1] expects the subject sid to be
> the one of the server, which has been true only by accident, as SCTP
> often processes the incoming ASCONF chunk via softirq right after it
> is sent.
>
> This seems tricky to fix, as we don't have any appropriate subject
> context at hand at the time of receiving the ASCONF chunk... Any
> ideas?

I had some interruptions at home this afternoon, but I'll take a look
tonight to see if anything comes to mind.  Although I believe you know
that code fairly well so I'm not very confident that I'll be able to
spot anything new.

-- 
paul-moore.com
