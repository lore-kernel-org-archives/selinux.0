Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DA1C10F0E
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB362068D
	for <selinux@archiver.kernel.org>; Wed, 27 Jan 2021 00:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404616AbhA0Ax3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 19:53:29 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:45603
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395037AbhAZS7B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 13:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611687493; bh=kX8MhTLSLqWaybog46em+I2fGY6S98kXDDJnONF4/Ow=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=hB5IiROf/6oo6bRQHXmkKdVNCyyNP13EkIOHEzzQw0fZjTrPKOYIbGIt7IFYPxNgwErdq23M3nBMqvtd6l+A5/55SA5tPfqQYngO/H7RnD12qiYMuVzd5lIgJe0wfggtrauKD2BV7CL0j70XnNhzUafZtqYm3mAe7jE+IPXc7QBRmgElNGjLlb7tOJXMzIAaWIX71BFbLikBYKJqT4YOciK2KnMJEuOjganBMIglmMZxOHIuNsbirpOvgNYAMXCd6yDpmQRx3WRPOOFtIPtt3qrdy77k6MEmMPYag0JS3ChBO0uU2rmpKcrUI7rwdF+aJRaA4um6SRpYxmYZf7My0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611687493; bh=Orev5EAT6w/J3/85Z3/7AfZ/D21lHL92m6TVz7GRDH9=; h=Subject:To:From:Date:From:Subject:Reply-To; b=t3zXFkCAzr4Jm7L1fbwmqaXP6nr+u+LShzf7sK/4njF7+LmVjlG1Fqt6n7uCJRchz2JTdRw3tGaJgbxdDRsUokTKhhAT5/OH/RA1uAMK87qXuEbXzFhnyPlNDs+4sYiLGwzPphadaimYeAJQKwq82PCo6SyFNmQbmWBwxqG725fAm/Coq7nBqV6w/SjwSyn9LNzlJs8P6Dk8VE8y5jAEN6rySCHJR0LcmV+gAeESWcSueLPRLo/DgVnn8bVQ2zp35CwYsRcmKHL6PENOl+2M1u5ZoqvXIfTmHWUxwfjj+tYeCQ7Dly8DNR9s5VnpFY68Su+KP/kJ/5L1LYVQSM+QAw==
X-YMail-OSG: 9CQPUtgVM1lBFwLgCMWeCV_rkyfX7dJoWgtr6pJGFtCtfFfXlhumLp1D31EGlRE
 0MmdOGdvbUFI0MsQI8suhRUl7yw5Rup3DFau47BelsgzCawoavo9cTHeyC17c9btaL0RakIrXp0m
 laPp8r1O_dB7x9S9Vdl..sIfvZhk33QbBHvOuk7vydJJBYyJa0cuAPuAuSgfSoKavOAol1D4npK2
 bCKqFgbyEofg_ez_S6pvQ4FgEJ9L4v2ZjJC1T7a2DT50VxnhHcMvCDvNmT0zZHnNxRsTeeHlW5j7
 nj7Dkb_iPjukSyraIdVHb3ZlLNZCvefVioU0ouCJc0QHfatnOCDRx7.RfjYY9HIcrp0y06GL8EVs
 cqSvFHpmJycZf6F727jGKee2HIA76mgQqfBDNXqIhC6YU0YBhf.h656cTxWK7XICDbvdsNficQl7
 LuJAP.doymJ1VZvB57rzk3yjZoDrpGENig.UJeugQyBJpAU8iZl.Diej7XPv1hCkH1m8LYhu.s9Y
 lAAnCTrHgLSTbe2r22D_RIoBxp3.SSE4_AN7ZVxQaYDVSD33uOACfyvxaPhVXU.GxtfNqGn9s7Fo
 4TQn_HpQVWPr0odjHrA2LKLkOK.FUPD6Y03Fj03X4Pzlmq7sShNQLwczsMWgaI0_BKPvRVqOFXzo
 72wC7BQxyCc_E30WmPBke2_IgNeFpIRDpNtkrH6ph_YdUjD3Zsd7k08K1JIgQSwdiMLG8AUM5.NC
 5amhii3_DnGzqOZRTUzgSMFTtMidEfT_w6vb7gkkWt94w2BsjN677MMJuUGGfgWGepaylhkIfRds
 vtVeN2fcAAWtC3HLghaMj9z.cP7oZKv52azsCzlcOhI4VCysPHVZJYMtQiRI8DKw5ZLdlUkb0FPF
 9c.FfqDUxJWFSRT.JGG0EyYFQP.8oxUEETPD5TqziV0WNdaJDMtton5H.KMRZ.5FJLc2V.jZeSDN
 U39wTXd9iEDlVpTdN6ZSs5dPNu0dIirDgP2ISH5sJ9fWKdy8SAyv261nW1yuclF47UaqRMF215nc
 01Ps.HIsMo1BeuCuBkimKFmOiN4tHp5inrthYW2cRKJFIDfg.OdKu0AYpnaAHUBf0genGe4Bmi5T
 R4fuFsltkvC6puj5DZC7Mvj6Mg6SvdcMBiSrp7_XtL1VQq.2WuBXvlJc7GN_vScSO95K3vHyUhKk
 .TG7mWsNaCJPgM2IOIcYCvKmOZd3ElggtAjrHkEvE6ymugtyHliDcpObfkUun4OvGiroW7uMF0Jc
 DkKlYF0mfRfaFnHIwjpVc030RjUa7i8qIVE3p.PHbOIOO9wLeCcKZVCayT7eCRfskkhkCjhp.VwS
 vqFO8enyAETEQpqQNqQEcAiMMxzB2io38V.bV8x7oyRUy9eYBtA5JAezGJCizO4uEfptn0MTMZLe
 blXE9MNnc_h4ucvSAANNQWqV4SlBf.hsQ1ODkQ46SqiKHdFAIEseXcJoj2EM5rwKjEjx2Y9X9uha
 iO6TJkcDfMijSHNgt7hJ7of6MYmG8UeB9c.6dQ7FujFXdNQWesBztfR95VsIu_uSA7JpagiqKeJr
 eveq6LjU4QuKKsbC6awV4gL00ZxXSrcO0zZcR3Moun74cSgk8h_vaDynZOwmY6K0JvTo3oi9Bs0U
 Cwsc7fF8NnJc0hfuu57XFVbOtInnpV7auwzNMderpgCWXX8DUbvHEchAs2hxSpY53jMN9jG8aXPq
 Y8hMoJLus5p06AXZB7wWwKsumRU7TDutCNrhOkGX9PUgb9tT2wZOa1Ap52mDqykDAbX1N0sCm6NA
 o3f5SPWSq9usqnbiFbTyXNvocjvajt8_vNw.9AGqYqYJNj6a7HSCc3oz7i4jbiW2afdV608gtfo5
 3oJivJnWQkrBk1WKULBxUryyDJB8Bth_tgE2jOcqCrYsqS_xSSU6XVIGqhgFm243Q3Y.xRZovitO
 OZcmJtvuNYaBahum2Xgp2LRBI1geBvaNoOltEkFzCOFMCuvrtM2rixI.XdLuOepo5fp6C023MPKI
 BNofMNWTMeH4cxKLtcZtFTAp.crwOihiBvf_BQdPL2SJH5oTGOylqGVFKP2bthu4SixvOE9euk8L
 FeaKciHypYYEJnP6ONoOg0sForBAFEsLUZXbZKM7vt54_9aXj_1vJE11ilTci6_Hl_y4Vfq65i9E
 Mzm6NAysDMwn98J_QaxPLqgI45NjxOhzyeafa6ueF5Ui8twwzN1iRxsLvk9KYCmczJ2DAe7q1ruL
 qMg.AjK2Get3M4X0_80w.s3IMbjix89sPZULVJ4bdMr0TywSufQ5n6XQXApDiS3hOWf5oEnHiVc5
 U8B4Pda5Iol2uRwdXAPIR04o4FPMVdkhas8rSgUk47HEL7evIi0l.u0zJylnp0A2P3jw4ZosT6jp
 mJ82QXBllhhK863bSvErPJC90VdzITi6URmczYn1o5y11o0TRxb4KZitB5guTgvuXLkfJFW_CdeT
 ruaN35x6gJovel.GmLL2UWU1KiXwQrMmc9.Nd1r_fMUhllgdqMByDdQh_t1ccC0IuzuywLSNstx8
 ZnmCIzThWIxLoVbSyYLFc6SDIi.LtGV.RCT8a7dymd3nrQ9UoPRNOy1UcV_dsD7AvQChpQ1meGlR
 X43We4aGXyUa1uOSV6d5kGly4Z0WV06.6bmWVUru6HCbcqAiCZgFXnotxfrO0X1g.T5OwJ8A3qqT
 cSGGP9yMPCpDGy23zrVaeX5bgrJxI.0wiYH2dHZ_i_0y0_IfLnGNOeI9JtmwkIJT5mKQF3ZmOSF8
 eSYDGYneXh08WtdNN6aBZI3vJ5dn2.6PRjiLx_zm2xFZtzqPkiR9xO.4lMe1DuzO_TRWNQOKGTG8
 8uSlcGQEeFG8JB_F_9hQIY8tXevCdr5G6KH_8fyzLf.BgumxScBV14bPJS2QflB8n3XFMnu5AZdB
 p_cxqlb5dUu5H3fuv9hTnWtKclK79Y5PXnrVHDt8BZ1ezRqRHlpU1UcuFNYBvGNYYKAi5R1kHKp2
 ONMiURgpCpQHziWCiy9I3QhWBrqZrChCE65KiQTwmUO1_E9hd6R82Eff4BCQqmMZeVML9KcRGcLX
 QHwUwO5737120cWpiqVpYun2cuZiI9iUxDrOlUhaB1gKWVe7Er52zBQF1mcovNdznZazReizZala
 ukonpaxRlSZp2fNmwjl6kQOWesVB47CidybaCrercSnH5JSi3Gy2ly0ti.cJ6ew5Sk.XPVu66eg.
 XPBpSCMzucrRL3MMUoPPj7bGbtFPPBU1zvbqyIT6IoG2VIYwcQQw2PEh_uRE9vTDVFDoHzQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 18:58:13 +0000
