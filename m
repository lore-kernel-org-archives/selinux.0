Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F04CC433DB
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EF64FF0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhCDXmM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhCDXmM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 18:42:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1675C061574
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 15:42:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bm21so34044853ejb.4
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 15:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5EDf9ncNuU6Gr96EZPTVT0fXM6QXMRjDMEHVuOqfDg=;
        b=zE2xlDIuD0pCnfhboV1yiP2xkWpEu9cJ2W2pQup7RtDY05ZIEB1LIUh847iBcvJ0tS
         k+DhhU8lXsvP1RSJ8joLIVXcw/znVQOuv7j/dqJJbQpCITaw9U7OxT/UvrWSl+eePfG+
         Jldv/oJWKkPeHIWKuHbLe7LlaQ7A3bPRoa7jlVLO1zCsNZK4SHs+WYlvMrKxea2JNZTU
         kLnrKLcp605qbU/ks2QN/balNme9p0/DJPZKQjiD/d0u+hPKDOI0La5uAuU4ytNwvLMg
         40INVyc6uHTjW+FoB/689mIcqbTgwAM2hGyWWhN6h2i/GQeFMavxmPK3V9Ml6cN5bwuG
         rYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5EDf9ncNuU6Gr96EZPTVT0fXM6QXMRjDMEHVuOqfDg=;
        b=Y2ZihwI9MJV5smi1qAI6oeb0sUTf1Rufw+fA0PRAkpbK07iVivBmt+k8SrjgChJyK8
         B3Hn0atgJnp0R/SyXsLlQ2od2nGm18kFthv8DewSKiuk9aMLI7tHnkCRpFvPYUkZcWvv
         ZG9HLUPB6yOcEJaP0zBVvjtbGrzkMZ6cBOAot/xBDNMw95ZTHKyMXbMhqybzdXzkwBge
         0r4Qljy43KXyJq80c2LTrh38xkJiF+zC2t2bE0nlqtly2SroOi+MyfWy6cf//1nftmCM
         d3GIvBZ24kjijKcdRss90HfI4oLuzI+7yRzMStF/HB1qwmOcy/xOvOPHCN1peWqThwoj
         UKxA==
X-Gm-Message-State: AOAM533LCRidzmEBgGBUTOtj6IaPAFtTF0sljrCjnYKKE+fwH8gmjwfr
        zXQnypi1BR4VjRjOJqC5tL3XIyBVval5+vMbKcW0
X-Google-Smtp-Source: ABdhPJw4Kmqx3AHQrHGHaRoum3GAWUxNj073/4lUV0foGYaoZpybwLKPT5KVSGG88SX9+dXmFgblQgmO2g/3aPW4zcA=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr3527eja.178.1614901330585;
 Thu, 04 Mar 2021 15:42:10 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com> <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
 <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com> <CAHC9VhR3=dNpxHXSo7TgJD6bCezgzfS-iT32f-jAZJgzCsNA3w@mail.gmail.com>
 <ac0bf135-a103-57a7-f358-d54219749768@schaufler-ca.com>
In-Reply-To: <ac0bf135-a103-57a7-f358-d54219749768@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 18:41:59 -0500
Message-ID: <CAHC9VhSy929orY1vCGbXC5qVWOqT6KSmK5VnNuD5vD+JywQEOA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj variants
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 3, 2021 at 9:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/3/2021 4:46 PM, Paul Moore wrote:

...

> > Assuming you are still good with these changes Casey, any chance I can
> > get an ACK on the LSM and Smack patches?
>
> Yes. You can add my:
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> to both.

Done, thanks Casey.

I talked to John and he is working on the AppArmor tweaks so I'll hold
off reposting until I see an update from him (nothing beyond the ACKs
has changed anyway).

-- 
paul moore
www.paul-moore.com
