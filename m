Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8C3C2B9F8
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B3761378
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEYTHo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 May 2021 15:07:44 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42122
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbhEYTHo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 May 2021 15:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621969573; bh=qx1wdAU034eq26AjX+I9fWsGqxt1FtXZaudB8bKNICM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=mXYEZYtsoZZkopznfO5By5eKqIbNd44rP5RXtNXc+2QdaBUC/LHPDq5ZXwLdW+quvIEX4ISKGS9jDBWWnYzRVVMH4+tonssfv48nJHBqCtdg3wFODgvrDHrmBC/caJgldEn3Wq1e+FOMaO5KLL6eAy9XEcdvasMBGru6zx39aIvbs7fck7OWAxR0vrsfsKX+c/JDVUTRAg0BjpBawpgliyEr/wWtYG2Lwmd1iHQPzv0G66gL+tO0S7o9DRfUogQIxXhuIGPxtIlWil4Zj17xxPGbLYUnlYS5ZQ3FQ+F8lhxqUEGv7IldOwnTDdVCH6S/crFSyTpKVQZkN5poG9czWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621969573; bh=3MgK4nc6CEr/CBb1kmgcYdwLdRDVkppfO+gX1cLIswT=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=tCon1i/nmKe/xk3oGuvBfTO9g+KdmIKnqhjRhtbAK9yxXHjgTLyQDS2hb/g+GHDWHNJluDkNzk/b6QIUcNC4CBU5oa9RIixJKUPKQIgJHy5UiyWMhy5UpknDbuZMCHtIC0uIVtFbzB19Qncmhph16HPKZjLxVwlPHCM9lek0JnlXsloLBr8dqJ4Xl6SZiTreNYD6lNvxM/D78fddqn1IUS7HX7CGpAyLCojZ6+nPdsRSkQlxQ7ZBMlvNNsBKvYPnJIkjHpSw7McyoEbQ0gMmyJNxfSCGVWReZ3CckTQ3RSVa163hEVzaodNyg+1ptoAsxn63/gCspzQwPrp88t2HWg==
X-YMail-OSG: 3uJtIA4VM1lTRuFjRfOjgl7W9m4GhDVBGGj1C7D9A2Y3hcpJ642tyEynWP7Q36K
 kc1RPo0ZoLjPi9h.bLcmorzTHctJd2P1ugmuDK8W_8NL.pvYPHtq32fmlfufWGtlCxJnVv1wsPhg
 odvuaI3PDFHMakfgdszLPlkKKhv6BdULQTxth8O1EsmJb5e7iBdzJELkNLAef56b6RRH2iatVl6s
 .2kAc4GwqaLrZfSPPtXEy5snkWL04xRSl5F1xT1ZoJ7l6i8v3GonP2tYZS.aFAFz5bCfq00D0wGG
 mMil_bdhnyb.nXDJqGZndurmsUA.c7L5eRegxsDpJMTQlBwwXS6tV8PpjSKe5e62vQuFoxGVfAPO
 DEZcUw84jJfJCTEgO1K9TbCDQPmQw4j4dJv_Fh3qWyio7FJk_WLdybZwqOp7oPIOuKS.vzIusqqW
 iUJRK5Che8Auh0SOOfevhLS2L31529KCsojn03AE0M2j6ITxPePA_2fNMnqEtb_OE3FF3oF.6myK
 dX9dJwGNuyIxaPxfWHvnGc.MnKIDub0FjdU3co7LDKmecOsFjmSRbR1IQ6ZhtOxByUHHsOzb8FhD
 rNnyGBGn0aAlgYMdQrjS1LavPQ_8LB09qPVmXfonwkZ2.LAs.bRBUO_z9K3bFptsq5x1AFq4OrO9
 SPqCoQy8plxYe0TQVn_JRYTnpEJUk8ylWSVJ0VjgulHXFz6NCgv_yVGY7PemOFUvPBfNLDOyv3QJ
 LhAfcIKnGkw7vBQJiI5Dk_MdqONwir2X_UNZtBTAXcMgEXa1FOyJ3lSiZ9G4zj2jsDJgs1cBojMY
 sYzmv.26BtaItQdz8f6Bca29c_7rPdecxHWrr4wLuVjWcQpSwvscQfz955CiWSLajsx7IQhoziJd
 S2ZHo9u5usfcFAjTCLV9tzzqw3w3U1l2DZeide5ODxOgF9YFKwM4RS2drbZybOMrjBAIq8SkBgXj
 B3SL.WydkEcNCHDLTvfaKLvZcAji5bXupUCkQogoeS9dZWWSvetjJGZfGwptABY7lJJZLQaj0.qB
 fcZnBblP06VFRg2gc2nEWvSo5FPQhoPaJVxGIoH_G02zmzs2hXF8l.Cf7frheB7h94ymbXLiNBHK
 5nFE0A9OIs4tOww3DKM._J6ld863AjzcEf9YkFWrcuWnee_jpusDpqmBb9qTNw8Ax_AyEDNLp7aH
 DNRRs5dD9Y4UnQiRn3XonCsuhGrBqsDg6tLCDLVYvDtgpbboZpE7lTqwIyG6jvRFtM51Rzv3WlZq
 qJkYizyxEI65dUuuhXR8JJwVrQnTRHp9gNfxdjLtuYBGSHVwMzD5fIF81ddOVpMp80dwWXV0NYo3
 iCvXmoOLw_32km9Fh3E9zA3uJtUd3dShRQwOJ3Q_Vs5I5AOVd4Cae1e.GvCTOYrGbf80Z8Tuuada
 8cBobKHFGF_1uvUqfn3UXytBVqbOlexO4jLFjTa31JFf7.koqFkBseF2y0M0tCmOMWHdGm8RScRj
 u0BZ6YCQfMH43I1SvxdhDRJk0G779FrOep6yu.27iMu62qk_C64IhPPicyEI.6Dph8bFCx4WGDtg
 2DtD4yEzhB5vbQ4zaQ02D29BOQ1AC9VxG24M9xG0i.eNezZ4VQ79ewMaaLEO1niRO5yqdVhwKCvd
 sPyO7RiywNKHMc7ZBJD9mK_qW27zBqhWeEWw0jyWv2tjZjhj7ICTBLmDFHvBvp6RGp9ST0UmmXyx
 v.lDfKpREJbICPo6MWjoBtMxPe0wXHGYi_XCeML2latWcVXJ6LWXLYtfxV0vFZ7hzqMYWBFogeue
 hOqqf0eLzm2kVKnXKYxedmJA7wxVfpI7dxr80lYma0kWslEU9r2hWwLRTViiRB4rD8pqNhjlyCQU
 Hkj70StJRCGD1R8_g2433iYv.dAlCrqY3OfqTIH8Xk8nM7a_EXkm0WxU.rNq.prUj1_ly5KGVkoQ
 vQ7RoVvHVAKpred3rU4auX9KjXilCey_v_JZN.joxHnFp6UzWC8md.B6TckzN9ZKqHxQQR4sWox0
 SuP38Lt4AkxZg3KqyjMJzM9b4Y1QW9dO7LzYXhxMeIYIQ0v7TrIUMuiXHe8pUOKKaY0y2OhvBR8g
 YDiebEcKqU8sePNZ71QJ7V0HBr18WVLzzee3bih1L5ELqe2wBE_9aMHAhRonBpCLB3MxCvc0ZyKn
 KuK5l7TnUVk3GUCjHnpufFTMVKReUnb12WKFoVI7Ln2FTSYZUFJHorqddq9WGy0hbIKbw_983vg_
 TtcZbr9cLqElXcWLsOTdmqqnCxc.HyBQVFalGO5Jc5EM9nMNzu0g95DMNTUzTQKdMm8zBf.YLMn6
 Wa8s6YWGcv9E6cvJBhh4HG1O6pix.tpNhyafHRddDUziqMtuPI6EHtJN4yAFa_6xPJquXyJtN9jG
 t7uRNL8VfGhp5709invYdOgo6IvXeI7L0bve8ws11tW.yU2p_cuZi5R02FHtd7rhwSgvqb86EJx3
 DvPGZSpkTjfZF1IvV1UIWYSVdqHfUV6jg05M9bZCNW3FSxgPl_T6zoKXUo9t.owI1wkXXitXvHDU
 e5mdPDKaRjziHWuFrNzd9cK1lJg6jX0RSjpOlX493cbs4vLJw9h9FnEuI8TIWcLjC.qXsLlATlEP
 DM0vHyVAaNagABWFzktOe1qhPwcs2UkaptgOyleh6LxTu7BjlYhSTNlIoTuexbTpPnxhS0bRpUjR
 UuWLXCvzS87LWsjwl2iqBdp38jDSlirb8wm9KSL2RI5ol.e80iYSEffxVskgSTmEMwDXckdtozB7
 bHUVQyUimR8NIKcZ80MqAV2C1o4fhzKOh8hIrxx8gdd76IegAnzdB_hWELvcBBML6bGsWAy7XVPg
 EuROVX5aJGPOtVzDYx78flnNl7MwG3Ly6PVJBM0Y5AoH9S81usy.aoQBalDVNSl.iJURoEN6pjpl
 .Q_Z5t4zwVvuq3eAIUye2cVGLfe7qAdCXM.RyCLHP9Ge4rw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 May 2021 19:06:13 +0000
