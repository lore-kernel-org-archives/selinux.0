Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E703C433E2
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE54207D3
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 14:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeaJfcKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIBOeD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgIBOdx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 10:33:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD25C061244
        for <selinux@vger.kernel.org>; Wed,  2 Sep 2020 07:33:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t7so4455095otp.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2020 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oGSnWlQcmus3xg9GrwlLP4TPMoGIQwkngX3G/eE8TzA=;
        b=UeaJfcKavuJn37R52lqKVkbCPh9ysn0TqL88lEpkgSBd7n/jT9UdQMwuY/acl3nK8F
         ZpRhExUAleZdp7aCIjC1V1JwO/ubTl43cpCZqhfEtahlm9d/dNqr3/ulcCtzT+NhCEq/
         9Cq8VvQWLGegmcbrK0iBmYoY1CQCQKf84uyEBJBKeBaqcsC1I8MHf72lCZq8j28MucmO
         64gp3harkAQkklk+yEwAZAEwMgWwlg0UcUfB0uG9vf4tdqJ7kfj6ylNkjBDKiT0IDlPH
         XMZS6D1FjfdHr4+/Fzfd5FgW6G4dSIpHOZkWG2hx30gjytBXLb/NDaj01/juOg82C8+X
         3Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oGSnWlQcmus3xg9GrwlLP4TPMoGIQwkngX3G/eE8TzA=;
        b=In3aCKWCwON1cgiryQt4yoDIqIxQbVciHUL3B64Ggj3UrQ9uIA9mc0f11N16NiSamh
         KquWt0/9mk3hzzbJ+l9UJC4sIxlKvoTt5LQi2e7v5wtzjUA2C51O6x2KL2BS+7IaqLSr
         P6K6BnEGuI/FPIRWpEkrsE0DQdJWjenWDdMcXnvWeiuSLeOYZK1CPN5Brzhrenu3cB/N
         tHXOOuOpHNLAojumrwjwz6DhDaywh21jlrz9/aeZcA+rUb/lxIggnCJNsmeJkBuvmOGs
         xBgGEsHRwxULkBQuNzBtWBSn8QOXcHHr2b3asozqNRk/UPeejBUxcMz7TgrmbtSBqwp0
         yMFw==
X-Gm-Message-State: AOAM530rMqcKt5eiGr2fd4d2vmO6A4xjEpiaeDwljsLdYpiIqWgo5HoT
        84AC2oglMo6F1tLVCTjHMEozZmeTohb17P4xhj+7VO5x7vU=
X-Google-Smtp-Source: ABdhPJxW//OUCG3+KgBTduWNNt2qpcPgDSLuC03TFIR7A8A6fpBq4NdPse/oJvUF6cpXBO/Q5c9P4G1rTy4IVktqTnk=
X-Received: by 2002:a9d:185:: with SMTP id e5mr5629305ote.135.1599057231511;
 Wed, 02 Sep 2020 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200901114245.3657-1-liwugang@163.com> <CAEjxPJ7RU037b3m0rhzNQnGFJuX9UXZirpUwEXdeQfGxjUWwDw@mail.gmail.com>
 <623f4bd0.4d4a.1744d97f808.Coremail.liwugang@163.com>
In-Reply-To: <623f4bd0.4d4a.1744d97f808.Coremail.liwugang@163.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 2 Sep 2020 10:32:41 -0400
Message-ID: <CAEjxPJ6nvu4nvy8PW_ABYxNXMU5SD6fYcgH_D1H1X03Sixcv8Q@mail.gmail.com>
Subject: Re: Re: [PATCH] Optimize the calculation of security.sehash
To:     =?UTF-8?B?5p2O5q2m5Yia?= <liwugang@163.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 2, 2020 at 2:54 AM =E6=9D=8E=E6=AD=A6=E5=88=9A <liwugang@163.co=
m> wrote:
>
>
> At 2020-09-01 20:39:55, "Stephen Smalley" <stephen.smalley.work@gmail.com=
> wrote:
> >I'm not sure this works the way you intend.  /data/(.*)? is a full
> >match for /data/backup.  Do you want to stop there and not include
> >/data/backup(/.*)? This also changes behavior of an existing API/ABI
> >in an incompatible manner.
> >
>
> My original intention is that /data/backup(/.*)? is always after /data/(.=
*)?, traversing from
> back to front, The /data/backup(/.*)? will first be meet the condition.
> But after checking the code, the function sort_specs don't sort the entri=
es. just put the entries
>  with the meta characters in the front. So it can't guarantee the sequenc=
e I want.
> I think I also need add the function to sort the entries.

Typically the policy runs a helper (fc_sort) to sort the file_contexts
based on a set of rules, and upstream performs sorting in libsemanage
(semanage_fc_sort()) when generating file_contexts.  So it might work
but you need to confirm that the sorting rules are guaranteed to yield
the right behavior.  What if there are meta-characters at the
beginning or middle of the pathname and not just the end?
