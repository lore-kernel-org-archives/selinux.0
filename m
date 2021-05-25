Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A7C47086
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 22:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE226102A
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEYWrm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 May 2021 18:47:42 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:45664
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhEYWrm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 May 2021 18:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621982771; bh=cF3MeGw91dCmpfZc8xAjk+kdxDC3XKErhuhTshpbGlg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Cr7K6O83Y5qIQ1siQxYDG5eGU7nU9WX0mOzooYzvoyYIbsb9a0pb2EdhjZg5OlzJuGhp5+AOZr2wxMwyNVjXg6h671eCgU8G7dptvPmz5y1EmC+HsaSMNzn2iXBEaCQT81cVl8VvsAqC07ceqZzmUDvl1pcqch2vEK3p9x4z5Hgs7YfwXeKPg0S17ri8NqvVX3evzOnbZYzDf5hEU3bBe3dKrDiKXa6ud0LZUYW182dbqsuBEPFQKrcRfzyBLzpyS6pSj39dO/HNQnzpVNLNcLzvL5glSzeL0wjQ7PRuZyMh8i3/SCwB6ezjsy1mlgju2CBBIXAX5n/STX5zA8E0KA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621982771; bh=uZSmUbvEopMv5/N1pKDzldSjcbkhFaFmlDBWygzKe0u=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=q7eoWipKwDloGxZX3EcCVl0kRSNk78dsH3qaiJzaWZqGLB6x3tcaY6XQNF/SvsptuZfkog4FTqNVSp0YjKvRQNTq4qmRhWV61ZyDHQCRFbXMt1oGRA/NEZTjhY+uLs7R4rQQI8NaFEAUHnPsu2FHhR/lJLixh9SxHwyTaKNGFGXzG1pRptS49+LDGQ5tORTfGMtX/f3GF8hawVw1n1oo6BP6Ju/A+EIHFxJV816sLYcmJB6Wk8rw51mIWA4UAoMN1hlzJgq4GDd+0UhqFWmzb8HyUcclCeU6zp6OL1/vVtqz8lWVdf11U7sWaqDLVGgrNuJEEBjlnDfInHtnz63wAg==
X-YMail-OSG: QfL.c8EVM1kJH.TtE0fwoG2MWmsjA3dX7Ghn0iOAe0BoK9zVEWO8tp4Pmwcjo_Q
 V2EMVx7D.z.ouC9gj6.Xox88aReJpu6S2efikeFnK0lMTx8qLlsAobL7To0XqVd7qKk_7MrtJPTy
 bo5eZ3BJAPNYUXKs0O.4uhHqc8iTOzBWiVAsmT1hDt4w_ZArsIJDmTVyw2y6FiwAQfl.F4Vn.R0U
 EiwaFZ9YdrAAKM.WmRBJUOJBTRCFxqJTeH68c5vqAT3XcaPkvqNwfwAyN2bo4oqESc5qrwN7Mblh
 jUlmVQDP_924JqZPX6NRFzsMbZkbma11phk9cfCPsO8Ut8DCMFUhEC2JeqrjEe_Hn1gKCWScAIbv
 83Oe3rDqNW3r2rpxZiqanUcidQdqQBpI...54CcR8JHIHiTyZJQMZEC3k6dqSkjjEb.am41x58tt
 SjexDqdspYS5X0Er5rYyxoyiSY5Q4r6YgxoKKQAyyGrLT78Sy2_pExPKLvBOZcEAGPxfEpeMU_.Z
 RLkdAKINZIb5kWOYR1RMtKiNXfsxKSOjq19qAJxqq4GiMtX.fha1Urbg23tpJ.j5BzEjU2QZCDmi
 4bwdJVILxjyf37cWBrXgumdQSRAHGHHlXYUIFOrjdAof_eHGhyLWZSSH8PUmuAwLAEU4l09wdaCJ
 Zve_yM.UWLhFZx.FqXQG7ij2W91EuwadsQta.IQOzXNpPdb3k.sqyG_llQSFIa6TaYUyZUEzvYt_
 9GrlOUFsY.zyuN8XmJcLirU2yI.K760XVGlpIGsWVXeG4Wb.Kni5kjCsER75Ctfhn_xhbDwh1jSt
 eRuhJua5q1_1DT2BX7..vyuoLRzwMyd9aBC_rQBeKbf2ZayiXCw5HyCjdNCcIcG81a1S2ZGfGD_p
 TZU7xQHr1B4h_BlQjSJaM9vE7KoC8gpwgDGikdUtH9WHczjH4bs20XsKlqIF41bFrXK_IWHrHP93
 H9BnLWhb_rAaW8ElaMjqjAuH0WchHti0nBO4EFnCKm3cGwQ3SeiwvKdq_VqK_tkNz2OzDkh5584Q
 oIN88Hn8WPQZYzxuKrGTcpU1w79UCzGPnyUtBVtQkviihba2hW4ybRQ3vDLyTz_s7Xq1gkj8zf4c
 Wkfdlemt.6z01G1_XZlWW_pvzF.HvbVEuQSphhYqVHnyLe8MJ_z6ndmyyQSCucA3AfeR6CvddC1.
 Ng4quqkg16RYlXw7O.3krtzkuYZySblJ3P3dRNmbTA5561g1573BKPSs8md4sfK68lPJgi1WUpwj
 e29l1lQAuAwJvwTb5.e3IS5uNWidD.nJJu_q6pV0.K3xaoiGOwawZpH9gCbULBXELHPHE4yV2tPC
 XbR4zFY4TRYv0Y.6rJOYQSr9_9OmOaUhTnSU1CR9pddPvt_2lVPhe4lpW3q2SvyveayM.2qGR47O
 oWbgqeynedUp13LomzQ27tBWhaaZjeHIBVxEIrHNh2iI4H1yQPsdM3xEeOLVBrxBeLR7u5g2GMWN
 Mtyjen4x6XkHQLOPo6O1.hSPD78z3w6ieAXIbonYWy0snje..5I4FJQu5mpRhG9IcRTmyzFhoLGG
 iUFaopxRV2nQPWCtb6_xKDg.p1Buaabh.0IFeIJW1.WsaWq4wjn8Z.MGkAfAo0owJEjt_pFSWCss
 sfXbeQIApfQOyzL3JWUKcsDPxZ4CjvouISwJm9i8onvkQsaycPTgjN94QFRcJGJdMn_PrgVSCzXK
 _LDwG_UcI4XYwaMdLAPWBVpTcBVd13FzY2oGqW2bXeGrVyMMtKk9DgKZZaKQJKuIiY_8ty.aJGmH
 w0WcOpSDMaccAnPKUIzV8jNbMWnzqTw.uzn9BaeImQAW0i.4UJl3X6KMvOVBdm9rBG.tCPAlU27e
 4t.NAnfknEaXiTPl4EAxCYaGN62IFGYIx_A61rPkMjmWTZXvkcaOQGIugw57xAd.oF7Hr7ejfY3h
 v7DY4aHrE1TqxlFqAvRI6fNeDTXjCkQ52g0mUWI_bvr74HE3IrwK7u.iNG58Nvig0mcVPe09rrxW
 EhuU4_a41d22VINJVc7lklbKohhy0u.C7hvQQVf2tx6oWsdfSJSTwi7cfAJ.4dwUYMB1p1Yd637y
 AatLMrNqszYmYQU57T7g35Y.HNzi5oOETV3JN1p.bdvDZ1fQtUjhYvrwZtTVKS9NYHYUcKo2NOE7
 6hH0Nw8xoCCvqu8IRFUC8RBf58Ch4azilIAIL3ks_zsDK1Jq81QT6z_rhdEBavIxpE0iC_x1..P1
 8YXSOCaQb9GkIO_8zB3M246Ch_G2MpTgpPPgZxszWzbascyI4ThfvN3oYTfvkYCcSVj4_XmTSbYk
 _jZ1b3IAfIfRycM__4F4BbftwPK3WP60l9sPGBeLgL.h_T2FiM9.t2zs7q3vws.HO2YvZ9oEiPT4
 Khid6X7eM6V3dKhl0FPlo_w3.6DyY6ubrq1QdjuR9FK1c5PKomAbAxCX4Dsiev2Jrpl7IX7LeU6p
 CGk_3P0arOS.1h08X7B_tIkuxL.9a7c5JbDpdlNO_NqGYs3B8O46zaUizNJv22E_u7Q9qujgQUA7
 CNCU1Z7amLThTDE.YsfG.uLT3Bl0T0gpFQB3vmkRYdE6zreg2B0WZbgPV4HNWt5mktGDbbgdz2KV
 iSlWUngazgdVF09tfa5WMiyVCDx3GdNkDNr1qRnT_1C.iOMlyqA.4TrQERJOrgNybba387YEHYjZ
 N4rKvFHKvWY9rmmPECaYTynjeJW7W23883uSZadZdWSyZo3uVXUeNVInwPda1pdKRcDvAMlMvb5Q
 i9VReZptTmd3cA4mJY_HbLJSW8tAhDNvXFI0VhptA2dllPIYr1PAVavwZPJX6UUB6WqgdaAyKU7L
 31veNIFmlnXeqwxQ4xfIMUuz9hzJqzJhVTyeMAuNlmkEPOP4ACxg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 May 2021 22:46:11 +0000
