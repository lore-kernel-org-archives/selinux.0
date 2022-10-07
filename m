Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F1C433FE
	for <selinux@archiver.kernel.org>; Fri,  7 Oct 2022 12:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJGMqP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Oct 2022 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGMqO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Oct 2022 08:46:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC63D0CF9
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 05:46:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g28so4795061pfk.8
        for <selinux@vger.kernel.org>; Fri, 07 Oct 2022 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZHQHVfhsd5erXDvQP9UhI/8ZNLoEkF3POd5QnFX5P0=;
        b=ZvFkzjlYVmYLnOZo9FqMYf/WiK923Oq9K7BZNKfjKv48JlPjLyLoawK98/7RHOov92
         lpiUOMg0v1zuyZVYFilurICASXOxNPefvvWaSrccWGDp1bmSgyC1aL99g1H1Ay848zEe
         G7vqYYWrDKEDn1ncWZTaeYeSDUwtZM5b+UhD2CWWn9M76qGdRhAbgzdc2ESCUUno7+tK
         jUoZ4xlxNOnYmD1cpXg7sfqiGJmGOUMX2yOsB0mfES4sZAhZad/AalMR/vQYYbg1mU/P
         QuFucbIpXwtcDWJNUE9KhFd1S+BQ49ec4GqB6c4jN88nqHuAIb6s/EOTN7ZaD7UDEyed
         Pw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZHQHVfhsd5erXDvQP9UhI/8ZNLoEkF3POd5QnFX5P0=;
        b=wEd88lCuC4EJbDfyV7w2cGy2sgUu+E9SI3Yb6PhDkgDHrEVunCoHv2N7r9hctUlsyY
         BVg1Ym/Q2k+7fxeHKKoxMZzOBkD3e3pAGxZkqoUapZwN6FBt1gsOCiATXmUZOJ9TcLeR
         6hseKhhCKu68WDE0k0UWM6B4NFvctT9934soXseq2ibsF9ZffrpRGHopHCIuWuKuXRSj
         TOa3XbvO1MZBVXsQOEXNtrihkl4vwbPjW0DN3ui0jpe8YmJvv9Q3XzCFQgrYSTqM3+9M
         0KlDC8VMC3lbIfEn0r+/aZ/ca7LgNAdWYnkUNvxe6nnHus3B3s7HaHvEG3sgj2FUX2k0
         mlVg==
X-Gm-Message-State: ACrzQf1OTWNjj2OteP4T4BE0dFBqkC/TPXIplTGwScpKMrBhK4QBoxN/
        Dvxxb07nsg+4vk7tb9Pu3mzaavluLm99yfwm51ZJZM8C
X-Google-Smtp-Source: AMsMyM6kEu6h8rQdQ0kQgzHtGOsUPHu7DH33/wFGcZ6gy3O/QDgH6viLogBreX5tLe9hsBUouOw1PfTdB15sAnkXuvA=
X-Received: by 2002:a63:f103:0:b0:439:398f:80f8 with SMTP id
 f3-20020a63f103000000b00439398f80f8mr4396747pgi.494.1665146772835; Fri, 07
 Oct 2022 05:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <87ilkwxbde.fsf@redhat.com>
In-Reply-To: <87ilkwxbde.fsf@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 7 Oct 2022 08:46:01 -0400
Message-ID: <CAEjxPJ6hQ3-_6_O2LxQPLD14Xzrcs6NfmqLRpe9arbEppU711g@mail.gmail.com>
Subject: Re: unnecessary log output in selinux_status_updated
To:     Petr Lautrbach <plautrba@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 7, 2022 at 4:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hi,
>
>
> Commit 05bdc03130d74 ("libselinux: use kernel status page by default") changed
> selinux_status_updated() so that it calls avc_process_policyload() and
> avc_process_setenforce() and both functions call avc_log() and avc_log() logs to
> stderr by default. So when a process like `rpm` checks whether there was a
> change, it gets output on stderr which previously wasn't there.
>
>
> Before this change:
> >>> from selinux import *
> >>> selinux_status_open(0);
> 0
> >>>
> >>> selinux_status_updated();
> 0
> >>> selinux_mkload_policy(0);
> 0
> >>> selinux_status_updated();
> 1
>
> Current version:
> >>> from selinux import *
> elinux_status_updated();
> selinux_mkload_policy(0);
> selinux_status_updated();
> >>> selinux_status_open(0);
> 0
> >>> selinux_status_updated();
> 0
> >>> selinux_mkload_policy(0);
> 0
> >>> selinux_status_updated();
> uavc:  op=load_policy lsm=selinux seqno=2 res=11
>
>
> The calling process could set its callback but it seems unnecessarily
> complicated just for selinux_status_updated() which is supposed to check whether
> something has changed or not. Also processing events in this function seems to
> be unnecessary.
>
> It looks like the reason for the new code added to selinux_status_updated() is
> that there were several avc_netlink_check_nb() calls replaced by
> selinux_status_updated(). Given the problem described above, I don't think it's
> correct and I would like to change selinux_status_updated() back and use another
> mechanism that would help with the replacement.
>
>
> So what do you think about it?

The goal was to switch the AVC and all of its users (e.g.
selinux_check_access) over to using the much more efficient SELinux
kernel status page mechanism for setenforce and policy load
notifications on newer kernels instead of the SELinux netlink
mechanism (which imposed extra syscall overhead on the critical path).

Understand your concern but unsure as to whether we can just change
selinux_status_updated() back now.
Would require an audit of all users of selinux_status_updated(), both
direct and indirect, to ensure that none of them are relying on this
behavior. We can obviously fix the callers within libselinux but
addressing external callers is more problematic and is arguably an ABI
change. Would need to look at all users of the AVC,
selinux_check_access(), etc.
This change happened 2 years ago so I have to wonder why it is only
coming up now?
