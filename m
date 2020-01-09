Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2318C33CA1
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898372072A
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RNvWvVUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgAIO3W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:29:22 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:62500 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgAIO3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 09:29:21 -0500
X-EEMSG-check-017: 43943162|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="43943162"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 14:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578580158; x=1610116158;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=jb0Rol1i4rztnFUyq6eitHKoPjU9qbf6vD4jnOU72JY=;
  b=RNvWvVUQI2xMMhJEJ/Hmgwl85F3Zk/vdJZChxpPVComg8bpW6aYDfT81
   wNFQrQc5Di9A0i9LJFfrL+mSMHeR8A0eTmw8G0ETrCj1wnXEWGxB6ZSdf
   h2JLvtqntnhYAVYkUghsULXXQ3xZh/nU+SdUOXPOKaDnORoiIFMF5+YdA
   5FK37c/KkJaUAdW9pdNl71DgVc39kWLC4sWThGqyWeXipeoDSeG9bxK40
   9yabvz/ik1PguqEiH5gyqxYQ1WZyGoAOY3T4C/CviZrY0vRCut8D+RX3u
   ZkqtmeLWMZDitLym9X3nxdBJ4UH+WJK2lkM/M5noklPc5LaRoreeHn41O
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="37542852"
IronPort-PHdr: =?us-ascii?q?9a23=3AKE4z6RVdGcxSZbbE0XsRPWrTdavV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbR2Et8tkgFKBZ4jH8fUM07OQ7/m7HzZeuN3a6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIp/Jqo+xB?=
 =?us-ascii?q?bFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZErYBIPf0Wk/qstzXFAM2PBKvzub9Ftpyy4MeVniTAq?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896v71k3A5nV4dfa+03ZoYc324APtmLF?=
 =?us-ascii?q?uDYXb2gdcOD30KvgwgQ+zuklGCViRTZ3mqVaIm+j47EJ6mDZvERo21mLyOxj?=
 =?us-ascii?q?q7HplNa2BeEF+MDHPoe5yBW/cLbyKSONFuniYYWrimTo9ynS2p4Sj8x6BqLK?=
 =?us-ascii?q?Lx/TYevJnu15Ah4OjUjhc7/jFcFcmR02iRCWpzmzVMDyQ72KF5vFxV1FiOy+?=
 =?us-ascii?q?57juZeGNgV4OlGFk8CPIPYh8l9DMr/ElbZd8qNYE6vX9HjBDY2VN93yNgLNR?=
 =?us-ascii?q?VTAdKn2yvf0jKqDrldrLmCAJg54+qIxHTqD9pswHbBkq86hh8pRdUZZj7uvb?=
 =?us-ascii?q?J26wWGX92BqE6ejav/MP1HjSM=3D?=
X-IPAS-Result: =?us-ascii?q?A2CJAgAPOBde/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YFtIBIqhAmJA4ZlBoE3gQGIbY9hgWcJAQEBAQEBAQEBNwEBhEACghI4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFCwcxgjspAYJ6AQUjFVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?lcMP4JXJasagTKFT4NCgT2BDiiMM3mBB4ERJw+CKDU+hAMugyiCXgSNLiSJT?=
 =?us-ascii?q?UaXRYJAgkWKMIknBhuCR4d+kB6OV5x9IoFYKwgCGAghDzuCbFAYDYsMghIXj?=
 =?us-ascii?q?kEjAzCONoIyAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Jan 2020 14:29:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009ESdsB127119;
        Thu, 9 Jan 2020 09:28:41 -0500
