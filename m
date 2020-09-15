Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E1C433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 20:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746D020809
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 20:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCAE3w/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIOUmK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgIOUlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 16:41:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA30C06174A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 13:41:12 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c10so4534308otm.13
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC+qva/7DNIyg2XAov+2UGDM6A/P3E1L1z3erk5iXbU=;
        b=oCAE3w/+wiHgbzVJcaGkGkEIGV+RqnpxkGEhkll9b2PfV9zUwD70LJDe77LbB6tZHm
         Ox/iqIEDZjxaFcqkb0F5E3r762QUll/ad+mo+qwXOcoaMxrXi19Qwf2eiG/dPvhzXbW3
         rEWYIYlzc063qB/YvYds+K5IBWF0TKf+Okj+LkmMVLgZfIIn9owZGTa7fl9yjs68VDQ8
         FaYYYZl+eJet4mRTsDoQT+wNj0Rp3BSG4KXtK4CkbLSl7ReaBxAMGuQjZzv53lMKi9WX
         +dwRsrgmgVXN/Wk4XNX98Nx6wNQEeI15wRj/MGlcqw0+mEs14KZXGPYg5CSM032kcM5N
         3o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC+qva/7DNIyg2XAov+2UGDM6A/P3E1L1z3erk5iXbU=;
        b=E7qM2EywvnqWlj8EnLnXEZrE5MR68ERaEjOJIEUVsCaCXQLgzp0nomiZ0kj5I7yx+D
         IR0IpfQFL7FtkpdJkaXR4ZHO1owU9hxd61zZayDSf4HgxxVEzffM1LGPk6gXhSNQvZHw
         b/hmJUyjr/NOR2TE9w3IU7vilhZoS2V3Klf7j0MEcp8VyP3VTToaLuxPIMQ5bi1D/fm6
         uKDk32K6E0xqJ+oFxFT8ZKXY8LZPtDOWaGTe+8xUN2H8i8Vqww7F/MV4SNJo92U2O3Fr
         GZhEGD7xznExf00hH9cjsxVBLq595Y9GqeF9o1h5BIEWdUX2y/EFtqmG8OiH7Jrk2QKn
         XeqQ==
X-Gm-Message-State: AOAM530sxaAy8WBhs01rCcvE32EMzcuXu8x7Aff3TTIL6LqvgRC+brgt
        ejF4AM4gla5RaSrbbU7SaAmTILKDUvTIsgoLwlU=
X-Google-Smtp-Source: ABdhPJyPvPL3nNDWqyAP/0K8NY65lk6jypniJNfhjkVy+IMlIi1X09QDKH6mCn8fu3+ViDEqZBbqwV7zvwPPRCjfpA4=
X-Received: by 2002:a9d:185:: with SMTP id e5mr14797694ote.135.1600202471445;
 Tue, 15 Sep 2020 13:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200915173332.574700-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20200915173332.574700-1-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Sep 2020 16:41:00 -0400
Message-ID: <CAEjxPJ6cREbJT3gPJzz5pmsec3XSRtHqnhtjfiAERdjMm9OebQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: Add additional log callback details in
 man page for auditing.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 15, 2020 at 1:36 PM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> Add additional information about the log callback message types.  Indicate
> which types could be audited and the relevant audit record types for them.
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
