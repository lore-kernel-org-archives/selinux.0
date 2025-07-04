Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648711F0E58
	for <selinux@vger.kernel.org>; Fri,  4 Jul 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661545; cv=none; b=NK99OPokXESeZAOj9Zdd0LwWL/VbcuU714RoUBfqsHNC1XZEYvk50UbLcY5RLIW3mUcz/ht0jTD1P6KxsaG8IWVZUIU4z+2VTzRtc/p79kfpDTsUP1cGzxFZjzThSpl+qmnERhR5MIl++tlUdsMhkNduaMMx0i6EnKCpQagDgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661545; c=relaxed/simple;
	bh=wmTwb/ESj8mt3RdCb/bQcf81LWxmx7wO751Td3wNT7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEFDrEaJEqSsQbKHTouuDA1KxFOU3xrNMYaqePV9IzixCxRg+QngjrE/UwJvX01lc9dgUwh0ZNujZs3v5GAjmJMWsgNdtelACbBlf1sD38x3Or/f0NE/h0UZ3WyMRhKmsUuYKZtpb/ZWgUT68W+8VER9Z70lIAKaTDft24JpI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bEpIL4mj; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bEpIL4mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1751661542; bh=BFdTymDCauQuYahgXXk7TeWFJYMaJlv8kgHtcNY0uuk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bEpIL4mjminAkl/22MlZYMF0vHpLlKpggKyV1TPgAyHvOOpq6r0GjToPGrwp/N3plqF/Sl8QLiTZDw925wkwGrVogpIQkiqgDo22l3C8ByW49Tm0Uc28fJ3Tg8mOuCSrxTMT6/8n2Zf7Zu2F8ok7J1SGvls4JWLMo0et2Ry//U9FfTUdtvrp0+sbHGq9vOwagHfW8e0rBwZHEO4gMpoAlvW0fySOHXQiNqw0UTutQJ5bYdzf3III2RaG0bAsCNBlfkhPMdw8yMpdSeq5uzurpgH29UeGvyLyf+/v9AnYxfQ/C7vn5Bdj/fmxB5+JuF/n2+c5s1QBKjQGmTRp6gWsJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1751661542; bh=51wc7ldeGpVCYi6ASpTi6L4io5itqoXzAMja8ik89iX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DyeNmyZqAmj6YNHC/F2VfDo866Rd47l4zBb8Cl8LpC4ubt+8F5dcqNOq85bFTzR5EiFxC0Jo8sQFCVhgFlpYwbU5n2elFr6w3ArJ5wOXp9eacvRPn6WB4EvoQpGqQOX5wrY0IzBBlzC2zbNnGcdhFtgfkH3SNGMTX4aFZw6OHE2gy0IVCtt/SSbpbWycAyxMmLfiOkQNkx8jbTP+Bgz932d+dXqPU6vXZhNJRNSCB7crqCMYIl4CQJa7wWwGaLp9f7y2JKnytwxHI1TdzAq5V4LC//q2Urx62hVRppqnGxmDF4DcMKu13PTEF7ANbkR2WWVkCTI9EiHCTmV0iHihuA==