Received: by smtp410.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e1bae85a7ff10632e9e39fc038bb2e7c;
          Tue, 26 Jan 2021 18:58:09 +0000 (UTC)
Subject: Re: [PATCH v24 21/25] audit: add support for non-syscall auxiliary
 records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
 <20210126164108.1958-22-casey@schaufler-ca.com>
 <20210126184246.GM1762914@madcap2.tricolour.ca>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e9140e2a-a6ca-9d51-9db4-a0ec0dfd56cc@schaufler-ca.com>
Date:   Tue, 26 Jan 2021 10:58:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126184246.GM1762914@madcap2.tricolour.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17642 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/26/2021 10:42 AM, Richard Guy Briggs wrote:
> On 2021-01-26 08:41, Casey Schaufler wrote:
>> Standalone audit records have the timestamp and serial number generated
>> on the fly and as such are unique, making them standalone.  This new
>> function audit_alloc_local() generates a local audit context that will
>> be used only for a standalone record and its auxiliary record(s).  The
>> context is discarded immediately after the local associated records are
>> produced.
>>
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-audit@redhat.com
>> To: Richard Guy Briggs <rgb@redhat.com>
> This has been minorly bothering me for several revisions...  Is there a
> way for the development/authorship to be accurately reflected
> if/when this patch is merged before the contid patch set?

