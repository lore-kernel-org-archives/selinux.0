Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F2CC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A5F2176D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 00:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kNnb7cEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfLRA2o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:28:44 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:39864
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbfLRA2o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 19:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576628920; bh=HoQQMsEevny0CyNqWJW4dbYz9E5lpxL8ThnXEPXduGc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kNnb7cEXxrsryK28rmrUjVP/6NhMLTShesaatkKX9LNZdX4Wd65x8ShPodQCYvQAp2QL2U897RPTykQ7HMoTzoAM0EX8BYw5uprwgImm8nGafIDCy8k35nVaITFv4TgW2EF1JWuHHic0m7cQ3VRPPgNC6tOLnr1cUIWjshCObTCp7zwxPru9tpTAh6Y07bekOhHkmuqF6XQNFtjAeleZ7um3riAp43q7uzhpoBUxmH68tSUPvPFKDi64AtRiy4VVKXKzMqQeYvg08wqjre/rsPWydStFsW4wykZcGBQEbu7J6PpodLg9fxzn4B3OItfbVMZeNYYsPtH5BtqYtjx1Pg==
X-YMail-OSG: 98ErhRUVM1las_KR6.aR6YAek0XpL.QooMcUD2uyzYF1rTphKnOqwKam4rLJVAP
 1MWoebpMWtjKNwmjBUwfDgQsNjmo576My_MUmQBalPoHcEso6wurouB8e4qHHxyGzZSQYzg_X3JN
 GcVVX8nS0zsYrAOWEubZA9sizWznUuGqnYj6ObQqw2SoVxx94iz5LKnbxiy.nLzkiKIalD6uCybU
 EcrSU27FDhAfp4YhRUNrWy5GRZ4dg1._ZLWn65eBO9nM1fF6sasYk0WNRFpn1Temr4ehKOiY7WOp
 vMlv0YVeUVmTrLVjKfMgVaKg13Mokzv2e2rcGQnZAD_nA0oRJYXAOa8s9T1.Q1vfi3sThS5wR6ve
 oqNbdvFwa9WKedy9TS0mhkH_m9I05_JhNfnuWIhqQtevPyop8dKh.8EV3iQG1d9RUKIh4FZiItH0
 FSkpRPG7oXtIzcRzRXkQheFmi_8MEFGhGAwsdhJoe4vTfyYpeNMROa6iqRUIfe4NH4orOY8JlF0Q
 2ubgv98ral07kOHy28uoRDHCuvgTkDDoCj..gpxucftVenrk9OAhwhBQPPnOw8EhfgN3xbpFuPHC
 WogF6zQBwWIyeFwb8XxkskgDI31.h2NyiqE0j.0MmAbXhr1K3ZxRo2N4Tlhrkhxhaxs2Zl5xRZtS
 QHuqjN7_I_r2Luqsl0jp8zKKUvs2lL6Yn_8OVaYce0_6JXdGokw4hxNWeXa.c.iGR0Lk1sDCty8H
 baOwsyY84DqW.W_j.ceuC2PO0zl8G5lU0hAjg6vku.7a0.M0UwUHFRt1ZxjsTEeP19Z2J5fJ8IT7
 psVRBRHvptMFEibhQGglM9AY0LmFfVW8pZS.H1jEL0LIeoKSZkPBL9uW6y2_AvjGYQBY_JLjFxpK
 _ZsA.hYLQLYYSp9vUXWX8J_ZXxY30IYylPPefOrWjw3k.7yza3Wz.8C8QDhvlbfIxZ_U.b8eeSr9
 1BQSuV20.Kj.H6o1KadrCrYklPTDs7ritRUttxZBlA13kuBXmgMaVdbdQiC7hJaGPL6EusTDcgwM
 OFC0LI7fn0hqzAPNLSSlxOorJeVDZPcH3z2pYIS4ch1QPPRj97TdGjuTqDlpSZi6qL07zARukUBV
 FSU3MvsVm7j4Bs52ISruY6HS1yCYs5dXhntsq5yhnfgpBwdO7pstnNrfzOAbYI2Rrq8qGfxy0KTR
 Q6ecD7u1rX_.AlvzZudtcZ17lPKIU9EcgRXyu0yUjzbkANYUFYJvi_l7dhW0WRqBT.FVcpk07Ct0
 NHxarunU2nuzN6eou7VVK0TIk1kdVQX49qExnPRaYEikN5wCOpYt_fVKBJ61xgdr0XahLByaifqW
 jAGO3Wk1q1h9haBi8g51hEc1QzMETbhagxVWZJFsNVsAp_1S6ddX82VyTLz5t4gBmaz1fBkkHyKe
 xW5hkcDKbNJ3JNIlDAIK6p4MmvikIMRDcycnA7hYh8l.Q4Yv7aw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Dec 2019 00:28:40 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID aed0f0682d3ee5b3be0c271544b166bd;
          Wed, 18 Dec 2019 00:28:38 +0000 (UTC)