Received: by kubenode559.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8cffc7d5c13c6b90ccd1362f190fee85;
          Tue, 25 May 2021 22:46:09 +0000 (UTC)
Subject: Re: [PATCH v26 22/25] Audit: Add new record for multiple process LSM
 attributes
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     john.johansen@canonical.com, selinux@vger.kernel.org,
        linux-audit@redhat.com, casey.schaufler@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-23-casey@schaufler-ca.com>
 <CAHC9VhSdFVuZvThMsqWT-L9wcHevA-0yAX+kxqXN0iMmqRc10g@mail.gmail.com>
 <39d6ac53-d965-de64-266f-d0fa3139e52f@schaufler-ca.com>
 <20210525182350.GG447005@madcap2.tricolour.ca>
 <6bf8050a-6dbd-1a2a-40c1-29fd3f64fd4d@schaufler-ca.com>
 <20210525200832.GI447005@madcap2.tricolour.ca>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a90a58be-5eb0-f447-a511-3f58e0326678@schaufler-ca.com>
Date:   Tue, 25 May 2021 15:46:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525200832.GI447005@madcap2.tricolour.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/25/2021 1:08 PM, Richard Guy Briggs wrote:
> On 2021-05-25 12:06, Casey Schaufler wrote:
>> On 5/25/2021 11:23 AM, Richard Guy Briggs wrote:
>>> On 2021-05-25 10:28, Casey Schaufler wrote:
>>>> On 5/21/2021 1:19 PM, Paul Moore wrote:
>>>>
>>>> <snip> and trim the CC list.
>>>>
>>>>> Okay, we've got a disconnect here regarding "audit contexts" and
>>>>> "local contexts", skip down below where I attempt to explain things=
 a
