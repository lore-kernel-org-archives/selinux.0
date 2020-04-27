Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13583C54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 15:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED26206BF
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 15:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzBbKP2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgD0PZh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0PZh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 11:25:37 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AFAC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 08:25:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i27so26792177ota.7
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUnTidjP15eRWtIIf/PJ8yNOoTKngFawN0qZkWNC7WU=;
        b=RzBbKP2eyrtK0YZrGM02ftlfdmwn+hZ3mE1un1P4OMOL+IUf7yKfRQsv1AODG4Ju6u
         9eBFU2i/AgQHvFeBFOQRWH1Klt/p0PE6tYhlokXZFjFn0xDr2YUn+u2CP++egUPVhgmr
         rjkJqfegeV8ADrg0wGGpJaieWPsf8RRqGGFfl4gwlEOPLJX9TXiExuzMvbBYQPKMTFsl
         XR5Fl7DxEujQC+QkJrWaa97GwtrUXkhwn+IwV8Kv+63veXayz3APyrS5cNSoF+UCAy2G
         agNb4WTQihibLpnhzEzebxBvPC/oWA7y8DSzVoWPZaLXQL2TreLo99OXslQB7tesbYbA
         +hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUnTidjP15eRWtIIf/PJ8yNOoTKngFawN0qZkWNC7WU=;
        b=IcQRafZyXaxbN1CfwfAeGa+aj3ft7fNZLnQOmIYVpgihhVFeTSx2fUg59QSx1yPqaZ
         XeWy6onxbGEN81XykNmFAtwRuLggV02hD/eEUVZW5xrjW8tv42YG/vJXGGMYo9/LsFj/
         cGWQe7C6AMHw3/AzwCpwcAQk4r1gNWirB5y3X1eXZ8sFU1AQK3eS9F8iYpiLE3zYXsnX
         18SwsNKZqso6cqMkdSCNs18rrPtQWEfn8cgZ1gvKyzZv3IhAAPCSoILVpXTwBxdfYimM
         ERzVEzHyCf9rYR/DtaMl92QvMRhy4sIURI/A1TdjbuVXr0bvLgOvrT126VmJQvHws0fp
         hQgQ==
X-Gm-Message-State: AGi0PuakgO1b9KAVQhfrytQ0GNKaI9/rkjdb4SzPNIg/hgpNiH5lZEbT
        cfCh75wp89gquixGgzoPQFuzVlHYg929DS4+L7w=
X-Google-Smtp-Source: APiQypLFTvtj2Chewbnz4Z17gQf8ceGdQts0SCISvISkehCCeGeexITZ4F0sZzwaaP4i7Ekf3m9ffM0hFVu0ehnR0kU=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr4991961otb.162.1588001136437;
 Mon, 27 Apr 2020 08:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200325130900.15047-1-richard_c_haines@btinternet.com>
 <20200325130900.15047-3-richard_c_haines@btinternet.com> <a932f3c7-ed7a-0e55-6f17-ad9e5ead757a@tycho.nsa.gov>
In-Reply-To: <a932f3c7-ed7a-0e55-6f17-ad9e5ead757a@tycho.nsa.gov>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Apr 2020 11:25:24 -0400
Message-ID: <CAEjxPJ5cbikaManxb0U1jt3gJPTcibRq3tomusGvsKDpEs8maA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] selinux-testsuite: Use native filesystem for tests
 - Part 2
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:30 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 3/25/20 9:09 AM, Richard Haines wrote:
> > Use the filesystem type that the selinux-testsuite is running from to be
> > used for tests/fs_filesystem.
> >
> > Add tests/nfs_filesystem to run tests only via tools/nfs.sh. This allows
> > tests on initial NFS mounts.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Sorry for the delay.  Applied both patches.