Subject: Re: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-4-casey@schaufler-ca.com>
 <5d2d0621-5156-28af-7c08-0f9daac6ea6e@tycho.nsa.gov>
 <5dca060d-da34-3460-ecf2-54d4a31266c4@schaufler-ca.com>
 <201912171547.7B4FED2@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <752bb0c9-6e3b-9a63-3dd9-e2cc81641e09@schaufler-ca.com>
Date:   Tue, 17 Dec 2019 16:28:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <201912171547.7B4FED2@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/17/2019 3:47 PM, Kees Cook wrote:
> On Tue, Dec 17, 2019 at 02:01:19PM -0800, Casey Schaufler wrote:
>> On 12/17/2019 9:34 AM, Stephen Smalley wrote:
>>> On 12/16/19 5:35 PM, Casey Schaufler wrote:
>>>> Change the secid parameter of security_audit_rule_match
>>>> to a lsmblob structure pointer. Pass the entry from the
>>>> lsmblob structure for the approprite slot to the LSM hook.
>>>>
>>>> Change the users of security_audit_rule_match to use the
>>>> lsmblob instead of a u32. In some cases this requires a
>>>> temporary conversion using lsmblob_init() that will go
>>>> away when other interfaces get converted.
>>>>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>   include/linux/security.h            |  7 ++++---
>>>>   kernel/auditfilter.c                |  7 +++++--
>>>>   kernel/auditsc.c                    | 14 ++++++++++----
>>>>   security/integrity/ima/ima.h        |  4 ++--
>>>>   security/integrity/ima/ima_policy.c |  7 +++++--
>>>>   security/security.c                 | 18 +++++++++++++++---
>>>>   6 files changed, 41 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>>> index b74dc70088ca..9c6dbe248eaf 100644
>>>> --- a/include/linux/security.h
>>>> +++ b/include/linux/security.h
>>>> @@ -1837,7 +1837,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>>>>   #ifdef CONFIG_SECURITY
>>>>   int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>>>>   int security_audit_rule_known(struct audit_krule *krule);
>>>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>>>> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>>>> +                  void *lsmrule);
>>>>   void security_audit_rule_free(void *lsmrule);
>>>>     #else
>>>> @@ -1853,8 +1854,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>>>>       return 0;
>>>>   }
>>>>   -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
>>>> -                        void *lsmrule)
>>>> +static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
>>>> +                        u32 op, void *lsmrule)
>>>>   {
>>>>       return 0;
>>>>   }
>>>> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
>>>> index b0126e9c0743..356db1dd276c 100644
>>>> --- a/kernel/auditfilter.c
>>>> +++ b/kernel/auditfilter.c
>>>> @@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>>>>               struct audit_field *f = &e->rule.fields[i];
>>>>               pid_t pid;
>>>>               u32 sid;
>>>> +            struct lsmblob blob;
>>>>                 switch (f->type) {
>>>>               case AUDIT_PID:
>>>> @@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
>>>>               case AUDIT_SUBJ_CLR:
>>>>                   if (f->lsm_rule) {
>>>>                       security_task_getsecid(current, &sid);
>>>> -                    result = security_audit_rule_match(sid,
>>>> -                           f->type, f->op, f->lsm_rule);
>>>> +                    lsmblob_init(&blob, sid);
>>>> +                    result = security_audit_rule_match(
>>>> +                            &blob, f->type,
>>>> +                            f->op, f->lsm_rule);
>>>>                   }
>>>>                   break;
>>>>               case AUDIT_EXE:
>>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>>> index 4effe01ebbe2..7566e5b1c419 100644
>>>> --- a/kernel/auditsc.c
>>>> +++ b/kernel/auditsc.c
>>>> @@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>>>>       const struct cred *cred;
>>>>       int i, need_sid = 1;
>>>>       u32 sid;
>>>> +    struct lsmblob blob;
>>>>       unsigned int sessionid;
>>>>         cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
>>>> @@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>>>>                       security_task_getsecid(tsk, &sid);
>>>>                       need_sid = 0;
>>>>                   }
>>>> -                result = security_audit_rule_match(sid, f->type,
>>>> +                lsmblob_init(&blob, sid);
>>>> +                result = security_audit_rule_match(&blob,
>>>> +                                   f->type,
>>>>                                      f->op,
>>>>                                      f->lsm_rule);
>>>>               }
>>>> @@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
>>>>               if (f->lsm_rule) {
>>>>                   /* Find files that match */
>>>>                   if (name) {
>>>> +                    lsmblob_init(&blob, name->osid);
>>>>                       result = security_audit_rule_match(
>>>> -                                name->osid,
>>>> +                                &blob,
>>>>                                   f->type,
>>>>                                   f->op,
>>>>                                   f->lsm_rule);
>>>>                   } else if (ctx) {
>>>>                       list_for_each_entry(n, &ctx->names_list, list) {
>>>> +                        lsmblob_init(&blob, n->osid);
>>>>                           if (security_audit_rule_match(
>>>> -                                n->osid,
>>>> +                                &blob,
>>>>                                   f->type,
>>>>                                   f->op,
>>>>                                   f->lsm_rule)) {
>>>> @@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
>>>>                   /* Find ipc objects that match */
>>>>                   if (!ctx || ctx->type != AUDIT_IPC)
>>>>                       break;
>>>> -                if (security_audit_rule_match(ctx->ipc.osid,
>>>> +                lsmblob_init(&blob, ctx->ipc.osid);
>>>> +                if (security_audit_rule_match(&blob,
>>>>                                     f->type, f->op,
>>>>                                     f->lsm_rule))
>>>>                       ++result;
>>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>>> index df4ca482fb53..d95b0ece7434 100644
>>>> --- a/security/integrity/ima/ima.h
>>>> +++ b/security/integrity/ima/ima.h
>>>> @@ -381,8 +381,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
>>>>       return -EINVAL;
>>>>   }
>>>>   -static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
>>>> -                         void *lsmrule)
>>>> +static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
>>>> +                         u32 op, void *lsmrule)
>>>>   {
>>>>       return -EINVAL;
>>>>   }
>>>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>>>> index f19a895ad7cd..193ddd55420b 100644
>>>> --- a/security/integrity/ima/ima_policy.c
>>>> +++ b/security/integrity/ima/ima_policy.c
>>>> @@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>>>>       for (i = 0; i < MAX_LSM_RULES; i++) {
>>>>           int rc = 0;
>>>>           u32 osid;
>>>> +        struct lsmblob blob;
>>>>             if (!rule->lsm[i].rule)
>>>>               continue;
>>>> @@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>>>>           case LSM_OBJ_ROLE:
>>>>           case LSM_OBJ_TYPE:
>>>>               security_inode_getsecid(inode, &osid);
>>>> -            rc = security_filter_rule_match(osid,
>>>> +            lsmblob_init(&blob, osid);
>>>> +            rc = security_filter_rule_match(&blob,
>>>>                               rule->lsm[i].type,
>>>>                               Audit_equal,
>>>>                               rule->lsm[i].rule);
>>>> @@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>>>>           case LSM_SUBJ_USER:
>>>>           case LSM_SUBJ_ROLE:
>>>>           case LSM_SUBJ_TYPE:
>>>> -            rc = security_filter_rule_match(secid,
>>>> +            lsmblob_init(&blob, secid);
>>>> +            rc = security_filter_rule_match(&blob,
>>>>                               rule->lsm[i].type,
>>>>                               Audit_equal,
>>>>                               rule->lsm[i].rule);
>>>> diff --git a/security/security.c b/security/security.c
>>>> index a89634af639a..bfea9739c084 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
>>>>   /*
>>>>    * Current index to use while initializing the lsmblob secid list.
>>>>    */
>>>> -static int lsm_slot __initdata;
>>>> +static int lsm_slot __lsm_ro_after_init;
>>>>     /**
>>>>    * security_add_hooks - Add a modules hooks to the hook lists.
>>>> @@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
>>>>       call_void_hook(audit_rule_free, lsmrule);
>>>>   }
>>>>   -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>>>> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>>>> +                  void *lsmrule)
>>>>   {
>>>> -    return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
>>>> +    struct security_hook_list *hp;
>>>> +    int rc;
>>>> +
>>>> +    hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
>>>> +        if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>>>> +            continue;
>>> Do you think we really need to retain these WARN_ON()s?
>> Kees was especially keen on having the WARN_ON().
>> I'd be fine with removing it.
> It should really really never happen, so I like the WARN_ON staying.
>
> -Kees

Given that Mr. Hardening likes it the way it is, I'm inclined to leave
it as is. Would that prevent an Ack?


>
>>
>>>   If not, then you could dispense with it now and leave lsm_slot as __initdata?  Otherwise,
>>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>
>>>> +        rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
>>>> +                           field, op, lsmrule);
>>>> +        if (rc != 0)
>>>> +            return rc;
>>>> +    }
>>>> +    return 0;
>>>>   }
>>>>   #endif /* CONFIG_AUDIT */
>>>>  
