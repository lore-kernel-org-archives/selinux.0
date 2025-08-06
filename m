Received: from sonic.asd.mail.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488F28CF75
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496213; cv=none; b=Exl3LX/5uspb58iSDNy+JKYaLzxLsPtON0WY8iJW55hJ7PH4saH5mQ4Gd0xfU0rYxDZqA2k679AHVBZthvwAUgTQ33x7BWDa4kvIKAiN7Eus9YtY9Rh/yHsR+WZSIEN1xTwuBgSKPWbiei6jewqx79dHlcMvLHiK6J0lDZzlLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496213; c=relaxed/simple;
	bh=AWH+D89M7aStP3oBIorWUMPFTbDveQKqKoCvhdHagZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiZZRXUHc2+MNSB6blfeHo64+zoXe2DnHOGFTv5efsnMF5QIkgqkGmHM9KjIjtsE03jXQcLxbTgQJy2LnkMGE0HZhpred3s4giM1k7DKJHGt5ymOZ1hWdcE7GQ+UfTVO08cOopKZNNt0N43/5JPojB0RYbfAJiI9ZIgndpHJMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VYWyTFWu; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VYWyTFWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754496210; bh=+1GhTDSV2/PdaKmjl8xXuqQHtInrepdxPt+4s7N2l7k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VYWyTFWuFZfBE9dRSSC2halaAOrCQFp6oWyTA8rnJRaCr2G69jRI4AMcq5GUYBPNUzaSzBT6eYxHD2S+ipPJi2veUeRHYdfi88WqpYVlM1z2dk6lGLxdC4J9goI7Cy0ArpOQWT5QL/I+izhLQKuRSJcI/zNAqjAEOXwKABnQeCqCJhkXUvmKdM+4ONMQIUr9czWLIZndYac8it55VSEXScyAqXNLu1fRill1vi3hcjWjAYckGu/tbkQmCRKykMlvy6o68idGsiDH8RW6SfA2CharnqOhe3j37/4tkR9hEvmQ9TXNUyEiZjuE9TSfqVFct7q2xHRCU7B0t4GAz7CEuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754496210; bh=GX7vH3XNLrebdEs0+LooVkc08eKW2zj0pdCrVYzFvJm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fTd0cEGNCyMukORe6KivcRJ/xG8S9h/Kip+r7X+uBnWPown13udqKB02DXTHiyYjAUC+fFsm7qKWFrsnMHNUs1/FSBodoDvD9A2xZkCzFtTZ8c8atjWxlJP5TShnY+OA5GjKl2Vn7sihLe6A5P0UcI9TYwm+CWl0b/HwOs1IG+ahKrpOiEUckvDzXELNGuFZniTOwo/0rYDuIG1FEJTk75QuYAabdNp8pnW6hg21eYnTcYtfv2OtmaaTRtWi5e+m2viRl2jywo3VAIu46F2eA9kOmSm35/c8yWPA4mC9WZq/Sl15SU4Yc+LMsEcnA9l40XtYUbLImDCzn/IaUCd59w==
