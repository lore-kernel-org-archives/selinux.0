Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E921C433EF
	for <selinux@archiver.kernel.org>; Sat, 20 Nov 2021 00:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhKTApy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 19:45:54 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:39449
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235736AbhKTApx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 19:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637368971; bh=ubAUJAWytncUDHJ4J5NDwEI/1d5sEsYHFs6UtBnuNWw=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=gPvnFWH3/RCnGbLGU/rfKxvrSfc2z754yIcz4EXeSbrs5pKsz8bE7eect/rkHenNm+GtNj4qHSuGjlt4sKzX60+k19cNC2mzvgwHtQk+ycWc/wGbzMh3dNWugRUSfBrGNL6pPG6VEBp0Q2RBuq/Zl8hEC2uADiDX4TmtQ550EN21H5fGakp2ICQKe/igbzhEv7bupWRHxxaksaWPmbvRif1pv21EudeXIjlDg57F5jgVxkFDZmd1db9FJuVps8sjz6xfWevoXSKnbgbqeJxB1JA7tyHqcTmEHdNbzYKLcxo8g10BPQLM+VdjAZqXWXSkKQQA/s6pz4iSZvWT3+I4pA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637368971; bh=jm297Gg3n3fCsUPsXBpssE4qVSOOTa3GMfL2N1f38xl=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HoUyLF7pc98nQT/EwEzMyq1et2gAKchxjExAcuV71iB6Jx1UDsBskZmYvEqVeZj2GdJUCXfIEdKuyulHBy12P/IQ4BEkJnNC+ejxKkUXDN0t53YpD8IHgVYHP9DLQ9L8QHabMwc7kdAbWrVNKEgVr/+xw6ffuaP4iCm80TrQ0tS6gS2w/lrn4UQSGt0jq6A8xL+FYPrdj+jeLiuX4utaYBWQUIoQzsqAatMUmj+FwiG88Z3L3rDGBo33TzJr6lgi2WAYwL+5ss+N1GdDaQjCXB12AWCWPtD8PaoPh7p6EhJPBe/lFR5Zys7fDtSGqxSBET704oIgJrwbcE+UmaHCrA==
X-YMail-OSG: vqdBglQVM1nz544FHdZnzXRCQ10riMKtHOW2G6vSEyowcwBXdEr54Dinb1Yaho7
 sWSNcFqR9wmnxqQROaL4ZVXurDCkjR_eRKF2KOR4hB8PlvbMF1BI2newuegu_glboi1fLgpB7Dhb
 ijfNUY6IQGZMSV_v7BlihJhDsrZds7J9SH86L8yPSoTgUtVdIZ6M2vvEtPgaHKYxTNkD6fJhAX0P
 YRbPKXP.TDNkK5kWOU6QTCP3CbJjNfOWzfK7okRgqVtmwoq2oKNqGO4.Q4_LGI8inzBReMuTGg67
 VchPB8y8bQ9miGBDtFKs2IqVgmhkUp2vRu2dOxem9WEB8FYpYEKNmOfJvqz7oJm0bHbiobGkzhHF
 X6iCZbVxjDzaM.3wQo_sKLVnQ3TvpDy5k815hQL9rNLKUBzTL8bPouqUPpFxioJQyE.atr035k7Z
 IVlXhqsiq8Uhwipakf2Py7YMj4P0uQWUEE4TTGgZQtADV3s50femhCYrOZ2t2lwMuO5eFZcAMIuu
 hmSZmWoAgN0xFH0nruILLPRwg9x9I0_583FgFJHZyU4LNimujn5SNDA5l9oXL6EhB3pwqDU8UB4M
 XKcM6OT_BqH.iy3dHCVL8l1AXWaaAgT.LNjEhDD2E4Jnx.vlOqC8WGd.5bEX7YcZFDhwGyZmV3Bz
 9yTcZApxTjIigZTF7QciHJKM0HjPumSEHhXJFUprEJ7w7rodBPrOnmw8cpB2OGyF0byH0WM7MZ0l
 AEQbtiqlTpgv95KjlDcy6UBi5kQorwWw5HAIzSKZm5TjIvQ84SS114UoV0e2_q1Uj05XHw9Qxvdf
 wuWUuYNPzqU04EKESI0kBICtGc4Edrhpe6YCo3KTCXYBKsbiuDvj0CiXgNqRXZxyQP5g4h0NQHNR
 wqPp.n26GCzbYEfeD9aPU3Cvgls8ITtsGD.Bz1RpLFBsWoHMql7qGs7WS1H2OvMOf4jem7fwDxgh
 nt4jJjJVJUzNW1K7r.yvRRzhCBmrLQE7xK0QO9dg17qmzGvnzRGZVQLcHlZ46rO_rDtMRA5bVOeT
 g8d5F0hVyRpYOhscw4lrjQmtNh3EQqQcRhRdCM.m17YrtHFBzmHS1YTd0Y0yBdcdbADLGIos5s90
 guxidXvINb_z076b0Ea.7lx3RvtgwTpt8Y9FehFSJf_gfpQVw6kk0W4AmfSozCKopd1iqr1dZsRl
 nhFipJ1l6pXGQL9s7GfBBLj1jabFXuAKCbn4.Oz_Q5HjBXcMyGlj3f_KVA0fWRtdTKD.hhg0Nled
 KGudFMP9KtVzvzzPilJMg86dm.5Lq.DtmtS1it2JihYRANWvToLSDtr1DGzlHyc88kUjXnMUoc1h
 .icdF86OpkNywpRqpPwtnMxp9mHM2Ya8bDLubM9MPjfcJ1ZT8Ct2pOvzD78VhXPrTRFdHvdnz6eo
 6Sr08FBCwqJhQrKs3Zrr7ywQQCrQsWCPwcNFVVW7tE8OId83MZu9.cDdlwJEwp3cYtRUfg0h6zXK
 SUy8JN77p_5uR5yI26iH0NrkXUr160P8lL_r3pef3d6fBN0NexygCsdIg9Pw6vCF77do0ZCpzMze
 lPTkVdzRNUVDO49Ocg114lPctK5eFLudic9Sm1vqUTgBNsWRv5HHTNg0zoURMAiJtY3Sx.3ZxkbZ
 vVEZyaVF3ioO6NKvlIu6PHJqfSuHeKrpEvH52rno9LuNJSmi_kXRrekpPzfzj1j8QmzNEB_fGrV5
 c6D0nZTBU8enAxTTUG9X4vODKbUd6hnT4EVsF8VjE5l2xa8aDI6hY1Mv9rKxzxCI7hilHI2rqgDT
 7DMESD2fizoxYad_LeiYIyO5j98KW7WdpN3gSN7H4MENaqMOBOXXI4JZgtRl74XguxSqfQzwQBJ5
 gjabQ9RKgXBEuujIZYQ0IGjDjA3UoOWbMMsLUQHv8DC4F40spuVhDUUoQ.iPiIHnvWXperRhnrBz
 zOmxi_agfsajws5aSzVf42iCdW8Q.KOKLtbeoLi1S2U1SFmOHEkbm1bi4dMh_r0lX1Aem4Fa4Yhy
 nv8h7pJOg9HkV01hqJHN61U6BLEDyLa6hyCsgU8ZI4agca9FKh9W4hjDlUxuWuc.bTppdcO.RExO
 pMysKYbXraBlB1qWCCBnDkwQSdOzkVt_9H8U7rJ_EfmjyYWE.Tk6Yurb7r545Pjx1C8.UbB3jTLv
 YErisF6Cg_jIkH6Guwg.mYb8WeAvse6g9s2Tc3_hochTQ0M87jf3GyCfOlpYoVNgqxsGK43rz8Uf
 mQ_uUAYDqqxuolWMEES5QiOP8JlHO6JRT_.aiEfRt42iZCatVxHCRZwJp.zIXjk62iVA8SSHgb_q
 YjAQkroQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sat, 20 Nov 2021 00:42:51 +0000
