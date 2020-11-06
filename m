Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870BC55178
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 12:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4126620735
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 12:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE1sbJLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFMXI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Nov 2020 07:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMXI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Nov 2020 07:23:08 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074B5C0613CF;
        Fri,  6 Nov 2020 04:23:07 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id k9so805513qki.6;
        Fri, 06 Nov 2020 04:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YUaSvirGjnftb3iKPYnFo0tj48LEYiycIQEKrdpMFyc=;
        b=NE1sbJLHXHxLe1VKkyvAys8FCLfs8AAM0uBNLB6KQKGoXsAGa03B1Vg0hwCpy8vsFw
         XCWa8KPPlZ+kmssLPXS/KI7q3ysKzfe+Ou94jLsBjSPPP49QoiVHmYJybqG2wceXn8c4
         heWyOoGnwFC8IeugfDGF4Rmw6Gr1/XraoSDjAxaW2fSAfPNqhhXGk6Jhb+h+sv2QBeMH
         1EfDHyZBGCTtA7NCUpC+gafzYQ92mYbo+Pdq8DNkjcq+oMl464xwAhkAJOTidRo2I1g3
         yI4qEhe2PebWpFMaLun6b0uf7fDYqy25fm1z0scMj+EOdzikhfb8hdjBErzo0ugpW7ra
         TZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YUaSvirGjnftb3iKPYnFo0tj48LEYiycIQEKrdpMFyc=;
        b=TIPqzH5E4TZxxhsL1a3NVHi4leLmMDTjhODkibZEImfZV/lb8AdCUD/1eDCGsrwjaz
         //TOB394RQGjYTpOt//FYMdCcYIoeWCLS88wWRJbqsWm559oT62jTE+iJsmLwRjjncgF
         kd0hDDsns9ucFCIt/LW0uEJagvlaOsEjDd/0am0/f9obBSNJuEujgVhrXroBOFmurIr1
         WN0jaH1WHlh2NGn6J9ieOSGJ3mMWz7G7hqAPe4flqHsvJZOfaadxwBO4uru9miB2V0L2
         lk20Tf/ias/DPeXTi3V6lBO1YH002udtUsrV9UFz9Z/BIpcjEi6UftNPQlNae3BLkRyG
         jyIg==
X-Gm-Message-State: AOAM531bVhJD9PFVzdBIFiPuN0k7W7ih46j9en80UgADgUR8Yyv1WcjI
        qlQWP6+/WVuYAqjVFAiJQHeybjT5Hhf3xWHcal0YNXBvMVj2mg==
X-Google-Smtp-Source: ABdhPJzT0dk6rjZxXjDdLhFVqJx2yxnUIxwYVK1lNvUbh/5JLPizGPBuyaouVo2hhzwqwD7PwD9MvyIoNOb413KIVLc=
X-Received: by 2002:a05:620a:2443:: with SMTP id h3mr1086875qkn.447.1604665386816;
 Fri, 06 Nov 2020 04:23:06 -0800 (PST)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 6 Nov 2020 17:52:55 +0530
Message-ID: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
Subject: Selinux policy for x509_ima.der public certificate loaded by kernel
 during boot
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I am getting below error as selinux is denying access to the .ima
keyring. Looking for guidance for asymmetric public key selinux
policy.

[  172.014855] integrity: Request for unknown key 'id:87deb3bf' err -13

[  172.015035] audit: type=1800 audit(1604596570.579:240): pid=825
uid=1021 auid=4294967295 ses=4294967295
subj=system_u:system_r:mydaemon_t:s0-s15:c0.c1023 op="appraise_data"
cause="invalid-signature" comm="mydaemon"
name="/usr/lib/libstdc++.so.6.0.25" dev="ubifs" ino=14353 res=0

(a) Do I need to set the selinux context of file
/etc/keys/x509_ima.der. If yes what it should be.
(b) Do I need to set some selinux rule for .ima keyring. If yes how. I
tried a lot but could not find any resource.

Regards,
Rishi
