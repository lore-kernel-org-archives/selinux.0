Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD74C10F1B
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 18:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiLSSr1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiLSSrX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 13:47:23 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0AA1275B
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1671475638; bh=IzMXfBS2i3h/TqDSTk5MBhwJyvxPX0qNGeA1pFyurf8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WLVsh3sJE+RX3JwDtORLj7X670bjKkwEYjg4Wfc+odlgKgnmXBkZtxWjN+NTMCxlJiWaMkIglQ/SK8igaWLEAFRVIh4Qn0mGqjUjNv1rX32Ma6aW3VGFQjI+bzz7UpMqyJEmcMtb6vhQNVxOZaapYYBOY+C6K6RrGfvCrWqjbhnWawzKIKhzbU9bVJgiL0DxoIKEBnx8oeMekVqY6cMlTWI4pFgVozTmJ9LZF9jLFeXmcDWjyGrSABpjDgnN+XHrKy10MERNiRHAui9jHWTn17a54WpCOgUVVNd0+/54xz0XNH7GoFfbOjmy7fDKn2UASLliUQXsdGPGzb4ATCuSbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1671475638; bh=ZQ0eNzOQnK40sThRtc/xiMkVk1cpgaD4t5lijHxU/HS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sVw8wMnWKrlUElR+VInQF649zlPOTPGvrHcy5vy6kN9vpQrzrvlZmqUTfZMm4PICBJywfTeQEyfGjZKk+aFETT3AyNYe+1/yZHOjC6BbCtfTSWPTL/wJVinbWiaqX7waZ3+HnsR3wsvhL4SzsL7tBV8l5OgBp6j5H6kXlFEBcdnDD4bp+6fQk2IS3xfW3mBFt4IglAUiCbbWgcLVTjNTyFJHeaH5DWQxZau9p0jn5gJvlo9Q4z6KlgMlqGwz7lSOV12AwqWQXTIOAduCQ/tqC5BtJAmxJgJe8irddmpKnh6ghtPppLBbkUwcgnQRmdLojrSBzkqN+M2+E2wx4QyYmQ==
X-YMail-OSG: 2ARrY_oVM1mVcLwyc7sbTrjaB2Nb.kT0eZZyj.XbQM.6n6iWEilSME857GGJ5id
 dNsKpY520Mh4dY7K06Vc.BLjuJ4PmI.h0ZBzjFwH1Uy6I32BtSiJ17kXyyIdcsxQ7AQ1OXZkBJPC
 IzRzQcxX4Bso5guq7GzWVyTLyrmgCj5g9419.xkTY52T7XaFe5m7QciMZu72Vt3_quUJYVqAfRq6
 nllEkIFlh9afeJZfs_GqTltpcg0xlKq0GASkJfIZ6cLTzBYedeVDErk9QJEWVEWq126zaY4ju6Rl
 tHXFaYsat9VtR7E7wXKsC2TknlSiHTzd2qeRPXY6Ob8YCi_PXc8ZPH4JW1M9HXdFVBSl6Ai69ej5
 L9HkxpdNWJSYCJBBsYuaTpqOU.4a82.Typ5sQKe7ukYxEExgHlz_A.oMgduLzk8M1KZykEGcnMaZ
 SN1SanpW9_W8FkuylbrByyTESL2IJQIO_NIUK7HMC0UZZUZvLXkz7UNsfyExCEXfajL.DL66uXjz
 h_VVy1fVveUuAki9nSNDUZKapWYwSJrBdeKjCw.1XceXxSB6R7x9gtXaigkXo0o74lyLFDHuIo82
 IVI1MZm08fkrI8CmT.Iekoai_ynngAhRV_TWOaBIXD5e21vdnIJjuWCDJXtfLrCseFCaW8FDK4xV
 5.jEYkCdEYACgVkCn05oMX2WfARfge.cNCXeJy.3aqVMC5NT6UIL8ucOc914sLBdt25ePGNne6kB
 NSJ3P2a_nABscLXfcVcYxcgkTzRZJo64bF3El77xM79mWfvzpDl1Vpa9YvsbL4XnzBbEdrVk.ngb
 bbA02c8YlLTV5wANqa4yNDmbhX5n8T8yBp_E.TJBMRxxpyb1t7JNNRDUZkq.HogCUIfXH.ASOehs
 3iiBH_Mekb2LczQDpTh0DKSXhOy_t7W8AOFpQ3hz4J5c35.PmrB..CBzonponuzVBo2tdZDbqK31
 wfSLhP2EZW.EvUsb4ExbfcUq7av0Gd03mmXel10iAPqtjxZu7BegN.OMNVV21O3Uzc7x1Dxn6oZK
 7pAEpBDuP07UDGmSdktzrwl9a7SvUDTvsQb8JBr.ZlbBa2.ijbymoZa.GBhfUI9CoKj2xbtv9a4z
 PzwJUp3ivOFXqKpLFH3KgCEyOcL8nAyJDivHfOrGUTpZVCIrzeiDZkrdFqu.1MFq3ZaOjZ_sWCs.
 4ZqN_X8EwdcmNPLh.z82TW_Syi_Mf3hIumiGKkji7JmSU8NGHn554ZcKWg_iVPTjxxyP_mzLr6c1
 pq7iSxlGWszfCUbSO3zvKLNGxXdLUPcP3SX9hLYW95yHTm.JysMDuxnXbzyyp6vwx.s7R5FbGq4Z
 tJWHDfpMQt9UYKSXgR8UEHpLPsgeLNaj_5BOuuR_HEWhMBgGW15.Ggf.70hq0uVJihV1I1n41YbX
 KpV4ayMO91ytHA_ihy4vPu7BpH3k5bodH_7Z7TmdATyyTQqOuLwE3xnATMXU9Kd1wTtpXyZeTVI8
 k4SO.SygBj7r0cWEUN0ODtLTP0xSMe3kD.9PNEa2NozzyLiPa2VBQsPi1YQpdJq83kVeVooqYBJy
 Zo9NdygzBxh9QzZaj4mAwOxtRpmVHaVALvqOmkYMkahDqztVBxgBUnGprgJJ0iigF9aGgQ1.Qfez
 1DdTO4grZ4FSbchbgbVnTt2p.SXG35kXzKytPpC3msSbiZNx58mJcuGWSINLRwkCvjj3oDi1oXau
 vWT_rvLC_YYve02it8UEP5X3TEv4aPFUug7eiMjThILKbB2O9.bsnd_051K7FO4WLqDtEVQ5IAbG
 JyAxRdtWZ.NOuKhZPY3RfOrxJcw7JRiFGgEhPo4c7ZQIh71RXEhmp1ILPlHu0q8tayg9L0OaMPBi
 6TDIEL5Ed2O1Cp99nffZX5EmkrwcLcnV7vwNdCUWe5cmQ15xScNPCQ5dE3NswL1jt16XZO3jA7KS
 MH107zK1hA.9mtFSUMyZ..4fcGgIPBSJqOdiIjNFdlRhw_G6VUmUsCItI8.EL67K.oJUmYZTin.7
 bnxeEW4Hd9iphqeV3_04CCkCMElH70fnoJcDmZ26LuwLEBUspEirxVe5KrtdJbS3lM_Q9HVJpnXt
 ezzyl1ejQ1dPgogrtgLYHDgO8fSKorVBIDNDfAxn6eH4NSbD2CGmrnvf_u7gTtloeJDuK3Vc.SbR
 Tcx2jxweU6McUnYcPgnk24rn.Q4ss1EYkj8rwbZn7424xeWHHJuGFADUpq6dO6nHAsTEVnhKdw5l
 nHnaF0RC3hrGLLXXaD4Yk6jb.pYsZ3RNDI5uu
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 19 Dec 2022 18:47:18 +0000
Received: by hermes--production-ne1-7b69748c4d-srx4j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d0bca7aba8d37ba6997629a118a468b6;
          Mon, 19 Dec 2022 18:47:16 +0000 (UTC)