>>>>> little more but basically if there is a place that uses this patter=
n:
>>>>>
>>>>>   audit_log_start(audit_context(), ...);
>>>> This pattern isn't helpful. audit_context() returns NULL in about 1 =
of 4 calls.
>>> Ok, this rings a bell...  I think we talked about this on an earlier
>>> revision...
>>>
>>>> All of these callers of audit_context() get a NULL result some of th=
e time.
>>>>
>>>> getname_kernel
>>>> debugfs_create_dir
>>>> tracefs_create_file
>>>> vfs_fchown
>>>> do_settimeofday64
>>>> bprm_execve
>>>> ksys_mmap_pgoff
>>>> move_addr_to_kernel
>>>> __do_pipe_flags
>>>> __do_sys_capset
>>>> syscall_trace_enter
>>>> cap_bprm_creds_from_file
>>>> load_module
>>>> __x64_sys_fsetxattr
>>>> bpf_prog_load
>>>> audit_signal_info_syscall
>>>> sel_write_enforce
>>>> common_lsm_audit
>>>> audit_set_loginuid
>>>> __dev_set_promiscuity
>>>> ipcperms
>>>> devpts_pty_new
>>>>
>>>>> ... you don't need, or want, a "local context".  You might need a
>>>>> local context if you see the following pattern:
>>>>>
>>>>>   audit_log_start(NULL, ...);
>>>>>
>>>>> The "local context" idea is a hack and should be avoided whenever
>>>>> possible; if you have an existing audit context from a syscall, or
>>>>> something else, you *really* should use it ... or have a *really* g=
ood
>>>>> explanation as to why you can not.
>>>> Almost all audit events want to record the subject context by callin=
g
>>>> audit_log_task_context(). If multiple contexts need to be recorded
>>>> there has to be a separate record, which means there has to be an
>>>> audit context. The only case where an audit context is reliably avai=
lable
>>>> is in syscalls. Hence, a "local context" for many of the cases where=
 the
