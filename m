Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A6C433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 10:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EFC61420
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 10:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhD1KzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 06:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhD1KzB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 06:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619607256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAtHOuu8UFojOTp6V42YTeKVXJLCBUn0sF4pumdT8VA=;
        b=NQCjS3945YwUESVjW5XPbAIObTnAvdv4QEMW8YdRkyoqwy1TsetDewr0Ptm/QaVHjO1oHj
        bv5zhpRi+eIwnoPC+P9yq9uQt6d1/tIVSaJTeaH9AqfhCcimNcHNqQ7llwytBnItEzftQo
        BLH3n2J+DT42m15CvUNLRpwf43im0ro=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-uly3uR3IPHuklHLt4Qq9Fg-1; Wed, 28 Apr 2021 06:54:13 -0400
X-MC-Unique: uly3uR3IPHuklHLt4Qq9Fg-1
Received: by mail-yb1-f197.google.com with SMTP id e65-20020a25e7440000b02904ecfeff1ed8so29807899ybh.19
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 03:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAtHOuu8UFojOTp6V42YTeKVXJLCBUn0sF4pumdT8VA=;
        b=YWgv2MKaehMQH33gxSsMB/6udRalIHnx28gxIznRrDRBiyy6eHdEmVRHFhDV1ASFsl
         O92mDIhx8wAoxMAsxX4BBSNbRVZDeHqozoobCa3Bah0aeYN23K3lEaekbjFZqULqYiwK
         /Eqfd207pvr5OJdoEQo3Gg2Uhi1k4wSu1m4qC3LGAbPpwZJMe3VRW1Gwvo4eaiUgZVN5
         wPwQ96FY6i8OuaoMvuo7WQmiXZyB0ka0HHZbVYdxdkeDTUlqb+GOLa479eCZnFAFxAH/
         jay5QjTb3AcxpZjcF8NqUfmLx1tHomMojlcXPxZ6dSnYoQx0OJUHAn7lOf13gNgjtWIl
         329Q==
X-Gm-Message-State: AOAM531A+DG37c6+yIQQqfr6X0h/02NBB7ojzPME96VS+2hLUWVYc8uS
        BUZqMyKrTLAipHrk+RGirIbtTWPoDqIBnNnMAP2JY1VfJW5ADJ1PLVvwRiLXSDKDUpxDN7Baczi
        2Ub2euwYPthaV/moaoD34OCDpsYOrd3ALSA==
X-Received: by 2002:a25:7085:: with SMTP id l127mr40144078ybc.293.1619607253103;
        Wed, 28 Apr 2021 03:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiFYA7ycAmOeLzfS/rfrLKZjRl0XZH9fL8MShbgcWQ+C766L9YkKkVWaQEa3zwqRRoMMGyFR2Wn4lYmHAQEBA=
X-Received: by 2002:a25:7085:: with SMTP id l127mr40144070ybc.293.1619607252915;
 Wed, 28 Apr 2021 03:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <161955450031.8261.16400002795828868356.stgit@olly>
In-Reply-To: <161955450031.8261.16400002795828868356.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 28 Apr 2021 12:54:02 +0200
Message-ID: <CAFqZXNtwXv8zydfY=oZLD4Ca5m26Ci9MKmRa184GCLpx919zZQ@mail.gmail.com>
Subject: Re: [PATCH 2] testsuite: fix cap_userns for kernels >= v5.12
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 27, 2021 at 10:15 PM Paul Moore <paul@paul-moore.com> wrote:
> Starting with Linux v5.12 CAP_SETFCAP is required to map UID 0/root.
> This is due to kernel commit db2e718a4798 ("capabilities: require
> CAP_SETFCAP to map uid 0").  In order to resolve this in the test
> suite allow the cap_userns test domains to exercise the setfcap
> capability.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  policy/test_cap_userns.te |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> index ab74325..9683870 100644
> --- a/policy/test_cap_userns.te
> +++ b/policy/test_cap_userns.te
> @@ -12,6 +12,9 @@ unconfined_runs_test(test_cap_userns_t)
>  typeattribute test_cap_userns_t testdomain;
>  typeattribute test_cap_userns_t capusernsdomain;
>
> +# linux >= v5.12 needs setfcap to map UID 0
> +allow capusernsdomain self:capability setfcap;
> +
>  # This domain is allowed sys_admin on non-init userns for mount.
>  allow test_cap_userns_t self:cap_userns sys_admin;

Thanks! Would you mind if I move the new rule to the end of the file
(where other rules for the attribute live) and tweak the subject line?
The final commit is available for preview here:
https://github.com/WOnder93/selinux-testsuite/commit/fd4254f09316f6db0410a9187cb8866571f109b5

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

