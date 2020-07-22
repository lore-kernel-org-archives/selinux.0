Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE710C433E1
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98996206C1
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 16:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHbhOPno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGVQs1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVQs0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 12:48:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D36C0619DC
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 09:48:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t18so2258724otq.5
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXqMAEggJrdv2b+tPHRZnVSRMqG76d6OE4OvxVwySoM=;
        b=dHbhOPnows23bSDpgzcYZqBoW2CdOFr3Rvg/MUEcjtEEDpl6VMEXiJvVYp2hvJiTo1
         uVh/gxIrl1oG7oM0tkO17kJ6spLMJspJXOII/28Xg6QkhLa04RwSEqyM2t5mU19Z1bnE
         Bbb1KWBRx8XkMfGcwcS/eRip3oeJEW9NCr57R2Eld1u7T1Rn7rlxP0+6TQQE38h/nCRN
         gmxsFiddM88Lley3qcKZC4CUXQUpjVyeUgn36Ekg/prZSiFEVqbWgd/Y3TkFjVqecQdC
         3dCUAXvGGCXBRs91ez59wY3HZyNYWOIW6zzEQF3QCdFZbeToBwM/Wm/gp3cyWQKSmEq9
         TWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXqMAEggJrdv2b+tPHRZnVSRMqG76d6OE4OvxVwySoM=;
        b=XZ3kmGOxx0PweTEvl1CkETJ7lDVXK3YNLOrZWAlHn7NPe2BDaa/ucNhjIc9+Xe0TqC
         JCFrcI/PJChZJveYuQV52ZVMMqmcK8Rjxa4o5N2XuIg42utUQ/juz51J1T5eIKpT0blN
         Gy9F+cE2V58xmM197MQ8ClKuqq0CLUHXFztrlI6gno++/RPMMqYUQ3HrPiQNOsfd3VGP
         ce5skjxhY+OEYCEAMnLEvETe3YelK2OmSO3k5Q1ELv1QUsecjeFjfg9bZmTcd+PPIcJH
         Vvg0iZOrkYxjSo2eYqq+SnJXchcSSWgki8XLtO0KwDPt7wZuedy6ZHa9t9Kt/18bL29N
         XVxg==
X-Gm-Message-State: AOAM531Ty2N+AWMNhwhulcl9fHn/dl571ZCdc8tEZ6QL0hu7r9q0jmgB
        JAu6DRnkpsNIdzILCXcDE+SzkRFlyZpCaqQ4k1vMDA==
X-Google-Smtp-Source: ABdhPJzXp4jPxSsaF0anAhI4t9CTAEMvDFkA9PBafPv9xMqer3hoRqZO7YCgytx/7WwMHKavv4+rB39N7J+FlJ+1HrY=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr795603oti.162.1595436506170;
 Wed, 22 Jul 2020 09:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
In-Reply-To: <ypjl365kzkvb.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 22 Jul 2020 12:48:15 -0400
Message-ID: <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 4:14 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> > +context for both subjects and objects when their label is invalidated
> > +by a policy reload (their SID is unchanged but the SID is
> > +transparently remapped to the unlabeled context).
>
> I will note here that I suspect there is currently something broken
> with libselinux / unlabeled sids
>
> libselinux consumers still use *invalidated* contexts associated with
> inodes to compute access vectors.
>
> for example rpm will not consistently work until the filesystems are
> relabeled after a new policy is loaded that invalidates contexts
> currently associated with /bin/sh (entrypoint for setfscreatecon to
> "rpm_script_t")
>
> systemd will not consistently work until the filesystems are relabeled
> after a new policy loaded that invalidates contexts currently associated
> with (i suspect) parent directories for socket activated sock files
> (maybe setfscreatecon?)

That's because userspace doesn't pass SIDs to the kernel (they aren't
exported by the kernel); it passes security contexts, and the kernel
refuses to accept invalid contexts. So a context previously used by
userspace that is invalidated by a policy reload and then later passed
in again to a kernel interface will produce an error.  IIRC, the
security_get_initial_context() and avc_get_initial_sid() interfaces
were added to allow userspace object managers like SEPostgreSQL to get
the context associated with an initial SID like the unlabeled SID for
their own internal use/handling, but libselinux doesn't try to remap
like that internally and it wouldn't always know whether the context
was previously valid unless it maintained state on all calls.