>>>> first argument to audit_log_start() would otherwise be NULL, either
>>>> explicitly or because audit_context() returns NULL.
>>> Ok, so in that case, I think I'd test audit_context() and if it is
>>> indeed NULL then create a local context, otherwise use the one that i=
s
>>> available.
>> audit_alloc_for_lsm() returns the value of audit_context() if it is
>> not NULL. Otherwise it checks to see if a separate record will
>> be required. If it is the value from audit_alloc_local() is returned.
>> Otherwise, it returns NULL.
>>
>>>   I should really go back and look carefully again at your
>>> code to see if it is in fact doing this, but unilaterally creating a
>>> local context if a context already exists is going to cause confusion=

>>> because there will be two events generated for one event.
>> Indeed. I had discovered that.
>>
>>> Is it possible these functions are not actually generating records if=

>>> the context is NULL?
>> There are definitely cases where records are generated when audit_cont=
ext()
>> is NULL.
>>
>>> I'd be digging to find out why the context is NULL in these cases and=
 if
>>> any record is even being produced in those cases?
>> Context is NULL because they're not coming out of syscalls.
> Where are they coming from then?  I'm guessing that they are in fact
> coming from syscalls, but that it wasn't a syscall rule that triggered
> the need to record the event.

audit_receive_msg() is one place. If you look at my patch you'll
see others, I only put audit_alloc_for_lsm() calls in where they were
needed. There are plenty of places.

>
>>>   Perhaps there is an
>>> active filter that indicates that logging is not of interest for that=

>>> process/task/file/syscall/perm/etc...
>>>
>>>> Is there some other way to synchronize the "timestamp" without use o=
f
>>>> an audit context? My understanding is that this is the primary purpo=
se
>>>> of the audit context.=20
>>> What has been done is to call it with a NULL context and it would ass=
ign
>>> a timestamp and serial number, but those are all single records that
>>> don't need synchronization (obviously).  This was why I'd come up wit=
h
>>> this mechanism to solve the need to attach a contid record to a singl=
e
>>> record associated with a network event (or user record that should no=
t
>>> be associated with a syscall).  Those were the only two use cases I h=
ad
>>> up until now.
>> Right. Adding the contid record is a special case. Adding the lsmconte=
xt
>> record is the common case. Thus Paul's lament.
> Yeah, this is a similar sort of accompanying record that needs to be
> tied into an event which is why I had suggested the similarity behind
> your local context generation patch and the one in the contid patchset.=


Just so. I think the $2 point is that the audit system seems oriented
to have multiple records per event be unusual. I need to make it normal.


>
>>> - RGB
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
>