X-YMail-OSG: g3aMrfUVM1l09G9Rgc0JK1La41RR4KILnoI.r1gbwykzbmyaEBndsUEdkK3GmKO
 k4.gHkWLZj_ErY0NlJGozI1ZVXYtnd5RiZeh_erhPbwLJd1joN6dc7Ch4VrxlgVjDFQOrMDr9ljg
 tFrQ_KtfcaQ96kUVr869EXlPbBADQBDURiUtvLiB4qTdD3kDR9ZT01nEkbBTk9kDmqag_Qemq2DM
 Z31qed7fqQfi74xtH4pahdpim.VkbKJqihyASq0H2RgOK7Iya0cIvDysiCwg85fR07mQsz4CicZx
 wctSvu3JAhQDxTM38JvFTWcje7UDTK8EnNQUzMqo8DrOQONa2Gg81WXzJbjnPSS2424R5ZASR91R
 ZTBf5repnehiip6.yMddgpIHiMuqtyBtY9Etxn.RcY2kp3FxIzMIZTTCQzFfYZg_Klv3mS2dYT0W
 Q8Hz5IDGfc4QW7O7kbMmoilbLZhwrvZ8_Ytf2B6_vwLiJ_qc77g6haCx8x0ooAGoQ5miSJfAU8x0
 bk9jidhDInKwCAsOZ9qo5N_LgPtDBaaAaYEF_GPiiOoVuInpfTwsWS6djbNm25Q9k4k95SH02pQ7
 SU5JvhdLDgOGgifGRPEIQXPo31tuNmHBnkYDi552tGTQVDJIW584kEDGIwRWYwFkpBagx4ViMbbb
 S8Q9TBoGkx1lBXnUbYTMp_rRuo9hn3QDv76pToGyEemRB9De.oYhE4oha8I4VLuCBnad0_CsyUuW
 2qnXdhcXoU7J2vz5CDaactb4pLaHwa1A2QeqZHilyuWpkIcxjoaYBzUP01aB4X3pTNp_rLky4Iqh
 SR.8mcwYzreD2APx.9m5.eJPxlNaDee3sS1M0oPTn9f7xc.SHBN5FFMY48pRe0owlQJPdVmqtmJb
 axxxzkTBpRBbf4TyfZxLhR_YFRpKdMo0zP1q3TGxWVlk99n4q_tkDBvSOqerCP4I8Q.RNeSRsUfQ
 B0FGJhyTPjNZ.ZeGb5vkT3tdNCVB4gfLm0V1glR8uU5FSwvGjbQ9NXWfmG.fBja.2ul9EiWm79HR
 tB46_8gIp1_TxT.1kOoBLSF0KzAQSPy0_u025mPgx5S356qpD1KML2F.uO9Wxg0_BAEeFdiJ4Q8x
 ZS6nFinFaJRbQdOv5rWWO58ZMAN6lKY5serMSiCyBPTuP8e5clyifZwZhEXVrUoIy1te62I0zKP2
 SIcKHCNzt9n5iKtZpgVpLBtWwZaDMa7Nztmx7yiao5OrbsJ6PyozFacCXWd7rfhEahgLV4vb3zhi
 qthYDhcgxJEt3XSGBTFNP8Q8bzsFZEPc_rzJl11S4hJDV5AG_Kni.boUq4U8nQnDNKMDHUKzsrIw
 46VkCgp4us2zImR51Yv1tBkjGU2Kn1plZdJVVG6b5VYMZ1WnVW2.aLDmJ5Tq8qpK.DspClQi5hmJ
 iVs4eEbv6RnE1bZwWvSS8W5WfvJdim_xrwFh2tLbd1Xjgtvu7wHQi6at.hnbG14v9GCg9V21lOtP
 DeXnfrgjyCmiR6rWsuY3Ge7.1tL_m_MTl36uBY4Awy_DdK4PPebz2i.XOYXp6EgLbDizNR6dpgjE
 n4T3XmLhaS8NysqpVIifJB0bwo_OXIYlOh7F5tZ2AoWvF8BywBnZnwcdWAAzrap_t3YOGOit.wOC
 D9.4KcLJnrcDrL2kEkyw7fXUYB8R5m57N5h0CTK10.wVDE0VQ7.Xy8ZfsJgpMqDf.nw1c8KGNw9A
 cPVZrg2zmOe4_z0rJkApvutlkRkh2_zNotBHq4EruwzqwYEUk..3IHznfftLThNrXRIzlPlcNQXL
 n9RQq_gduJVk9kkg8Iiz8.IyjqoHGoc1XIheI84DHA7FzQ0eIxVmYeuI5JTFji4oSnCLtqUmJdXG
 aMXmMH2ao91EwhrRTG8G4w.rcYAnfkh.W0voAHLabZkKTQaRgfsk4SF9pBnfVqW25ix5UedsPASJ
 7a44G0_DV_.ILmhbJJjO.G1MjRa0wOnToX3_hJmg4uUcz5ztU9LR3YyTnadyeIXS9CPA6vPdUK89
 gjl6kExh8EMYw8P82pH.7qcvvxk3_PIaoAvSLZbvuByekFv4_5UibpKbZPNu66fE0k.3ZH3PeGND
 nwvPjx.s0P48EAL2CHTRy2qDpDLIDcwm99OlrrtKi_ZwhSyqy8fRECd8PjowxSz7grLjCKBTOlFb
 1kUQ141jp9UbVl4s2hiegthBFwPIDVCUdqem1E0q1m7.v6Npfzx1NxB_ZtQw5P_YPngwaeMg_FsH
 PPFUjn8OJL__6KdOVdlov9dqHD_94asalOp3GQtVVSnzTtsTzawl6ZZeignL2hbyhlmMdkhSPzfD
 6wGDENbwELZBcizudOiGLPd995Htr
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d558d37f-4020-496f-9ac3-3d32cfe1e38d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Aug 2025 16:03:30 +0000
Received: by hermes--production-gq1-74d64bb7d7-fddgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 23901a302fe8bb0ca70528d7882e9a23;
          Wed, 06 Aug 2025 16:03:26 +0000 (UTC)