X-YMail-OSG: GtR.pvgVM1mKXLbwN5Q1McAYDhm8smCGUCBDyHlvhvh2O9RjttbXRQE2cKMlqwq
 ngrp_Qptm1jBZq3xe7vStpWTEYXFVQWihSoKnm_WUyD3SYs3i3OXgkolmN1Tu2.h4HkUm.YLk4Ty
 5bV.Axjkmy1w8qY04zno37J8xEdU6SXCotC8eBQv5RLdkdCptGpl7pQ6IJv4F9KDP4vXAlVLCtID
 9UV_A_GjH_JgB.aRuVdJwZzHVr3KhE6Hs7IQqD.cFlROzdRTOAMoI1XSdAqWfY8K2xFUUfdKqn9C
 afGLyl8Og_TdCFj95QfVeiws0FADcaMIEAGmEeMEy2gqCY1wJWcgtCtOYMEyzroERlGY9aJmh30T
 253RdUcBR5YkiJ_9ALO9dbL9prHEoXUuYpBoLF8xsRsKeH_KBe1VmOr.2cJy5CFr2uqQqaByTgFW
 54xucmdy_iJ6seNUvehFP89zcAe64Wpigoi_xrey9BM_NtoDNYWuZu1manpbcjUkbErBJwiZ5BwG
 H708YgWZwOFUHWgtS2c8h_imsXOq.2fjYj.e12wEss2nzEHwLCFlLVuudGekXTWDIp1hNdwQ6FXM
 VSJNc9N93nbfdoWzn1RN_JmwZs2ph2RD7YnwtwRp8nKcJApXihFZrrni7iqdUec7Cveh2SlMPH.k
 doCt75Ije3yU_KkZh88QYBxvAO7STtiYHx.l3yBW0ISDSCXAM8OCj0_nJhZzN8602Vklfp9GxfSE
 9prfe8.pZw6.jXO70GajeinpUTwbPfxTi4Fh_3MnL02UV1cOtYDT7D8JaEy38gtIem9WX1WWob3J
 YJOWbc6LS2Fd5aic99RQ.z82joRK2d7W1mlgZGkbnv26EVRHRofuWWjxUPbq1f4.G8r6DVJmDVCZ
 ZfHYyVjWurOlWY46mSCBOeN6oU0pIfwhlC._pULYsu7XVSEz.aPDvgMt8n.2vZNClagSIpijtPqc
 m1ZA5eMvjJl6OmBB3nn7Lf1eF0IYOXtGWUBJIkGZXZmmMwxMIosOQa0V12ObjOeUmPuvpHWwaOG_
 luJLJNtDHmf2tETqdzsAuWQFya.XLMuKC5ySnJqTI7v.o9Ah0MhrojAt8J5Y6iXP9r2ks6XdWQns
 F90EZAtpvfA1mY65UND18YCp06.tXgRAeAZF_Y_PCBt2XHF5Y.hmyBfGlrPXls.VwKdtFBouXoLY
 vkzY.iyFq3uutsovzmt83iygQ.RIo5SGKpo7faoqvjN7wbiXvcTwV4Z_qHEKZ8FRwwr2MVQQ63zT
 1OWupSSJaSR_nTqnK7cR4BxziRqUm_pH26dZt8IWIymi.prmtag4gXpA9oSh3HehIcQgDBi5tdGL
 lncjEyEii.N6sVIsIhP5ERt7iKT9_8lOKzdY0_e84O6dCVEUWwtHue2DONocXIqTcr6V51Dw8SAN
 eIu6NlAqzwBW9YE7yUUgxPHJYNpdWd_fg6V_kdjDlZApls9uNNCI6DALK3fqahi.A.RxRYA7uoLc
 KpprzdyqSj0wl7x2FqxGRf0q1tiGHhx67DP_duW87sZosyYLjhZlM2RV51lx.AK18Xk7UhzCWCOf
 .ERYNFeHXrjdAjUv.YcwP_iYkdHO7IwyzsWY3XhpPckoOhTtjfT5Ff3ziNIt9lWvrSMVpUzueqNB
 xerJHscMhrpMPHLCC5z4dVw930uRyACxSIrXXrky1JsfCUWShB6o6FSarNhqa1VEDPZtD3e2or1E
 Jlo6VdNxUO2.90hupj6SRHmNLW_IFRNHtdrQqwjkvOUvnU.qh0NMn19dlIRP0aFQUfQuCzywDzWC
 UEcoH5UfV7VOmIDsv_8EIFvG79D0T4lG9pcXGUw79.1ZBR3xAKBjbBYO3r0JE23MQPUwu_9XsCyQ
 42V85hUmynSD8DGFK8hXmhwPcDxEJcUwg8yd7qYCLClHjY5w.OpTDn3JtZreHvBkFG5V2cxPJ8Cq
 TIsFlGBA7_gSgILmFlg31OKxej.bI3YV30hmLz4OLPnNDQUelE7VQCddKjSB_Q8xMjiwhds6dW_F
 7gWdW2lSzljEe7Emqhxi5qQRptpCIgY_1gzLF2yDC84KA3pmJflVqqjBdLWIdatttxykN2gZKeKL
 UiwzLf8PfBxIYYqaDZN6eRvBc0tslFFiGmaIZ_ta3Bjh1iN0hxgBIXQIiEQhN5KO_OOKzgbbFDji
 HyjxHLK4g9Q2M0I5spmGRXQwqcjk85kNnmHMYUjpdvjPCLRQjDACM5HkMm5GIebB2eiVBwUG.TUS
 GUs6Gg9oS0xm33NyZPBUKB590BL76klMYkmfaDQSz6WSSVfZK50umHPy.ETVZLnFvue5.F11OISQ
 hyZo3yviXRfBn9e7wG1luC9fZGRDw
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fa6aedc0-9693-446b-ab2c-8b3725ad2efb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 4 Jul 2025 20:39:02 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce5598f86d5bbd8e79ee8ba7cd309f9a;
          Fri, 04 Jul 2025 20:18:42 +0000 (UTC)
Message-ID: <9fcc7e8f-7d5c-4499-9693-787bd7ecc8ed@schaufler-ca.com>
Date: Fri, 4 Jul 2025 13:18:41 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] Audit: Add record for multiple object contexts
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250607005134.10488-5-casey@schaufler-ca.com>
 <88f740c7efa914435e2223e90666c8b2@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <88f740c7efa914435e2223e90666c8b2@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24099 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/16/2025 1:54 PM, Paul Moore wrote:
