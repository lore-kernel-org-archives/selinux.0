Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EBAC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 19:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5822664EB3
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 19:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBRTu1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBRTfY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 14:35:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B5C061574
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 11:34:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so5755940edb.9
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=c4NCOHqlaolHGqdkr1amleTsjWwegvUhICByRNknl9o=;
        b=VYP7Kxn2xl6USBdk1jBYIwDJwjHivxnwpkFDglZqSgeMN1gHRG+QjhHArffCbM780/
         R5PdBRu9lniq+JLN3TBJ8ADffMBC/mRFGRyrdhBcDDYeiNAvKb8Nkm8xs05+TjHF7Ay4
         64aIeYAK3LYWiotIw2+EC+EGNREeiiUZT98tgQYA44zKpiRXRIlGtSl8rppbmC1ueLH0
         xfULZWfgB7UwXgFnT+PgcSb1JithYeEc0lEI69EoUlBxUBcxiWNZT5X07odMGOaRMwqR
         LB8/RJFG17UzONpC1rxeuCKkf+FRUcLBdJ1u4vGV3nqFL0WJezxcFfgC29VAPDlbPNq1
         tVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c4NCOHqlaolHGqdkr1amleTsjWwegvUhICByRNknl9o=;
        b=qb/qMzQhRv7W61U+Hsw7x+nY2a+7NZk0MqQLJiDAsrJ5QwAZA8sc5DSx3EbozXykWO
         h5yrxx01ZMyVh+An39SuEPxlQM315yCqDg3oyDD6tOumU7RhoJD8N6JMroOAiLw+1JA9
         aSDybpcD9gDcQx1v4wUGJBrzM4HgdVJETlX7+AdfIFMEuUw7KLJTamBtnFGwJ2Blprw5
         nICeEhkt2bpR85b0bpvbyfCnKvGFIXihPTb4MbgJVuVAuMbrJHi7ESfqlnaPg+MkyK9g
         NkysNsdVF83dLaIWOnAybiStDe7Hyr8/UYozaBURfv5IaKsr0CpdxoF0J+wgRFZG6sm8
         t4cw==
X-Gm-Message-State: AOAM533cltvd8uXTKVruGJ6WUA7OkddeC54S1/Okm6liWio7lICsyK71
        OTjkYf027EBdVeNbNYsVyJ0EVvPHbqJWp+2Rtem0
X-Google-Smtp-Source: ABdhPJwpsC+vm8CzQEpfKZRHzdetnGTBoYfUnbFd5gkMtykFEPATHNNgEnqXIQm7R/p6kcs7bbTH95jkroqxH+lam48=
X-Received: by 2002:aa7:c5d4:: with SMTP id h20mr5541872eds.161.1613676881441;
 Thu, 18 Feb 2021 11:34:41 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Feb 2021 14:34:30 -0500
Message-ID: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
Subject: security_task_getsecid() and subjective vs objective task creds
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

When looking into a problem I noticed that audit was recording the
wrong subject label for a process.  Doing a bit of digging I realized
this was caused by the SELinux security_task_getsecid() implementation
returning the objective security label (taken from task->real_cred),
and not the subjective security label (taken from task->cred).

Looking around at the other LSMs which implement this hook, Smack and
AppArmor, it appears they both do the same thing: return the objective
security ID for the process.  Looking quickly at the various non-LSM
callers of the security_task_getsecid() hook, it unfortunately looks
like all of them expect the subjective security ID to be returned.
The only caller I'm not 100% confident in is binder, but from what I
can tell it looks like they are expecting the subjective ID too.

At least we are consistently wrong :)

How do we want to fix this?  The obvious fix is to change the SELinux,
AppArmor, and Smack security_task_getsecid() implementations to return
the subjective security ID (->cred), and likely make a note in
lsm_hooks.h, but if someone can see a case where we would need both
the subjective and objective security labels speak up and we can
introduce a new hook for the subjective label, and likely add a "_obj"
to the end of the existing hook to help make it more clear.  If
neither of those options are acceptable, we could convert all of the
existing callers to use something like the line below (assumes
current), but that is the least appealing option as far as I'm
concerned.

  security_cred_getsecid(current_cred(), &sid);

Opinions?

-- 
paul moore
www.paul-moore.com
