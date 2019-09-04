Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB7C3A5A8
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F82087E
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 16:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfIDQrB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:47:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60698 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbfIDQrA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 12:47:00 -0400
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1i5YQn-00061s-AT; Wed, 04 Sep 2019 16:46:53 +0000
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for the
 SELinux blob
To:     Stephen Smalley <sds@tycho.nsa.gov>, paul@paul-moore.com
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
 <38c27c97-d525-9afb-3f2d-9d3190444ae2@tycho.nsa.gov>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <412bc898-d142-081b-b86d-523348994ece@canonical.com>
Date:   Wed, 4 Sep 2019 09:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <38c27c97-d525-9afb-3f2d-9d3190444ae2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 8:31 AM, Stephen Smalley wrote:
> On 9/4/19 10:32 AM, Stephen Smalley wrote:
>> We need to use selinux_cred() to fetch the SELinux cred blob instead
>> of directly using current->security or current_security().  There
>> were a couple of lingering uses of current_security() in the SELinux code
>> that were apparently missed during the earlier conversions. IIUC, this
>> would only manifest as a bug if multiple security modules including
>> SELinux are enabled and SELinux is not first in the lsm order.
> 
> To further qualify that, it would only manifest as a bug if multiple non-exclusive security modules that use the cred security blob are enabled and SELinux is not first.  I don't think that is possible today in existing upstream kernels since the cred blob-using modules are currently all exclusive and tomoyo switched to using the task security blob instead.  Obviously that will change if/when the stacking for AA support lands and may already be an issue in Ubuntu depending on what stacking patchsets and what lsm order it is using.

Yes currently SELinux needs to be first in the stack for a few reasons. I haven't really played a lot with full SELinux and AA policy at the host level, instead focusing on running an Ubuntu container on an selinux based host. With SELinux and AA competing for userspace interfaces it currently only makes sense to specify SELinux first. I may have run into this bug when messing with the selinux namespacing patches to experiment with flipping the container order but there are enough other problems with that series that I can't say for sure.


> 
>> After
>> this change, there appear to be no other users of current_security()
>> in-tree; perhaps we should remove it altogether.
>>
>> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   security/selinux/hooks.c          |  2 +-
>>   security/selinux/include/objsec.h | 20 ++++++++++----------
>>   2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index d55571c585ff..f1b763eceef9 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -3435,7 +3435,7 @@ static int selinux_inode_copy_up_xattr(const char *name)
>>   static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
>>                       struct kernfs_node *kn)
>>   {
>> -    const struct task_security_struct *tsec = current_security();
>> +    const struct task_security_struct *tsec = selinux_cred(current_cred());
>>       u32 parent_sid, newsid, clen;
>>       int rc;
>>       char *context;
>> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
>> index 231262d8eac9..d2e00c7595dd 100644
>> --- a/security/selinux/include/objsec.h
>> +++ b/security/selinux/include/objsec.h
>> @@ -40,16 +40,6 @@ struct task_security_struct {
>>       u32 sockcreate_sid;    /* fscreate SID */
>>   };
>>   -/*
>> - * get the subjective security ID of the current task
>> - */
>> -static inline u32 current_sid(void)
>> -{
>> -    const struct task_security_struct *tsec = current_security();
>> -
>> -    return tsec->sid;
>> -}
>> -
>>   enum label_initialized {
>>       LABEL_INVALID,        /* invalid or not initialized */
>>       LABEL_INITIALIZED,    /* initialized */
>> @@ -188,4 +178,14 @@ static inline struct ipc_security_struct *selinux_ipc(
>>       return ipc->security + selinux_blob_sizes.lbs_ipc;
>>   }
>>   +/*
>> + * get the subjective security ID of the current task
>> + */
>> +static inline u32 current_sid(void)
>> +{
>> +    const struct task_security_struct *tsec = selinux_cred(current_cred());
>> +
>> +    return tsec->sid;
>> +}
>> +
>>   #endif /* _SELINUX_OBJSEC_H_ */
>>
> 

