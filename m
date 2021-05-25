Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDDC2B9F8
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA412610CE
	for <selinux@archiver.kernel.org>; Tue, 25 May 2021 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhEYRaN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 May 2021 13:30:13 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:41313
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbhEYRaM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 May 2021 13:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621963722; bh=w+ih7iZBs5mWwJphr0pCb91WOhsr5r4rER+BI0OoBuQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=uUW51KaH8nisDuFOftLOqPvG2sgQATwuNL/8X5dRFryJ1cnScDNXEI1MctxxKYyk2m5hzUZRGqOCt36yXzgE5RtykTK5FlpoOljSL6ZjjpGPOAYL0GR1z5MT2d5VPItiY1mfGC7aFye4tq4wXZh6x+tinm4h9CAlxDUaOZgswMq6TKZgi+DyroiuIgpgMg0Xb8NXPwfHgLssjGvEAWRbF6KVOIsv/IN0bNfRwh4Iu59XHQ2MfuRKugyWpEpbeOumAwHi+wqOwFhtc0fxJ/AuUOzdn/MWrDARst6rak11eqx0KMvjMghm7L3yR22rKk84v3WUsWTBQszfq0+BgylQew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1621963722; bh=SxHc+ZYtJVt7UalZS4TySyD51PDdjp/60BMyBReYi91=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=k1PqZGDgXLkISsY2tuh/rSn95PN1vOIKFJNUCTxTjcvJbHZiXvkBEEOx2IWNWf5SVchzwVYJsdNX69UvHVjKW/0eScmk7V5Ikllpd1HdugV7nZCkmVOqNkb+XgEwa5UiiSqP/sDxRf2jUE/h77mMYCRM2kNgwekxcWdqw949/TMBfEgSrua5W+n5ft+tYFBm1QrfrmXA8+H3LRuBwmdErqcGmiUY+FirMZ5elE2E4mplnbRaTVcSmmiA2P4/fzjVkvSGbDL0aJ9LUI+uG31G46a8oZl+Qc0azqbvIpxt6pHmDxtZR3LNs1PlyqQh53kR1ex+LnkfQzRwvr7QOOr27w==
X-YMail-OSG: VTTcTdAVM1k4nIelR7vc.NHiFJJKQgLcWQNwD5V5XO9Dxheb3VfZLO2EXFTxH4A
 i.YQ0wXok8wNvujBzetGcVhbQCisSfkvu5Zj8UU5.RXmPCN.3UC9lU9W1EmhdnAG5rqKgI.1MNmj
 9HWbJfkzHvrOdYbd21mJWVbheO90upqAMffFgKsZm0Vi5VYIbFjUp4cWaCbOwJJ1HJQWwYyIl4Ms
 iQpHiHjDnjH14p7cvGNkx5rD6H3nipmtV.vSHQahJ3jLUqSiYaZnvk7jeEoA1I__BBGj8rvDJsnZ
 NKANWA8GBcq3A.JRmyO7rW0I.sgzaBNNngtN2mr8qb5oq6KJnI.uHnp6po7McIhvkAyQGKS5OAUD
 N_.GpujRDwB2YriJhK7tLMf1htnz2xoZoDh_m_Cw_9.3zquUHgZcKlyHDpxpDNZkX9tZY2Yhsp_S
 yoOwsz5TsvvsaKEiswUecK7iSitj3peYz7YeDBku3MLKIJ6Mfkg9oQHOBNd9WWENpLHGJcMSwTSa
 gfng4nBPRZse7iHwUO6q2XEhFGmFfRzFv_6pTIdlGn3HLKrtM5ymS6IeEmay2hdDGU4BiQqPcGKk
 IFSgOnEXhLaEmI.drbjgX0StIOGWEaCLNfEds3b3FznoLmLnkgALfabs_LEd66IXDQ9R5y98OqZ3
 WyWpP4lIGMg9wro_RFlIR7GtB5QaHf9f3ua2HqC2Newk90So.VhInSR6FQ5LKib.blqAToNIl1X5
 __P1mcJTgywT.vD3sutQgY4686b4mnYlMtCCrjWwIpKcOdbSKV9G8NbZnJv.PTAe6jdvAYocagz8
 mYXasngCELCtywTzX.Z7ZtJXL4GSDlyOtNFIqSj6LxSVfVOxtBVIsaPbu76Bt3q6Rl5Q6NtYXerU
 9hilxWn.P1nqy099XcQWIcg_QWmqaGUdB4speGDB0WM7YTcSqRuQdhqYCO8GLAaVj4IzwRgY0pLN
 6nivLaFIfvqG34nBnrfrULTGGmHkReXLfNRNZB7y6T9Mt5eOgQasp14lxLSVewYIgKLXk9OAholT
 NpPZH_FgdVOHJ4j5ltMzmsFF4EbEtISn.V3rv5RXR5YaplJjh0L0jIHK8kds.PuRoIEJzkcyaMxE
 wR.bvCQcmkzOfJpQjuqCc0hwhg59jjeuoXEugST1zS2T2k2MxgAHwmoRAtG91J3n5V9GvIXHNucG
 wIoFvqEKQTbfrvNG3XNHzlZ8qfYQsvr_LoyLffsrKYFYeLj_StQyYz6IKFLulTCP9PMY.57PkdGc
 uoxodDFPbCwCJKBSEYA3wEHnCwocIze2jianoks_himUb_kWlmAWO73z9hn_LpasmBTf.CUJesaE
 gKcskSxmh0qskmN6SoKZkjDqLVyclHuxgIL_RyfVJnRI1CdN8rZUISQet_PZpUM4SpEAB3R5u2QI
 x8WXC4DxuUKX7aeBE3KTz.0UJfuWeV9J6iHegrMiYKj8Vu4.g4NjVI92dmBv_Xmc.P3nJ.khJouF
 V4giNve7w6vdRPemqGpnaKr_dzQEipVQFCzJX2TRIZ56P7y3CvDuo0zRt_chtZ52fVVmFC7Jwt42
 hRHstjNni40ROL7GqEByernEyjSwWhZAm4SoH7KqGOaLWSSQni5YRrThwghU3M9InRJ7Ly8qWrd9
 QC.ZbOllYyWs.KGLarNUfIICOwjMpQZb414vGNbJaSAwFvZwPjUYBvXCAmO_r5rRZssrv5Q.F_oy
 sV8FvivamaivAHKrzEBK29UehTYF0UadcnagNqt0M08CMx8bdoEZjQIN8GsThmt0332bg86p8hDD
 UX6nJ8povjHPu.xQDKldmeXZITTVsUWgUfJkSSSB9QI_bmMiLP7XhcsYZCTk1OnejI2NKFObl_ca
 ZkPk.LBbTrT7kbePmDp2jvvvNsqjSpBtF5hvUz8Q.C9B8cF4wxc4dMGDu4jPob2KyXmjTcJMU875
 TsjAovmGiCfgexvKVqEQ4YBsVk.kuzjX.uz3CcDS3JTpZ1FtPBcmBgecJxtU2YK62VlfV2L9cFrD
 3edY0JWYPuKfyMxsaOIfA1woxHOroRuIhKnCiNrPb8THRAkODxqD5TVJBK2yvv94NmCQQeFSYPc.
 PwKl_94ZXmnvnxdOIy4jWpHYRKMrZLmQNBpEw7FvJ44SdOlOV39ciQmQI3k8Mm9tKxL2B6JcSpLe
 GoDdK.L.ZKH.44yFOOOjS84lm1LnDxCK0rneV0ZoW_qMXuzLrfkFzY3ewG6yY03DDSP9VZ6rV4Ut
 CG06S6z8dXjrio6F4S8YaBb5H3kX3GaCecOJg44Hs4_Ynbpm7qkkVPXgUu5WWGIkbm_hY8ZJXtsk
 2mwiPRCo98nnI2RChxgxdsDMz5ggVga8FTcmQD5WU8Dzw3mdrOKvIxom2Oe2V6EkP4gSvRr1IvZy
 S_AMMQFdIEQ.sRF9L8m3C_VU3jP0wTftwZC3dW.mGMhTYsNSGszMkjqq4llu5A5I2srOk1g0qQe.
 NhwkQV1yGwevjgRw9j.2QAXHAC8ArPk8E7bIKFeRNrNy3_gmeq9Ue4mKIlq5EbrlGVm5MtMUS0zR
 OVL6M466OOc1yfGHboMYGQcebG5IWKbMOw12gOB7mEDWxo_boTB9Y4EDVLj1xg8Qg4qHFX.kv4R8
 ydgftkjcIXCCTHz8PMuKxccmYj4vpkjJ719fCYfv5ZPP2zX4umZjcT56fmFayDsjdsjA_NNpYUgI
 Aq8QrSWUDAoedD96rm69R8qLUhzh7iZC4NexliSWiYNsDi9XAX52oPiYlNtfW4EJ28KUXVRRSbs7
 2CandStS6chgOxRZqEUUBdsdhnXpSml.eXYsxO2R5umq0Ldd_bpEqNvRVvkntp4LCGMgK2gD_Q3p
 gjnoKoTID2s5Qr7bTurbuMPXt_qoQ0jbKJUZyutaSflBmNpoAcDobgm2uHddx4mrG9FxCWpbcGl1
 Tci30Gj_E4btexCOTLNE0hiXdU46wpsj.WuH59mOU9SQOvEQaYB3cPNuEjE_qSd5P8kol5uA04Q.
 _qSlqag6VPpm3c6p3mCDsmHstSKh0gKo8W4eEQTybgc0E_TJJ4t2UvvCX2kocWA9rrELWlSM14nn
 X6Pn2G3dTHsQCVftBTncZKpLdF16iM9W1dKuosg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 May 2021 17:28:42 +0000
