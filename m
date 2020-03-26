Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F41C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CE62083E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/oCM4Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCZQoI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:44:08 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:35637 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQoG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:44:06 -0400
Received: by mail-oi1-f179.google.com with SMTP id t25so6087125oij.2
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/k29ONf3KMe5lMtMkK3VMZGKIMi91LPC5SJ1pBP9xgs=;
        b=j/oCM4CtmzBsL2w5oFKd/udZJetxq2mWZ3FW5cjIVL9RZgtxYv7cgoiACFZy4bKGLk
         KSm6/onc4oeRFlfHsdJPq1Yv1/UnKnDNTo78rI36RvQ0nlvCU4k01ty2pW0Wkj19QrTD
         vhfyqWgIH4fH506lj05dGeGMmPlt7hA0U2GtQreNBb1tmfVHU/8lMQM4DjHeXtbJfw/W
         WvkRSYcEDzJtHxxjSxUNUrL/Hau43oYzT2XOurRMdMuSZzCywb8YMw0hmG1vPzCVGsm5
         vJ9IRSQAFigLCAEc0NHtCVfO1QBLA1fIcs44/FuxoFgHOrlERypgPoVgkexyDotPCPWw
         40eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/k29ONf3KMe5lMtMkK3VMZGKIMi91LPC5SJ1pBP9xgs=;
        b=NwwzbYWe6II2BW9dIKyQzUE7JYwqY5LVCLBapnjMHG4WXe+WhFapIFBHtbxO2CJYQm
         V6SMZpHxS7MegqGQ8XigpCY94C+0ttSlhNzra85+/n5uAFj/JAXcL5j+qFGJJbY3ios8
         931fusuUxASYUJzcq4l3JNPBXoprIERCBi2NxQZg5FhlNiHuLAf3eILVsXJF5hTn5FhJ
         AtrtA+NDWrX856Sy4Le7LnjfW61FM85nR7YVS3tOQf8axRm1p0NOD/vTJ5kQtugUSFwx
         04uQJme1NO8iFoCjtCfcA5HyfhqLAqJwoY6WGzbhnx6Id3l/bfOl8Z1c+oY5oSrp94Q0
         zihw==
X-Gm-Message-State: ANhLgQ1GSuc9EN4+vdtz9YBRYKzhDDAwA/3nZDYZO6DzX9WOZJ3m+R9W
        tb0HxgmQItuKzk04gQy/JR5pzPupkqcItabEXgU=
X-Google-Smtp-Source: ADFU+vtArUXM2sdCdrpbaEXt1rhA3h0bQtXSyrABhc5TRUnUOcJiJ6vDnZrWsfMmOw9cRS9ctJuTEGpoPigNw4VVmMg=
X-Received: by 2002:aca:5191:: with SMTP id f139mr780148oib.140.1585241045824;
 Thu, 26 Mar 2020 09:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
In-Reply-To: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 26 Mar 2020 12:45:08 -0400
Message-ID: <CAEjxPJ4iQmgz0Po7o1REc5Fb63ci=6WtF8=e6zwD46=1o9x9SQ@mail.gmail.com>
Subject: Re: PR 193 sitting for uClibC fix
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 12:22 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> This PR:
> https://github.com/SELinuxProject/selinux/pull/193
>
> Has been sitting forever. I looked through the mailing list and didn't
> see any patches hit the list,
> we should either close it, or merge it.
>
> Thoughts? If we need it to hit the list, can I grab it and sign-off on
> it and post it?

You can't sign-off on someone else's patch without them first signing off on it
or otherwise certifying to you that it falls under clauses (a), (b),
or (c) of the DCO.
You could create your own patch to achieve the same end, especially
since this one is trivial and seems
to be modeled after an existing commit,
ab0e27003ef245f20512d1808b1dfee662ab8f41, so it
seems like it is relatively safe.
