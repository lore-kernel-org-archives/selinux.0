Return-Path: <SRS0=Vikk=BC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241FBC433E0
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CB42071A
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vert+m+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGWMAh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWMAh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jul 2020 08:00:37 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67533C0619DC
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2020 05:00:37 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w17so4753686oie.6
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2020 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m+YOzDLU3WhnwrxpwKBrOfpqfpDyp3kAni8drf2/SZA=;
        b=vert+m+fHprHAnxKfdB01JiWfsciMUaE2z4R00HS07TdEGNMWwGo24UguSyWPj5UnW
         VhpKpN2RJk//dxHF2w6u0EK5Re0yhcC5LDQaxUQQfGOFd8t3uwje63PqqQ3w08GfIwRM
         cQi4sYb+EYuwYFCd1UzWbvCo3+EpqvjqmuzHbpiwqGQY9GC4eum9w4eLO/w4vEGsB/st
         RvdenxwDB6U8A4FY/NqdgVfbLHbI+P+0JRpwolSP24nq/iTO8W2oVuoBuza1XMwYJaDC
         EC779YDyV70nStwUvSovZpA6PQJ+9aPBalcikc6XwAQs8pCpdL4qGhHWP96W2ENeXXX8
         BdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m+YOzDLU3WhnwrxpwKBrOfpqfpDyp3kAni8drf2/SZA=;
        b=o181Uf7O9mrUisoRGX3Z0LFm4mc5IfXjRy+40QYj3UPpY1LSbtezEuKgihRJ9ePIYl
         LlOe02Hmw483laix8jMTyDnRm/xiIUnNZchXC6SrFYzPaD9YDfSGqrMN5X0AIgA4nXC+
         FiBB5u6KL/8dl5gjdtVZd9uzktxe0MlQfiIgg1VzoeJnydwCAB3Zvk8sxy5T0Ghb0U3t
         eyVeLsQUNNLmqqRK+kt8zUjF+mR4d5WV9QiBdxC4MyagVrnaNQEFXj8MGEmbrQ9bDK+b
         Pyo65U/ccWQIwXYWzzLccQ5TES1cUaP53kK7vf1vVVo/E60DeCOeGayfJ5uCgoXdjaux
         4wvg==
X-Gm-Message-State: AOAM532OB2vlKLX1Ev/1njDluyaO6KMyM5U5PmcGrygEnVUD3bmaTGq+
        ptP3SUE22+TB/12ZIvSXBWBKMT34vYIbu3o3BKqX7A==
X-Google-Smtp-Source: ABdhPJz13097y1Iw4CV+HeStRb+zWEq57nhmoIEZUTo/dsWryrsQGLYjMOV7JIxljuCHTphwgpzwlMKrW3Izx/PLmHM=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr3260950oif.160.1595505636857;
 Thu, 23 Jul 2020 05:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6twZempmDtTBQjUxs_x9PJr5eQf1aSLJ1a6OpM_1eR=g@mail.gmail.com>
 <20200723075008.2256123-1-dominick.grift@defensec.nl>
In-Reply-To: <20200723075008.2256123-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 23 Jul 2020 08:00:25 -0400
Message-ID: <CAEjxPJ49ieRSuPcTzu=J_ZiKXYSP42bOtHJhVhmvK9htR6R51g@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v9] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 23, 2020 at 3:51 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Elaborate on labeling. Touch on the significance of the default statement=
, on various av permissions related to labeling using the libselinux API, a=
nd on how the kernel and unlabeled initial security identifiers are used to=
 address labeling challenges in special cases such as initialization and fa=
ilover respectively.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
