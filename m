Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F6C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 02:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhLFCsI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 5 Dec 2021 21:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbhLFCsI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 5 Dec 2021 21:48:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A3C0613F8
        for <selinux@vger.kernel.org>; Sun,  5 Dec 2021 18:44:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so37098266edv.1
        for <selinux@vger.kernel.org>; Sun, 05 Dec 2021 18:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEpXl2rjEsQ/iZu4ZR5a4fZjtkeItsGvSxcWdc7M5Zk=;
        b=fEC0JL3Q3DjRFMGWonua7hcYvacbTymemEAL9m0L1IKQTYU7jXdvqbKOdfIpkZL9PP
         LOK81AbIdOhxqqfzvEagihtDvbP1lSk6FfLLVqgzCsbu5dYFHc4zoGRR1IZWg6MR2JQG
         akNV1TgQ9qiDpcTn8e1M942LzVjUjeeuaeihjCg3eoPQzL/111zPayRC0gOZcZYOyB2a
         1kUox4ZvMvtFNj5mlra3Cu3c6819pwgWHkTbqGqFxvuFkMjsQNcG6PMSgVL/3KCm1MEQ
         99sze4mx73lV+Lc2HQOjxFTsVw8RZXRn24p2v1pC0xXiRVRSo3Tsp9/DID/WopxTP8d7
         CBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEpXl2rjEsQ/iZu4ZR5a4fZjtkeItsGvSxcWdc7M5Zk=;
        b=tJHxH1SUA2MUb8NMyl3MhizhoDeefGfVVyyeRG2gXYmoTlbfDE4ViJ7OfrHlvvfGzB
         QK8sIXfbU/TwL6nGGB/gU+ID6Fzq+sQ28iDL92Ou/QSujcSVHoWjwWRcfqe33Fv41aFC
         DjFzO3gNJHlbixfVs9SM186Uav7mClel/H7mMWzXX8LPlFTIhqQRLZ/NfnKCgp67tEEa
         uQLryRi1amOD/+CNeFWIYbfjsIYa4Fpe3ACFP7MP5UOtK28fDF54JHnOxJ1OL6fS5uNx
         D8HyHX5FGS4P4cVPbMJUD9bVyTZew6/U3z08D8CJSXwlyR66f9ebqJ1vecZ6P2DCNnFv
         bpnw==
X-Gm-Message-State: AOAM530kH9L0gz9m/vYhZSq8BdyIF5WuQ283v4lmBGwMAOMPsz8xgd51
        6uSNDLW9QMawI3egybS1VF9Gyo9DsqRrZtvu/gu3
X-Google-Smtp-Source: ABdhPJz88VaoH/gPDTPj32gZHevyPs1vCaW00GNL3rgM+vqLPf2Urzonomb/cc2eL8/nvqRm7/jHabq1R3VDBOzvnNo=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr40290591ejb.69.1638758678834;
 Sun, 05 Dec 2021 18:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-7-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-7-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:44:28 -0500
Message-ID: <CAHC9VhRnFehuM4ODOMeUo9MZ-6K5bDL6KdakgzrivJKeUGDQFA@mail.gmail.com>
Subject: Re: [PATCH v30 06/28] LSM: Use lsmblob in security_audit_rule_match
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 23, 2021 at 8:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
>
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. The scaffolding function lsmblob_init()
> fills the blob with the value of the old secid, ensuring that
> it is available to the appropriate module hook. The sources of
> the secid, security_task_getsecid() and security_inode_getsecid(),
> will be converted to use the blob structure later in the series.
> At the point the use of lsmblob_init() is dropped.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> ---
>  include/linux/security.h |  5 +++--
>  kernel/auditfilter.c     |  6 ++++--
>  kernel/auditsc.c         | 16 +++++++++++-----
>  security/security.c      |  5 +++--
>  4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ddd4cf48413c..d846d90f5624 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1954,7 +1954,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr,
>                              struct audit_rules *lsmrules);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>                               struct audit_rules *lsmrules);
>  void security_audit_rule_free(struct audit_rules *lsmrules);
>
> @@ -1971,7 +1971,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>         return 0;
>  }
>
> -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +static inline int security_audit_rule_match(struct lsmblob *blob secid,
> +                                           u32 field, u32 op,
>                                             struct audit_rules *lsmrules)
>  {
>         return 0;

Assuming you fixup the typo above that the test robot found it looks
reasonable to me.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul moore
www.paul-moore.com
