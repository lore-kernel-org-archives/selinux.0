Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B7C3F6B0
	for <selinux@archiver.kernel.org>; Tue, 16 Aug 2022 05:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiHPFBt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiHPFBO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Aug 2022 01:01:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17724E87D
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 13:56:27 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w197so9845566oie.5
        for <selinux@vger.kernel.org>; Mon, 15 Aug 2022 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bZvFfLdmisv8ZmBmyGTlD8WQkr7MyMlLkvc8x5GfkIg=;
        b=cM0YcKCbdYEioSBk54JmMjcaPYvF2uw30kA6AhPPiq/t9gJwk3inIEf3EFt20xGqKP
         ZlsGuwNqALFaG1mysWBRis7rB6vjKJLaIvFlNP20SFtbh2eHMbNuQ8lC2PVdedR+Eh8S
         N9fPPWmhEVnuJsTEcXR669UglB8Lgq6s43BsNNF0hiYjykwyn7Zot0zy81Xn4yNExjjc
         Zz1ogRJ5ga3sZSlghGke9LAh/I44z7bQPfb0uTzsYWRSMyJ/wmyXCM5ONHeayAb8j153
         0+Mv7PPSFVcULYkFZwFOgcODr22u00SgUHIYOibPPi+TNiCSYjrrYS1SPJOYidNPav6C
         h0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bZvFfLdmisv8ZmBmyGTlD8WQkr7MyMlLkvc8x5GfkIg=;
        b=pSCXYhHnFLRAKBkiCaQEs6cZCy5u6OmT9n8d4r10XQ3WMgLbN/gNUYzD/N192vzkxa
         4T1QTNHCJicPjtBRQqiVtT1P/v+WfvWenAJKnhnL1XRb3Wy/RkHZ1BJ4ga3htqTE8ly+
         AdkAkiBvlGNVFp5W7gaaaA48upsy6466bCOiIuRf1ABBrPwVElDh/vSgMEfhOEEB/ceN
         YWohy7NMuwXPtHRAOkImHwbdHlSWMPWV1IX+Mg/Uwq6DAwxTvo5AdEfvQtcn+2N5d4q6
         E3C4Juf589P7EfMDpmgQFndLnfudQxa/YBjt76Y3uVlQSbx/xIkQ+Ka5337YKh3mpkSB
         7pDQ==
X-Gm-Message-State: ACgBeo0CzH4gSs+z2BdLf0zo9/5Oc52OY7v9P5am+H2r68FsGkMrUrYH
        Scc7luBl22iu7B4mCtFu40OT5zUxo5ImD9Rj4HrV5PBBhg==
X-Google-Smtp-Source: AA6agR6Q0qVJWpxSDRMTWwDizXjT5Myaa+MmdxMHBEyIOyRAgQgYt4StAdp3SjTVZwOQCfxxa7WwHSrnuGsmXBO6D24=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr9304558oie.41.1660596987219; Mon, 15 Aug
 2022 13:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <166008317384.447519.7250489605112175227.stgit@olly>
 <CAFqZXNshzY2L1yUMyCxTa2njgScUg5gwzmq-UP4SSnFnph-XuA@mail.gmail.com> <CAHC9VhRpTR_zdj+cdeGGKoe1vZKBy4FK4JP6iyurXR0NOr2tXw@mail.gmail.com>
In-Reply-To: <CAHC9VhRpTR_zdj+cdeGGKoe1vZKBy4FK4JP6iyurXR0NOr2tXw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 16:56:16 -0400
Message-ID: <CAHC9VhSTg1BZNF86SjH0uzyuwp5_wpaB_BKvyWML4k+7aTt0YA@mail.gmail.com>
Subject: Re: [PATCH] selinux: SCTP fixes, including ASCONF
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 11, 2022 at 11:04 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Aug 11, 2022 at 6:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Wed, Aug 10, 2022 at 12:14 AM Paul Moore <paul@paul-moore.com> wrote:

...

> > I believe you forgot to modify also
> > selinux_netlbl_sctp_assoc_request() in a similar fashion as the other
> > functions below?
>
> Good point.  I suspect selinux_netlbl_sctp_assoc_request() will be
> greatly simplified too, that will be nice.

I'm beginning to think the SELinux/SCTP code is cursed :/

That change brought up some other issues (more of the
multiple-associations-on-a-single-socket variety) which I need to
think about some more, so I'm putting this on the back-burner for a
little bit while I sort out the io_uring and other things which are
more straightforward and need to get into linux-next ASAP.

-- 
paul-moore.com
