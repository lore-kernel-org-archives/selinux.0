Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59DCC00454
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83584207FD
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="NuRHEGYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfLIN6E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:58:04 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:50768 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIN6D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 08:58:03 -0500
X-EEMSG-check-017: 58423083|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="58423083"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Dec 2019 13:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575899882; x=1607435882;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9A7wfU8u4Gs1r1qYyGKMIIOL7zk3nxeTOyCtJIhVIUQ=;
  b=NuRHEGYqcGYHo/d2a31y8X4cC0PJOt7+BqLVFhpMroL8lJGYp7+u65yC
   gqAtZ2s8h1/fBgvWLAjaDY42jEMW9aR5BtCGho7d/2kppU212oUhs8ycH
   E37pYDcrrCqlhEJnRi51S+vN9Hja8Yx+MWWrFho+w+4nh2J8hq0UYDDx2
   G3oWnLiOzLQhwmVLNI+gZ5ecQ44bB4DxhzkWLgXF+rFQp2QrVXAZVAw28
   l4Gw/SOL9jN3WWLE60oyYY8XRoDVRxe1/kzSZugt7KNTk67lVqLRhBaXn
   55Zk0hiiOW7MZlcd6uqSHmioc9dPw4eUyMMmvW04Zwkjn+09TCIEAvQ0q
   g==;
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="30890757"
IronPort-PHdr: =?us-ascii?q?9a23=3AeLyz1RLqm+A5aYNhQNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXK/7zrarrMEGX3/hxlliBBdydt6sfzbOH6+u9BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAHNusUZgYZvKLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03e?=
 =?us-ascii?q?Q/HwHI3wIuEdwBv3vWo9rpO6kfSvy1warSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHN09KeAmcgoj1O1DBPPD4DfClj1Sqizdk3erKPrLmApXTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1ddf55dTCrEaJvL8QFP+u8LDAx8jLQO73ubnB89h1o8ERW2PBa?=
 =?us-ascii?q?qZOrvIsVCU/uIvP/WMZIgNtTbmNfcl4//ujXkkmV4SZqSpw5QXZ26iHvh8IE?=
 =?us-ascii?q?WWf2DsgtEfHmcOpAY+S/bqiFKaWz5Je3myR7485i08CI++FYfMXJ2tgLia0S?=
 =?us-ascii?q?ejBJJWe2RGBkmJEXfvcIWEQekDZDiOLc9mlzwOTaKhRJM51RGyqA/6zKJqLu?=
 =?us-ascii?q?7V+i0eqJLi28F55/bNmh4u6Dx0FcWd032NTm1tm2MIQCI53L17oUNj0VqDz6?=
 =?us-ascii?q?d4jOJCFdBJ5PNGTB06NZjCwOx+EdzyXRjBftjaAGqhF/KgDSs8TJoUxMQIak?=
 =?us-ascii?q?1wGJ32iRXExCyjCLI9jbGHBJUotKnb2i61b91wz3fAybkJkVYrWI1MOHegi6?=
 =?us-ascii?q?o58BLcQ8bxmlid34Otcr4RlHrV/XqH5XKHoUUdVQl3S6iDVncaMA+eie/crh?=
 =?us-ascii?q?fGTrmzGfE8PwBc08+eO+5PbdH0iVhuWvjuIpLdbni3lmP2AgyHkOCido3vLl?=
 =?us-ascii?q?4B0T3dBU5MqAUa+XKLJEBqHSu6i37PBzxpU1T0agXj9vco+yDzdVM90wzfNx?=
 =?us-ascii?q?4p7LGy4BNAwKXHGv4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AGAQAQUu5d/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEAokDhmgGgRIlgQGIaI9egWcJAQEBAQEBAQEBNwEBhEACg?=
 =?us-ascii?q?j04EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbgEFIw8BBVEJAg4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAReCPAw/glMlj2ebdIEyiQWBSIEOKIwyeYEHgREnDAOCKDU+hAMug?=
 =?us-ascii?q?yiCXgSNESSKCZcbgjiCO4oRiRQGG4JCh3OEQIs9jkqcPCKBWCsIAhgIIQ87g?=
 =?us-ascii?q?mxQERSMcheOQSMDMIxfgjIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Dec 2019 13:57:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB9Dvdhi068334;
        Mon, 9 Dec 2019 08:57:39 -0500
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        LSM <linux-security-module@vger.kernel.org>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
Message-ID: <ecfd3846-b38f-4b85-4568-d64625c490ac@tycho.nsa.gov>
Date:   Mon, 9 Dec 2019 08:58:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/19 8:21 AM, Stephen Smalley wrote:
> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
>> infrastructure to use per-hook lists, which meant that removing the
>> hooks for a given module was no longer atomic. Even though the commit
>> clearly documents that modules implementing runtime revmoval of hooks
>> (only SELinux attempts this madness) need to take special precautions to
>> avoid race conditions, SELinux has never addressed this.
>>
>> By inserting an artificial delay between the loop iterations of
>> security_delete_hooks() (I used 100 ms), booting to a state where
>> SELinux is enabled, but policy is not yet loaded, and running these
>> commands:
>>
>>      while true; do ping -c 1 <some IP>; done &
>>      echo -n 1 >/sys/fs/selinux/disable
>>      kill %1
>>      wait
>>
>> ...I was able to trigger NULL pointer dereferences in various places. I
>> also have a report of someone getting panics on a stock RHEL-8 kernel
>> after setting SELINUX=disabled in /etc/selinux/config and rebooting
>> (without adding "selinux=0" to kernel command-line).
>>
>> Reordering the SELinux hooks such that those that allocate structures
>> are removed last seems to prevent these panics. It is very much possible
>> that this doesn't make the runtime disable completely race-free, but at
>> least it makes the operation much less fragile.
>>
>> An alternative (and safer) solution would be to add NULL checks to each
>> hook, but doing this just to support the runtime disable hack doesn't
>> seem to be worth the effort...
> 
> Personally, I would prefer to just get rid of runtime disable 
> altogether; it also precludes making the hooks read-only after 
> initialization.  IMHO, selinux=0 is the proper way to disable SELinux if 
> necessary.  I believe there is an open bugzilla on Fedora related to 
> this issue, since runtime disable was originally introduced for Fedora.

