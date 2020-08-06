Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1675DC433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 01:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E028D21744
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 01:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2Q4BjuLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFB7E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHFB7D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 21:59:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B7C061574
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 18:59:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs17so15208229edb.1
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 18:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ostgo0eNdE33X81G6hkoTnGzieAZGyQPcjASc0Vt1E=;
        b=2Q4BjuLgFC8qdlpqqPHSx63pLaHFC19bVsuX8f9fBTIK1qdGi8bToxFzfBSRwkhOHQ
         +DdfhXWAKg+lDPNe2A22KLNN+tW4QGUYWe8iZMg9NVxrieD9ay53LwsIs3R/Aec2hzGu
         SvqLcDJep2XxR8P8TmcBGv5XADCZJVH4GB5w/e0DrCqszUpQ7SxYvJOEhyLCFYyCPLUc
         XafTOlKsNPzwDXKutrgA6+aBwwBu8aPpuq/6KkFvo6ZDVUEOFIWhyOu8gv2cuV8l2e2Q
         DsFYjO2pJ4HQQ/yN31g6WNSvBI5wVl8kBp/lABFgev7G+HXR89RDtjswVbVr8SupL0Yq
         +Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ostgo0eNdE33X81G6hkoTnGzieAZGyQPcjASc0Vt1E=;
        b=jZgNSbMF1YnFpcZTj9u4oqx0c4d51bnnlguPldkFtwZDzTzF5jK7Apy8xDVb1cQTBa
         twz8JQ4oAc6Qiaj7q7Lb16oV+jvZk9yWg4zMaY5cjmTPOvGNLYTM3YKERe71ozXEs6kU
         EYRl6CnWa25zoKeu/mjPjCHA/vjJKbGC5j06oKhqObk0r2e14zBPRrOpf095OuJKFKrN
         SsqLij8nnWIsM7US37qME5lJl41VOJ8AhswrMZqEWKx8LdhZZiVjJywqb2YNhz3ZGgFW
         892z+pgcqYFChbsJitvCBIfaCxsxxbfacXWMge3pweRYCnTIWnmxgZMyKOIpPYDEWYQp
         3MEg==
X-Gm-Message-State: AOAM531iuj8S58Slq0vROFsBEBOjROmLatsbXj7cpiz0dnfGifwMgsQJ
        NlhNbvd52il0fbITgZI2dCmN3uzHzHONNdLMuM37E9Jt5A==
X-Google-Smtp-Source: ABdhPJyQK5+46V9dpZnkUX+vwSorgAGpF/mQoBjFufHEahLtbVpmI7vCHBmHoNjwJ/zVc5Yb5AS8Vt7Y8SwkOiBHcRw=
X-Received: by 2002:a50:93c5:: with SMTP id o63mr1930971eda.31.1596679139875;
 Wed, 05 Aug 2020 18:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <159650470076.8961.12721446818345626943.stgit@sifl> <81320b12edc1cc5bf0818f21f467f5fe83405626.camel@btinternet.com>
In-Reply-To: <81320b12edc1cc5bf0818f21f467f5fe83405626.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Aug 2020 21:58:48 -0400
Message-ID: <CAHC9VhSuxT=NHiZ-yKmDt+FQYeEaVCQEbwL5coPFfADZiemraA@mail.gmail.com>
Subject: Re: [RFC,selinux-notebook PATCH 00/18] markdown conversions and cleanups
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 4, 2020 at 6:31 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2020-08-03 at 21:33 -0400, Paul Moore wrote:
> > This patchset helps to get us a little closer to finishing the work
> > of converting The SELinux Notebook to markdown.  I believe this is
> > a worthwhile goal for two main reasons: it makes the raw markdown
> > much easier to read (the HTML tables are painful in source form),
> > and it makes it easier to render the markdown into different formats
> > (currently HTML and PDF).
> >
> > My original goal for this patchset was to complete the markdown
> > conversion before posting the series, but I now realize that was
> > neither a practical or good idea.  While this patchset may miss my
> > original goal, I do believe it is a step forward both in terms of the
> > raw markdown and the rendered formats, and I would suggest we merge
> > these changes assuming no strong objections.
> >
> > For those who want to quickly check the markdown on GitHub or the
> > rendered HTML and PDF formats, I've included the links below:
> >
> > * https://drop.paul-moore.com/21.HGW6/SELinux_Notebook.pdf
> > * https://drop.paul-moore.com/21.HGW6/SELinux_Notebook.html
> > *
> > https://github.com/pcmoore/misc-selinux_notebook/tree/working-md_full
> >
>
> I'm okay with these changes.
>
> The changes of tables to lists in the policy rules files
> (xperms_rules.md etc.)  makes the text much easier on the eye when
> reading in all formats. Splitting the policy types looks better too.

Thanks Richard.

> I think a small number of the HTML tables will be difficult to convert
> to pipe tables, also others when converted may require the HTML <br> to
> make them more readable (using <br> seems to be the only way to get
> line breaks in pipe tables). Still, see how it goes !!
>
> Acked-by: Richard Haines <richard_c_haines@btinternet.com>

Who doesn't love a good challenge :)

I went ahead and added your ACK to all the patches that weren't yours
(ACK'ing your own patch seems silly) and pushed the bunch to the repo
- thanks!

-- 
paul moore
www.paul-moore.com
