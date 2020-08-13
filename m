Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A95C433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB61320658
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UnMmjJ4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMPFt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:05:49 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:40060
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgHMPFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 11:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597331147; bh=YfKVNcs7+BEsRc0goaFkdxz7uPwdRW+v8HkdAP+LTcA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=UnMmjJ4K6/DVJeMiri5Q/oB9RPRunSh9CjnqSYeFzQMUQWni3hQXKDWEwRQ3NK+Pd98JZWDJXEgnYBHKa6KTUeB+W7FH1J6aNnJtEpTEBricGNZRea1lD09LIkTk/mF1k/6ICiRsf0gtw1KiP7UCadIsSmOcbkFMkGneN5wy5QPFyeNDvYI8zenagq5NBL+c4xLHm8Ta5CvCUzu+swQ3tslYXlnRGWWwLdooer+okl5N5uvyB7uRxlfLcV6V3TUO5c0R62cnzsy4iyyVIYTzAFtkTrt9b7fyDJL3TMcv2dC2NxJ6Zil5Kh4/Y3dnGuPEC3VI0NQu8UQrP3oNpBnVNQ==
X-YMail-OSG: jblOXSIVM1k8BNiAneNJIdqbyW7XucjcIQ4uvLotu7gw8nX7Os6dpNu82bzascN
 nq1qLuLOSyV8Pb0iJk6G2cLY7zUBVBF5bXi93gk9KWkpAX_ewT6Y3Xu3N9XkuRydTtjVfVI76F2.
 vYMQpxjMSFImJtB4xYC2c87mrSOMvuVPWuurb8_eFd6acWt0fVxyxh0hrTWlXaVsrjlzHhHTsXLi
 ZP.qtNMvBM7IS5cqoXiIiBouMiFuzaXt6AL_0PLGWf_nUqjuMzEBjPmMKDVIoQdIC6CqAI8ZjKjo
 aRv1g1pwsPx0fp2iJaakSPA.e0sTfGE5tUauJZoOHFDCcCQC7SzTxcE83zdmexyyPM4FjMEeWfSW
 slO_vWuloNWrjtV1g_YHodKXeiv15_7iAET6_4Y.9oH8N5Yiyt.yLpSmRxOiFIPD38JcTNZxgTpH
 I2PhcZj6wU7K.xp5ah1YZo6MqDmvn.UQ356pAgJYuEV_1EeEB6102XoTiD1Pj1OFkYuBYsnZ.qE7
 EN4bILwJDrLwB53VY9BzuUs6HuwkcsuSAbXrAYVMaNN87v3UjWNG2eV5A5WGJqIIJxBg1ITCls1I
 Uh9yZotkNEcC1hOQohRVSkZhijMsay7jFD9LkzPpV2y32vuFevD2Qd4iSMkh6XOHQFbfsLZZR5ww
 1bBEZC36S4wJCjtat_KJKRYU.ndJ9EnIrFduBgxPjL09KmvXPWv_sng8qzX_wrEb5PXap65DCpAW
 p.RQnV3sUvu.4syn7_uuoIMaSDgPvOCKe4O51Y_wAzd28nLrvcxT_AuKtl80NkorpYNvwsZ2Aoa5
 HrjeRPYndxRDD7UqBCbPPoU20i6dhcKHIIfCl2idsN1Ckjs4Lf6.1hWE89FAqII31U1KIvq9iZyx
 vshktCc1XpgcBuTJhfWWROV4nS8E.RXkw4Ww8tFEBq_Ww72jeYGO3SyN2PPKrwmOFP4dJooYKCA2
 ZRAFwNWB8WskOxDxLrJWQR1WGMiViqk3LOW68Pj1za_GQQwOiIhLZAEyRMNFMuVslhfdyI3C0aIp
 GRCJO0am8oVf_g5NFONIi_0V_7sEH1SpEkwx4W.zQ0jZVANj3pHkKD1GLhIzgx.3sZKqp9ft.ufx
 gmvUC1GLsWqA3HilimJRp3bSyLYoOOe_rQ2oDF6nrQl_w3JwYUT0A7nBp3l0VtQcy3hwY0x0u0UC
 IUTgWWzzVUjmI9WHPK06RjZB44YGwwUGy4YgyFuyF58BGNGcARrHgqUQ4gX1iIexFAGwcnuOgedU
 GXiJvEb1YSIszOOFPRyiamX1NEX1qARSwPE47wQiqWkneUQYkKZXAtdjWONU3hwNzwo8ItPxPdTx
 bxc00sCOfI8arxb80mtsf6_u1JrRt0dBUfhd57f3zZI7jagV_oQ3Yp5_TNTeei6m4vHMKoPVlFtp
 NPwiTTtIV7GgZJat999LJ_Hk21hefBpBsWDNt5rXOABWlInkb5s_jiardUu68M0sdltD1VisRo0i
 eLOrQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Aug 2020 15:05:47 +0000