Received: by kubenode502.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID afa27adbf342e9a739c4d5777f17d304;
          Sat, 20 Nov 2021 00:42:47 +0000 (UTC)
Message-ID: <e5f141ee-43fe-56e9-e47f-f9da518b3e73@schaufler-ca.com>
Date:   Fri, 19 Nov 2021 16:42:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() ->
 security_current_getsecid_subj()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/19/2021 2:52 PM, Paul Moore wrote:
> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
>> The security_task_getsecid_subj() LSM hook invites misuse by allowing
>> callers to specify a task even though the hook is only safe when the
>> current task is referenced.  Fix this by removing the task_struct
>> argument to the hook, requiring LSM implementations to use the
>> current task.  While we are changing the hook declaration we also
>> rename the function to security_current_getsecid_subj() in an effort
>> to reinforce that the hook captures the subjective credentials of the
>> current task and not an arbitrary task on the system.
>>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>   include/linux/lsm_hook_defs.h         |    3 +--
>>   include/linux/lsm_hooks.h             |    8 +++-----
>>   include/linux/security.h              |    4 ++--
>>   kernel/audit.c                        |    4 ++--
>>   kernel/auditfilter.c                  |    3 +--
>>   kernel/auditsc.c                      |   10 +++++++++-
>>   net/netlabel/netlabel_unlabeled.c     |    2 +-
>>   net/netlabel/netlabel_user.h          |    2 +-
>>   security/apparmor/lsm.c               |   13 ++++++++++---
>>   security/integrity/ima/ima_appraise.c |    2 +-
>>   security/integrity/ima/ima_main.c     |   14 +++++++-------
>>   security/security.c                   |    6 +++---
>>   security/selinux/hooks.c              |   19 +++----------------
>>   security/smack/smack.h                |   16 ----------------
>>   security/smack/smack_lsm.c            |    9 ++++-----
>>   15 files changed, 48 insertions(+), 67 deletions(-)
> I never saw any comments, positive or negative, on this patch so I'll
> plan on merging it early next week.  If you've got objections, now is
> the time to speak up.

