Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD2AC10F11
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950E620652
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t369a1jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfDJRTC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:19:02 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:41085
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729068AbfDJRTC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554916739; bh=NmvuOqslKy2Aqo+yKmwK5ht8j+yWEeRWVEanD8DKtak=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=t369a1jP4CFOiT57QThZXypiBePlY1o8nUTN3a8dU2+MC1HdK22AH2mu50h0FUm0LtfJvAPOKiWTH9yv/HN9/1Sqdz9BASQpJnbdVy4n13ULwYj2esKe3dYWzzwqzs0GufMskceD5XXXwICfy1yQZP1v4WZJHtQD5cG0SKvmV7BuQBUkoRFBOaNrb73wNSqzK1wb4MWBBWLsnF9WBlo1o4U0HmT25VzcbMran4A+iq+DG/UxL7bW8uaJzudznLcS/uqv1NMNpu6MaQemIXzKW6YnThXodtsiZdrtHEjeo3GVJwbMAlSfvXbSQOrFxaz6/iKmH7LHgv+ooIgIte8qgw==
X-YMail-OSG: 0PasLWYVM1lNtZ0CIJC2Nafgat1BwTunLNfLUgjRN2MPYJPgxznMQ8ooxdzB8j5
 k0Qo6qOj7Uqg_FRi6awzxweBszgVzSWnyly0KimQ5sCPF1t.TRFgwbb499ZPGm9ZO_we8g7g7MDI
 72qxgovbzD8qXBJB4l87DPo2FGGpy7GBpmqu9cNQt18q7Ow3cQS3yXwlpx_8qlj749c6BMJNgq93
 Ow5nNNHK37NLJzG1VAU1_ar.brmxoWp34tcIL23YaJfDqwSDn.l.5GMJkpNaYorI_w0gSOsSXNPi
 _sKnhbvn81Lke.py3nj2nq8ZZ9Qm_mlvFcXIG_8OsITI.tpBPAvWKIPZ.0EMApMp.qiUWLl_G0BW
 vWm3fe1q.b8iTpCf08t2VASvKJtfWJshr_lq6OCdbMWnBCFqI2PafknAvbH41iYECvdqjDHsHEVA
 LXCckp1XupKXBNvjdinb7jqC7Wf_QboWpTdPZTReIHg7xf58Z5amm86061QMClSZ.zxPbRXbd4pL
 KYDkvBibiPW6R6uLwFKthbICo_TbElfZMdx0CNK4CNgNZLDVvb59NEiXC4a_aVukCp4x5lpcWDul
 JoqTh9fbwAb4TFAxsZLOSTl6eqKbknmFqjbhot_i7UK89yed9wix2mAourIT_uTeod1u8brsiq43
 l2xJafGjBzRnvsGEPt2kcRaEI7vAXcjzs4OPu2kdNw4PN7LflM8GsEV6D9DWaN9mgrb5.Q1K2Ame
 sVFuNlFVdZGRgDXPNTdBth69uqPAsMoE9hXLvFL_LxbSc5fYtnba0jQGJRAq4RiQxH43YUdFY4Gp
 EXNrPfJ8cngB0GEB9lkMVJS5XyQOeuhIBfbEudt_UUK.RSikuOUT_GUwUrCLnct9JNn89dNCx3mj
 RS_.jZiOZDr7TDAaAmFVyF90txfY4PVSBTANwx8CNBV58yEhOa4QToOIu5OLqBJ1r.UwAe3y1aGn
 fhQFiIahhUI_nfb2Gr__gjCOVZnxnZDCB2JpdbNZ2px0ptN3UpYMuWfzS0Bps9exDc_6.NIZR9Gb
 KpnwWSMGL_NMEGg652W6sOPzZ24U354RX3LJvCSzvak_nycXzg4FGz7x02wBKgSmDXDu2LHjxTTp
 hw7Fei8oxzgJDyDRhms9vM0ne2HJV5DqMLMVG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 10 Apr 2019 17:18:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ba0c710dc1817734e03514c72a62b0c7;
          Wed, 10 Apr 2019 17:18:57 +0000 (UTC)
Subject: Re: [PATCH 58/59] LSM: Specify which LSM to display with
 /proc/self/attr/display
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        casey@schaufler-ca.com
References: <20190409213946.1667-1-casey@schaufler-ca.com>
 <20190409213946.1667-59-casey@schaufler-ca.com>
 <CAB9W1A0ZVUHAtAEhYw+HSyOnRdekg=6WQ2RP8PqNAirmDxBkZw@mail.gmail.com>
 <CAB9W1A2Bgr+gVGNxyVOwd7A52Gp8Kx0dPyd91pSjtXKp4UHoxw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3bbc2089-177c-f4f3-c803-cc009fcc7a75@schaufler-ca.com>