I don't know the right way to do that because I had to pull
some of what was in the original patch out. Any way you would
like it done is fine with me.

>
>> ---
>>  include/linux/audit.h |  8 ++++++++
>>  kernel/audit.h        |  1 +
>>  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
>>  3 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/audit.h b/include/linux/audit.h
>> index 418a485af114..97cd7471e572 100644
>> --- a/include/linux/audit.h
>> +++ b/include/linux/audit.h
>> @@ -289,6 +289,8 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
>>  				/* Public API */
>>  extern int  audit_alloc(struct task_struct *task);
>>  extern void __audit_free(struct task_struct *task);
>> +extern struct audit_context *audit_alloc_local(gfp_t gfpflags);
>> +extern void audit_free_context(struct audit_context *context);
>>  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>>  				  unsigned long a2, unsigned long a3);
>>  extern void __audit_syscall_exit(int ret_success, long ret_value);
>> @@ -552,6 +554,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
>>  extern int audit_n_rules;
>>  extern int audit_signals;
>>  #else /* CONFIG_AUDITSYSCALL */
>> ++static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
>> +{
>> +	return NULL;
>> +}
>> +static inline void audit_free_context(struct audit_context *context)
>> +{ }
>>  static inline int audit_alloc(struct task_struct *task)
>>  {
>>  	return 0;
>> diff --git a/kernel/audit.h b/kernel/audit.h
>> index ce41886807bb..3f2285e1c6e0 100644
>> --- a/kernel/audit.h
>> +++ b/kernel/audit.h
>> @@ -99,6 +99,7 @@ struct audit_proctitle {
>>  struct audit_context {
>>  	int		    dummy;	/* must be the first element */
>>  	int		    in_syscall;	/* 1 if task is in a syscall */
>> +	bool		    local;	/* local context needed */
>>  	enum audit_state    state, current_state;
>>  	unsigned int	    serial;     /* serial number for record */
>>  	int		    major;      /* syscall number */
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index de2b2ecb3aea..479b3933d788 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -927,11 +927,13 @@ static inline void audit_free_aux(struct audit_context *context)
>>  	}
>>  }
>>  
>> -static inline struct audit_context *audit_alloc_context(enum audit_state state)
>> +static inline struct audit_context *audit_alloc_context(enum audit_state state,
>> +							gfp_t gfpflags)
>>  {
>>  	struct audit_context *context;
>>  
>> -	context = kzalloc(sizeof(*context), GFP_KERNEL);
>> +	/* We can be called in atomic context via audit_tg() */
>> +	context = kzalloc(sizeof(*context), gfpflags);
>>  	if (!context)
>>  		return NULL;
>>  	context->state = state;
>> @@ -967,7 +969,8 @@ int audit_alloc(struct task_struct *tsk)
>>  		return 0;
>>  	}
>>  
>> -	if (!(context = audit_alloc_context(state))) {
>> +	context = audit_alloc_context(state, GFP_KERNEL);
>> +	if (!context) {
>>  		kfree(key);
>>  		audit_log_lost("out of memory in audit_alloc");
>>  		return -ENOMEM;
>> @@ -979,8 +982,27 @@ int audit_alloc(struct task_struct *tsk)
>>  	return 0;
>>  }
>>  
>> -static inline void audit_free_context(struct audit_context *context)
>> +struct audit_context *audit_alloc_local(gfp_t gfpflags)
>>  {
>> +	struct audit_context *context = NULL;
>> +
>> +	context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
>> +	if (!context) {
>> +		audit_log_lost("out of memory in audit_alloc_local");
>> +		goto out;
>> +	}
>> +	context->serial = audit_serial();
>> +	ktime_get_coarse_real_ts64(&context->ctime);
>> +	context->local = true;
>> +out:
>> +	return context;
>> +}
>> +EXPORT_SYMBOL(audit_alloc_local);
>> +
>> +void audit_free_context(struct audit_context *context)
>> +{
>> +	if (!context)
>> +		return;
>>  	audit_free_module(context);
>>  	audit_free_names(context);
>>  	unroll_tree_refs(context, NULL, 0);
>> @@ -991,6 +1013,7 @@ static inline void audit_free_context(struct audit_context *context)
>>  	audit_proctitle_free(context);
>>  	kfree(context);
>>  }
>> +EXPORT_SYMBOL(audit_free_context);
>>  
>>  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>>  				 kuid_t auid, kuid_t uid,
>> @@ -2214,7 +2237,7 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
>>  int auditsc_get_stamp(struct audit_context *ctx,
>>  		       struct timespec64 *t, unsigned int *serial)
>>  {
>> -	if (!ctx->in_syscall)
>> +	if (!ctx->in_syscall && !ctx->local)
>>  		return 0;
>>  	if (!ctx->serial)
>>  		ctx->serial = audit_serial();
>> -- 
>> 2.25.4
>>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
>