Message-ID: <51b05437-c84d-4611-b294-f4944128728f@schaufler-ca.com>
Date: Wed, 6 Aug 2025 09:03:24 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] Audit: Add record for multiple task security
 contexts
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250716212731.31628-4-casey@schaufler-ca.com>
 <aafebe14727836ea747b97982926cc38@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <aafebe14727836ea747b97982926cc38@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/5/2025 12:39 PM, Paul Moore wrote:
> On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the single skb pointer in an audit_buffer with a list of
>> skb pointers. Add the audit_stamp information to the audit_buffer as
>> there's no guarantee that there will be an audit_context containing
>> the stamp associated with the event. At audit_log_end() time create
>> auxiliary records as have been added to the list. Functions are
>> created to manage the skb list in the audit_buffer.
>>
>> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
>> An example of the MAC_TASK_CONTEXTS record is:
>>
>>     type=MAC_TASK_CONTEXTS
>>     msg=audit(1600880931.832:113)
>>     subj_apparmor=unconfined
>>     subj_smack=_
>>
>> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
>> "subj=" field in other records in the event will be "subj=?".
>> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
>> multiple security modules that may make access decisions based on a
>> subject security context.
>>
>> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
>> This is used in netlabel auditing to provide multiple subject security
>> contexts as necessary.
>>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/audit.h        |  16 +++
>>  include/uapi/linux/audit.h   |   1 +
>>  kernel/audit.c               | 207 +++++++++++++++++++++++++++++------
>>  net/netlabel/netlabel_user.c |   9 +-
>>  security/apparmor/lsm.c      |   3 +
>>  security/lsm.h               |   4 -
>>  security/lsm_init.c          |   5 -
>>  security/security.c          |   3 -
>>  security/selinux/hooks.c     |   3 +
>>  security/smack/smack_lsm.c   |   3 +
>>  10 files changed, 202 insertions(+), 52 deletions(-)
> If there were no other issues with this patch I would have just fixed
> this up during the merge (I did it in my review branch already), but
> since you're no longer dependent on the LSM init rework changes (and
> I've dropped the subj/obj counting in the latest revision), just go
> ahead and base your next revision on the audit tree or Linus' tree as
> one normally would.

OK. Can I assume that the dependency on the init changes has dropped?

