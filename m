Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899EC433DB
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0288964F03
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 12:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBUMwc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 07:52:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33898 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBUMwb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 07:52:31 -0500
Received: from [50.53.41.238] (helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1lDoD8-0005Pg-Vb; Sun, 21 Feb 2021 12:51:43 +0000
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377734508.87807.8537642254664217815.stgit@sifl>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkU1bXJQb0JFQURB
 azE5UHNnVmdCS2tJbW1SMmlzUFE2bzdLSmhUVEtqSmR3VmJrV1NuTm4rbzZVcDVrCm5LUDFm
 NDlFQlFsY2VXZzF5cC9Od2JSOGFkK2VTRU8vdW1hL0srUHFXdkJwdEtDOVNXRDk3Rkc0dUI0
 L2Nhb20KTEVVOTdzTFFNdG52R1dkeHJ4VlJHTTRhbnpXWU1neno1VFptSWlWVFo0M091NVZw
 YVMxVnoxWlN4UDNoL3hLTgpaci9UY1c1V1FhaTh1M1BXVm5ia2poU1pQSHYxQmdoTjY5cXhF
 UG9tckpCbTFnbXR4M1ppVm1GWGx1d1RtVGdKCk9rcEZvbDduYkowaWxuWUhyQTdTWDNDdFIx
 dXBlVXBNYS9XSWFuVk85NldkVGpISElhNDNmYmhtUXViZTR0eFMKM0ZjUUxPSlZxUXN4NmxF
 OUI3cUFwcG05aFExMHFQV3dkZlB5LyswVzZBV3ROdTVBU2lHVkNJbld6bDJIQnFZZAovWmxs
 OTN6VXErTklvQ244c0RBTTlpSCt3dGFHRGNKeXdJR0luK2VkS050SzcyQU1nQ2hUZy9qMVpv
 V0g2WmVXClBqdVVmdWJWelp0bzFGTW9HSi9TRjRNbWRRRzFpUU50ZjRzRlpiRWdYdXk5Y0dp
 MmJvbUYwenZ5QkpTQU5weGwKS05CRFlLek42S3owOUhVQWtqbEZNTmdvbUwvY2pxZ0FCdEF4
 NTlMK2RWSVpmYUYyODFwSWNVWnp3dmg1K0pvRwplT1c1dUJTTWJFN0wzOG5zem9veWtJSjVY
 ckFjaGtKeE5mejdrK0ZuUWVLRWtOekVkMkxXYzNRRjRCUVpZUlQ2ClBISGdhM1JneWtXNSsx
 d1RNcUpJTGRtdGFQYlhyRjNGdm5WMExSUGN2NHhLeDdCM2ZHbTd5Z2Rvb3dBUkFRQUIKdEIx
 S2IyaHVJRXB2YUdGdWMyVnVJRHhxYjJodVFHcHFiWGd1Ym1WMFBva0NPZ1FUQVFvQUpBSWJB
 d1VMQ1FnSApBd1VWQ2drSUN3VVdBZ01CQUFJZUFRSVhnQVVDVG8wWVZ3SVpBUUFLQ1JBRkx6
 WndHTlhEMkx4SkQvOVRKWkNwCndsbmNUZ1llcmFFTWVEZmtXdjhjMUlzTTFqMEFtRTRWdEwr
 ZkU3ODBaVlA5Z2tqZ2tkWVN4dDdlY0VUUFRLTWEKWlNpc3JsMVJ3cVUwb29nWGRYUVNweHJH
 SDAxaWN1LzJuMGpjWVNxWUtnZ1B4eTc4QkdzMkxacTRYUGZKVFptSApaR25YR3EvZURyL21T
 bmowYWF2QkptTVo2amJpUHo2eUh0QllQWjlmZG84YnRjendQNDFZZVdvSXUyNi84SUk2CmYw
 WG0zVkM1b0FhOHY3UmQrUldaYThUTXdsaHpIRXh4ZWwzanRJN0l6ek9zbm1FOS84RG0wQVJE
 NWlUTENYd1IKMWN3SS9KOUJGL1MxWHY4UE4xaHVUM0l0Q05kYXRncDh6cW9Ka2dQVmptdnlM
 NjRRM2ZFa1liZkhPV3NhYmE5LwprQVZ0Qk56OVJURmg3SUhEZkVDVmFUb3VqQmQ3QnRQcXIr
 cUlqV0ZhZEpEM0k1ZUxDVkp2VnJyb2xyQ0FUbEZ0Ck4zWWtRczZKbjFBaUlWSVUzYkhSOEdq
 ZXZnejVMbDZTQ0dIZ1Jya3lScG5TWWFVL3VMZ24zN042QVl4aS9RQUwKK2J5M0N5RUZManpX
 QUV2eVE4YnEzSXVjbjdKRWJoUy9KLy9kVXFMb2VVZjh0c0dpMDB6bXJJVFpZZUZZQVJoUQpN
 dHNmaXpJclZEdHoxaVBmL1pNcDVnUkJuaXlqcFhuMTMxY20zTTNndjZIclFzQUdubjhBSnJ1
 OEdEaTVYSllJCmNvLzEreC9xRWlOMm5DbGFBT3BiaHpOMmVVdlBEWTVXMHEzYkEvWnAybWZH
 NTJ2YlJJK3RRMEJyMUhkL3ZzbnQKVUhPOTAzbU1aZXAyTnpOM0JaNXFFdlB2RzRyVzVacTJE
 cHliV2JRclNtOW9iaUJLYjJoaGJuTmxiaUE4YW05bwpiaTVxYjJoaGJuTmxia0JqWVc1dmJt
 bGpZV3d1WTI5dFBva0NOd1FUQVFvQUlRVUNUbzBYV2dJYkF3VUxDUWdICkF3VVZDZ2tJQ3dV
 V0FnTUJBQUllQVFJWGdBQUtDUkFGTHpad0dOWEQySXRNRC85anliYzg3ZE00dUFIazZ5Tk0K
 TjBZL0JGbW10VFdWc09CaHFPbm9iNGkzOEJyRE8yQzFoUUNQQ1FlNExMczEvNHB0ZW92UXQ4
 QjJGeXJQVmp3Zwo3alpUSE5LNzRyNmxDQ1Z4eDN5dTFCN1U5UG80VlRrY3NsVmIxL3FtV3V4
 OFhXY040eXZrVHFsTCtHeHB5Sm45CjlaWmZmWEpjNk9oNlRtT2ZiS0d2TXV1djVhclNJQTNK
 SEZMZjlhTHZadEExaXNKVXI3cFM5YXBnOXVUVUdVcDcKd2ZWMFdUNlQzZUczbXRVVTJ1cDVK
 VjQ4NTBMMDVqSFM2dVdpZS9ZK3lmSk9iaXlyeE4vNlpxVzVHb25oTEJxLwptc3pjVjV2QlQz
 QkRWZTNSdkY2WGRNOU9oUG4xK1k4MXg1NCt2UTExM044aUx3RjdHR2ExNFp5SVZBTlpEMEkw
 CkhqUnZhMmsvUnFJUlR6S3l1UEg1cGtsY0tIVlBFRk1tT3pNVCtGT294Tmp2Uys3K3dHMktN
 RFlFbUhQcjFQSkIKWlNaZUh6SzE5dGZhbFBNcHBGeGkrc3lZTGFnTjBtQjdKSFF3WTdjclV1
 T0RoeWNxNjBZVnoxdGFFeWd1M1l2MgoyL0kxRUNHSHZLSEc2d2M5MG80M0MvZWxIRUNYbkVo
 N3RLcGxEY3BJQytPQ21NeEtIaFI0NitYY1p2Z3c0RGdiCjdjYTgzZVFSM0NHODlMdlFwVzJM
 TEtFRUJEajdoWmhrTGJra1BSWm0zdzhKWTQ0YXc4VnRneFdkblNFTUNMeEwKSU9OaDZ1Wjcv
 L0RZVnRjSWFNSllrZWJhWnRHZENwMElnVVpiMjQvVmR2WkNZYk82MkhrLzNWbzFuWHdIVUVz
 Mwo2RC92MWJUMFJaRmk2OUxnc0NjT2N4NGdZTGtDRFFST1pxejZBUkFBb3F3NmtrQmhXeU0x
 ZnZnYW1BVmplWjZuCktFZm5SV2JrQzk0TDFFc0pMdXAzV2IyWDBBQk5PSFNrYlNENHBBdUMy
 dEtGL0VHQnQ1Q1A3UWRWS1JHY1F6QWQKNmIyYzFJZHk5Ukx3Nnc0Z2krbm4vZDFQbTFra1lo
 a1NpNXpXYUlnMG01UlFVaytFbDh6a2Y1dGNFLzFOMFo1TwpLMkpoandGdTViWDBhMGw0Y0ZH
 V1ZRRWNpVk1ES1J0eE1qRXRrM1N4RmFsbTZaZFEycHAyODIyY2xucTR6WjltCld1MWQyd2F4
 aXorYjVJYTR3ZURZYTduNDFVUmNCRVViSkFnbmljSmtKdENUd3lJeElXMktuVnlPcmp2a1F6
 SUIKdmFQMEZkUDJ2dlpvUE1kbENJek9sSWtQTGd4RTBJV3VlVFhlQkpoTnMwMXBiOGJMcW1U
 SU1sdTRMdkJFTEEvdgplaWFqajVzOHk1NDJIL2FIc2ZCZjRNUVVoSHhPL0JaVjdoMDZLU1Vm
 SWFZN09nQWdLdUdOQjNVaWFJVVM1K2E5CmduRU9RTER4S1J5L2E3UTF2OVMrTnZ4KzdqOGlI
 M2prUUpoeFQ2WkJoWkdSeDBna0gzVCtGMG5ORG01TmFKVXMKYXN3Z0pycUZaa1VHZDJNcm0x
 cW5Ld1hpQXQ4U0ljRU5kcTMzUjBLS0tSQzgwWGd3ajhKbjMwdlhMU0crTk8xRwpIMFVNY0F4
 TXd5L3B2azZMVTVKR2paUjczSjVVTFZoSDRNTGJEZ2dEM21QYWlHOCtmb3RUckpVUHFxaGc5
 aHlVCkVQcFlHN3NxdDc0WG43OStDRVpjakxIenlsNnZBRkUyVzBreGxMdFF0VVpVSE8zNmFm
 RnY4cUdwTzNacVB2akIKVXVhdFhGNnR2VVFDd2YzSDZYTUFFUUVBQVlrQ0h3UVlBUW9BQ1FV
 Q1RtYXMrZ0liREFBS0NSQUZMelp3R05YRAoyRC9YRC8wZGRNLzRhaTFiK1RsMWp6bkthalgz
 a0crTWVFWWVJNGY0MHZjbzNyT0xyblJHRk9jYnl5ZlZGNjlNCktlcGllNE93b0kxamNUVTBB
 RGVjbmJXbkROSHByMFNjenhCTXJvM2Juckxoc212anVuVFlJdnNzQlp0QjRhVkoKanVMSUxQ
 VWxuaEZxYTdmYlZxMFpRamJpVi9ydDJqQkVOZG05cGJKWjZHam5wWUljQWJQQ0NhL2ZmTDQv
 U1FSUwpZSFhvaEdpaVM0eTVqQlRtSzVsdGZld0xPdzAyZmtleEgrSUpGcnJHQlhEU2c2bjJT
 Z3hubisrTkYzNGZYY205CnBpYXczbUtzSUNtKzBoZE5oNGFmR1o2SVdWOFBHMnRlb29WRHA0
 ZFlpaCsreFgvWFM4ekJDYzFPOXc0bnpsUDIKZ0t6bHFTV2JoaVdwaWZSSkJGYTRXdEFlSlRk
 WFlkMzdqL0JJNFJXV2hueXc3YUFQTkdqMzN5dEdITlVmNlJvMgovanRqNHRGMXkvUUZYcWpK
 Ry93R2pwZHRSZmJ0VWpxTEhJc3ZmUE5OSnEvOTU4cDc0bmRBQ2lkbFdTSHpqK09wCjI2S3Bi
 Rm5td05PMHBzaVVzbmh2SEZ3UE8vdkFibDNSc1I1KzBSbytodnMyY0VtUXV2OXIvYkRsQ2Zw
 enAydDMKY0srcmh4VXFpc094OERaZnoxQm5rYW9DUkZidnZ2ays3TC9mb21QbnRHUGtxSmNp
 WUU4VEdIa1p3MWhPa3UrNApPb00yR0I1bkVEbGorMlRGL2pMUStFaXBYOVBrUEpZdnhmUmxD
 NmRLOFBLS2ZYOUtkZm1BSWNnSGZuVjFqU24rCjh5SDJkakJQdEtpcVcwSjY5YUlzeXg3aVYv
 MDNwYVBDakpoN1hxOXZBenlkTjVVL1VBPT0KPTZQL2IKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
 RVkgQkxPQ0stLS0tLQo=
Organization: Canonical
Message-ID: <b2f85cf5-a110-68ae-47b6-276dd8062be7@canonical.com>
Date:   Sun, 21 Feb 2021 04:51:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161377734508.87807.8537642254664217815.stgit@sifl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/21 3:29 PM, Paul Moore wrote:
> Of the three LSMs that implement the security_task_getsecid() LSM
> hook, all three LSMs provide the task's objective security
> credentials.  This turns out to be unfortunate as most of the hook's
> callers seem to expect the task's subjective credentials, although
> a small handful of callers do correctly expect the objective
> credentials.
> 
> This patch is the first step towards fixing the problem: it splits
> the existing security_task_getsecid() hook into two variants, one
> for the subjective creds, one for the objective creds.
> 
>   void security_task_getsecid_subj(struct task_struct *p,
> 				   u32 *secid);
>   void security_task_getsecid_obj(struct task_struct *p,
> 				  u32 *secid);
> 
> While this patch does fix all of the callers to use the correct
> variant, in order to keep this patch focused on the callers and to
> ease review, the LSMs continue to use the same implementation for
> both hooks.  The net effect is that this patch should not change
> the behavior of the kernel in any way, it will be up to the latter
> LSM specific patches in this series to change the hook
> implementations and return the correct credentials.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

So far this looks good. I want to take another stab at it and give
it some testing


> ---
>  drivers/android/binder.c              |    2 +-
>  include/linux/cred.h                  |    2 +-
>  include/linux/lsm_hook_defs.h         |    5 ++++-
>  include/linux/lsm_hooks.h             |    8 ++++++--
>  include/linux/security.h              |   10 ++++++++--
>  kernel/audit.c                        |    4 ++--
>  kernel/auditfilter.c                  |    3 ++-
>  kernel/auditsc.c                      |    8 ++++----
>  net/netlabel/netlabel_unlabeled.c     |    2 +-
>  net/netlabel/netlabel_user.h          |    2 +-
>  security/apparmor/lsm.c               |    3 ++-
>  security/integrity/ima/ima_appraise.c |    2 +-
>  security/integrity/ima/ima_main.c     |   14 +++++++-------
>  security/security.c                   |   13 ++++++++++---
>  security/selinux/hooks.c              |    3 ++-
>  security/smack/smack_lsm.c            |    3 ++-
>  16 files changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56ac..39d501261108d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		u32 secid;
>  		size_t added_size;
>  
> -		security_task_getsecid(proc->tsk, &secid);
> +		security_task_getsecid_subj(proc->tsk, &secid);
>  		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 18639c069263f..42b9d88d9a565 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -140,7 +140,7 @@ struct cred {
>  	struct key	*request_key_auth; /* assumed request_key authority */
>  #endif
>  #ifdef CONFIG_SECURITY
> -	void		*security;	/* subjective LSM security */
> +	void		*security;	/* LSM security */
>  #endif
>  	struct user_struct *user;	/* real user ID subscription */
>  	struct user_namespace *user_ns; /* user_ns the caps and keyrings are relative to. */
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index dfd261dcbcb04..1490a185135a0 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -200,7 +200,10 @@ LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
>  LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
>  LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
>  LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
> -LSM_HOOK(void, LSM_RET_VOID, task_getsecid, struct task_struct *p, u32 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, task_getsecid_subj,
> +	 struct task_struct *p, u32 *secid)
> +LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
> +	 struct task_struct *p, u32 *secid)
>  LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
>  LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
>  LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index bdfc8a76a4f79..13d2a9a6f2014 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -706,8 +706,12 @@
>   *	@p.
>   *	@p contains the task_struct for the process.
>   *	Return 0 if permission is granted.
> - * @task_getsecid:
> - *	Retrieve the security identifier of the process @p.
> + * @task_getsecid_subj:
> + *	Retrieve the subjective security identifier of the process @p.
> + *	@p contains the task_struct for the process and place is into @secid.
> + *	In case of failure, @secid will be set to zero.
> + * @task_getsecid_obj:
> + *	Retrieve the objective security identifier of the process @p.
>   *	@p contains the task_struct for the process and place is into @secid.
>   *	In case of failure, @secid will be set to zero.
>   *
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b0d14f04b16de..1826bb0cea825 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -406,7 +406,8 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
>  int security_task_getsid(struct task_struct *p);
> -void security_task_getsecid(struct task_struct *p, u32 *secid);
> +void security_task_getsecid_subj(struct task_struct *p, u32 *secid);
> +void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
>  int security_task_setnice(struct task_struct *p, int nice);
>  int security_task_setioprio(struct task_struct *p, int ioprio);
>  int security_task_getioprio(struct task_struct *p);
> @@ -1084,7 +1085,12 @@ static inline int security_task_getsid(struct task_struct *p)
>  	return 0;
>  }
>  
> -static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
> +static inline void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
> +{
> +	*secid = 0;
> +}
> +
> +static inline void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
>  {
>  	*secid = 0;
>  }
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 1ffc2e059027d..8e725db6ecb02 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2132,7 +2132,7 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	int error;
>  	u32 sid;
>  
> -	security_task_getsecid(current, &sid);
> +	security_task_getsecid_subj(current, &sid);
>  	if (!sid)
>  		return 0;
>  
> @@ -2353,7 +2353,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  			audit_sig_uid = auid;
>  		else
>  			audit_sig_uid = uid;
> -		security_task_getsecid(current, &audit_sig_sid);
> +		security_task_getsecid_subj(current, &audit_sig_sid);
>  	}
>  
>  	return audit_signal_info_syscall(t);
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 333b3bcfc5458..db2c6b59dfc33 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1359,7 +1359,8 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_SEN:
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_rule) {
> -					security_task_getsecid(current, &sid);
> +					security_task_getsecid_subj(current,
> +								    &sid);
>  					result = security_audit_rule_match(sid,
>  						   f->type, f->op, f->lsm_rule);
>  				}
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ce8c9e2279ba9..3bfbecca4664a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -667,7 +667,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			   logged upon error */
>  			if (f->lsm_rule) {
>  				if (need_sid) {
> -					security_task_getsecid(tsk, &sid);
> +					security_task_getsecid_subj(tsk, &sid);
>  					need_sid = 0;
>  				}
>  				result = security_audit_rule_match(sid, f->type,
> @@ -2400,7 +2400,7 @@ void __audit_ptrace(struct task_struct *t)
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getsecid(t, &context->target_sid);
> +	security_task_getsecid_obj(t, &context->target_sid);
>  	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>  }
>  
> @@ -2427,7 +2427,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getsecid(t, &ctx->target_sid);
> +		security_task_getsecid_obj(t, &ctx->target_sid);
>  		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
>  		return 0;
>  	}
> @@ -2448,7 +2448,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
> -	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
> +	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
>  	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
>  	axp->pid_count++;
>  
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index ccb4916428116..3e6ac9b790b15 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1539,7 +1539,7 @@ int __init netlbl_unlabel_defconf(void)
>  	/* Only the kernel is allowed to call this function and the only time
>  	 * it is called is at bootup before the audit subsystem is reporting
>  	 * messages so don't worry to much about these values. */
> -	security_task_getsecid(current, &audit_info.secid);
> +	security_task_getsecid_subj(current, &audit_info.secid);
>  	audit_info.loginuid = GLOBAL_ROOT_UID;
>  	audit_info.sessionid = 0;
>  
> diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
> index 3c67afce64f12..b9ba8112b3c52 100644
> --- a/net/netlabel/netlabel_user.h
> +++ b/net/netlabel/netlabel_user.h
> @@ -34,7 +34,7 @@
>  static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
>  					    struct netlbl_audit *audit_info)
>  {
> -	security_task_getsecid(current, &audit_info->secid);
> +	security_task_getsecid_subj(current, &audit_info->secid);
>  	audit_info->loginuid = audit_get_loginuid(current);
>  	audit_info->sessionid = audit_get_sessionid(current);
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 1b0aba8eb7235..15e37b9132679 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1243,7 +1243,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(task_free, apparmor_task_free),
>  	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
> -	LSM_HOOK_INIT(task_getsecid, apparmor_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid),
>  	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
>  	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
>  
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 8361941ee0a12..afa4923dbd33d 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -75,7 +75,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>  	if (!ima_appraise)
>  		return 0;
>  
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid_subj(current, &secid);
>  	return ima_match_policy(inode, current_cred(), secid, func, mask,
>  				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f87cb29329e91..97a6913bb3d86 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -391,7 +391,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>  	u32 secid;
>  
>  	if (file && (prot & PROT_EXEC)) {
> -		security_task_getsecid(current, &secid);
> +		security_task_getsecid_subj(current, &secid);
>  		return process_measurement(file, current_cred(), secid, NULL,
>  					   0, MAY_EXEC, MMAP_CHECK);
>  	}
> @@ -429,7 +429,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>  	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>  		return 0;
>  
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid_subj(current, &secid);
>  	inode = file_inode(vma->vm_file);
>  	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
>  				MMAP_CHECK, &pcr, &template, 0);
> @@ -469,7 +469,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  	int ret;
>  	u32 secid;
>  
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid_subj(current, &secid);
>  	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
>  				  MAY_EXEC, BPRM_CHECK);
>  	if (ret)
> @@ -494,7 +494,7 @@ int ima_file_check(struct file *file, int mask)
>  {
>  	u32 secid;
>  
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid_subj(current, &secid);
>  	return process_measurement(file, current_cred(), secid, NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
> @@ -679,7 +679,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
>  
>  	/* Read entire file for all partial reads. */
>  	func = read_idmap[read_id] ?: FILE_CHECK;
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid_subj(current, &secid);
>  	return process_measurement(file, current_cred(), secid, NULL,
>  				   0, MAY_READ, func);
>  }
> @@ -722,7 +722,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  	}
>  
>  	func = read_idmap[read_id] ?: FILE_CHECK;
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid_subj(current, &secid);
>  	return process_measurement(file, current_cred(), secid, buf, size,
>  				   MAY_READ, func);
>  }
> @@ -859,7 +859,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  	 * buffer measurements.
>  	 */
>  	if (func) {
> -		security_task_getsecid(current, &secid);
> +		security_task_getsecid_subj(current, &secid);
>  		action = ima_get_action(inode, current_cred(), secid, 0, func,
>  					&pcr, &template, keyring);
>  		if (!(action & IMA_MEASURE))
> diff --git a/security/security.c b/security/security.c
> index 401663b5b70ea..85e504df051b3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1757,12 +1757,19 @@ int security_task_getsid(struct task_struct *p)
>  	return call_int_hook(task_getsid, 0, p);
>  }
>  
> -void security_task_getsecid(struct task_struct *p, u32 *secid)
> +void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
>  {
>  	*secid = 0;
> -	call_void_hook(task_getsecid, p, secid);
> +	call_void_hook(task_getsecid_subj, p, secid);
>  }
> -EXPORT_SYMBOL(security_task_getsecid);
> +EXPORT_SYMBOL(security_task_getsecid_subj);
> +
> +void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
> +{
> +	*secid = 0;
> +	call_void_hook(task_getsecid_obj, p, secid);
> +}
> +EXPORT_SYMBOL(security_task_getsecid_obj);
>  
>  int security_task_setnice(struct task_struct *p, int nice)
>  {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index af2994adf9dd1..f311541c4972e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7143,7 +7143,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>  	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
>  	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
> -	LSM_HOOK_INIT(task_getsecid, selinux_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid),
>  	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
>  	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
>  	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f69c3dd9a0c67..2bb354ef2c4a9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4755,7 +4755,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
>  	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
>  	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
> -	LSM_HOOK_INIT(task_getsecid, smack_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid),
>  	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
>  	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
>  	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),
> 

