Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB69C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DDF2177B
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 16:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oCenvAMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgGaQ0I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgGaQ0I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 12:26:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFFC061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 09:26:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c16so11606876ejx.12
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFOuk76yMwQhQV9ByIgRBjjTkNxg7Ago7/Y+BCV2wIs=;
        b=oCenvAMKcQo4om3UnSu+8Ar8x2n6W2iWW0QqunLJYEiV2E2dYwhC5oNTouCoEjKtBB
         jhYZDjDWPxyFpJ5o0zxgbU40ADL2AW9gt4EYC1fsUM/+djVeo6Jt4mU6M2E2iPi7zVKf
         xrWIfU/GF3rSI54QPNgX9KIVUaf2QrEtjRUWTimiqpX39Di2+ymJc/BCh93Wf1bipSW4
         qkRapf9yauDnTsNzhR2zaXR3TNSI+we5Qn2hFz6izjQatEo9Bcv6fAFaQESkQ9kg3RAd
         Y3HC2TUAzYI9xUQgkCtO9NGVPPd+8ydH/dVTc5EE/PlE5i8sUAinBiyJlfZU6vuvKifV
         vO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFOuk76yMwQhQV9ByIgRBjjTkNxg7Ago7/Y+BCV2wIs=;
        b=ivGkPFGzws4We5JydDqVF427Ns5UGCRYqcR8OR3Eh5pLkPIkr6v8VE/ajZJNLC1Php
         0JA73UUpxtEgl8eUqW8jnGFugcZxn+OPA1sQ9Eo3QqUBksrV5DobBL82ShWFs3b2yL5H
         zM5Q5rfua30CpLEenwDJD89AhRmcmtugkM8rMrR2i8agEHI/JMp++JRYdUeojC8Usymk
         TdAv4Dn7s5JEZQMaIehF3ofhYgHlLVrr2+8bXolZvuEdMOS1/LhQuSn0N1Qb2tDSM2IK
         gMhDo0LILEO3sZMe1xQAcxDh8T85DvNMgB1bFoKoExBXYJvmGeVXz95x1Z+iQ3y6LktH
         oPzQ==
X-Gm-Message-State: AOAM533fWdjFjG4NTZ3Ylcq13YinXA6ZaN6bAEmbfRmvfreQaJ+XtXaI
        P4iTdiu/EPvXxM2CRaHDyKcnmGn4x40nGCOqdpzjhg==
X-Google-Smtp-Source: ABdhPJxMdskudnQ+XmfQ0GeQImJih0awC9kLcrrsfss+J8woULvyXHu6Vf2NXZPnwwJ4qGBSxVUbR9aVFowpf5zF8QA=
X-Received: by 2002:a17:906:8517:: with SMTP id i23mr4684154ejx.287.1596212766705;
 Fri, 31 Jul 2020 09:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
In-Reply-To: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 31 Jul 2020 18:25:55 +0200
Message-ID: <CAJ2a_Dcev_o+NyuwUqh2ANseRniZRMQJ4dhDtrF1BtCmFSLgpg@mail.gmail.com>
Subject: Re: lnk_file read permission
To:     Gionatan Danti <g.danti@assyoma.it>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Fr., 31. Juli 2020 um 12:03 Uhr schrieb Gionatan Danti <g.danti@assyoma.it>:
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
>

An alternative would be, since these symlinks are trusted and
permanent, to label them as their parent directory (e.g. var_lib_t
(use the '-l' file type specifier)) and allow the applications to read
these lnk types.
This also prevents e.g. mysqld_t to alter the symlink /var/lib/mysqld
(since it probably has write permission to mysql_db_t:lnk_file but not
var_lib_t:lnk_file).
