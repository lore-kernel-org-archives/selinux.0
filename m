Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B617C433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D8E20737
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZDXtI4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXMXg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMXf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 08:23:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E90C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:23:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w17so6828325otl.4
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/b+jNO+eymkfwzqcHpbKuqQollp4Goylmnd7bUHpps=;
        b=FZDXtI4Fz5E/0bL2D3TlQDyLMcezyCcaFN7voOxJQTqlklPDbjOn+4UsoDrJK/g5Nr
         oyZqIqyErzexTTh9olaGdFeT+pfFyJcmArqksOHS8xTnLwzSr13URTyBymuMCUnIROsH
         yyFcLQlvh4JbxCDN4oLOM4cJzKbiz+gNwEQDO4erZID+BBIeJ+0M92dgtz8BRwHndz46
         8wyG3FDzEDpfrDoq3y+HA6X3QSUqLxtt1LlqHZO8aixvHRqqVGPENtC2RYuGBlmKWJQa
         /F9tICCmeGTp3TOHk9GZwTJbHS3abAYI8pKvIYMQQTw+IHLQtVmcVt8xXLFYtMxgjplu
         HLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/b+jNO+eymkfwzqcHpbKuqQollp4Goylmnd7bUHpps=;
        b=BurQjKM2/OpTDV2oKMnrjPVWBqywxcYdHChDJxtX8UOn/CPcQlWBMXQNNVmkEe8t8S
         yZrSAIno6tV2EiODH0l5Y5pwLVXKKvq49NwM8dVz1S4fdti/XQd00EKYr2BcYeEg0cyR
         6Gt8oFOBpBDE6gdseaPFLlgNr9cFv1dwflr8CNvDh4tJxoWJYk/LAjZqc115EpiwnyW3
         WNhAzqlZ1Xc01PhtjpOygA9Z5Qv4rX6OG+5b9ZGAYcePVFly3XBtfLDMYFP+t20kwI88
         e7XRJMC1R9fkuSrI2GayXoSbCED8ZQcUnfSm1cuqqmOMJWopHsN4zNJ3v4t5vjYAl2Dc
         lnsQ==
X-Gm-Message-State: AOAM532pAkKGASfoqIHk+WWO6px9yjrVqxKC3mQh3DBj8M+TMOJH+SHn
        eOB0u/XmgZCXDdC6iP2JfQQbfPP5PwtqfCmgMkD97A==
X-Google-Smtp-Source: ABdhPJx3FjtCazDVUvxMGTvtgae/VQ8SJ21LJ/XBvSFy6aIeOTG7feXILjNFfl4hdWlvOcsw8kb3xLzCBUEgvr1CTcA=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr8682007oti.162.1595593415024;
 Fri, 24 Jul 2020 05:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl> <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
 <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl> <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
 <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl> <CAEjxPJ6e=FSV6xiuZQW1m8yxEg-zQ-VMk=iQQYNF9JiQb3XJag@mail.gmail.com>
 <0c0245c2-ece3-f772-1595-d8433ec36386@defensec.nl>
In-Reply-To: <0c0245c2-ece3-f772-1595-d8433ec36386@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 08:23:23 -0400
Message-ID: <CAEjxPJ7KuNR3T60-4XrsjAL-Po1a0MUuaBh_f_iTEuEVTFw+qw@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 3:54 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
>
> On 7/23/20 3:24 PM, Stephen Smalley wrote:
>  > There is a tension there with fail-closed versus fail-open and the
> > potential for a security vulnerability to arise if it proceeds.  Would
> > have to look at the specifics to evaluate how it should be handled.
> > Of course, in practice, one really shouldn't be removing contexts
> > while they are still in use (or else use aliases to preserve some
> > degree of compatibility).
> >
>
> I guess if there is tension be between GNU/Linux use of libselinux and
> SEAndroids use of libselinux, where SE for Android is implemented by the
> vendor to be immutable by the device owner, and where GNU/Linux
> leverages SELinux to empower device owners, then any tension can be
> alleviated if Google forks libselinux. In GNU/Linux it should just be
> possible to switch policies.

I wasn't talking about Android, just about the tension of
fail-closed/secure versus fail-open/insecure in general.
I don't have any problem with someone installing a new policy that
completely changes the set of file contexts; I just don't think they
should do that at runtime without a reboot in between and expect
things to work seamlessly.