Subject: Re: [PATCH v2] selinux: reorder hooks to make runtime disable less
 broken
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200108140958.870283-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <57ed1511-992a-de6d-686b-ae849c3b3109@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 09:29:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108140958.870283-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 9:09 AM, Ondrej Mosnacek wrote:
> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
> infrastructure to use per-hook lists, which meant that removing the
> hooks for a given module was no longer atomic. Even though the commit
> clearly documents that modules implementing runtime revmoval of hooks
> (only SELinux attempts this madness) need to take special precautions to
> avoid race conditions, SELinux has never addressed this.
> 
> By inserting an artificial delay between the loop iterations of
> security_delete_hooks() (I used 100 ms), booting to a state where
> SELinux is enabled, but policy is not yet loaded, and running these
> commands:
> 
>      while true; do ping -c 1 <some IP>; done &
>      echo -n 1 >/sys/fs/selinux/disable
>      kill %1
>      wait
> 
> ...I was able to trigger NULL pointer dereferences in various places. I
> also have a report of someone getting panics on a stock RHEL-8 kernel
> after setting SELINUX=disabled in /etc/selinux/config and rebooting
> (without adding "selinux=0" to kernel command-line).
> 
> Reordering the SELinux hooks such that those that allocate structures
> are removed last seems to prevent these panics. It is very much possible
> that this doesn't make the runtime disable completely race-free, but at
> least it makes the operation much less fragile.
> 
> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> Changes in v2:
>   - rebased on latest selinux/next
>   - added comment above selinux_nf_ip_exit() call to ensure it remains
>     ordered correctly
> 
>   security/selinux/hooks.c | 101 +++++++++++++++++++++++++++------------
>   1 file changed, 70 insertions(+), 31 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 63a6e36abe9f..c06bb63d88bd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6896,6 +6896,21 @@ static int selinux_perf_event_write(struct perf_event *event)
>   }
>   #endif
>   
> +/*
> + * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
> + * 1. any hooks that don't belong to (2.) or (3.) below,
> + * 2. hooks that both access structures allocated by other hooks, and allocate
> + *    structures that can be later accessed by other hooks (mostly "cloning"
> + *    hooks),
> + * 3. hooks that only allocate structures that can be later accessed by other
> + *    hooks ("allocating" hooks).
> + *
> + * Please follow block comment delimiters in the list to keep this order.
> + *
> + * This ordering is needed for SELinux runtime disable to work at least somewhat
> + * safely. Breaking the ordering rules above might lead to NULL pointer derefs
> + * when disabling SELinux at runtime.
> + */
>   static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>   	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -6918,12 +6933,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
>   	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
>   
> -	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
> -	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
> -
> -	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
>   	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
> -	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
>   	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>   	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>   	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
> @@ -6933,12 +6943,10 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(sb_umount, selinux_umount),
>   	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>   	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
> -	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
>   
>   	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
>   	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
>   
> -	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
>   	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
>   	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
>   	LSM_HOOK_INIT(inode_create, selinux_inode_create),
> @@ -7010,21 +7018,15 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
>   	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
>   
> -	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
> -
> -	LSM_HOOK_INIT(msg_queue_alloc_security,
> -			selinux_msg_queue_alloc_security),
>   	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
>   	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
>   	LSM_HOOK_INIT(msg_queue_msgsnd, selinux_msg_queue_msgsnd),
>   	LSM_HOOK_INIT(msg_queue_msgrcv, selinux_msg_queue_msgrcv),
>   
> -	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
>   	LSM_HOOK_INIT(shm_associate, selinux_shm_associate),
>   	LSM_HOOK_INIT(shm_shmctl, selinux_shm_shmctl),
>   	LSM_HOOK_INIT(shm_shmat, selinux_shm_shmat),
>   
> -	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
>   	LSM_HOOK_INIT(sem_associate, selinux_sem_associate),
>   	LSM_HOOK_INIT(sem_semctl, selinux_sem_semctl),
>   	LSM_HOOK_INIT(sem_semop, selinux_sem_semop),
> @@ -7035,13 +7037,11 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>   
>   	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
> -	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
>   	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
>   	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
>   	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
>   	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
>   	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
> -	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>   
>   	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
>   	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
> @@ -7064,7 +7064,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(socket_getpeersec_stream,
>   			selinux_socket_getpeersec_stream),
>   	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dgram),
> -	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
>   	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
>   	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
>   	LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
> @@ -7079,7 +7078,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
>   	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
>   	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
> -	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
>   	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
>   	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
>   	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
> @@ -7089,17 +7087,11 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
>   	LSM_HOOK_INIT(ib_endport_manage_subnet,
>   		      selinux_ib_endport_manage_subnet),
> -	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
>   	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
>   #endif
>   #ifdef CONFIG_SECURITY_NETWORK_XFRM
> -	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
> -	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
>   	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
>   	LSM_HOOK_INIT(xfrm_policy_delete_security, selinux_xfrm_policy_delete),
> -	LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
> -	LSM_HOOK_INIT(xfrm_state_alloc_acquire,
> -			selinux_xfrm_state_alloc_acquire),
>   	LSM_HOOK_INIT(xfrm_state_free_security, selinux_xfrm_state_free),
>   	LSM_HOOK_INIT(xfrm_state_delete_security, selinux_xfrm_state_delete),
>   	LSM_HOOK_INIT(xfrm_policy_lookup, selinux_xfrm_policy_lookup),
> @@ -7109,14 +7101,12 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   #endif
>   
>   #ifdef CONFIG_KEYS
> -	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
>   	LSM_HOOK_INIT(key_free, selinux_key_free),
>   	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>   #endif
>   
>   #ifdef CONFIG_AUDIT
> -	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
>   	LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
>   	LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
>   	LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
> @@ -7126,21 +7116,66 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(bpf, selinux_bpf),
>   	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
>   	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
> -	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
> -	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
>   	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>   	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>   #endif
>   
>   #ifdef CONFIG_PERF_EVENTS
>   	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
> -	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
>   	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
>   	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
>   	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
>   #endif
>   
>   	LSM_HOOK_INIT(locked_down, selinux_lockdown),
> +
> +	/*
> +	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
> +	 */
> +	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
> +	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
> +	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> +	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
> +#endif
> +
> +	/*
> +	 * PUT "ALLOCATING" HOOKS HERE
> +	 */
> +	LSM_HOOK_INIT(msg_msg_alloc_security, selinux_msg_msg_alloc_security),
> +	LSM_HOOK_INIT(msg_queue_alloc_security,
> +		      selinux_msg_queue_alloc_security),
> +	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
> +	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
> +	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
> +	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
> +	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
> +	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
> +	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
> +	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
> +#ifdef CONFIG_SECURITY_INFINIBAND
> +	LSM_HOOK_INIT(ib_alloc_security, selinux_ib_alloc_security),
> +#endif
> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
> +	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
> +	LSM_HOOK_INIT(xfrm_state_alloc, selinux_xfrm_state_alloc),
> +	LSM_HOOK_INIT(xfrm_state_alloc_acquire,
> +		      selinux_xfrm_state_alloc_acquire),
> +#endif
> +#ifdef CONFIG_KEYS
> +	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
> +#endif
> +#ifdef CONFIG_AUDIT
> +	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
> +#endif
> +#ifdef CONFIG_BPF_SYSCALL
> +	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
> +	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
> +#endif
> +#ifdef CONFIG_PERF_EVENTS
> +	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> +#endif
>   };
>   
>   static __init int selinux_init(void)
> @@ -7319,14 +7354,18 @@ int selinux_disable(struct selinux_state *state)
>   
>   	pr_info("SELinux:  Disabled at runtime.\n");
>   
> +	/*
> +	 * Unregister netfilter hooks.
> +	 * Must be done before security_delete_hooks() to avoid breaking
> +	 * runtime disable.
> +	 */
> +	selinux_nf_ip_exit();
> +
>   	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
>   
>   	/* Try to destroy the avc node cache */
>   	avc_disable();
>   
> -	/* Unregister netfilter hooks. */
> -	selinux_nf_ip_exit();
> -
>   	/* Unregister selinuxfs. */
>   	exit_sel_fs();
>   
> 

