Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD1C56201
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 07:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8181206DC
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 07:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ3H6I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 03:58:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3H6I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 03:58:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMvn93PZmzhd2n;
        Fri, 30 Oct 2020 15:58:05 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 15:57:53 +0800
Subject: Re: [RFC PATCH v2] selinux: Fix kmemleak after disabling selinux
 runtime
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Chen Jun <chenjun102@huawei.com>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
CC:     <stephen.smalley.work@gmail.com>, <eparis@parisplace.org>,
        <rui.xiang@huawei.com>, <guohanjun@huawei.com>
References: <20201028020615.8789-1-chenjun102@huawei.com>
 <c2eba2fb-79f8-eb48-ddd1-77fbc205ebff@schaufler-ca.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <c9e1646e-f242-4d76-f482-f6281585860e@huawei.com>
Date:   Fri, 30 Oct 2020 15:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2eba2fb-79f8-eb48-ddd1-77fbc205ebff@schaufler-ca.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On 2020/10/29 0:29, Casey Schaufler wrote:
> On 10/27/2020 7:06 PM, Chen Jun wrote:
>> From: Chen Jun <c00424029@huawei.com>
>>
>> Kmemleak will report a problem after using
>> "echo 1 > /sys/fs/selinux/disable" to disable selinux on runtime.
> 
> Runtime disable of SELinux has been deprecated. It would be
> wasteful to make these changes in support of a facility that
> is going away.
> 
But this sysfs file will still be present and workable on LTS kernel versions, so
is the proposed fixe OK for these LTS kernel versions ?

Regards,
Tao


>>
>> kmemleak report：
>> unreferenced object 0xffff901281c208a0 (size 96):
>>   comm "swapper/0", pid 1, jiffies 4294668265 (age 692.799s)
>>   hex dump (first 32 bytes):
>>     00 40 c8 81 12 90 ff ff 03 00 00 00 05 00 00 00  .@..............
>>     03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<0000000014622ef8>] selinux_sb_alloc_security+0x1b/0xa0
>>     [<00000000044914e1>] security_sb_alloc+0x1d/0x30
>>     [<000000009f9d5ffd>] alloc_super+0xa7/0x310
>>     [<000000003c5f0b5b>] sget_fc+0xca/0x230
>>     [<00000000367a9996>] vfs_get_super+0x37/0x110
>>     [<000000001c47e818>] vfs_get_tree+0x20/0xc0
>>     [<00000000d239b404>] fc_mount+0x9/0x30
>>     [<00000000708a102f>] vfs_kern_mount.part.36+0x6a/0x80
>>     [<000000005db542fe>] kern_mount+0x1b/0x30
>>     [<0000000051919f9f>] init_sel_fs+0x8b/0x119
>>     [<000000000f328fe0>] do_one_initcall+0x3f/0x1d0
>>     [<000000008a6ceb81>] kernel_init_freeable+0x1b4/0x1f2
>>     [<000000003a425dcd>] kernel_init+0x5/0x110
>>     [<000000004e8d6c9d>] ret_from_fork+0x22/0x30
>>
>> "echo 1 > /sys/fs/selinux/disable" will delete the hooks.
>> Any memory alloced by calling HOOKFUNCTION (like call_int_hook(sb_alloc_security, 0, sb))
>> has no chance to be freed after deleting hooks.
>>
>> Add a flag to mark a hook not be delete when deleting hooks.
>>
>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> ---
>>  include/linux/lsm_hooks.h |  6 +++++-
>>  security/selinux/hooks.c  | 20 ++++++++++----------
>>  2 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index c503f7ab8afb..85de731b0c74 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1554,6 +1554,7 @@ struct security_hook_list {
>>  	struct hlist_head		*head;
>>  	union security_list_options	hook;
>>  	char				*lsm;
>> +	bool				no_del;
>>  } __randomize_layout;
>>  
>>  /*
>> @@ -1582,6 +1583,8 @@ struct lsm_blob_sizes {
>>   */
>>  #define LSM_HOOK_INIT(HEAD, HOOK) \
>>  	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
>> +#define LSM_HOOK_INIT_NO_DEL(HEAD, HOOK) \
>> +	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK }, .no_del = 1 }
>>  
>>  extern struct security_hook_heads security_hook_heads;
>>  extern char *lsm_names;
>> @@ -1638,7 +1641,8 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>>  	int i;
>>  
>>  	for (i = 0; i < count; i++)
>> -		hlist_del_rcu(&hooks[i].list);
>> +		if (!hooks[i].no_del)
>> +			hlist_del_rcu(&hooks[i].list);
>>  }
>>  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>>  
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 6b1826fc3658..daff084fd1c7 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6974,8 +6974,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
>>  	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
>>  
>> -	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>> -	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>> +	LSM_HOOK_INIT_NO_DEL(sb_free_security, selinux_sb_free_security),
>> +	LSM_HOOK_INIT_NO_DEL(sb_free_mnt_opts, selinux_free_mnt_opts),
>>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>>  	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>> @@ -7081,7 +7081,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  
>>  	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
>>  	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
>> -	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
>> +	LSM_HOOK_INIT_NO_DEL(release_secctx, selinux_release_secctx),
>>  	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
>>  	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
>>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>> @@ -7107,7 +7107,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(socket_getpeersec_stream,
>>  			selinux_socket_getpeersec_stream),
>>  	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
>> -	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
>> +	LSM_HOOK_INIT_NO_DEL(sk_free_security, selinux_sk_free_security),
>>  	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
>>  	LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
>>  	LSM_HOOK_INIT(sock_graft, selinux_sock_graft),
>> @@ -7121,7 +7121,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
>>  	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
>>  	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
>> -	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
>> +	LSM_HOOK_INIT_NO_DEL(tun_dev_free_security, selinux_tun_dev_free_security),
>>  	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
>>  	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
>>  	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
>> @@ -7130,7 +7130,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
>>  	LSM_HOOK_INIT(ib_endport_manage_subnet,
>>  		      selinux_ib_endport_manage_subnet),
>> -	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
>> +	LSM_HOOK_INIT_NO_DEL(ib_free_security, selinux_ib_free_security),
>>  #endif
>>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
>>  	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
>> @@ -7144,7 +7144,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  #endif
>>  
>>  #ifdef CONFIG_KEYS
>> -	LSM_HOOK_INIT(key_free, selinux_key_free),
>> +	LSM_HOOK_INIT_NO_DEL(key_free, selinux_key_free),
>>  	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>>  	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>>  #ifdef CONFIG_KEY_NOTIFICATIONS
>> @@ -7162,13 +7162,13 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(bpf, selinux_bpf),
>>  	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
>>  	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
>> -	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>> -	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>> +	LSM_HOOK_INIT_NO_DEL(bpf_map_free_security, selinux_bpf_map_free),
>> +	LSM_HOOK_INIT_NO_DEL(bpf_prog_free_security, selinux_bpf_prog_free),
>>  #endif
>>  
>>  #ifdef CONFIG_PERF_EVENTS
>>  	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
>> -	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
>> +	LSM_HOOK_INIT_NO_DEL(perf_event_free, selinux_perf_event_free),
>>  	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
>>  	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
>>  #endif
> .
> 
