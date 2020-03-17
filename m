Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5945EC1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C7A2073E
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 20:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mV3iqTRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQUJt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:09:49 -0400
Received: from mail-vk1-f180.google.com ([209.85.221.180]:38596 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQUJt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 16:09:49 -0400
Received: by mail-vk1-f180.google.com with SMTP id n128so1822613vke.5
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sZRn8/KlrpZgAWjpv6i/HId4X3Can1DqLkzmeUSWfJ0=;
        b=mV3iqTRvFobKDWgCQSW290rJ3/CAvwAGCdPFe9DzJfcydln++7RbDEL234RlJHnB5Y
         tXa5uvWU48pfKpOG9x0pZGDWx8Cd9WCG+tJOj/8sVuXaRJ5VCHa/LfzBEh6XNB+vz6bL
         eFV0GJcONVSzW4BXHljwRcWIDEqqZUwBnPq4q1fVYdy3tSwMeoloKfLxKyJ9PPR35GUo
         OKfnpb2OXPm7lcQY0B7Q0npZOHq9zlKnXJUJ+bt9Jj3nWRx9kQ0eLsubIYEi7vUQSsLK
         A6noM99oScXzEdmWrf3L8BdnVxt0bB6FsiCdcNkWgZEzspAng88kjiqeQU43SgmnSk8P
         nang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sZRn8/KlrpZgAWjpv6i/HId4X3Can1DqLkzmeUSWfJ0=;
        b=mA0xbftJ5GRxAM/JA2WYrPfI3NV9jtM0RNR9tB1Hzsw3G0AnVBNI4JQwG8tTnzPBoA
         sq7n73NQy0eCb/hIsamfXz/bvOIcj8n6bYNKglJJUmyyDEIRZqZ3KT15gVTgijfooINf
         8d2k9nLlBhX3kWQ8frEZQ5/sClkKAj8NVTwjs996IVHOweL8mb+vhLcnu0JuKvOLOIZz
         OtVzf4S6clXHevkx3ScyyZkt1gYDjF9NqISa1v9yQ5WrLlQ+kwPNisNO7gS8TvMh97Jq
         94A4v9vdQR+xHtQpOdaXtIx9PjSjb1Whq/AIhSZgO4bquyBr8J8B6SaEeziug+Swtgqd
         jM3Q==
X-Gm-Message-State: ANhLgQ2jqw0mraBwurqU98RJf5jJXeMSUoZPhktMVcUCyvzkjyli0KAF
        bmV1BMmo2mY2FrcRqX9pvNoNImkh6W+Tbtx4afXIBMwvt5o=
X-Google-Smtp-Source: ADFU+vs9IKbIZTjs7zrg3nl+YN1CX8gQi04Xtv/0OTYMdllb1/kWU9h67/UcxSBR0a9+ymG3oDLLULAmkH2n7f5zXq8=
X-Received: by 2002:a1f:2d4f:: with SMTP id t76mr910176vkt.58.1584475788162;
 Tue, 17 Mar 2020 13:09:48 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 17 Mar 2020 21:09:37 +0100
Message-ID: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
Subject: checkpolicy does not forward (t1 == t2) constraint correctly
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

the following cil constraint works correctly:
    (constrain (kernel_service (create_files_as)) (eq t1 t2 ))

but the te-style constraint fails at load_policy time:
    constrain kernel_service create_files_as ( t1 == t2 );

with
    Invalid syntax
    Invalid constraint syntax
    Bad expression tree for constraint
    Bad constrain declaration at
/var/lib/selinux/debian/tmp/modules/100/base/cil:957
    /usr/sbin/semodule:  Failed!
    make: *** [Rules.modular:59: load] Error 1