Also, if we have to retain this support, it seems like this ought to be 
fixed in the LSM framework especially since it was a change there that 
broke the SELinux implementation.

> 
>>
>> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>   security/selinux/hooks.c | 97 +++++++++++++++++++++++++++-------------
>>   1 file changed, 66 insertions(+), 31 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 116b4d644f68..5075be8eea2a 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6864,6 +6864,21 @@ static int selinux_perf_event_write(struct 
>> perf_event *event)
>>   }
>>   #endif
>> +/*
>> + * IMPORTANT NOTE: When adding new hooks, please be careful to keep 
>> this order:
>> + * 1. any hooks that don't belong to (2.) or (3.) below,
>> + * 2. hooks that both access structures allocated by other hooks, and 
>> allocate
>> + *    structures that can be later accessed by other hooks (mostly 
>> "cloning"
>> + *    hooks),
>> + * 3. hooks that only allocate structures that can be later accessed 
>> by other
>> + *    hooks ("allocating" hooks).
>> + *
>> + * Please follow block comment delimiters in the list to keep this 
>> order.
>> + *
>> + * This ordering is needed for SELinux runtime disable to work at 
>> least somewhat
>> + * safely. Breaking the ordering rules above might lead to NULL 
>> pointer derefs
>> + * when disabling SELinux at runtime.
>> + */
>>   static struct security_hook_list selinux_hooks[] __lsm_ro_after_init 
>> = {
>>       LSM_HOOK_INIT(binder_set_context_mgr, 
>> selinux_binder_set_context_mgr),
>>       LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>> @@ -6886,12 +6901,7 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(bprm_committing_creds, 
>> selinux_bprm_committing_creds),
>>       LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
>> -    LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>> -    LSM_HOOK_INIT(fs_context_parse_param, 
>> selinux_fs_context_parse_param),
>> -
>> -    LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
>>       LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>> -    LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
>>       LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>>       LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>>       LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>> @@ -6901,12 +6911,10 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(sb_umount, selinux_umount),
>>       LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>>       LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
>> -    LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
>>       LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
>>       LSM_HOOK_INIT(dentry_create_files_as, 
>> selinux_dentry_create_files_as),
>> -    LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
>>       LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
>>       LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
>>       LSM_HOOK_INIT(inode_create, selinux_inode_create),
>> @@ -6978,21 +6986,15 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
>>       LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
>> -    LSM_HOOK_INIT(msg_msg_alloc_security, 
>> selinux_msg_msg_alloc_security),
>> -
>> -    LSM_HOOK_INIT(msg_queue_alloc_security,
>> -            selinux_msg_queue_alloc_security),
>>       LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
>>       LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
>>       LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
>>       LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
>> -    LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
>>       LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
>>       LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
>>       LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
>> -    LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
>>       LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
>>       LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
>>       LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
>> @@ -7003,13 +7005,11 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>>       LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
>> -    LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
>>       LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
>>       LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
>>       LSM_HOOK_INIT(inode_invalidate_secctx, 
>> selinux_inode_invalidate_secctx),
>>       LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
>>       LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>> -    LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>>       LSM_HOOK_INIT(unix_stream_connect, 
>> selinux_socket_unix_stream_connect),
>>       LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
>> @@ -7032,7 +7032,6 @@ static struct security_hook_list selinux_hooks[] 
>> __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(socket_getpeersec_stream,
>>               selinux_socket_getpeersec_stream),
>>       LSM_HOOK_INIT(socket_getpeersec_dgram, 
>> selinux_socket_getpeersec_dgram),
>> -    LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
>>       LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
>>       LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
>>       LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
>> @@ -7047,7 +7046,6 @@ static struct security_hook_list selinux_hooks[] 
>> __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
>>       LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
>>       LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
>> -    LSM_HOOK_INIT(tun_dev_alloc_security, 
>> selinux_tun_dev_alloc_security),
>>       LSM_HOOK_INIT(tun_dev_free_security, 
>> selinux_tun_dev_free_security),
>>       LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
>>       LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
>> @@ -7057,17 +7055,11 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
>>       LSM_HOOK_INIT(ib_endport_manage_subnet,
>>                 selinux_ib_endport_manage_subnet),
>> -    LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
>>       LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
>>   #endif
>>   #ifdef CONFIG_SECURITY_NETWORK_XFRM
>> -    LSM_HOOK_INIT(xfrm_policy_alloc_security, 
>> selinux_xfrm_policy_alloc),
>> -    LSM_HOOK_INIT(xfrm_policy_clone_security, 
>> selinux_xfrm_policy_clone),
>>       LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
>>       LSM_HOOK_INIT(xfrm_policy_delete_security, 
>> selinux_xfrm_policy_delete),
>> -    LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
>> -    LSM_HOOK_INIT(xfrm_state_alloc_acquire,
>> -            selinux_xfrm_state_alloc_acquire),
>>       LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
>>       LSM_HOOK_INIT(xfrm_state_delete_security, 
>> selinux_xfrm_state_delete),
>>       LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
>> @@ -7077,14 +7069,12 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>   #endif
>>   #ifdef CONFIG_KEYS
>> -    LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
>>       LSM_HOOK_INIT(key_free, selinux_key_free),
>>       LSM_HOOK_INIT(key_permission, selinux_key_permission),
>>       LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>>   #endif
>>   #ifdef CONFIG_AUDIT
>> -    LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
>>       LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
>>       LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
>>       LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
>> @@ -7094,19 +7084,64 @@ static struct security_hook_list 
>> selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(bpf, selinux_bpf),
>>       LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
>>       LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
>> -    LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
>> -    LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
>>       LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>>       LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>>   #endif
>>   #ifdef CONFIG_PERF_EVENTS
>>       LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
>> -    LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>>       LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
>>       LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
>>       LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
>>   #endif
>> +
>> +    /*
>> +     * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>> +     */
>> +    LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>> +    LSM_HOOK_INIT(fs_context_parse_param, 
>> selinux_fs_context_parse_param),
>> +    LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
>> +    LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
>> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
>> +    LSM_HOOK_INIT(xfrm_policy_clone_security, 
>> selinux_xfrm_policy_clone),
>> +#endif
>> +
>> +    /*
>> +     * PUT "ALLOCATING" HOOKS HERE
>> +     */
>> +    LSM_HOOK_INIT(msg_msg_alloc_security, 
>> selinux_msg_msg_alloc_security),
>> +    LSM_HOOK_INIT(msg_queue_alloc_security,
>> +              selinux_msg_queue_alloc_security),
>> +    LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
>> +    LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
>> +    LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
>> +    LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
>> +    LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
>> +    LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>> +    LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
>> +    LSM_HOOK_INIT(tun_dev_alloc_security, 
>> selinux_tun_dev_alloc_security),
>> +#ifdef CONFIG_SECURITY_INFINIBAND
>> +    LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
>> +#endif
>> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
>> +    LSM_HOOK_INIT(xfrm_policy_alloc_security, 
>> selinux_xfrm_policy_alloc),
>> +    LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
>> +    LSM_HOOK_INIT(xfrm_state_alloc_acquire,
>> +              selinux_xfrm_state_alloc_acquire),
>> +#endif
>> +#ifdef CONFIG_KEYS
>> +    LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
>> +#endif
>> +#ifdef CONFIG_AUDIT
>> +    LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
>> +#endif
>> +#ifdef CONFIG_BPF_SYSCALL
>> +    LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
>> +    LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
>> +#endif
>> +#ifdef CONFIG_PERF_EVENTS
>> +    LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>> +#endif
>>   };
>>   static __init int selinux_init(void)
>> @@ -7287,14 +7322,14 @@ int selinux_disable(struct selinux_state *state)
>>       selinux_enabled = 0;
>> +    /* Unregister netfilter hooks. */
>> +    selinux_nf_ip_exit();
>> +
>>       security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
>>       /* Try to destroy the avc node cache */
>>       avc_disable();
>> -    /* Unregister netfilter hooks. */
>> -    selinux_nf_ip_exit();
>> -
>>       /* Unregister selinuxfs. */
>>       exit_sel_fs();
>>
> 

