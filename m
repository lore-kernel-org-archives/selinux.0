Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E08C2D0BF
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 23:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BB321775
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 23:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="feaLw842"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLQXr6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:47:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52295 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLQXry (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 18:47:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so92224pjd.2
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2019 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QUV0SVwkGK6YV+aRCFhMJTkUNAPFhgNw2L3v1FuBH0g=;
        b=feaLw842hZXmEOx+jLHE2o/1+zAi1yU2XN2fM+yCsz9xXahn4N6WBvI7FmOPdmbeSG
         n9NZ0zKFThv1fIK+zZ7g83n+sR7yYoQfq+WxH+o71arx4PRAvxata/VIlOVSFTPYdoJj
         m02qm+2lQU9KuG8qiydbRMWOaOv7aKVAG5Kpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QUV0SVwkGK6YV+aRCFhMJTkUNAPFhgNw2L3v1FuBH0g=;
        b=YtAuz6cn6OTQvqO8po8Nsnaf35ndYve2C6dM4mryENzlKE2yrcdr7/6kuw0T6ZemR7
         ST72RgNIU/ukfIEg2dUwx8numfXEdmOJYKpBZQGaQd7aVBWOrg41cG6M0Q0rnLmKboAz
         sXNTQ/hBpTOknftYima1xLCPQmULb8De6fccKhXn0aOpntTV7F7Qsr0KT4hw329V1ea1
         7ka/5U3wDUk2wA9nlyIoTFtfKGdoSvNbb+lfOiOT5ipKLWR/zUIc+DDslmC2gF2wMAPT
         0Vv6NqHeicHAFzO1ZakOr9958xUfWEkZTUls0/4hvzYm4TlO3gBnogJvhhV60aiAtswH
         MGoA==
X-Gm-Message-State: APjAAAXoFWZZq7C+7o3Tqb4adXxBh0KtoxcIKSG7v92buAaZB8ypplqa
        SPNoyaEIOX8LLTY1PHGonKtcgQ==
X-Google-Smtp-Source: APXvYqyTKjYBrQBRLFKv1qrcWcNJQCDkfZmXauRFA5pCTMhEmXo5tuEJQdOxXWYacc0v/mxKYVM04w==
X-Received: by 2002:a17:902:56e:: with SMTP id 101mr784789plf.118.1576626473931;
        Tue, 17 Dec 2019 15:47:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm165649pfk.24.2019.12.17.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:47:52 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:47:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
Message-ID: <201912171547.7B4FED2@keescook>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-4-casey@schaufler-ca.com>
 <5d2d0621-5156-28af-7c08-0f9daac6ea6e@tycho.nsa.gov>
 <5dca060d-da34-3460-ecf2-54d4a31266c4@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dca060d-da34-3460-ecf2-54d4a31266c4@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 17, 2019 at 02:01:19PM -0800, Casey Schaufler wrote:
> On 12/17/2019 9:34 AM, Stephen Smalley wrote:
> > On 12/16/19 5:35 PM, Casey Schaufler wrote:
> >> Change the secid parameter of security_audit_rule_match
> >> to a lsmblob structure pointer. Pass the entry from the
> >> lsmblob structure for the approprite slot to the LSM hook.
> >>
> >> Change the users of security_audit_rule_match to use the
> >> lsmblob instead of a u32. In some cases this requires a
> >> temporary conversion using lsmblob_init() that will go
> >> away when other interfaces get converted.
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   include/linux/security.h            |  7 ++++---
> >>   kernel/auditfilter.c                |  7 +++++--
> >>   kernel/auditsc.c                    | 14 ++++++++++----
> >>   security/integrity/ima/ima.h        |  4 ++--
> >>   security/integrity/ima/ima_policy.c |  7 +++++--
> >>   security/security.c                 | 18 +++++++++++++++---
> >>   6 files changed, 41 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/include/linux/security.h b/include/linux/security.h
> >> index b74dc70088ca..9c6dbe248eaf 100644
> >> --- a/include/linux/security.h
> >> +++ b/include/linux/security.h
> >> @@ -1837,7 +1837,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
> >>   #ifdef CONFIG_SECURITY
> >>   int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
> >>   int security_audit_rule_known(struct audit_krule *krule);
> >> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> >> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> >> +                  void *lsmrule);
> >>   void security_audit_rule_free(void *lsmrule);
> >>     #else
> >> @@ -1853,8 +1854,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
> >>       return 0;
> >>   }
> >>   -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> >> -                        void *lsmrule)
> >> +static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
> >> +                        u32 op, void *lsmrule)
> >>   {
> >>       return 0;
> >>   }
> >> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> >> index b0126e9c0743..356db1dd276c 100644
> >> --- a/kernel/auditfilter.c
> >> +++ b/kernel/auditfilter.c
> >> @@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
> >>               struct audit_field *f = &e->rule.fields[i];
> >>               pid_t pid;
> >>               u32 sid;
> >> +            struct lsmblob blob;
> >>                 switch (f->type) {
> >>               case AUDIT_PID:
> >> @@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
> >>               case AUDIT_SUBJ_CLR:
> >>                   if (f->lsm_rule) {
> >>                       security_task_getsecid(current, &sid);
> >> -                    result = security_audit_rule_match(sid,
> >> -                           f->type, f->op, f->lsm_rule);
> >> +                    lsmblob_init(&blob, sid);
> >> +                    result = security_audit_rule_match(
> >> +                            &blob, f->type,
> >> +                            f->op, f->lsm_rule);
> >>                   }
> >>                   break;
> >>               case AUDIT_EXE:
> >> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> >> index 4effe01ebbe2..7566e5b1c419 100644
> >> --- a/kernel/auditsc.c
> >> +++ b/kernel/auditsc.c
> >> @@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
> >>       const struct cred *cred;
> >>       int i, need_sid = 1;
> >>       u32 sid;
> >> +    struct lsmblob blob;
> >>       unsigned int sessionid;
> >>         cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> >> @@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
> >>                       security_task_getsecid(tsk, &sid);
> >>                       need_sid = 0;
> >>                   }
> >> -                result = security_audit_rule_match(sid, f->type,
> >> +                lsmblob_init(&blob, sid);
> >> +                result = security_audit_rule_match(&blob,
> >> +                                   f->type,
> >>                                      f->op,
> >>                                      f->lsm_rule);
> >>               }
> >> @@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
> >>               if (f->lsm_rule) {
> >>                   /* Find files that match */
> >>                   if (name) {
> >> +                    lsmblob_init(&blob, name->osid);
> >>                       result = security_audit_rule_match(
> >> -                                name->osid,
> >> +                                &blob,
> >>                                   f->type,
> >>                                   f->op,
> >>                                   f->lsm_rule);
> >>                   } else if (ctx) {
> >>                       list_for_each_entry(n, &ctx->names_list, list) {
> >> +                        lsmblob_init(&blob, n->osid);
> >>                           if (security_audit_rule_match(
> >> -                                n->osid,
> >> +                                &blob,
> >>                                   f->type,
> >>                                   f->op,
> >>                                   f->lsm_rule)) {
> >> @@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
> >>                   /* Find ipc objects that match */
> >>                   if (!ctx || ctx->type != AUDIT_IPC)
> >>                       break;
> >> -                if (security_audit_rule_match(ctx->ipc.osid,
> >> +                lsmblob_init(&blob, ctx->ipc.osid);
> >> +                if (security_audit_rule_match(&blob,
> >>                                     f->type, f->op,
> >>                                     f->lsm_rule))
> >>                       ++result;
> >> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >> index df4ca482fb53..d95b0ece7434 100644
> >> --- a/security/integrity/ima/ima.h
> >> +++ b/security/integrity/ima/ima.h
> >> @@ -381,8 +381,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
> >>       return -EINVAL;
> >>   }
> >>   -static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
> >> -                         void *lsmrule)
> >> +static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
> >> +                         u32 op, void *lsmrule)
> >>   {
> >>       return -EINVAL;
> >>   }
> >> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> >> index f19a895ad7cd..193ddd55420b 100644
> >> --- a/security/integrity/ima/ima_policy.c
> >> +++ b/security/integrity/ima/ima_policy.c
> >> @@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> >>       for (i = 0; i < MAX_LSM_RULES; i++) {
> >>           int rc = 0;
> >>           u32 osid;
> >> +        struct lsmblob blob;
> >>             if (!rule->lsm[i].rule)
> >>               continue;
> >> @@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> >>           case LSM_OBJ_ROLE:
> >>           case LSM_OBJ_TYPE:
> >>               security_inode_getsecid(inode, &osid);
> >> -            rc = security_filter_rule_match(osid,
> >> +            lsmblob_init(&blob, osid);
> >> +            rc = security_filter_rule_match(&blob,
> >>                               rule->lsm[i].type,
> >>                               Audit_equal,
> >>                               rule->lsm[i].rule);
> >> @@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> >>           case LSM_SUBJ_USER:
> >>           case LSM_SUBJ_ROLE:
> >>           case LSM_SUBJ_TYPE:
> >> -            rc = security_filter_rule_match(secid,
> >> +            lsmblob_init(&blob, secid);
> >> +            rc = security_filter_rule_match(&blob,
> >>                               rule->lsm[i].type,
> >>                               Audit_equal,
> >>                               rule->lsm[i].rule);
> >> diff --git a/security/security.c b/security/security.c
> >> index a89634af639a..bfea9739c084 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
> >>   /*
> >>    * Current index to use while initializing the lsmblob secid list.
> >>    */
> >> -static int lsm_slot __initdata;
> >> +static int lsm_slot __lsm_ro_after_init;
> >>     /**
> >>    * security_add_hooks - Add a modules hooks to the hook lists.
> >> @@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
> >>       call_void_hook(audit_rule_free, lsmrule);
> >>   }
> >>   -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> >> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> >> +                  void *lsmrule)
> >>   {
> >> -    return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> >> +    struct security_hook_list *hp;
> >> +    int rc;
> >> +
> >> +    hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> >> +        if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> >> +            continue;
> >
> > Do you think we really need to retain these WARN_ON()s?
> 
> Kees was especially keen on having the WARN_ON().
> I'd be fine with removing it.

It should really really never happen, so I like the WARN_ON staying.

-Kees

> 
> 
> >   If not, then you could dispense with it now and leave lsm_slot as __initdata?  Otherwise,
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> >> +        rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
> >> +                           field, op, lsmrule);
> >> +        if (rc != 0)
> >> +            return rc;
> >> +    }
> >> +    return 0;
> >>   }
> >>   #endif /* CONFIG_AUDIT */
> >>  
> >

-- 
Kees Cook
