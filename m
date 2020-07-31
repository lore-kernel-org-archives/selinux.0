Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4AC433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0390206FA
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD5LArsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGaNJt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgGaNJt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 09:09:49 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF58DC061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 06:09:48 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u63so14887543oie.5
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/7X8QZwh6VdbYYthWjORZzrnkdSeSPbS0gw/UM3lf0=;
        b=UD5LArshmLD0y1QLlZKEcdgz9F6Qj/xJ3xzhCuKFeR9J5rixETscR91/EVswDBXwz1
         7cTtI+uQ/nWN6sEh2Y4In8+W/DOnYzLozCk9gnC5xzbhbtdkhT5Hmrj6ryrS/oQ/5/S1
         MAe5tMWPBeGaN0Aa4HMDKWPJlKLXz/JyDrvCc5QORZgtlvWizSxzIOeuUOkxlUGP7Xt+
         ARRtnLBAji0+amg9x5ZS7ykZp0fOjaJ/MSYRsqqpZ9OceZmB3n+u1KGQjnHSGHLwmgnZ
         3gG0wGtAKmyvJavbtHCcZA3ka1NpQcEYF/WYhMqbOjfyA2hkRsmauSkkrHE8PMDRkMnI
         5K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/7X8QZwh6VdbYYthWjORZzrnkdSeSPbS0gw/UM3lf0=;
        b=KDuzOYvndLPw9JS3iG/PI4CG6AAziLOd7v+R96HexPhabuLxLwO7s+cGlFAxPLckmd
         DeYfmhJOsd/taHv2xsKvQVkAm4eaJzTqR1w2G4AaZYitqPPD4qaZg70/7G5DazuLo+0+
         tNPE93AaWBd1FD44dKLoMk3W9HPsHyn285CVqTqXXOmjj8T9ETZxpHRpS29xZcYUv8dB
         zcMuz+hLvxozIySHqpxPhBTWPb1L6t1gvgOOWCj+oKLbkVto6uTkeeCdDyZwvkvWzuRH
         YoznTWIbyJXJDhuWKZWUwpx5IZDwg6RVoW1b8f7bcKVFfTwtWXUasXpxWcQ9lhEoxbse
         986A==
X-Gm-Message-State: AOAM5301xP24Q1hImFBURgcF7Uq67lsG7oio33Dxvzq2i+u0MsTlprbA
        RsMualSPem0jDri8RKLGJz9Tu9kH7eDe8pMbG7IC0BRN
X-Google-Smtp-Source: ABdhPJw9251rPpeDhHk05BbcLfxKVaFT4NA4k00ffh8HwxIoslpcEg5BYC1KgYRvdxiPwLCBAT8kMvwHcMwZssB54EA=
X-Received: by 2002:a54:4817:: with SMTP id j23mr2880407oij.140.1596200987790;
 Fri, 31 Jul 2020 06:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
In-Reply-To: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 31 Jul 2020 09:12:31 -0400
Message-ID: <CAEjxPJ5XGhaZmAvC=-2A=KaCKmqZEp4r6z7fOoDP0+GpJDOZog@mail.gmail.com>
Subject: Re: lnk_file read permission
To:     Gionatan Danti <g.danti@assyoma.it>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 6:06 AM Gionatan Danti <g.danti@assyoma.it> wrote:
>
> Dear list,
> I am writing this email as suggested here:
> https://lists.fedoraproject.org/archives/list/selinux@lists.fedoraproject.org/message/GWEWGDUQS6PERAYEJHL2EE4GDO432IAO/
>
> To recap: I have issue with selinux permission when relocating specific
> daemon data directory, and using symlink in the original location. For
> example, lets consider moving /var/lib/mysql in a new, bigger volume.
>
> After moving /var/lib/mysql in /data/lib/mysql and creating a symlink
> for the new location, I used semanage fcontext to add the relative
> equivalency rules. Moreover, I changed my.cnf to explicitly point to the
> new data dir and socket file. So far, so good.
>
> When restarting apache, I noticed it can't connect to mysql. ausearch -m
> avc showed the following:
> ...
> type=AVC msg=audit(1596055762.070:175569): avc:  denied  { read } for
> pid=72946 comm="httpd" name="mysql" dev="sda2" ino=103
> scontext=system_u:system_r:httpd_t:s0
> tcontext=system_u:object_r:mysqld_db_t:s0 tclass=lnk_file permissive=0
>
> The log above clearly states that httpd policy lacks lnk_read permission
> for mysqld_db_t type. While I solved the issue by leaving the socket
> file inside the original directory (removing the /var/lib/mysql symlink
> and recreating the mysql dir), I was wondering why each symlink type is
> specifically allowed
> rather than giving any processes a generic access to symlinks.
>
> Is this kind of rule not permitted by selinux? Can it open the door to
> other attacks? If so, why? Generally, what is the least invasive
> approach to relocate services?

The lnk_file read permission check can be used to protect processes
from following/reading untrusted symlinks, often used in malicious
symlink attacks.
The more broadly you allow it, the more potential for the process to
be misdirected to an unexpected file in order to overwrite some file
or leak its contents.
That said, I think the policy macros/interfaces could allow it more
widely than is currently done without too much risk. That's more of a
question for selinux-refpolicy for upstream policy and/or the Fedora
selinux list for their fork of it. The alternative approach for
relocating directories is to use bind mounts.