Received: by kubenode559.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 97ed44420ef618bd42957cc86f7c5aef;
          Tue, 25 May 2021 17:28:38 +0000 (UTC)
Subject: Re: [PATCH v26 22/25] Audit: Add new record for multiple process LSM
 attributes
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-23-casey@schaufler-ca.com>
 <CAHC9VhSdFVuZvThMsqWT-L9wcHevA-0yAX+kxqXN0iMmqRc10g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <39d6ac53-d965-de64-266f-d0fa3139e52f@schaufler-ca.com>
Date:   Tue, 25 May 2021 10:28:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSdFVuZvThMsqWT-L9wcHevA-0yAX+kxqXN0iMmqRc10g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/21/2021 1:19 PM, Paul Moore wrote:

<snip> and trim the CC list.

> Okay, we've got a disconnect here regarding "audit contexts" and
> "local contexts", skip down below where I attempt to explain things a
> little more but basically if there is a place that uses this pattern:
>
>   audit_log_start(audit_context(), ...);

This pattern isn't helpful. audit_context() returns NULL in about 1 of 4 =
calls.
All of these callers of audit_context() get a NULL result some of the tim=
e.

getname_kernel
debugfs_create_dir
tracefs_create_file
vfs_fchown
do_settimeofday64
bprm_execve
ksys_mmap_pgoff
move_addr_to_kernel
__do_pipe_flags
__do_sys_capset
syscall_trace_enter
cap_bprm_creds_from_file
load_module
__x64_sys_fsetxattr
bpf_prog_load
audit_signal_info_syscall
sel_write_enforce
common_lsm_audit
audit_set_loginuid
__dev_set_promiscuity
ipcperms
devpts_pty_new

> ... you don't need, or want, a "local context".  You might need a
> local context if you see the following pattern:
>
>   audit_log_start(NULL, ...);
>
> The "local context" idea is a hack and should be avoided whenever
> possible; if you have an existing audit context from a syscall, or
> something else, you *really* should use it ... or have a *really* good
> explanation as to why you can not.

Almost all audit events want to record the subject context by calling
audit_log_task_context(). If multiple contexts need to be recorded
there has to be a separate record, which means there has to be an
audit context. The only case where an audit context is reliably available=

is in syscalls. Hence, a "local context" for many of the cases where the
first argument to audit_log_start() would otherwise be NULL, either
explicitly or because audit_context() returns NULL.

Is there some other way to synchronize the "timestamp" without use of
an audit context? My understanding is that this is the primary purpose
of the audit context.=20