Message-ID: <fae32a51-d422-d3ea-0bee-6223ca2cf902@schaufler-ca.com>
Date:   Mon, 19 Dec 2022 10:47:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] audit: introduce a struct to represent an audit
 timestamp
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        selinux@vger.kernel.org,
        Peter Enderborg <peter.enderborg@sony.com>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Zdenek Pytela <zpytela@redhat.com>,
        Michal Sekletar <msekleta@redhat.com>, casey@schaufler-ca.com
References: <20221219175449.1657640-1-omosnace@redhat.com>
 <20221219175449.1657640-2-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221219175449.1657640-2-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20982 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/2022 9:54 AM, Ondrej Mosnacek wrote:
> Join the two fields that comprise an audit timestamp into a common
> structure. This will be used further in later commits.

Patch 30/39 of my LSM stacking patchset[1] is almost identical to this.
The only significant difference is the structure name. You use audit_timestamp
whereas I use audit_stamp. I believe that audit_stamp is more correct and
more consistent with the code that uses it. 

[1] https://lore.kernel.org/lkml/f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com/T/#m3205b98b2a6b21a296fb831ed35892f01ead191f

>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h |  5 +++++
>  kernel/audit.c        | 16 ++++++++--------
>  kernel/audit.h        |  4 ++--
>  kernel/auditsc.c      |  9 ++++-----
>  4 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 3608992848d3..788ab93c3be4 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -84,6 +84,11 @@ enum audit_ntp_type {
>  	AUDIT_NTP_NVALS /* count */
>  };
>  
> +struct audit_timestamp {
> +	struct timespec64 t;
> +	unsigned int serial;
> +};
> +
>  #ifdef CONFIG_AUDITSYSCALL
>  struct audit_ntp_val {
>  	long long oldval, newval;
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..aded2d69ea69 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1818,11 +1818,11 @@ unsigned int audit_serial(void)
>  }
>  
>  static inline void audit_get_stamp(struct audit_context *ctx,
> -				   struct timespec64 *t, unsigned int *serial)
> +				   struct audit_timestamp *ts)
>  {
> -	if (!ctx || !auditsc_get_stamp(ctx, t, serial)) {
> -		ktime_get_coarse_real_ts64(t);
> -		*serial = audit_serial();
> +	if (!ctx || !auditsc_get_stamp(ctx, ts)) {
> +		ktime_get_coarse_real_ts64(&ts->t);
> +		ts->serial = audit_serial();
>  	}
>  }
>  
> @@ -1845,8 +1845,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>  				     int type)
>  {
>  	struct audit_buffer *ab;
> -	struct timespec64 t;
> -	unsigned int serial;
> +	struct audit_timestamp ts;
>  
>  	if (audit_initialized != AUDIT_INITIALIZED)
>  		return NULL;
> @@ -1901,12 +1900,13 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>  		return NULL;
>  	}
>  
> -	audit_get_stamp(ab->ctx, &t, &serial);
> +	audit_get_stamp(ab->ctx, &ts);
>  	/* cancel dummy context to enable supporting records */
>  	if (ctx)
>  		ctx->dummy = 0;
>  	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
> -			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
> +			 (unsigned long long)ts.t.tv_sec, ts.t.tv_nsec/1000000,
> +			 ts.serial);
>  
>  	return ab;
>  }
> diff --git a/kernel/audit.h b/kernel/audit.h
> index c57b008b9914..e3ea00ea399a 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -262,7 +262,7 @@ extern void audit_put_tty(struct tty_struct *tty);
>  #ifdef CONFIG_AUDITSYSCALL
>  extern unsigned int audit_serial(void);
>  extern int auditsc_get_stamp(struct audit_context *ctx,
> -			      struct timespec64 *t, unsigned int *serial);
> +			     struct audit_timestamp *ts);
>  
>  extern void audit_put_watch(struct audit_watch *watch);
>  extern void audit_get_watch(struct audit_watch *watch);
> @@ -303,7 +303,7 @@ extern void audit_filter_inodes(struct task_struct *tsk,
>  				struct audit_context *ctx);
>  extern struct list_head *audit_killed_trees(void);
>  #else /* CONFIG_AUDITSYSCALL */
> -#define auditsc_get_stamp(c, t, s) 0
> +#define auditsc_get_stamp(c, ts) 0
>  #define audit_put_watch(w) do { } while (0)
>  #define audit_get_watch(w) do { } while (0)
>  #define audit_to_watch(k, p, l, o) (-EINVAL)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9f8c05228d6d..061009ba9959 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2513,16 +2513,15 @@ EXPORT_SYMBOL_GPL(__audit_inode_child);
>   *
>   * Also sets the context as auditable.
>   */
> -int auditsc_get_stamp(struct audit_context *ctx,
> -		       struct timespec64 *t, unsigned int *serial)
> +int auditsc_get_stamp(struct audit_context *ctx, struct audit_timestamp *ts)
>  {
>  	if (ctx->context == AUDIT_CTX_UNUSED)
>  		return 0;
>  	if (!ctx->serial)
>  		ctx->serial = audit_serial();
> -	t->tv_sec  = ctx->ctime.tv_sec;
> -	t->tv_nsec = ctx->ctime.tv_nsec;
> -	*serial    = ctx->serial;
> +	ts->t.tv_sec  = ctx->ctime.tv_sec;
> +	ts->t.tv_nsec = ctx->ctime.tv_nsec;
> +	ts->serial    = ctx->serial;
>  	if (!ctx->prio) {
>  		ctx->prio = 1;
>  		ctx->current_state = AUDIT_STATE_RECORD;
