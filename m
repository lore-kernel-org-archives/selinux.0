Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E6C433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 17:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350111AbiDARdk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347779AbiDARdj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 13:33:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC71223223
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 10:31:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w25so3729132edi.11
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigbadwolfsecurity-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9EX5YaELNjIWzmC8yigkopSMTjQSj4wLnf7eTlROuA=;
        b=fP48xkAa4GkgHV1RKzBWMVbiIPPoQId1mNbdhsvn9z0tC/v638iCBybimikUSui33l
         UZJX6eyhDrv2SyosCv+W0FHeKBW3IRsixb85T463L/9Wvb5jdqNRYImV/zHKKTm3OfUN
         Kl2iWR8SaqYWQHtIaFRKqFwL9lFSDPIdfcNDwBBWPHP7BoeDUPsfDEjHyBnjSzAr6fIl
         drxT3IQFFa0Atrd90/NqnOqhYODxppvcO7SSNN/YSlSaZnE6YxApI0WFTnqdqd9KGIal
         vYGJXCjw88MeHuIJxjw5B2cO5rxIu+vXGe+xR4C6AS3RgWG0ULq1KLCEDw4b6yJUsLQw
         GjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9EX5YaELNjIWzmC8yigkopSMTjQSj4wLnf7eTlROuA=;
        b=E9cgY1eKlII953Sk7KxEF1xWFxBpcF7IMjla7rIEX3Ks44QBbrzWKVn2mAAHEDscYg
         eRkXR9IL/BqpsRckWtwsOkYA3iV15wNWeLF0aBtBXmTDOBcMRChcPWMwyzC6uMpAdIF1
         WK3VGja/5687A9cntM+Ywrad/UePFvWeuyzI1jZWkLl+jsu77UbmT6IJqhkRfMbPwtqQ
         DpOzA+HGXmIfHsq6zNn6RgtAFye0ZHVyVE11C/c3hHOcP0GT84r/ZaxP5TqJrI49d6U+
         8zEMGqHWmvUPZu4e1u4jdfInb/ccKbuOME5iru43QSod1ybvoS2CSAhniQhlrlMwSiQD
         rPfQ==
X-Gm-Message-State: AOAM5307VdmQY7bSYAUCfAEjvXzsW3b4XPlTq/28NSTXPtLoutN9ZhLY
        NWNnfwJJnwSP3s9E9vFrksOYmgcgd4gjnaTfTfVeVg==
X-Google-Smtp-Source: ABdhPJyhZGYjVVIfV8yuQbee3S1M47hUXOTYp4+MS39dhrwVNUC5NT8roYSDWJLY4JBfJrHjWO5sJgZlitodXrVmq0k=
X-Received: by 2002:a05:6402:34cf:b0:419:75b1:99ad with SMTP id
 w15-20020a05640234cf00b0041975b199admr21956054edc.228.1648834308617; Fri, 01
 Apr 2022 10:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <87fsmwc26c.fsf@redhat.com>
In-Reply-To: <87fsmwc26c.fsf@redhat.com>
From:   Karl MacMillan <karl@bigbadwolfsecurity.com>
Date:   Fri, 1 Apr 2022 13:31:37 -0400
Message-ID: <CA+EEuAj-iik6OPLMKNyb7DexVvxBjjfUXWvayw4d6OoPKg9XzQ@mail.gmail.com>
Subject: Re: [PATCH] sepolgen: Update permission map
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 1, 2022 at 10:29 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
>
> https://github.com/SELinuxProject/selinux/pull/349
>
> It's too big to be posted on this ML.
>

I just glanced quickly and one thing stuck out to me. It looks like
relabelfrom on sockets is marked as 10. The theory on using 10 for
relabeling of files is that the full contents of the file is, of
course, immediately available under a new context after relabeling and
thus represents a large flow of information. The same is not true of a
socket. Yes, subsequent send / recv from that socket would yield data,
but the actual relabel seems, to me, to not transfer much data.

Karl
