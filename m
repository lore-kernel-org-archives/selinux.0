Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E94C3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B40E246B6
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXSvAIiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgB1NQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:16:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38942 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1NQp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 08:16:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id x97so2505934ota.6
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 05:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73jkFDgDNFDtPb/rtTNH4yz7VbKB264E7XUdHWqNXQo=;
        b=WXSvAIiLXavo1L8RO3e9bj2ZLgJFC/T65a03/8/V78qaeKj1SGQqvb1UDBE8E47MXA
         rjenHdtL4T3WoLYJMUdLdJpVULV8s25UEKIwDMqahbeJxYKWMJlychUWGa21dobUIvZS
         VcdEg/FaEJR+mCd8jDQpUIwPWHPKuTVOHA9gC/MF+t0IlmM8sM11yLv+4jZu9C+3y0t4
         0B/aqQN9TsG88xb+Qj1w6weSOQlx7BzofKX6eHI6+tDfhetRdP4udmQSzY37c4uUv5ak
         ih2E6jASHFbruY/zudKvqPvDK26jHsFWRab5O8oUMdhwK7it+MRtYDC5QBYpWD3cpXFH
         7E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73jkFDgDNFDtPb/rtTNH4yz7VbKB264E7XUdHWqNXQo=;
        b=towvWpOm8gTEKnWDC2UqkV83uukUW91N4ztZSHQOQYTqtdH6f8IADChvBr/XP18vW0
         riDsEkect/VkKvsVqTZl4VOm1v3mCfCpdPVbc/j22iAh+IqJmfl1undv4MykRGJzwfEs
         b5af/k9s/Eot/mGLFuuJwsYc6atYjN4rISS7Gx0+Ch4BxJhKWgaQQ+2sJi5oh584+CsX
         /KpZ+WkVeI75lPDe1ElZu6lxnndSE9/kea47SmlETFowwp3h4I6N8UBLO2PKQGoGYOhJ
         iRmPVchIlr5G8mVGevn/Z7Cedl7gog/6bzK3XkP8bxkQ4FbblJbQ7lLTf7aAfDVLRawg
         bKCA==
X-Gm-Message-State: APjAAAXDAm97RR70kdv2gdkgNWfDBGTA2oA0Gd5VP8gOkYrOU6Ut1FCW
        oStJxfMA4l1/UGnp9iB1SnASf9UH+PwNrhIU3x8tzw==
X-Google-Smtp-Source: APXvYqxqssqRJO7fa/DBxbbVuRqAI2a/Q5FxlnGHzLNSEXYGi9sgQCDo6BIKMa7hKXnnXIvt4PHdU7c3yIL4B/nK0NQ=
X-Received: by 2002:a05:6830:140b:: with SMTP id v11mr3257009otp.340.1582895804031;
 Fri, 28 Feb 2020 05:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20200225094529.178623-1-omosnace@redhat.com>
In-Reply-To: <20200225094529.178623-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 08:18:00 -0500
Message-ID: <CAEjxPJ7=5yPzv+PCmtTsuN_osgmkxWGab4CN9y7k5LTEoT-dJg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/sctp: fix setting of the SCTP_EVENTS sockopt
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 4:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> First, the setting of SCTP_EVENTS socket option in sctp_server.c is
> completely wrong -- it assumes little-endian byte order and uses a plain
> int instead of the dedicated sctp_event_subscribe struct.
>
> Second, the usage in sctp_peeloff_server.c is correct, but it may lead
> to errors when the SCTP header definitions are newer than what the
> kernel supports. In such case the size of struct sctp_event_subscribe
> may be higher than the kernel's version and the setsockopt(2) may fail
> with -EINVAL due to the 'optlen > sizeof(struct sctp_event_subscribe)'
> check in net/sctp/socket.c:sctp_setsockopt_events().
>
> To fix this, introduce a common function that does what the
> sctp_peeloff_server's set_subscr_events() did, but also truncates the
> optlen to only those fields that we use.
>
> Fixes: c38b57ffdac4 ("selinux-testsuite: Add SCTP test support")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
