Return-Path: <SRS0=FZ6t=4J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BCCC11D00
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 00:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBD7208CD
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 00:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="l5KdBAC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgBUADy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:03:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42852 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgBUADy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Feb 2020 19:03:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so165639edv.9
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2020 16:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDxfAboEghoTjz6JeUPEpMA5WNYCcURwB2Y3lDV27KY=;
        b=l5KdBAC0f/L/zWRVlOc39WvhRlanX7zUP9cEMb+3Wg3CxZwnqLheAUxziwvKpuU9db
         6u2DqVYk/DPQuQPFRTTquYOaEof0iaAT5sTgMXBcXYNbdGARfl4szoJHoTzypGaEAE3k
         hHALNPxNtrYycxGF1gHOWf162X0v5cisshUz+d+RrtiXTm/WucGHu4KWM+RgCbVRPu1t
         /UyEjDVumCKuVvnzv3vGgFZO0VL2r0Ux6eIdV64j24eNuI8AWrxV0a0Kdp2F6LTVe3z9
         PHYGGOIBWA1aEK/QhPXC/184Tql7z3wZHoGWvR5QBT682qr5eZYXUiDE/elL6ON7msDF
         wa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDxfAboEghoTjz6JeUPEpMA5WNYCcURwB2Y3lDV27KY=;
        b=qsYX2c7DuxBdOVm3Ql/NTjfg92T0h7heGFfg06govjVALZBwiByoBZHRH9ciS2l/Qm
         EgwPGGlD+cOTo4f27kI5BYPu/aSVOPDqL9AAkD8cL/Xo0f86eP7ipfJstJGFIJFiebay
         rTfJfh8ZTpz4J+Lho8GwMoEE8YFC/ga1iSkn619Pus6XHau38UckySBIKMfctvKXbHlG
         RMRrlfVRnI3WD071SpB70Z94Ubs9ywXOOzPuhn3wfhm+8dSDtYLMesPhYYW318DIkeSu
         5o6n6r1uwxIw9cZOUMl6CXTHQrSyyF5+jPu/pFQEqmm1BNxAtqbNZPMNodGfzN688nX2
         5GVA==
X-Gm-Message-State: APjAAAUnfjZ56S3Tiuz9gPiZlYpwE+J6UdAe9ScK5w4sCe1hij+0B3En
        f/sJIpclksTxhhsH2tvAs65dOQa7N6cGlUGa939T
X-Google-Smtp-Source: APXvYqxWYMaojlGn5uGmJYAU92Kt+xSuOHLghYVKYWZnd1vNWE6DXxyv0hbgrotpb8BmsTqsdbK4pHzSUOBTGbGbuUQ=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr31406679ejw.95.1582243431635;
 Thu, 20 Feb 2020 16:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20200220181031.156674-1-richard_c_haines@btinternet.com>
 <20200220181031.156674-2-richard_c_haines@btinternet.com> <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
In-Reply-To: <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Feb 2020 19:03:40 -0500
Message-ID: <CAHC9VhQ+pNTJjb=ipG_gsTSpv6-rEtWTL2sybrOnjyBJ+==2hw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] selinux: Add support for new key permissions
To:     dhowells@redhat.com
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 20, 2020 at 2:26 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/20/20 1:10 PM, Richard Haines wrote:
> > Add a new 'key_perms' policy capability and support for the additional
> > key permissions: inval, revoke, join, clear
> >
> > Also fixes JOIN -> LINK permission translation when policy
> > capability 'keys_perms' = 0;
> >
> > The current "setattr" perm name remains and is used for KEY_NEED_SETSEC.
> > This gives the following permissions for the 'key' class:
> >
> > create        Create a key or keyring.
> > view  View attributes.
> > read  Read contents.
> > write Update or modify.
> > search        Search (keyring) or find (key).
> > link  Link a key into the keyring.
> > setattr       kernel < current version: Change permissions on a keyring.
> >       kernel >= current version: Set owner, group, ACL.
> > inval Invalidate key.
> > revoke        Revoke key.
> > join  Join keyring as session.
> > clear Clear a keyring.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
>
> What is this relative to?  Didn't apply for me on any of keys-acl or
> keys-next or selinux-next.
>
> Regardless, we need to revert the original patch and create a new one
> that addresses the KEY_NEED_PARENT_JOIN issue I mentioned and that adds
> the key_perms capability in the right place in the first place, not
> apply a fix on top.

Yes, you really need to revert this patch David, I mentioned this some
time ago when the linux-next conflict appeared.  Also, future patches
like this *really* need to go in via the SELinux tree, not the keys
tree, as they affect the SELinux kernel ABI and if they aren't merged
via the same tree lots of bad things can happen if we aren't careful.

-- 
paul moore
www.paul-moore.com