>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 226c8ae00d04..c7dea6bfacdd 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
> ..
>
>> +/**
>> + * audit_log_subj_ctx - Add LSM subject information
>> + * @ab: audit_buffer
>> + * @prop: LSM subject properties.
>> + *
>> + * Add a subj= field and, if necessary, a AUDIT_MAC_TASK_CONTEXTS record.
>> + */
>> +int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
>>  {
>> -	struct lsm_prop prop;
>>  	struct lsm_context ctx;
>> +	char *space = "";
>>  	int error;
>> +	int i;
>>  
>> -	security_current_getlsmprop_subj(&prop);
>> -	if (!lsmprop_is_set(&prop))
>> +	security_current_getlsmprop_subj(prop);
>> +	if (!lsmprop_is_set(prop))
>>  		return 0;
>>  
>> -	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
>> -	if (error < 0) {
>> -		if (error != -EINVAL)
>> -			goto error_path;
>> +	if (audit_subj_secctx_cnt < 2) {
>> +		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
>> +		if (error < 0) {
>> +			if (error != -EINVAL)
>> +				goto error_path;
>> +			return 0;
>> +		}
>> +		audit_log_format(ab, " subj=%s", ctx.context);
>> +		security_release_secctx(&ctx);
>>  		return 0;
>>  	}
>> -
>> -	audit_log_format(ab, " subj=%s", ctx.context);
>> -	security_release_secctx(&ctx);
>> +	/* Multiple LSMs provide contexts. Include an aux record. */
>> +	audit_log_format(ab, " subj=?");
>> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
>> +	if (error)
>> +		goto error_path;
>> +
>> +	for (i = 0; i < audit_subj_secctx_cnt; i++) {
>> +		error = security_lsmprop_to_secctx(prop, &ctx,
>> +						   audit_subj_lsms[i]->id);
>> +		if (error < 0) {
>> +			/*
>> +			 * Don't print anything. An LSM like BPF could
>> +			 * claim to support contexts, but only do so under
>> +			 * certain conditions.
>> +			 */
>> +			if (error == -EOPNOTSUPP)
>> +				continue;
>> +			if (error != -EINVAL)
>> +				audit_panic("error in audit_log_task_context");
> Argh ... please read prior review comments a bit more carefully.  As was
> pointed out in the v4 posting you're using the wrong function name here.
>
> https://lore.kernel.org/audit/fc242f4c853fee16e587e9c78e1f282e@paul-moore.com

Yeah, that was sloppy. Sorry. Will fix.

>> +		} else {
>> +			audit_log_format(ab, "%ssubj_%s=%s", space,
>> +					 audit_subj_lsms[i]->name, ctx.context);
>> +			space = " ";
>> +			security_release_secctx(&ctx);
>> +		}
>> +	}
>> +	audit_buffer_aux_end(ab);
>>  	return 0;
>>  
>>  error_path:
>> -	audit_panic("error in audit_log_task_context");
>> +	audit_panic("error in audit_log_subj_ctx");
>>  	return error;
>>  }
>> +EXPORT_SYMBOL(audit_log_subj_ctx);
> ..
>
>> @@ -2423,25 +2575,16 @@ int audit_signal_info(int sig, struct task_struct *t)
>>  void audit_log_end(struct audit_buffer *ab)
>>  {
>>  	struct sk_buff *skb;
>> -	struct nlmsghdr *nlh;
>>  
>>  	if (!ab)
>>  		return;
>>  
>> -	if (audit_rate_check()) {
>> -		skb = ab->skb;
>> -		ab->skb = NULL;
>> +	while ((skb = skb_dequeue(&ab->skb_list)))
>> +		__audit_log_end(skb);
>>  
>> -		/* setup the netlink header, see the comments in
>> -		 * kauditd_send_multicast_skb() for length quirks */
>> -		nlh = nlmsg_hdr(skb);
>> -		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
>> -
>> -		/* queue the netlink packet and poke the kauditd thread */
>> -		skb_queue_tail(&audit_queue, skb);
>> +	/* poke the kauditd thread */
>> +	if (audit_rate_check())
>>  		wake_up_interruptible(&kauditd_wait);
>> -	} else
>> -		audit_log_lost("rate limit exceeded");
> .. here is another case where you've missed/ignored previous feedback.
> I believe this is the second revision in the history of this patchset
> where you've missed feedback; *please* try to do better Casey, stuff like
> this wastes time and drags things out longer than needed.
>
> https://lore.kernel.org/audit/fc242f4c853fee16e587e9c78e1f282e@paul-moore.com

My bad. I've been staring at this patch for over five years and sometimes
can't see where it has, hasn't or needs to be changed. I mucked this up
while pulling the indentation fixes into the separate patch.

>>  	audit_buffer_free(ab);
>>  }
> --
> paul-moore.com
>
