Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC17C3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F45F20848
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET8yTZdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgCDO2R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:28:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46026 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDO2R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 09:28:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id f21so2137815otp.12
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 06:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yR5SERaqmIHAt72SLZ7OfN7owXSdkCyulWamqOzpCo=;
        b=ET8yTZdxQaU5zKmZPjr98CYq0FYpnLXDPgZsvDCrc4T+VBuDj3BoGe0D4azYFRRH/j
         IAnjyslD7fmQTHujRI1beWNya2nEet+7SD8zZOOYpdyUQF2NK/1RfmIOG82Wdmw3bMwH
         42I4CzQ5dMsTVQDyKj1R95rK9eFXn2HXJn4Ml3qvE744owOL7F3wZou4ERodhU+D0W+K
         oaxEWvyd4ekLXwuE10kzbF7LQ8xTVHJGQBO9bleQg5FFHACDs4jjxgdIVgdQ5O205LKl
         DXJ1neUrFix3YEVnGFLGugERFFJrUjUyz+nS8ic0C62CWF2sEhg5+QWHyWLymDVz6jpX
         TqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yR5SERaqmIHAt72SLZ7OfN7owXSdkCyulWamqOzpCo=;
        b=tmmBTxC20nYHLtdUtJsIT0+LludFvaUtskOm0HwwulYnTEJJCYGGtAY8SaJvRs/feD
         SyMrxuZBvFfmq9AdaheHrtYTbyNe6gliu9ZGpBQVrIZtnee/AbAGezhMz6Uk9Sd+NRMN
         NG8+h7EruM+JBsmiBEpJFFnZL9A0Dw0FvEqjf5DwXs5dMwmdwd2nAmpMO7/tsBFlWNRP
         NcR2zgwd54kBlS2SEMyq77tcHFqBbrdDl+YNZd7mcSv+6XE6rcO+UQ4VbIUf86CoQXmR
         vMpZ0D/0jGKjVNAAFBJaLtNTUfxo6uG2r6uT1+udmq6/LHJEN/x/LD+qeUxYc139uTjV
         gAfQ==
X-Gm-Message-State: ANhLgQ1Z2QAndeuVTXySsl7yMQYtPjdtIFQIzlwCrGFuyeDTvFQuZsV4
        FTnavDLqEYG2nux2TK2sotFQZy+g7W06HgNKx8s=
X-Google-Smtp-Source: ADFU+vvkHjlX1MFTP/92B3KT6hfJu6R//6hDsktDptAoTmVB1QIMPiT+lW+prQnhPKu3S2n3zlecxinGl1p5irJSVvM=
X-Received: by 2002:a9d:6289:: with SMTP id x9mr2573048otk.340.1583332094946;
 Wed, 04 Mar 2020 06:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20200303112910.147788-1-omosnace@redhat.com> <CAEjxPJ591G_wJrEb4dFSfS=DHNYWRWkWwxTqAM=AK1YL3uvN3g@mail.gmail.com>
 <CAFqZXNs=hayAWPP9cPXtUCnYiwMeTdUoaWxcU=LkEb8+B=_ePg@mail.gmail.com>
In-Reply-To: <CAFqZXNs=hayAWPP9cPXtUCnYiwMeTdUoaWxcU=LkEb8+B=_ePg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 09:29:26 -0500
Message-ID: <CAEjxPJ61teE6eB-pZMHKYr2QMSCMcqC9nCvP_WT9bYAOnsSvxA@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up error path in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 4:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Mar 3, 2020 at 8:12 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Mar 3, 2020 at 6:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Commit e0ac568de1fa ("selinux: reduce the use of hard-coded hash sizes")
> > > moved symtab initialization out of policydb_init(), but left the cleanup
> > > of symtabs from the error path. This patch fixes the oversight.
> > >
> > > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > Looks like avtab_init() and cond_policydb_init() can no longer return
> > errors, merely initialize fields to 0/NULL,
> > which is already done via the memset above, and are not used anywhere
> > else so those can go away entirely?
>
> OK, but that can be done in a separate patch, right? Do you plan to
> send it? Anyway, I'd prefer to keep the *_init() functions for the
> sake of abstraction - I'd suggest just changing the return type to
> void where possible.

Fair enough.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