> On Jun  6, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
>> An example of the MAC_OBJ_CONTEXTS record is:
>>
>>     type=MAC_OBJ_CONTEXTS
>>     msg=audit(1601152467.009:1050):
>>     obj_selinux=unconfined_u:object_r:user_home_t:s0
>>
>> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
>> the "obj=" field in other records in the event will be "obj=?".
>> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
>> multiple security modules that may make access decisions based
>> on an object security context.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/audit.h      |  7 +++++
>>  include/uapi/linux/audit.h |  1 +
>>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>>  kernel/auditsc.c           | 45 ++++++++---------------------
>>  security/selinux/hooks.c   |  3 +-
>>  security/smack/smack_lsm.c |  3 +-
>>  6 files changed, 80 insertions(+), 37 deletions(-)
> ..
>
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 0987b2f391cc..451c36965889 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -2337,6 +2344,55 @@ int audit_log_task_context(struct audit_buffer *ab)
>>  }
>>  EXPORT_SYMBOL(audit_log_task_context);
>>  
>> +int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
>> +{
>> +	int i;
>> +	int rc;
>> +	int error = 0;
>> +	char *space = "";
>> +	struct lsm_context ctx;
>> +
>> +	if (audit_obj_secctx_cnt < 2) {
>> +		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
>> +		if (error < 0) {
>> +			if (error != -EINVAL)
>> +				goto error_path;
>> +			return error;
>> +		}
>> +		audit_log_format(ab, " obj=%s", ctx.context);
>> +		security_release_secctx(&ctx);
>> +		return 0;
>> +	}
>> +	audit_log_format(ab, " obj=?");
>> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
>> +	if (error)
>> +		goto error_path;
>> +
>> +	for (i = 0; i < audit_obj_secctx_cnt; i++) {
>> +		rc = security_lsmprop_to_secctx(prop, &ctx,
>> +						audit_obj_lsms[i]->id);
>> +		if (rc < 0) {
>> +			audit_log_format(ab, "%sobj_%s=?", space,
>> +					 audit_obj_lsms[i]->name);
>> +			if (rc != -EINVAL)
>> +				audit_panic("error in audit_log_obj_ctx");
>> +			error = rc;
> Do we need the same logic as in audit_log_subj_ctx()?

I seriously debated the issue. Subjects always have data to put in
the aux record. Objects may or may not, in the AppArmor case. Not having
a subject context is an error, not having an object context is interesting,
but not necessarily an error. Hence the different treatment. You can tell
me I'm wrong, and I'll make them consistent.

>
>> +		} else {
>> +			audit_log_format(ab, "%sobj_%s=%s", space,
>> +					 audit_obj_lsms[i]->name, ctx.context);
>> +			security_release_secctx(&ctx);
>> +		}
>> +		space = " ";
>> +	}
>> +
>> +	audit_buffer_aux_end(ab);
>> +	return error;
>> +
>> +error_path:
>> +	audit_panic("error in audit_log_obj_ctx");
>> +	return error;
>> +}
>> +
>>  void audit_log_d_path_exe(struct audit_buffer *ab,
>>  			  struct mm_struct *mm)
>>  {
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 322d4e27f28e..0c28fa33d099 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -1098,7 +1098,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>>  				 char *comm)
>>  {
>>  	struct audit_buffer *ab;
>> -	struct lsm_context ctx;
>>  	int rc = 0;
>>  
>>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>> @@ -1108,15 +1107,9 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>>  			 from_kuid(&init_user_ns, auid),
>>  			 from_kuid(&init_user_ns, uid), sessionid);
>> -	if (lsmprop_is_set(prop)) {
>> -		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
>> -			audit_log_format(ab, " obj=(none)");
>> -			rc = 1;
>> -		} else {
>> -			audit_log_format(ab, " obj=%s", ctx.context);
>> -			security_release_secctx(&ctx);
>> -		}
>> -	}
>> +	if (lsmprop_is_set(prop) && audit_log_obj_ctx(ab, prop))
>> +		rc = 1;
> We should probably use the return value from audit_log_obj_ctx().

Sure.

>
>>  	audit_log_format(ab, " ocomm=");
>>  	audit_log_untrustedstring(ab, comm);
>>  	audit_log_end(ab);
> ..
>
>> @@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
>>  						  axs->target_sessionid[i],
>>  						  &axs->target_ref[i],
>>  						  axs->target_comm[i]))
>> -				call_panic = 1;
>> +			call_panic = 1;
>>  	}
>>  
>>  	if (context->target_pid &&
>>  	    audit_log_pid_context(context, context->target_pid,
>>  				  context->target_auid, context->target_uid,
>>  				  context->target_sessionid,
>> -				  &context->target_ref, context->target_comm))
>> -			call_panic = 1;
>> +				  &context->target_ref,
>> +				  context->target_comm))
>> +		call_panic = 1;
> I appreciate the indent fixes, would you mind pulling this out and
> submitting them separately?

Sure.

>
> --
> paul-moore.com