Received: by smtp412.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 293221fac1ea28c2ea94da4a5198ec0a;
          Thu, 13 Aug 2020 15:05:44 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] selinux: add basic filtering for audit trace
 events
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200813144914.737306-1-tweek@google.com>
 <20200813144914.737306-2-tweek@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <02c193e4-008a-5c3d-75e8-9be7bbcb941c@schaufler-ca.com>
Date:   Thu, 13 Aug 2020 08:05:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813144914.737306-2-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/13/2020 7:48 AM, Thiébaud Weksteen wrote:
> From: Peter Enderborg <peter.enderborg@sony.com>
>
> This patch adds further attributes to the event. These attributes are
> helpful to understand the context of the message and can be used
> to filter the events.
>
> There are three common items. Source context, target context and tclass.
> There are also items from the outcome of operation performed.
>
> An event is similar to:
>            <...>-1309  [002] ....  6346.691689: selinux_audited:
>        requested=0x4000000 denied=0x4000000 audited=0x4000000
>        result=-13 ssid=315 tsid=61

It may not be my place to ask, but *please please please* don't
externalize secids. I understand that it's easier to type "42"
than "system_r:cupsd_t:s0-s0:c0.c1023", and that it's easier for
your tools to parse and store the number. Once you start training
people that system_r:cupsd_t:s0-s0:c0.c1023 is secid 42 you'll
never be able to change it. The secid will start showing up in
scripts. Bad  Things  Will  Happen.