Received: by kubenode563.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5aba19526700cdf3bcc5064657a3d778;
          Tue, 25 May 2021 19:06:08 +0000 (UTC)
Subject: Re: [PATCH v26 22/25] Audit: Add new record for multiple process LSM
 attributes
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, john.johansen@canonical.com,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        casey.schaufler@intel.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-23-casey@schaufler-ca.com>
 <CAHC9VhSdFVuZvThMsqWT-L9wcHevA-0yAX+kxqXN0iMmqRc10g@mail.gmail.com>
 <39d6ac53-d965-de64-266f-d0fa3139e52f@schaufler-ca.com>
 <20210525182350.GG447005@madcap2.tricolour.ca>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6bf8050a-6dbd-1a2a-40c1-29fd3f64fd4d@schaufler-ca.com>
Date:   Tue, 25 May 2021 12:06:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525182350.GG447005@madcap2.tricolour.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/25/2021 11:23 AM, Richard Guy Briggs wrote:
> On 2021-05-25 10:28, Casey Schaufler wrote:
>> On 5/21/2021 1:19 PM, Paul Moore wrote:
>>
>> <snip> and trim the CC list.
>>
>>> Okay, we've got a disconnect here regarding "audit contexts" and
>>> "local contexts", skip down below where I attempt to explain things a=

