Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D68CCA47F
	for <selinux@archiver.kernel.org>; Mon, 13 Jun 2022 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiFMP4g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbiFMP4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jun 2022 11:56:11 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8920193221
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 06:46:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s8so7788392oib.6
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F8034aqgQYOIDnTJYbKnqdxe/P3NxT2RcNrYib0/ruQ=;
        b=R4MMR5hyemRuM3l2mh4JZIS+Ysd67mGMs9w57QzxuAYNivT2oR2uA0ccLItOXx/Nff
         HI6/bkCTWcHzuf8uaxK0aZVKIRxAzJmo3pQ4NckjHUXisjQlQKqlTIlGGFMleFZ26TS5
         XrbPJQzMEXp3LBINHndQ9fwG3XW2+NnK70OZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F8034aqgQYOIDnTJYbKnqdxe/P3NxT2RcNrYib0/ruQ=;
        b=bp7GoDC62qpO/TlfkhIdW28KA68+0YAQYM9uRnzlxwlb8l/fWZI1kMiErACq5SoBR8
         ODILXK1Yfexssd2/DIUwp3iM+87f90gum/lgeu1o2rozRrJ4MvnCnGcNh7Q61450H0kb
         nzYGjg+/3VXq1i0rHUQHWVvd194rm07k2l/PSTJcRnrqxSXt536u2RN8f8TQ0r2RUm/I
         npBD2SCJnGuca3A51ZSLoXgbONruLVFMVJELZOwraGVgyGeOpItQT7A415G4b6bDLw2Z
         ZlqMjY28NYvu2fnuRp4kpLBKJqdZsWZWf964NbDRl+jlj49PothHYL665/YBOSve++D3
         07Eg==
X-Gm-Message-State: AOAM530Lq1BR9f5Dv98mEfWWwvfnN8aPcsxmgasZAPELn6glsIKlbURh
        /8+luWLreZ6nDI7C56notJbWoA==
X-Google-Smtp-Source: ABdhPJxMf2Qm5H8GA35Xq5n+x+nRvAKUAEETko5C92sldqd/ieCBtB6EHAADbYtdN68bTfZpGjw0Ow==
X-Received: by 2002:aca:b744:0:b0:32f:4c19:cec1 with SMTP id h65-20020acab744000000b0032f4c19cec1mr1696209oif.43.1655128012170;
        Mon, 13 Jun 2022 06:46:52 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id o20-20020a4ad494000000b0035eb4e5a6b5sm3699171oos.11.2022.06.13.06.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 06:46:51 -0700 (PDT)
Message-ID: <b4113083-73de-3ab6-e23f-32c6627d177e@cloudflare.com>
Date:   Mon, 13 Jun 2022 08:46:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] cred: Propagate security_prepare_creds() error code
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        serge@hallyn.com, amir73il@gmail.com, kernel-team@cloudflare.com,
        Jeff Moyer <jmoyer@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20220608150942.776446-1-fred@cloudflare.com>
 <YqJ/0W3wxPThWqgC@sol.localdomain>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <YqJ/0W3wxPThWqgC@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Eric,

On 6/9/22 6:18 PM, Eric Biggers wrote:
> On Wed, Jun 08, 2022 at 10:09:42AM -0500, Frederick Lawler wrote:
>> diff --git a/fs/aio.c b/fs/aio.c
>> index 3c249b938632..5abbe88c3ca7 100644
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -1620,6 +1620,8 @@ static void aio_fsync_work(struct work_struct *work)
>>   static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
>>   		     bool datasync)
>>   {
>> +	int err;
>> +
>>   	if (unlikely(iocb->aio_buf || iocb->aio_offset || iocb->aio_nbytes ||
>>   			iocb->aio_rw_flags))
>>   		return -EINVAL;
>> @@ -1628,8 +1630,11 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
>>   		return -EINVAL;
>>   
>>   	req->creds = prepare_creds();
>> -	if (!req->creds)
>> -		return -ENOMEM;
>> +	if (IS_ERR(req->creds)) {
>> +		err = PTR_ERR(req->creds);
>> +		req->creds = NULL;
>> +		return err;
>> +	}
> 
> This part is a little ugly.  How about doing:
> 
> 	creds = prepare_creds();
> 	if (IS_ERR(creds))
> 		return PTR_ERR(creds);
> 	req->creds = creds;
> 

I can do that, and same for below.

>> diff --git a/fs/exec.c b/fs/exec.c
>> index 0989fb8472a1..02624783e40e 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1468,15 +1468,19 @@ EXPORT_SYMBOL(finalize_exec);
>>    */
>>   static int prepare_bprm_creds(struct linux_binprm *bprm)
>>   {
>> +	int err = -ERESTARTNOINTR;
>>   	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>> -		return -ERESTARTNOINTR;
>> +		return err;
>>   
>>   	bprm->cred = prepare_exec_creds();
>> -	if (likely(bprm->cred))
>> -		return 0;
>> +	if (IS_ERR(bprm->cred)) {
>> +		err = PTR_ERR(bprm->cred);
>> +		bprm->cred = NULL;
>> +		mutex_unlock(&current->signal->cred_guard_mutex);
>> +		return err;
>> +	}
>>   
>> -	mutex_unlock(&current->signal->cred_guard_mutex);
>> -	return -ENOMEM;
>> +	return 0;
>>   }
> 
> Similarly:
> 
> static int prepare_bprm_creds(struct linux_binprm *bprm)
> {
> 	struct cred *cred;
> 
> 	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
> 		return -ERESTARTNOINTR;
> 
> 	cred = prepare_exec_creds();
> 	if (IS_ERR(cred)) {
> 		mutex_unlock(&current->signal->cred_guard_mutex);
> 		return PTR_ERR(cred);
> 	}
> 	bprm->cred = cred;
> 	return 0;
> }
> 
>> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
>> index eec72ca962e2..6cf75aa83b6c 100644
>> --- a/kernel/nsproxy.c
>> +++ b/kernel/nsproxy.c
>> @@ -311,6 +311,7 @@ static void put_nsset(struct nsset *nsset)
>>   
>>   static int prepare_nsset(unsigned flags, struct nsset *nsset)
>>   {
>> +	int err = -ENOMEM;
>>   	struct task_struct *me = current;
>>   
>>   	nsset->nsproxy = create_new_namespaces(0, me, current_user_ns(), me->fs);
>> @@ -324,6 +325,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>>   	if (!nsset->cred)
>>   		goto out;
>>   
>> +	if (IS_ERR(nsset->cred)) {
>> +		err = PTR_ERR(nsset->cred);
>> +		nsset->cred = NULL;
>> +		goto out;
>> +	}
> 
> Why is the NULL check above being kept?
> 

In the branch prior:

	if (flags & CLONE_NEWUSER) {
		nsset->cred = prepare_creds();
	else
		nsset->cred = current_cred();

I don't see cases where others are checking for null after 
current_cred(), therefore I can remove that check.

> Also, drivers/crypto/ccp/sev-dev.c needs to be updated.
> 

Nice catch! I clearly missed addition after the merge window.

> - Eric