It's OK by me.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 2adeea44c0d5..8d04b18155a3 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -205,8 +205,7 @@ LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
>>   LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
>>   LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
>>   LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
>> -LSM_HOOK(void, LSM_RET_VOID, task_getsecid_subj,
>> -        struct task_struct *p, u32 *secid)
>> +LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
>>   LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
>>           struct task_struct *p, u32 *secid)
>>   LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 5c4c5c0602cb..9f5b93011ecb 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -716,11 +716,9 @@
>>    *     @p.
>>    *     @p contains the task_struct for the process.
>>    *     Return 0 if permission is granted.
>> - * @task_getsecid_subj:
>> - *     Retrieve the subjective security identifier of the task_struct in @p
>> - *     and return it in @secid.  Special care must be taken to ensure that @p
>> - *     is the either the "current" task, or the caller has exclusive access
>> - *     to @p.
>> + * @current_getsecid_subj:
>> + *     Retrieve the subjective security identifier of the current task and
>> + *     return it in @secid.
>>    *     In case of failure, @secid will be set to zero.
>>    * @task_getsecid_obj:
>>    *     Retrieve the objective security identifier of the task_struct in @p
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 5b7288521300..24190cf61858 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -417,7 +417,7 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
>>   int security_task_setpgid(struct task_struct *p, pid_t pgid);
>>   int security_task_getpgid(struct task_struct *p);
>>   int security_task_getsid(struct task_struct *p);
>> -void security_task_getsecid_subj(struct task_struct *p, u32 *secid);
>> +void security_current_getsecid_subj(u32 *secid);
>>   void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
>>   int security_task_setnice(struct task_struct *p, int nice);
>>   int security_task_setioprio(struct task_struct *p, int ioprio);
>> @@ -1112,7 +1112,7 @@ static inline int security_task_getsid(struct task_struct *p)
>>          return 0;
>>   }
>>
>> -static inline void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
>> +static inline void security_current_getsecid_subj(u32 *secid)
>>   {
>>          *secid = 0;
>>   }
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 121d37e700a6..d4084751cfe6 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -2132,7 +2132,7 @@ int audit_log_task_context(struct audit_buffer *ab)
>>          int error;
>>          u32 sid;
>>
>> -       security_task_getsecid_subj(current, &sid);
>> +       security_current_getsecid_subj(&sid);
>>          if (!sid)
>>                  return 0;
>>
>> @@ -2353,7 +2353,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>>                          audit_sig_uid = auid;
>>                  else
>>                          audit_sig_uid = uid;
>> -               security_task_getsecid_subj(current, &audit_sig_sid);
>> +               security_current_getsecid_subj(&audit_sig_sid);
>>          }
>>
>>          return audit_signal_info_syscall(t);
>> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
>> index db2c6b59dfc3..f4ebd2f1cfca 100644
>> --- a/kernel/auditfilter.c
>> +++ b/kernel/auditfilter.c
>> @@ -1359,8 +1359,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>>                          case AUDIT_SUBJ_SEN:
>>                          case AUDIT_SUBJ_CLR:
>>                                  if (f->lsm_rule) {
>> -                                       security_task_getsecid_subj(current,
>> -                                                                   &sid);
>> +                                       security_current_getsecid_subj(&sid);
>>                                          result = security_audit_rule_match(sid,
>>                                                     f->type, f->op, f->lsm_rule);
>>                                  }
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 8dd73a64f921..e0987ee71b8f 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -673,7 +673,15 @@ static int audit_filter_rules(struct task_struct *tsk,
>>                             logged upon error */
>>                          if (f->lsm_rule) {
>>                                  if (need_sid) {
>> -                                       security_task_getsecid_subj(tsk, &sid);
>> +                                       /* @tsk should always be equal to
>> +                                        * @current with the exception of
>> +                                        * fork()/copy_process() in which case
>> +                                        * the new @tsk creds are still a dup
>> +                                        * of @current's creds so we can still
>> +                                        * use security_current_getsecid_subj()
>> +                                        * here even though it always refs
>> +                                        * @current's creds */
>> +                                       security_current_getsecid_subj(&sid);
>>                                          need_sid = 0;
>>                                  }
>>                                  result = security_audit_rule_match(sid, f->type,
>> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
>> index 566ba4397ee4..8490e46359ae 100644
>> --- a/net/netlabel/netlabel_unlabeled.c
>> +++ b/net/netlabel/netlabel_unlabeled.c
>> @@ -1537,7 +1537,7 @@ int __init netlbl_unlabel_defconf(void)
>>          /* Only the kernel is allowed to call this function and the only time
>>           * it is called is at bootup before the audit subsystem is reporting
>>           * messages so don't worry to much about these values. */
>> -       security_task_getsecid_subj(current, &audit_info.secid);
>> +       security_current_getsecid_subj(&audit_info.secid);
>>          audit_info.loginuid = GLOBAL_ROOT_UID;
>>          audit_info.sessionid = 0;
>>
>> diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
>> index 6190cbf94bf0..d6c5b31eb4eb 100644
>> --- a/net/netlabel/netlabel_user.h
>> +++ b/net/netlabel/netlabel_user.h
>> @@ -32,7 +32,7 @@
>>    */
>>   static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
>>   {
>> -       security_task_getsecid_subj(current, &audit_info->secid);
>> +       security_current_getsecid_subj(&audit_info->secid);
>>          audit_info->loginuid = audit_get_loginuid(current);
>>          audit_info->sessionid = audit_get_sessionid(current);
>>   }
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index f72406fe1bf2..fc21190c4f4f 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -728,7 +728,14 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
>>          return;
>>   }
>>
>> -static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
>> +static void apparmor_current_getsecid_subj(u32 *secid)
>> +{
>> +       struct aa_label *label = aa_get_task_label(current);
>> +       *secid = label->secid;
>> +       aa_put_label(label);
>> +}
>> +
>> +static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
>>   {
>>          struct aa_label *label = aa_get_task_label(p);
>>          *secid = label->secid;
>> @@ -1252,8 +1259,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>>
>>          LSM_HOOK_INIT(task_free, apparmor_task_free),
>>          LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
>> -       LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid),
>> -       LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid),
>> +       LSM_HOOK_INIT(current_getsecid_subj, apparmor_current_getsecid_subj),
>> +       LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
>>          LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
>>          LSM_HOOK_INIT(task_kill, apparmor_task_kill),
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index dbba51583e7c..17232bbfb9f9 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -76,7 +76,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
>>          if (!ima_appraise)
>>                  return 0;
>>
>> -       security_task_getsecid_subj(current, &secid);
>> +       security_current_getsecid_subj(&secid);
>>          return ima_match_policy(mnt_userns, inode, current_cred(), secid,
>>                                  func, mask, IMA_APPRAISE | IMA_HASH, NULL,
>>                                  NULL, NULL, NULL);
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 465865412100..8c6e4514d494 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -408,7 +408,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>>          u32 secid;
>>
>>          if (file && (prot & PROT_EXEC)) {
>> -               security_task_getsecid_subj(current, &secid);
>> +               security_current_getsecid_subj(&secid);
>>                  return process_measurement(file, current_cred(), secid, NULL,
>>                                             0, MAY_EXEC, MMAP_CHECK);
>>          }
>> @@ -446,7 +446,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>>              !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>>                  return 0;
>>
>> -       security_task_getsecid_subj(current, &secid);
>> +       security_current_getsecid_subj(&secid);
>>          inode = file_inode(vma->vm_file);
>>          action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
>>                                  current_cred(), secid, MAY_EXEC, MMAP_CHECK,
>> @@ -487,7 +487,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>>          int ret;
>>          u32 secid;
>>
>> -       security_task_getsecid_subj(current, &secid);
>> +       security_current_getsecid_subj(&secid);
>>          ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
>>                                    MAY_EXEC, BPRM_CHECK);
>>          if (ret)
>> @@ -512,7 +512,7 @@ int ima_file_check(struct file *file, int mask)
>>   {
>>          u32 secid;
>>
>> -       security_task_getsecid_subj(current, &secid);
>> +       security_current_getsecid_subj(&secid);
>>          return process_measurement(file, current_cred(), secid, NULL, 0,
>>                                     mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>>                                             MAY_APPEND), FILE_CHECK);
>> @@ -709,7 +709,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>>
>>          /* Read entire file for all partial reads. */
>>          func = read_idmap[read_id] ?: FILE_CHECK;
>> -       security_task_getsecid_subj(current, &secid);
>> +       security_current_getsecid_subj(&secid);
>>          return process_measurement(file, current_cred(), secid, NULL,
>>                                     0, MAY_READ, func);
>>   }
>> @@ -752,7 +752,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>>          }
>>
>>          func = read_idmap[read_id] ?: FILE_CHECK;
>> -       security_task_getsecid_subj(current, &secid);
>> +       security_current_getsecid_subj(&secid);
>>          return process_measurement(file, current_cred(), secid, buf, size,
>>                                     MAY_READ, func);
>>   }
>> @@ -905,7 +905,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
>>           * buffer measurements.
>>           */
>>          if (func) {
>> -               security_task_getsecid_subj(current, &secid);
>> +               security_current_getsecid_subj(&secid);
>>                  action = ima_get_action(mnt_userns, inode, current_cred(),
>>                                          secid, 0, func, &pcr, &template,
>>                                          func_data, NULL);
>> diff --git a/security/security.c b/security/security.c
>> index 9ffa9e9c5c55..827bd161f8b0 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1807,12 +1807,12 @@ int security_task_getsid(struct task_struct *p)
>>          return call_int_hook(task_getsid, 0, p);
>>   }
>>
>> -void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
>> +void security_current_getsecid_subj(u32 *secid)
>>   {
>>          *secid = 0;
>> -       call_void_hook(task_getsecid_subj, p, secid);
>> +       call_void_hook(current_getsecid_subj, secid);
>>   }
>> -EXPORT_SYMBOL(security_task_getsecid_subj);
>> +EXPORT_SYMBOL(security_current_getsecid_subj);
>>
>>   void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
>>   {
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index e7ebd45ca345..5c766b901f66 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -229,19 +229,6 @@ static inline u32 cred_sid(const struct cred *cred)
>>          return tsec->sid;
>>   }
>>
>> -/*
>> - * get the subjective security ID of a task
>> - */
>> -static inline u32 task_sid_subj(const struct task_struct *task)
>> -{
>> -       u32 sid;
>> -
>> -       rcu_read_lock();
>> -       sid = cred_sid(rcu_dereference(task->cred));
>> -       rcu_read_unlock();
>> -       return sid;
>> -}
>> -
>>   /*
>>    * get the objective security ID of a task
>>    */
>> @@ -4222,9 +4209,9 @@ static int selinux_task_getsid(struct task_struct *p)
>>                              PROCESS__GETSESSION, NULL);
>>   }
>>
>> -static void selinux_task_getsecid_subj(struct task_struct *p, u32 *secid)
>> +static void selinux_current_getsecid_subj(u32 *secid)
>>   {
>> -       *secid = task_sid_subj(p);
>> +       *secid = current_sid();
>>   }
>>
>>   static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
>> @@ -7221,7 +7208,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>          LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>>          LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
>>          LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
>> -       LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid_subj),
>> +       LSM_HOOK_INIT(current_getsecid_subj, selinux_current_getsecid_subj),
>>          LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
>>          LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
>>          LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>> index 99c3422596ab..fc837dcebf96 100644
>> --- a/security/smack/smack.h
>> +++ b/security/smack/smack.h
>> @@ -389,22 +389,6 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
>>          return tsp->smk_task;
>>   }
>>
>> -static inline struct smack_known *smk_of_task_struct_subj(
>> -                                               const struct task_struct *t)
>> -{
>> -       struct smack_known *skp;
>> -       const struct cred *cred;
>> -
>> -       rcu_read_lock();
>> -
>> -       cred = rcu_dereference(t->cred);
>> -       skp = smk_of_task(smack_cred(cred));
>> -
>> -       rcu_read_unlock();
>> -
>> -       return skp;
>> -}
>> -
>>   static inline struct smack_known *smk_of_task_struct_obj(
>>                                                  const struct task_struct *t)
>>   {
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 21a0e7c3b8de..40e1d764e616 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -2061,15 +2061,14 @@ static int smack_task_getsid(struct task_struct *p)
>>   }
>>
>>   /**
>> - * smack_task_getsecid_subj - get the subjective secid of the task
>> - * @p: the task
>> + * smack_current_getsecid_subj - get the subjective secid of the current task
>>    * @secid: where to put the result
>>    *
>>    * Sets the secid to contain a u32 version of the task's subjective smack label.
>>    */
>> -static void smack_task_getsecid_subj(struct task_struct *p, u32 *secid)
>> +static void smack_current_getsecid_subj(u32 *secid)
>>   {
>> -       struct smack_known *skp = smk_of_task_struct_subj(p);
>> +       struct smack_known *skp = smk_of_current();
>>
>>          *secid = skp->smk_secid;
>>   }
>> @@ -4756,7 +4755,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>>          LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
>>          LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
>>          LSM_HOOK_INIT(task_getsid, smack_task_getsid),
>> -       LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid_subj),
>> +       LSM_HOOK_INIT(current_getsecid_subj, smack_current_getsecid_subj),
>>          LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
>>          LSM_HOOK_INIT(task_setnice, smack_task_setnice),
>>          LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
>>
>
