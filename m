Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB883C43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75687229EF
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVj/plKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgIHOpe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:45:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729655AbgIHO0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599575163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=UVj/plKG6DRifmHMZTlUgfPoWrlDhO5hOcL37nFebFZBjBM2JajOpeMRZwFLK+9BMikk/E
        5xOawuMqdp4K0Kvxlk6KUe90Wou8YCbVFBJto0jBU9M58+ZkDLwBXaDZobqWA2E/hG1gpA
        gfUCoROtvep9rDbQpy5FpHT/R5xDupI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-0UjlI_EgMg-wuw3pRid2JQ-1; Tue, 08 Sep 2020 09:03:15 -0400
X-MC-Unique: 0UjlI_EgMg-wuw3pRid2JQ-1
Received: by mail-lf1-f69.google.com with SMTP id 20so1687496lfg.23
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye2KsuXoN2NlEMK5q8mCuzDzXGcGuNydsz7J1oYHs44=;
        b=bjViS4bj8BiJTxxzUF4ChLjG0QNU7CNhj9FAPqV0rU48vn1PIyuzKxfTcEn23gYFNO
         XAHAkSxza2iud80yuPaGDt9npL0vNRjjbjJ/mGuXrIQpgCdgq2D+fyO6ia2dHHb7JcRm
         oAXdSM0fVO8DcbZ3HYiP/kPUj7etLI2OM3E+DYUjRuEbnvOL3q+5CdUxxXPFp1nL5pxj
         4ohO4mfwhNvQSlS7pcz9MC0svKTYQ8pbqMnlbyyAD+qXSAbT4wOCxfiK5IJj+ztSVxqG
         3GhdpqnzXMG3U0bLMbk9x6DIfD1NHI8amkK/PmnMpoB9M5cTQibwNAesKWeJyuZnHK9n
         q1Ag==
X-Gm-Message-State: AOAM532/bCBA6N4uF5cuBxsjlra6iHS2zMh3TsrVNXLUtp8cJC1VLemp
        iHH3I5gUyAtKPcEOw1/3dyyHhhlkE9ZNP152pjpLAxr5wGRUuf9sh3vlEJX/XydGFZbwx/xqePV
        mid26evgSutOLFO1gjcwKgYurp6L6p4ooiw==
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002422ljb.337.1599570193915;
        Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp3OiZVrw0QoBLOoEdLIlQNVVb0O6eJMGa3bo/IK9ijWF8Ck46zu6UhG+8IzfVZdlckAAhTWm3SSIT9nd2q7U=
X-Received: by 2002:a05:651c:134a:: with SMTP id j10mr11002409ljb.337.1599570193556;
 Tue, 08 Sep 2020 06:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com> <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Sep 2020 15:03:02 +0200
Message-ID: <CAFqZXNtEywSumid=FHLysV8jaSPXDO--3YJC6DfuGwRRZLQ58g@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 2:37 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 7, 2020 at 5:39 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
<snip>
> > diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> > new file mode 100644
> > index 000000000000..caf9107937d9
> > --- /dev/null
> > +++ b/security/selinux/measure.c
> <snip>
> > +static int read_selinux_state(char **state_str, int *state_str_len,
> > +                             struct selinux_state *state)
> > +{
> > +       char *buf, *str_fmt = "%s=%d;";
> > +       int i, buf_len, curr;
> <snip>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               buf_len += snprintf(NULL, 0, str_fmt,
> > +                                   selinux_policycap_names[i],
> > +                                   state->policycap[i]);
> > +       }
>
> This will need to be converted to use
> security_policycap_supported(state, i) rather than state->policycap[i]
> since the latter is going to be removed by Ondrej's patches I think.

Based on my testing so far, even with just moving the array under
struct selinux_policy, the RCU accessing still brings a significant
overhead (relative to the whole syscalls it is probably negligible,
but relative to the rest of the simpler hooks it is about 30%), so I
don't think it is necessary to adapt other patches to it yet. It will
be my responsibility to adapt to the newly added code when/if I rebase
and respin my patch.

>
> > +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> > +               curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
> > +                                selinux_policycap_names[i],
> > +                                state->policycap[i]);
>
> Ditto.
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

