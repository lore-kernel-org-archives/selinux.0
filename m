Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A491BC43387
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A7F20823
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dFiNELfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfARQko (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:40:44 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:55528 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727346AbfARQko (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 11:40:44 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jan 2019 11:40:42 EST
Received: from mxback19o.mail.yandex.net (mxback19o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::70])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 77D111E801E4;
        Fri, 18 Jan 2019 19:34:42 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback19o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eHslFpwSWV-Yf9KhTnu;
        Fri, 18 Jan 2019 19:34:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1547829281;
        bh=1Y5YsmaBSWrEKkSMALBpgh8vRyyyRdlnpS05fll6xJo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=dFiNELfJqOVcafqWfwuQV+DjNRVT7siyeFJeBNNapcph7LSOOTaIs3HQiYxVz931L
         f4o0ue8rMJAqdXvB8vQ9fEcdVSK6hiaE/ykBK5fEp+116H2SM/oJaQWJ7YXaz8D/rr
         005VpoYG11pUvghuQrU018Q84ie2sNPb3DyyfoHw=
Authentication-Results: mxback19o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-fed4e4c8a570.qloud-c.yandex.net with HTTP;
        Fri, 18 Jan 2019 19:34:41 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
         <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com> <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 18 Jan 2019 19:34:41 +0300
Message-Id: <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi, Paul!
I don't like this. As you said, fix any calls to icmp_send is a trivial.
But in cipso_v4_optptr, we repeating the work already done, and in cipso_v4_error
we will need to do even more again. Any code, working with IP header data on several
levels of TCP/IP stack need to do this again and again. Is looks too overloaded!
In my opinion, this is a problem of TCP/IP stack design, comes from standing
compiled IP header data in different places at different stack layers.
May be better to add some flag or pointer to struct sk_buff?
But, I think, we need netdev developers advice for this.
Regards, Sergey.

18.01.2019, 17:53, "Paul Moore" <paul@paul-moore.com>:
> On Tue, Jan 15, 2019 at 2:52 PM Paul Moore <paul@paul-moore.com> wrote:
>
> It's been a few days now with no comments from the netdev folks, so I
> think it's probably best to start putting together a RFC patch for
> review/comment. Nazarov, would you like to do that? If not, that's
> okay, just let me know.
>
> I'm still concerned about calling ip_options_compile() in icmp_send()
> and I'm thinking we might be better off to add a new ip_options
> parameter to icmp_send(); if the parameter is NULL we behave as we do
> today, but if it is non-NULL we use the given ip_options parameter in
> place of calling ip_options_echo(). With that change in place, we
> would need to update cipso_v4_error() to do the extra work of calling
> ip_options_compile() and __ip_options_echo(). There looks to be maybe
> a dozen (or two?) existing icmp_send() callers, but it should be
> pretty trivial to update them to pass NULL for the new parameter.
>
> What do you think?
>
>
> --
> paul moore
> www.paul-moore.com
