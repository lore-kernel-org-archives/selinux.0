Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE4C433E2
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EAA2074B
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 14:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5PacdTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgINORg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgINNZf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 09:25:35 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEDAC061788
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 06:25:20 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o8so7131920otl.4
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DiRzZCQHGqj3T5JONDRdFBtB+hHjqPgAsdA1aY6qMPY=;
        b=M5PacdToXc0fvVs3ROPFWIF0WDzixFwX1mTGomexWf2NIALsJpm+DdVXcXKl2cLakU
         9zxdef5upztgWW9/I21max9WfB5feiKcQOLCghUUXSY9RstDCil/Danaxyws2eRnF9Sd
         +G4i8q9GU1FSMNgvL/3TP+YI2SCqNWKFlfyEOWCB5YQZ4YJ8ZDpJfuOkcW4TCwC75Ls0
         fJRKwz87Lb3pKaALFHCuqTgA/JEKE5M69KhfQZaQZD4bMxbNmZUPTFhy+dMS8vQEBAoS
         NzJYRm7H+sGWSQnWEnCni6zp+mhnqCk7rNxDwSvZOJR+yw5JZqYeui4JIHALZ1SReQyw
         9o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiRzZCQHGqj3T5JONDRdFBtB+hHjqPgAsdA1aY6qMPY=;
        b=NpjlfkLSPf/QaTPjLNTaWTIlV3yZEcmgm5UTOYe1OBHaD+OKK+MQkMNv5VcZmpJ7hc
         +vWm7rAOFepfGJKHq7JJmPmut14GtSP10Wt1/r/wMZTOwrYZuN/rQr3WwgBZv8UXS562
         CpcW044JKqL9mQUs21oA1kGdgqNBRxuGSPjUpWmI6J9NkaxdnBvVwvyIXD3u1LfsMavH
         tu8Vhs/AluCflQ5+sRlIaDz4wi6TPSGRxKIYDa8y0XxhK3UzWhqletZ/O7SfjVBDGNOt
         gwJlrVfN7KqNMdfu4gBQ4tY+HKxaDK1TD3MJ5mhBeLsBu5Z7iXcyX5nQ5T83kyaQPJtn
         5fXA==
X-Gm-Message-State: AOAM5313ccHIqRHHRp5DfsgJtQny+wFsxzT9h8sJIeokdl+Dfba+sX6c
        x2cTxAXnXdtDb9thvaWNqPi9OrpWiFjpTPXcxHI=
X-Google-Smtp-Source: ABdhPJx+LGpOVfDITm4qR6KaJyqJuY35FTmUx+XTNBso0L3WN+bQeUL2BnATToka6/3kZyFTkAQ2DODWYZhuCFDr9AE=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr9316992otb.162.1600089919495;
 Mon, 14 Sep 2020 06:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200911164009.21926-1-nramas@linux.microsoft.com>
In-Reply-To: <20200911164009.21926-1-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 14 Sep 2020 09:25:08 -0400
Message-ID: <CAEjxPJ4JCRkiSnDq=HZjk2pLj0m2ayYTeEvQ2jevMd=yLMoXhg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Add helper functions to get and set checkreqprot
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 12:40 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> checkreqprot data member in selinux_state struct is accessed directly by
> SELinux functions to get and set. This could cause unexpected read or
> write access to this data member due to compiler optimizations and/or
> compiler's reordering of access to this field.
>
> Add helper functions to get and set checkreqprot data member in
> selinux_state struct. These helper functions use READ_ONCE and
> WRITE_ONCE macros to ensure atomic read or write of memory for
> this data member.
>
> Rename enforcing_enabled() to enforcing_get() to be consistent
> with the corresponding set function name.

I thought Paul said to only use the new names for checkreqprot_*() and
not to touch enforcing_*()?  I don't really care either way about the
names but usually we wouldn't mix renaming of something else with the
introduction of these new helpers in a single patch.

FWIW, looking at the history, the enforcing functions were originally
named is_enforcing() and set_enforcing() in aa8e712cee93d520e96a2ca8
("selinux: wrap global selinux state") .  Then Paul renamed them to
enforcing_enabled() and enforcing_set() in e5a5ca96a42ca7eee19cf869
("selinux: rename the {is,set}_enforcing() functions").
