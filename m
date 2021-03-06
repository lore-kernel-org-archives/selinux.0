Return-Path: <SRS0=9Q29=IE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB9C433E6
	for <selinux@archiver.kernel.org>; Sat,  6 Mar 2021 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C92B65017
	for <selinux@archiver.kernel.org>; Sat,  6 Mar 2021 15:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCFPAa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Mar 2021 10:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhCFPAU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Mar 2021 10:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615042818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X88Djopi+WMAWKm99oxwdSdg0FHFApcQ39y/+Kn7kdo=;
        b=bOivJ5GTlScIh5HjP7ms1ug0Ukzir0SX0dZX8b/0Xvk/QrCgi9OJh5LA+wdoXhQFcT68kB
        /cy4fzRon08bKbUIzd9Kb+1MlTlg0EumD8Ryf8fciTuXxk3ZXwrpJ9nDCrgc5UaJtLBACV
        e1t/sZ59ljEz+KK+1+bVpeb9hnNglPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-a8JbdcJ9MOaD0zxE_2Aeuw-1; Sat, 06 Mar 2021 10:00:16 -0500
X-MC-Unique: a8JbdcJ9MOaD0zxE_2Aeuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7747C10059C0;
        Sat,  6 Mar 2021 15:00:15 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F1A05D6AB;
        Sat,  6 Mar 2021 15:00:04 +0000 (UTC)
Date:   Sat, 6 Mar 2021 10:00:02 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com
Subject: Re: Quick announcement on the selinux/next and audit/next branches
Message-ID: <20210306150002.GX2015948@madcap2.tricolour.ca>
References: <CAHC9VhTUJAD9KQyb0ibFtCZx1nRRLLRuepbMP_CS3Ni+EQMa0Q@mail.gmail.com>
 <CAHC9VhQOzw2aV+kT+b_cdmnAJk21MDP7jhoVy3Y-YVrCbqxBJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQOzw2aV+kT+b_cdmnAJk21MDP7jhoVy3Y-YVrCbqxBJA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-03-05 12:56, Paul Moore wrote:
> On Thu, Mar 4, 2021 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Hello all,
> >
> > As many of you are aware, normally with the close of the merge window
> > and the release of -rc1 I typically reset the selinux/next and
> > audit/next branches to Linus' -rc1 tag.  However, as you may have
> > heard already, there is a nasty problem with the early v5.12 kernels,
> > including -rc1, which could result in some fairly serious fs
> > corruption (see the LWN article below).  With that in mind, I'm not
> > going to reset the selinux/next and audit/next branches for this
> > development cycle ...
> 
> That idea was spectacularly short lived :/  Assuming -rc2 fixes the
> swapfile bug, I'll plan on rebasing both -next branches to -rc2 early
> next week.  This should have zero impact on the audit tree (audit/next
> is current empty), and a minimal impact on the selinux/next branch as
> we only have one small patch in there at the moment.

Well, it appears you are far from the only subsystem maintainer doing
that for this cycle.

> If for some reason this causes anyone a problem due to merge
> conflicts, you can still submit your patches (assuming they apply
> cleanly to the stable-5.12 branch) and I'll take care of the conflict.
> 
> Thanks for your understanding.
> 
> -- 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

