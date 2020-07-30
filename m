Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BBAC433DF
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 13:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0888A20829
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buI4Vj+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgG3Njm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Njm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 09:39:42 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E352C0617B1
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 06:39:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 93so9909463otx.2
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BklLXkWJneqmzaWh65wpdp1aVnL1vn7jDSG1roQWD3A=;
        b=buI4Vj+WJaqGV+tv3MBiIL1wsDkmiQndD9phb6kCO6ZACY8p/Q+kK65TfPUz/OwrQj
         N38lUTLWDaLbY1mYyq4xmc9cggWvGRniILIeCUePyfE/SNPvA8nGc5EqafbRlJOwfTGG
         Z1vrcKsX9mF4lKhV6syXndT6I9xieAhIOVXYE98DBzGBIehetpKv3sDvgZD2RbDLDUAk
         kXZ6oOIPAKSq904gvz65SmCSmlEFyykkrJwntc1t86jQx/rm56cD4b7iU70I+nCtNVDv
         uh9CvYEjs5h3y4MQQ8QCzdCjLi0oVoEZeznpuQm7kZiC/7LGq8eezEx+NerLTfH0YUz4
         T4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BklLXkWJneqmzaWh65wpdp1aVnL1vn7jDSG1roQWD3A=;
        b=l2cq0CUdPTpDGnqI7aiBWotx/XHdy1kV3/EEmhYAZNg369Ld0geoQAOMXpcm7D2lnS
         Bq0MH952x3TP5AUlvX2Dok00TyNdkPp6aTedwK7szP1wca5uN+1X46uxtLXiwIdUAhef
         NzHXB9fARqGMX+2iYrzMYI5PTEYYzc5aR25EF2LNLZordmou6iQTptV2QLMeO72fTaO3
         +TpyanWKUkeQeztFjE1wHRzU/3Et89f4fTE+Fnx5drEiqUJmH/RiMIv+iqdLA0pRtXsQ
         jucJ/SkXJg2Fc+12enHcJolMnSXmtaUFQsYFbL+YEuGQVKKo1DqVIGqHPLyRsAArPLpL
         8+YA==
X-Gm-Message-State: AOAM5339lmuCA8sc+qpOD8Ji/+n0WVa22lneYkZyv6QeFAtR0wv/mW/o
        XhHQGTfDm+dytZjEPgMYWtDPtTHh2C2tg2HqCweBxrAh
X-Google-Smtp-Source: ABdhPJxnp0EKc3AWpdGOuxOMTmQXwGO+fhXmHH7m/njSkqMkhqPObcb2ZWiMvkKzEoLLSiicile/vXyRrLOFGtOVQ00=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr2439381otb.135.1596116380941;
 Thu, 30 Jul 2020 06:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200728171929.50152-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200728171929.50152-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 30 Jul 2020 09:39:30 -0400
Message-ID: <CAEjxPJ4=1NUR6XywkpQ4OzQV76BK3QOdHNFv-4eVjKTgAMmrOQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: encapsulate policy-dependent state
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 1:19 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Encapsulate the policy-dependent state in its own structure
> (struct selinux_policy) embedded within the selinux_ss structure.
> The policy-dependent state includes the SID table (particularly
> the context structures), the policy database, and the mapping
> between the kernel classes/permissions and the policy values.
> No change in functionality or interfaces.  This change is
> preparatory to splitting the policy load logic into multiple
> stages to enable making the entire policy reload atomic.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I have a v2 of this patch in progress so feel free to ignore this one.
