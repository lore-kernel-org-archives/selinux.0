Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04071C0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86AE206E9
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPx65nkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgCKSjg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:39:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35545 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKSjg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:39:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id k8so1458539oik.2
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H9+hoKznHKoragQYf/qAZHv8pDnvH11eDpY3bTLIj8g=;
        b=oPx65nkThxFsLSOd18OXlYMWovaTwkWiIYypQXb0HzROjHTPgH/4YfbpaA+aUd3dks
         uXsFs8cxMmvVBz3wV8qTkgejTRxNkWN4Yyep40bW0tyKl/wW9sr5+LgTZoLxGs/uiUzH
         5gAkV3/AxosNVSU1LKuvrUaX9VCbFvOnwjIqrz2/WEzDkwlqnAiBnKFzpvqC7flrim2H
         txpNbadOJATv/rPZ02upJOYuViy50TmCPuTZxW8O6d1vyj2HW5OcWSE5mInk6z9rePoz
         7WikhOw+dgSAyO/CMdC2Wp0ggBjE+yjHyRENYioaBGhx7JBk3M9TEEwpPoQKhzSYSpcz
         lV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H9+hoKznHKoragQYf/qAZHv8pDnvH11eDpY3bTLIj8g=;
        b=pvjzeYImu9IYmaGG1y5AGJADDuSkA4U2m2R/UfTRUP2E/MvN8jnBKd/vYQ2DjsSp40
         C3i8wPyMz3qlJV0j9XjfXPv4vgUhvFE5n1yH8FFFe9qb17S8xZOz+53Nm4F9xWwuAK3X
         rr9ndcPjRlDQuoa8LPxddimQPmNKvNQhJ6IlzGOA4wy1CDRjL0dHyzln0q+zD/GvCnyt
         Q7VXkvASUu/2v1rtWOjeKBI2imSFOtq31/T0d0ifLGw/Bk1uobEckLWB9sxfRLyunX55
         IXMWIJK03g1bdCkmRN5/nNiyO7AG0dgG0jUeJtj17W9mE6gXxvvE5u4SWPqzVgBsyNwa
         1o5A==
X-Gm-Message-State: ANhLgQ29zD24Et3fqibRC3NNDxLG2ikuZa3T16U64urR1sErcG/y2ksj
        K25fwa2Ngu+8I/+5Lg/AqVN69aUbv9+wLIYjSHkswg==
X-Google-Smtp-Source: ADFU+vt1EyrqBKk+of3L710RnROgvpfjbx29BvhKGNHS1An/bBe8iqBw36tvEjM+9MUH797Mo4UTT+5kHGRxhn6N4KI=
X-Received: by 2002:a05:6808:34c:: with SMTP id j12mr50908oie.92.1583951975264;
 Wed, 11 Mar 2020 11:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200305184034.165554-1-dburgener@linux.microsoft.com> <CAEjxPJ6gTLzW451DKHhiSaRRUyx-E=ov_meKnHv1j_U7TykHTA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6gTLzW451DKHhiSaRRUyx-E=ov_meKnHv1j_U7TykHTA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 14:40:27 -0400
Message-ID: <CAEjxPJ4tGR2Y77-4ybckP=rL=dYWpxfs8f50=XnSNDDOfuMqsg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Add --werror flag to checkmodule and
 checkpolicy to treat warnings as errors.
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 9, 2020 at 9:58 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 1:40 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > When the lexer encounters an unexpected character in a policy source fi=
le, it prints a warning, discards the character and moves on.  In some buil=
d environments, these characters could be a symptom of an earlier problem, =
such as unintended results of expansion of preprocessor macros, and the abi=
lity to have the compiler halt on such issues would be helpful for diagnosi=
s.
> >
> > Signed-off-by: Daniel Burgener <Daniel.Burgener@microsoft.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Applied.