>        scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>        tcontext=system_u:object_r:bin_t:s0 tclass=file
>
> With systems where many denials are occurring, it is useful to apply a
> filter. The filtering is a set of logic that is inserted with
> the filter file. Example:
>  echo "tclass==\"file\" && ssid!=42" > events/avc/selinux_audited/filter
>
> This adds that we only get tclass=file but not for ssid 42.
>
> The trace can also have extra properties. Adding the user stack
> can be done with
>    echo 1 > options/userstacktrace
>
> Now the output will be
>          runcon-1365  [003] ....  6960.955530: selinux_audited:
>      requested=0x4000000 denied=0x4000000 audited=0x4000000
>      result=-13 ssid=315 tsid=61
>      scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>      tcontext=system_u:object_r:bin_t:s0 tclass=file
>           runcon-1365  [003] ....  6960.955560: <user stack trace>
>  =>  <00007f325b4ce45b>
>  =>  <00005607093efa57>
>
> Note that the ssid is the internal numeric representation of scontext
> and tsid is numeric for tcontext. They are useful for filtering.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> Reviewed-by: Thiébaud Weksteen <tweek@google.com>
> ---
> v2 changes:
> - update changelog to include usage examples
>
>  include/trace/events/avc.h | 41 ++++++++++++++++++++++++++++----------
>  security/selinux/avc.c     | 22 +++++++++++---------
>  2 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
> index 07c058a9bbcd..ac5ef2e1c2c5 100644
> --- a/include/trace/events/avc.h
> +++ b/include/trace/events/avc.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Author: Thiébaud Weksteen <tweek@google.com>
> + * Authors:	Thiébaud Weksteen <tweek@google.com>
> + *		Peter Enderborg <Peter.Enderborg@sony.com>
>   */
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM avc
> @@ -12,23 +13,43 @@
>  
>  TRACE_EVENT(selinux_audited,
>  
> -	TP_PROTO(struct selinux_audit_data *sad),
> +	TP_PROTO(struct selinux_audit_data *sad,
> +		char *scontext,
> +		char *tcontext,
> +		const char *tclass
> +	),
>  
> -	TP_ARGS(sad),
> +	TP_ARGS(sad, scontext, tcontext, tclass),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned int, tclass)
> -		__field(unsigned int, audited)
> +		__field(u32, requested)
> +		__field(u32, denied)
> +		__field(u32, audited)
> +		__field(int, result)
> +		__string(scontext, scontext)
> +		__string(tcontext, tcontext)
> +		__string(tclass, tclass)
> +		__field(u32, ssid)
> +		__field(u32, tsid)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->tclass = sad->tclass;
> -		__entry->audited = sad->audited;
> +		__entry->requested	= sad->requested;
> +		__entry->denied		= sad->denied;
> +		__entry->audited	= sad->audited;
> +		__entry->result		= sad->result;
> +		__entry->ssid		= sad->ssid;
> +		__entry->tsid		= sad->tsid;
> +		__assign_str(tcontext, tcontext);
> +		__assign_str(scontext, scontext);
> +		__assign_str(tclass, tclass);
>  	),
>  
> -	TP_printk("tclass=%u audited=%x",
> -		__entry->tclass,
> -		__entry->audited)
> +	TP_printk("requested=0x%x denied=0x%x audited=0x%x result=%d ssid=%u tsid=%u scontext=%s tcontext=%s tclass=%s",
> +		__entry->requested, __entry->denied, __entry->audited, __entry->result,
> +		__entry->ssid, __entry->tsid, __get_str(scontext), __get_str(tcontext),
> +		__get_str(tclass)
> +	)
>  );
>  
>  #endif
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index b0a0af778b70..7de5cc5169af 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -705,35 +705,39 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>  {
>  	struct common_audit_data *ad = a;
>  	struct selinux_audit_data *sad = ad->selinux_audit_data;
> -	char *scontext;
> +	char *scontext = NULL;
> +	char *tcontext = NULL;
> +	const char *tclass = NULL;
>  	u32 scontext_len;
> +	u32 tcontext_len;
>  	int rc;
>  
> -	trace_selinux_audited(sad);
> -
>  	rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
>  				     &scontext_len);
>  	if (rc)
>  		audit_log_format(ab, " ssid=%d", sad->ssid);
>  	else {
>  		audit_log_format(ab, " scontext=%s", scontext);
> -		kfree(scontext);
>  	}
>  
> -	rc = security_sid_to_context(sad->state, sad->tsid, &scontext,
> -				     &scontext_len);
> +	rc = security_sid_to_context(sad->state, sad->tsid, &tcontext,
> +				     &tcontext_len);
>  	if (rc)
>  		audit_log_format(ab, " tsid=%d", sad->tsid);
>  	else {
> -		audit_log_format(ab, " tcontext=%s", scontext);
> -		kfree(scontext);
> +		audit_log_format(ab, " tcontext=%s", tcontext);
>  	}
>  
> -	audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
> +	tclass = secclass_map[sad->tclass-1].name;
> +	audit_log_format(ab, " tclass=%s", tclass);
>  
>  	if (sad->denied)
>  		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
>  
> +	trace_selinux_audited(sad, scontext, tcontext, tclass);
> +	kfree(tcontext);
> +	kfree(scontext);
> +
>  	/* in case of invalid context report also the actual context string */
>  	rc = security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
>  					   &scontext_len);