Date:   Wed, 10 Apr 2019 10:18:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAB9W1A2Bgr+gVGNxyVOwd7A52Gp8Kx0dPyd91pSjtXKp4UHoxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/10/2019 7:09 AM, Stephen Smalley wrote:
> On Wed, Apr 10, 2019 at 8:43 AM Stephen Smalley
> <stephen.smalley@gmail.com> wrote:
>> On Tue, Apr 9, 2019 at 5:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Create a new entry "display" in /proc/.../attr for controlling
>>> which LSM security information is displayed for a process.
>>> The name of an active LSM that supplies hooks for human readable
>>> data may be written to "display" to set the value. The name of
>>> the LSM currently in use can be read from "display".
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>   fs/proc/base.c      |   1 +
>>>   security/security.c | 123 ++++++++++++++++++++++++++++++++++++++++++--
>>>   2 files changed, 121 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index ddef482f1334..7bf70e041315 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>>>          ATTR(NULL, "fscreate",          0666),
>>>          ATTR(NULL, "keycreate",         0666),
>>>          ATTR(NULL, "sockcreate",        0666),
>>> +       ATTR(NULL, "display",           0666),
>>>   #ifdef CONFIG_SECURITY_SMACK
>>>          DIR("smack",                    0555,
>>>              proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
>>> diff --git a/security/security.c b/security/security.c
>>> index 29149db3f78a..6e304aa796f9 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -47,9 +47,13 @@ static struct kmem_cache *lsm_inode_cache;
>>>
>>>   char *lsm_names;
>>>
>>> -/* Socket blobs include infrastructure managed data */
>>> +/*
>>> + *     Socket blobs include infrastructure managed data
>>> + *     Cred blobs include context display instructions
>>> + */
>>>   static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
>>>          .lbs_sock = sizeof(struct lsm_export),
>>> +       .lbs_cred = sizeof(struct lsm_one_hooks),
>>>   };
>>>
>>>   /**
>>> @@ -751,7 +755,10 @@ int lsm_superblock_alloc(struct super_block *sb)
>>>
>>>   #define call_one_int_hook(FUNC, IRC, ...) ({                   \
>>>          int RC = IRC;                                           \
>>> -       if (lsm_base_one.FUNC.FUNC)                             \
>>> +       struct lsm_one_hooks *LOH = current_cred()->security;   \
>>> +       if (LOH->FUNC.FUNC)                                     \
>>> +               RC = LOH->FUNC.FUNC(__VA_ARGS__);               \
>>> +       else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)    \
>>>                  RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);       \
>>>          RC;                                                     \
>>>   })
>>> @@ -1617,6 +1624,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>>>
>>>   void security_cred_free(struct cred *cred)
>>>   {
>>> +       struct lsm_one_hooks *loh;
>>>          /*
>>>           * There is a failure case in prepare_creds() that
>>>           * may result in a call here with ->security being NULL.
>>> @@ -1626,26 +1634,44 @@ void security_cred_free(struct cred *cred)
>>>
>>>          call_void_hook(cred_free, cred);
>>>
>>> +       loh = cred->security;
>>> +       kfree(loh->lsm);
>>>          kfree(cred->security);
>>>          cred->security = NULL;
>>>   }
>>>
>>> +static int copy_loh(struct lsm_one_hooks *new, struct lsm_one_hooks *old,
>>> +                   gfp_t gfp)
>>> +{
>>> +       *new = *old;
>>> +       if (old->lsm) {
>>> +               new->lsm = kstrdup(old->lsm, gfp);
>>> +               if (unlikely(new->lsm == NULL))
>>> +                       return -ENOMEM;
>>> +       }
>>> +       return 0;
>>> +}
>>> +
>>>   int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
>>>   {
>>>          int rc = lsm_cred_alloc(new, gfp);
>>>
>>> -       if (rc)
>>> +       if (unlikely(rc))
>>>                  return rc;
>>>
>>>          rc = call_int_hook(cred_prepare, 0, new, old, gfp);
>>>          if (unlikely(rc))
>>>                  security_cred_free(new);
>>> +       else
>>> +               rc = copy_loh(new->security, old->security, gfp);
>>> +
>>>          return rc;
>>>   }
>>>
>>>   void security_transfer_creds(struct cred *new, const struct cred *old)
>>>   {
>>>          call_void_hook(cred_transfer, new, old);
>>> +       WARN_ON(copy_loh(new->security, old->security, GFP_KERNEL));
>>>   }
>>>
>>>   void security_cred_getsecid(const struct cred *c, struct lsm_export *l)
>>> @@ -1960,10 +1986,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>>>                                  char **value)
>>>   {
>>>          struct security_hook_list *hp;
>>> +       struct lsm_one_hooks *loh = current_cred()->security;
>>> +       char *s;
>>> +
>>> +       if (!strcmp(name, "display")) {
>>> +               if (loh->lsm)
>>> +                       s = loh->lsm;
>>> +               else if (lsm_base_one.lsm)
>>> +                       s = lsm_base_one.lsm;
>>> +               else
>>> +                       return -EINVAL;
>>> +
>>> +               *value = kstrdup(s, GFP_KERNEL);
>>> +               if (*value)
>>> +                       return strlen(s);
>>> +               return -ENOMEM;
>>> +       }
>>>
>>>          hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>>                  if (lsm != NULL && strcmp(lsm, hp->lsm))
>>>                          continue;
>>> +               if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
>>> +                       continue;
>>>                  return hp->hook.getprocattr(p, name, value);
>>>          }
>>>          return -EINVAL;
>>> @@ -1973,10 +2017,83 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>>>                           size_t size)
>>>   {
>>>          struct security_hook_list *hp;
>>> +       struct lsm_one_hooks *loh = current_cred()->security;
>>> +       bool found = false;
>>> +       char *s;
>>> +
>>> +       /*
>>> +        * End the passed name at a newline.
>>> +        */
>>> +       s = strnchr(value, size, '\n');
>>> +       if (s)
>>> +               *s = '\0';
>>> +
>>> +       if (!strcmp(name, "display")) {
>>> +               union security_list_options secid_to_secctx;
>>> +               union security_list_options secctx_to_secid;
>>> +               union security_list_options socket_getpeersec_stream;
>>> +
>>> +               if (size == 0 || size >= 100)
>>> +                       return -EINVAL;
>>> +
>>> +               secid_to_secctx.secid_to_secctx = NULL;
>>> +               hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
>>> +                                    list) {
>>> +                       if (size >= strlen(hp->lsm) &&
>>> +                           !strncmp(value, hp->lsm, size)) {
>>> +                               secid_to_secctx = hp->hook;
>>> +                               found = true;
>>> +                               break;
>>> +                       }
>>> +               }
>>> +               secctx_to_secid.secctx_to_secid = NULL;
>>> +               hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid,
>>> +                                    list) {
>>> +                       if (size >= strlen(hp->lsm) &&
>>> +                           !strncmp(value, hp->lsm, size)) {
>>> +                               secctx_to_secid = hp->hook;
>>> +                               found = true;
>>> +                               break;
>>> +                       }
>>> +               }
>>> +               socket_getpeersec_stream.socket_getpeersec_stream = NULL;
>>> +               hlist_for_each_entry(hp,
>>> +                               &security_hook_heads.socket_getpeersec_stream,
>>> +                                    list) {
>>> +                       if (size >= strlen(hp->lsm) &&
>>> +                           !strncmp(value, hp->lsm, size)) {
>>> +                               socket_getpeersec_stream = hp->hook;
>>> +                               found = true;
>>> +                               break;
>>> +                       }
>>> +               }
>>> +               if (!found)
>>> +                       return -EINVAL;
>>> +
>>> +               /*
>>> +                * The named lsm is active and supplies one or more
>>> +                * of the relevant hooks. Switch to it.
>>> +                */
>>> +               s = kmemdup(value, size + 1, GFP_KERNEL);
>>> +               if (s == NULL)
>>> +                       return -ENOMEM;
>>> +               s[size] = '\0';
>>> +
>>> +               if (loh->lsm)
>>> +                       kfree(loh->lsm);
>>> +               loh->lsm = s;
>>> +               loh->secid_to_secctx = secid_to_secctx;
>>> +               loh->secctx_to_secid = secctx_to_secid;
>>> +               loh->socket_getpeersec_stream = socket_getpeersec_stream;
>> You can't just write to the cred security blob like this; it is a
>> shared data structure, not per-task.
> To be clear, you either need to perform a new = prepare_creds(); /*
> modify new->security as desired */; commit_creds(new); sequence here,
> or use the task security blob instead of the cred security blob.  The
> latter seems more amenable to your needs.


You're right. The task blob makes more sense.

