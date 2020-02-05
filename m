Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34384C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093CD2072B
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="haCPoFTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEXSW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:18:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44940 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXSW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 18:18:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so3892091eds.11
        for <selinux@vger.kernel.org>; Wed, 05 Feb 2020 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yPHQgk5l9M0uG8WfLlc/T29sIHXAdBAzb2aZffX87o=;
        b=haCPoFTXaldRhpfYr9XsOnDhJDgnrxG5uK4/QS+vJow/j1rRTTtB3+9Dn1UU0GpVkJ
         5XMIeOHTzVNn4iYKuFRERaBupMhA7jpHnbG+gC5hJjFe6rO/m4D1obWmUP/bagKuSgqp
         klZnkzrTnXRsGcfJ72tVZkAFIZ29RN//nhS3jFavE2oqxLoTjOpWWZAPOtvkUeR2FEoz
         JArQWjSrwaLkqI0aQlBntg1EJ630x9l5LYGEkRhvcLeEEqUlvmDtWGkb659chVXPNbe5
         gyvt2xuFEFAKk3hb7kQMMC1Dz/iRRKDpcpVMQXE+eJhRyMMChh4Ulp/wSQXpQhGCl+l8
         XE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yPHQgk5l9M0uG8WfLlc/T29sIHXAdBAzb2aZffX87o=;
        b=LPgIgEtprM88AsjOVur8nVlIOyy0W3Ic3c7ckqP729U19GUoXb0eif3Zr0WTtRQb5/
         cyVRF8nlipk9xBl2vFVinWKT7vFSpGmV/D7eCgyFbBvK3coaabCoUyfWhuw4MhBc0OGL
         Ji6l3vpKpoP9G1Ofb5jsKT09zAuIO+hGfI8K8mI/okInz4CWsoT3tjV6LDgthIoAJ6A2
         Qhj5nnuTYNwxhCR0A5mdcoUud27zFNyelsNESESJ2PtuQG8fhAhUSLnP/KUzeack6BNz
         hkBhJRz02qExOqeLs3D5v/U3K/6w4OyvY+urt1YPvmWu57iAzlW2U/oCo8JunHZg8xOs
         /2/Q==
X-Gm-Message-State: APjAAAXTVjU4O/xpv1dgro2r2vnynChCYQv1WRyqGyM58Gx6e90c001E
        oEpokOQDAzLbdIaRdvwgVNVIk6+5vGnVauW6Nr6pfgKKTQ==
X-Google-Smtp-Source: APXvYqzv3zmXH3t4F7lXd92ukfha+aVUaJxBYhdRCSIZ8b59VgZFYceOmtfFaxbXr2fnK8BWM1toPBwjZbWgDPwtmWE=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr456018edw.269.1580944700400;
 Wed, 05 Feb 2020 15:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20200131230017.199775-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200131230017.199775-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 18:18:09 -0500
Message-ID: <CAHC9VhQ=GQ7smodGjSD1iVOxpWCRNaCV8Ov+LYwZRVXoZWvgAw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Binder goto brexit fix
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 31, 2020 at 6:00 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Now the deed is done, correct the final leaving date.
> Could not resist adding the relevant dates to complement the 'goto brexit'
> statements.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> Before anyone asks regarding '240616' It's the result that counts !!!
>
>  tests/binder/binder_common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Without venturing into a political discussion, I feel the joke
deserves the proper magic number.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
> index f60860e..319b5dd 100644
> --- a/tests/binder/binder_common.h
> +++ b/tests/binder/binder_common.h
> @@ -43,7 +43,7 @@ enum {
>   */
>  #define TEST_SERVICE_ADD       240616 /* Sent by Service Provider */
>  #define TEST_SERVICE_GET       290317 /* Sent by Client */
> -#define TEST_SERVICE_SEND_FD   311019 /* Sent by Client */
> +#define TEST_SERVICE_SEND_FD   310120 /* Sent by Client */
>
>  extern bool verbose;
>
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
