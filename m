Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF9C4727F
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73802071E
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kZXhuwkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgI3NoT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgI3NoQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 09:44:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD9DC061755
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 06:44:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so2868965ejb.12
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv+0SEm3ZBbuCilDEG/CT4tZmdLu+h9w/O+Bpd1VJEw=;
        b=kZXhuwkp+0Pj2nq+Wdm8mrhdY9dD6koq1af5Fk5s6iJWJreLo6FGGg++D7B+iF2Z16
         Gc9IuJzNwpLIbJBk14f/+KcHO4zb07BLd3JdWWZ/6Sq53QRfNWGgZnNYraOqYw+NaV/S
         Oa52DvX7NZE2OAQai8XFn19vQRqJ7DZCWAYCPzunUkclSon5s8WuKyspntOGXBUGi+kM
         gSQSDp6Ih1tOXtz8Jfo8XC+2RHN6ucdjBH/ZZAh5bB8x9kBEAQie6wWnc+SvOSu9cFkb
         00sAviQPAdrFOZOxV0PZQ7ktzrj1OS69sEMG7wsu9RcsJSPo9XGLG0Ver4XX44A5fflG
         WC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uv+0SEm3ZBbuCilDEG/CT4tZmdLu+h9w/O+Bpd1VJEw=;
        b=XOXinv0smxORNhMXPGR4XRK9rYNb6SURtNmPpk+ciLcCz8RLED6hC7h5sc3uWIU4iY
         qL99Qv18as4obLmi8YYTqEul0IxUUc15m7ZQcEB5dJv7HvT0Yb815UpttzFDEG3wh2/8
         mZsY3r0LpBHfCnWSQ/v2K70sWo5+H51DsfWBr5IqVBnCGvH/YtsO5zktr2e7blGk9Y0Q
         5KH5vyoQY7NLIN15p5ObQi+p6aqPRK6XhlSFDQqxpRO0DRlcZtC8WgKC27Qyy75Zs/Tz
         ukQNlZO/of1Ou+7wamw0JP5GIj3kdtheiYlbODb907EdLqXs6szBL5pCO/9VVUECetlD
         34gw==
X-Gm-Message-State: AOAM532HfTDP9msdUnCTBeqB+HWFA9fE2ebCtRm7iFRSNRVe6htwZ/pr
        ABj7uODC7WrsX+l8Nv0hy5RVZuqF0z3VBaqALxd7
X-Google-Smtp-Source: ABdhPJyIyHapkdpsMZlH1k0VMzFpSD2bBOeAOJPN9zjb137yZwO+lFN8UEOnqZPlBqsUFSYFjZaRiRi8PRSDcuT8Xyg=
X-Received: by 2002:a17:906:77cd:: with SMTP id m13mr2817282ejn.106.1601473453339;
 Wed, 30 Sep 2020 06:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <160141647786.7997.5490924406329369782.stgit@sifl> <alpine.LRH.2.21.2009300909150.6592@namei.org>
In-Reply-To: <alpine.LRH.2.21.2009300909150.6592@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Sep 2020 09:44:02 -0400
Message-ID: <CAHC9VhTM_a+L8nY8QLVdA1FcL8hjdV1ZNLJcr6G_Q27qPD_5EQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: pass the family information along with
 xfrm flow
To:     James Morris <jmorris@namei.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 7:09 PM James Morris <jmorris@namei.org> wrote:
> I'm not keen on adding a parameter which nobody is using. Perhaps a note
> in the header instead?

On Wed, Sep 30, 2020 at 6:14 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Please at least change to the struct flowi to flowi_common if we're
> not adding a family field.

It did feel a bit weird adding a (currently) unused parameter, so I
can understand the concern, I just worry that a comment in the code
will be easily overlooked.  I also thought about passing a pointer to
the nested flowi_common struct, but it doesn't appear that this is
done anywhere else in the stack so it felt wrong to do it here.

-- 
paul moore
www.paul-moore.com
