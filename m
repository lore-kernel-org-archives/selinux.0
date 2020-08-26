Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB5AC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD3D2078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfGZijBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHZOrL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHZOrK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:47:10 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29EC061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:47:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n128so1748239oif.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rp7bv7q8faXNOQosmhFGspD2uTIROrBVXDNbG7iXFS0=;
        b=MfGZijBp60NhWBiF1MleNIxot2SWxBaQV1GPlBjwhd4henRVyd81C2yY6caAB4j007
         2qj2Dwed3JY9gVWVxHUIOLMS2akWyXrLPa89toweDUM1E7GDcDok3ZVCVfN2OsDa3J2s
         N+lcqCFQOn10IKFYlEg6cVAYoKEySb1LnZlUGE3gTCyOfHhmCID9kv/7NHK6KXKO0HbG
         4ZRcti/x2xcRxWI1g9l8zyFcB/UL52vU58/TC9sz4M37994bl1qFZx5ZrUER0ZtAguSj
         IQoxBg/m1G+NBAQdyJA53MsCSFofXwBLyvydUx4FNMNv3MV469OjGg9ZTtFGnpR9l9y0
         4KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rp7bv7q8faXNOQosmhFGspD2uTIROrBVXDNbG7iXFS0=;
        b=EUA66pwHyhgcwLyO/51PFDZfxA3Wq1nfyog5jD2niDO/VruSB5zyGur5V4g7FI/tBx
         Fz72q9WkliQKneibcVOmvY43wl5+1b2G4N3CA8oujApv0zpARPa8oawv+N1dGOFHVzf8
         BgppQyxDKiuHRPMRcRoNnrYH7H0+uAvUihLvZNcjQj1E+nlNVN9Z7VkMiygTgnA3qxQ/
         +8e50NFimLzxF44no+5EHeETIMDVKN5QHLR6wlybEkoDn/u6yXcZJIOni079ktaOf7ad
         E5uc5lKs/+eFVIr4A39mOGOLTwDnr4ETjhkAjV32YziucGrjbnvn3315LFcABTC4HPM8
         yKBw==
X-Gm-Message-State: AOAM53046WsBPNwpwOnyhQSXAYGH1B04jFEVsnoXvIPsXl2jK8tWSO0t
        zHpEqjWUqKfTdJL3DPZRxqPq9E8DbnUrhNfm+PkYX5dM
X-Google-Smtp-Source: ABdhPJzvkkgs29INfCl8ylenp2RTGdmPcuZFqAfkfyR/E2XdyA7R79ISeLXatx7+oGhuPAZEdLOjJSpb9+wrSc5+9ig=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr3921722oic.92.1598453229904;
 Wed, 26 Aug 2020 07:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <cb7451da-24d3-4a0c-e4f8-205e6539ed54@linux.microsoft.com> <e4cdec2a-8c01-fbe4-cba3-3468b4ebea2e@linux.microsoft.com>
In-Reply-To: <e4cdec2a-8c01-fbe4-cba3-3468b4ebea2e@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 10:46:59 -0400
Message-ID: <CAEjxPJ7xrzm6GQUxckRgVot082xZtabV-RZzv0E-Orfq7y_riQ@mail.gmail.com>
Subject: Re: Userspace AVC auditing on policy load
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 10:35 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> On 8/26/20 9:25 AM, Chris PeBenito wrote:
> > I was looking into this dbus-broker audit message, which has the wrong audit type:
> >
> > audit[422]: USER_AVC pid=422 uid=999 auid=4294967295 ses=4294967295
> > subj=system_u:system_r:system_dbusd_t msg='avc:  received policyload notice
> > (seqno=2)
> >
> > This is due to dbus-broker setting their avc log callback to send USER_AVC audit
> > messages for everything that comes to the libselinux log callback. I think the
> > right thing to do there is to change it to emit USER_SELINUX_ERR audit messages
> > if the log message is SELINUX_ERROR, otherwise log the message using their
> > regular method (stderr I think).
> >
> > But the question became, why is the userspace AVC not simply emitting its own
> > USER_MAC_POLICY_LOAD audit message instead of sending a message to the log
> > callback?
>
> Ok, I missed that there is a SELINUX_AVC log type and that's how the userspace
> denial messages are sent out. How about adding SELINUX_POLICYLOAD and
> SELINUX_ENFORCE log types so that callers can emit appropriate audit messages?

Do we need two different new types or just one?  Otherwise, I don't
have a problem with adding new ones as long as it doesn't break
existing applications.