>>> little more but basically if there is a place that uses this pattern:=

>>>
>>>   audit_log_start(audit_context(), ...);
>> This pattern isn't helpful. audit_context() returns NULL in about 1 of=
 4 calls.
> Ok, this rings a bell...  I think we talked about this on an earlier
> revision...
>
>> All of these callers of audit_context() get a NULL result some of the =
time.
>>
>> getname_kernel
>> debugfs_create_dir
>> tracefs_create_file
>> vfs_fchown
>> do_settimeofday64
>> bprm_execve
>> ksys_mmap_pgoff
>> move_addr_to_kernel
>> __do_pipe_flags
>> __do_sys_capset
>> syscall_trace_enter
>> cap_bprm_creds_from_file
>> load_module
>> __x64_sys_fsetxattr
>> bpf_prog_load
>> audit_signal_info_syscall
>> sel_write_enforce
>> common_lsm_audit
>> audit_set_loginuid
>> __dev_set_promiscuity
>> ipcperms
>> devpts_pty_new
>>
>>> ... you don't need, or want, a "local context".  You might need a
>>> local context if you see the following pattern:
>>>
>>>   audit_log_start(NULL, ...);
>>>
>>> The "local context" idea is a hack and should be avoided whenever
>>> possible; if you have an existing audit context from a syscall, or
>>> something else, you *really* should use it ... or have a *really* goo=
d
>>> explanation as to why you can not.
>> Almost all audit events want to record the subject context by calling
>> audit_log_task_context(). If multiple contexts need to be recorded
>> there has to be a separate record, which means there has to be an
>> audit context. The only case where an audit context is reliably availa=
ble
>> is in syscalls. Hence, a "local context" for many of the cases where t=
he
>> first argument to audit_log_start() would otherwise be NULL, either
>> explicitly or because audit_context() returns NULL.
> Ok, so in that case, I think I'd test audit_context() and if it is
> indeed NULL then create a local context, otherwise use the one that is
> available.

audit_alloc_for_lsm() returns the value of audit_context() if it is
not NULL. Otherwise it checks to see if a separate record will
be required. If it is the value from audit_alloc_local() is returned.
Otherwise, it returns NULL.

>   I should really go back and look carefully again at your
> code to see if it is in fact doing this, but unilaterally creating a
> local context if a context already exists is going to cause confusion
> because there will be two events generated for one event.

Indeed. I had discovered that.

> Is it possible these functions are not actually generating records if
> the context is NULL?

There are definitely cases where records are generated when audit_context=
()
is NULL.

> I'd be digging to find out why the context is NULL in these cases and i=
f
> any record is even being produced in those cases?

Context is NULL because they're not coming out of syscalls.

>   Perhaps there is an
> active filter that indicates that logging is not of interest for that
> process/task/file/syscall/perm/etc...
>
>> Is there some other way to synchronize the "timestamp" without use of
>> an audit context? My understanding is that this is the primary purpose=

>> of the audit context.=20
> What has been done is to call it with a NULL context and it would assig=
n
> a timestamp and serial number, but those are all single records that
> don't need synchronization (obviously).  This was why I'd come up with
> this mechanism to solve the need to attach a contid record to a single
> record associated with a network event (or user record that should not
> be associated with a syscall).  Those were the only two use cases I had=

> up until now.

Right. Adding the contid record is a special case. Adding the lsmcontext
record is the common case. Thus Paul's lament.

>
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
>

