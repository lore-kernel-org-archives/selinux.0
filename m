Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3CC433ED
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 17:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89006113D
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 17:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhDBRBh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBRBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Apr 2021 13:01:37 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698EC0613E6
        for <selinux@vger.kernel.org>; Fri,  2 Apr 2021 10:01:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d12so5464125oiw.12
        for <selinux@vger.kernel.org>; Fri, 02 Apr 2021 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O719XhROizLJyTG0yzD2ZFylJoCsa0pnwYN9IO307FI=;
        b=ermCAlDk/tuAAbx+QnWDw3Xqok9A85v9MoUHn1Kva/EdVMeQwND6COA6ns0SHFHxlU
         DP2Rc5F1j8i459ytJA9hZGLfiWA24OyKOAAHqy9mTWNQDNmgvtr1PJQQ4oGrcLp13lSZ
         pe6pggh6mYfEPqW0vovA6FA2pXtFtxCrfEZvHFFmO6Y1vWHikjgaDQebOT96O1ZNegLd
         oj/fnZXxy1SU5/LCZFJl2EZicixI/WLgHpvc+v2J7dZpJaRFyUAxu0yEKbiBKUdyCxMN
         bJuo/1slPACHBvRdKUxSU09F5opvM5yXys1KLNMDkNwSnXLSodwJQuPSja0ge1xhJqVq
         j/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O719XhROizLJyTG0yzD2ZFylJoCsa0pnwYN9IO307FI=;
        b=DyW6W8WArT5u5rJVm9cbbxS+xTZFTctdX57zP2wxwE+fN3t63iQKmXUTw8lahqBoUK
         /0wDPrwrXTZ3JWkMZY4CStubZjROKeScNsPNNF2gobSnsgRE9AShV8O9sMLrOql/seyD
         EwmPpX1fu6BvW13dpF6CgParw3MLamqw48gwBuISM7Ax6aZXTUpSkRPIBXxE3qK1qXuk
         SsnNq1EH3hDC+rsJHwAndGEHsDDE4ZcEBOaZkzB3gQi0zF0Ggqs/uBouv+UFFD1EL63Y
         x+nF9jjwNtWmzFcpl5tjUHXtFXHDj8/GakLOWaYyyGTEoPmToOib0KIPm/PfJXLwntVi
         M/Mw==
X-Gm-Message-State: AOAM531qX1MVvOaI3Xs6rE4n4iwLmKkGwi663mZVIf/WJxOKcOWN1Cz6
        snNMMWUJTJK30zt4yHmf4RwIMXe06rBqXdpcQ9ZdYJlNX1+I/g==
X-Google-Smtp-Source: ABdhPJyRv+bCl5la//Cvemlfhf2bi9oG4W4egF/kV9ob9ke+/cwMi+DNuLjCNCdGcJZbIFM+EH6oub9fuSPGxC2NvAU=
X-Received: by 2002:aca:534e:: with SMTP id h75mr10412045oib.16.1617382895241;
 Fri, 02 Apr 2021 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <df18624a-106a-6fde-6276-0c1aa13d5fd1@phd.unipi.it> <9cab1338-5b88-b30a-19ec-7d557d939668@phd.unipi.it>
In-Reply-To: <9cab1338-5b88-b30a-19ec-7d557d939668@phd.unipi.it>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 2 Apr 2021 13:01:24 -0400
Message-ID: <CAP+JOzTKjQcp0reUMHYc4oP9BqYoYWFySFrjZ=kAf1vhVydEKg@mail.gmail.com>
Subject: Re: [Request] CIL configurations
To:     lorenzo ceragioli <lorenzo.ceragioli@phd.unipi.it>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 2, 2021 at 12:51 PM lorenzo ceragioli
<lorenzo.ceragioli@phd.unipi.it> wrote:
>
> Hello,
>
> We are currently working on a tool for verifying information flow
> properties on CIL configurations. We want to allow reasoning about such
> properties with respect to the constructs of the configuration (block
> inheritance and nesting, macro). To test our approach, we are looking
> for configurations that make use of block inheritance, macros etc (hence
> CIL policies compiled from .pp files are not good for us). Do you know
> something that may help us? Are there repositories, or groups where we
> can ask?
>
> Thanks
> Lorenzo
>

Try Dominick Grift's CIL policy:
git clone https://github.com/DefenSec/dssp5.git

Thanks,
Jim
