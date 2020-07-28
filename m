Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79233C433ED
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555422074F
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgG1U30 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:29:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38604 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgG1U3Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 16:29:25 -0400
Received: from static-50-53-54-182.bvtn.or.frontiernet.net ([50.53.54.182] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1k0WDr-0004tD-DE; Tue, 28 Jul 2020 20:29:15 +0000
Subject: Re: [PATCH v19 13/23] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
References: <20200724203226.16374-1-casey@schaufler-ca.com>
 <20200724203226.16374-14-casey@schaufler-ca.com>
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
Message-ID: <e4939eb3-22f9-bcc8-e550-260a2f9a7db8@canonical.com>
Date:   Tue, 28 Jul 2020 11:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724203226.16374-14-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/24/20 1:32 PM, Casey Schaufler wrote:
> Create a new entry "display" in the procfs attr directory for
> controlling which LSM security information is displayed for a
> process. A process can only read or write its own display value.
> 
> The name of an active LSM that supplies hooks for
> human readable data may be written to "display" to set the
> value. The name of the LSM currently in use can be read from
> "display". At this point there can only be one LSM capable
> of display active. A helper function lsm_task_display() is
> provided to get the display slot for a task_struct.
> 
> Setting the "display" requires that all security modules using
> setprocattr hooks allow the action. Each security module is
> responsible for defining its policy.
> 
> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/proc/base.c                       |   1 +
>  include/linux/lsm_hooks.h            |  17 +++
>  security/apparmor/include/apparmor.h |   3 +-
>  security/apparmor/lsm.c              |  32 +++++
>  security/security.c                  | 167 ++++++++++++++++++++++++---
>  security/selinux/hooks.c             |  11 ++
>  security/selinux/include/classmap.h  |   2 +-
>  security/smack/smack_lsm.c           |   7 ++
>  8 files changed, 221 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d86c0afc8a85..40471a12ced2 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2794,6 +2794,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "fscreate",		0666),
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c9f792066d86..6908fa03cf31 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1647,4 +1647,21 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  
>  extern int lsm_inode_alloc(struct inode *inode);
>  
> +/**
> + * lsm_task_display - the "display" LSM for this task
> + * @task: The task to report on
> + *
> + * Returns the task's display LSM slot.
> + */
> +static inline int lsm_task_display(struct task_struct *task)
> +{
> +#ifdef CONFIG_SECURITY
> +	int *display = task->security;
> +
> +	if (display)
> +		return *display;
> +#endif
> +	return LSMBLOB_INVALID;
> +}
> +
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
> index 1fbabdb565a8..b1622fcb4394 100644
> --- a/security/apparmor/include/apparmor.h
> +++ b/security/apparmor/include/apparmor.h
> @@ -28,8 +28,9 @@
>  #define AA_CLASS_SIGNAL		10
>  #define AA_CLASS_NET		14
>  #define AA_CLASS_LABEL		16
> +#define AA_CLASS_DISPLAY_LSM	17
>  
> -#define AA_CLASS_LAST		AA_CLASS_LABEL
> +#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
>  
>  /* Control parameters settable through module/boot flags */
>  extern enum audit_mode aa_g_audit;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 432915c1d427..31a6f11890f1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	return error;
>  }
>  
> +
> +static int profile_display_lsm(struct aa_profile *profile,
> +			       struct common_audit_data *sa)
> +{
> +	struct aa_perms perms = { };
> +	unsigned int state;
> +
> +	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
> +	if (state) {
> +		aa_compute_perms(profile->policy.dfa, state, &perms);
> +		aa_apply_modes_to_perms(profile, &perms);
> +		aad(sa)->label = &profile->label;
> +
> +		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
> +	}
> +
> +	return 0;
> +}
> +
>  static int apparmor_setprocattr(const char *name, void *value,
>  				size_t size)
>  {
> @@ -623,6 +642,19 @@ static int apparmor_setprocattr(const char *name, void *value,
>  	if (size == 0)
>  		return -EINVAL;
>  
> +	/* LSM infrastructure does actual setting of display if allowed */
> +	if (!strcmp(name, "display")) {
> +		struct aa_profile *profile;
> +		struct aa_label *label;
> +
> +		aad(&sa)->info = "set display lsm";
> +		label = begin_current_label_crit_section();
> +		error = fn_for_each_confined(label, profile,
> +					     profile_display_lsm(profile, &sa));
> +		end_current_label_crit_section(label);
> +		return error;
> +	}
> +
>  	/* AppArmor requires that the buffer must be null terminated atm */
>  	if (args[size - 1] != '\0') {
>  		/* null terminate */
> diff --git a/security/security.c b/security/security.c
> index c3bac45bbb79..e1c9f87db64b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -75,7 +75,14 @@ static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +
> +/*
> + * The task blob includes the "display" slot used for
> + * chosing which module presents contexts.
> + */
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(int),
> +};

since we are stuffing structures in here with arbitrary items might
need alignment this should get changed to sizeof(long). The display
index itself can stay an int. This will just result in padding if
sizeof(int) < sizeof(long)

>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> @@ -470,8 +477,10 @@ static int lsm_append(const char *new, char **result)
>  
>  /*
>   * Current index to use while initializing the lsmblob secid list.
> + * Pointers to the LSM id structures for local use.
>   */
>  static int lsm_slot __lsm_ro_after_init;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>  
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -491,6 +500,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	if (lsmid->slot == LSMBLOB_NEEDED) {
>  		if (lsm_slot >= LSMBLOB_ENTRIES)
>  			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>  		lsmid->slot = lsm_slot++;
>  		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>  			   lsmid->slot);
> @@ -620,6 +630,8 @@ int lsm_inode_alloc(struct inode *inode)
>   */
>  static int lsm_task_alloc(struct task_struct *task)
>  {
> +	int *display;
> +
>  	if (blob_sizes.lbs_task == 0) {

lbs_task will always be > 0 now, but if you want to keep the guard I am not
opposed

>  		task->security = NULL;
>  		return 0;
> @@ -628,6 +640,15 @@ static int lsm_task_alloc(struct task_struct *task)
>  	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>  	if (task->security == NULL)
>  		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "display" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	display = task->security;
> +	*display = LSMBLOB_INVALID;
> +
>  	return 0;
>  }
>  
> @@ -1628,14 +1649,26 @@ int security_file_open(struct file *file)
>  
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  {
> +	int *odisplay = current->security;
> +	int *ndisplay;
>  	int rc = lsm_task_alloc(task);
>  
> -	if (rc)
> +	if (unlikely(rc))
>  		return rc;
> +
>  	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>  		security_task_free(task);
> -	return rc;
> +		return rc;
> +	}
> +
> +	if (odisplay) {

odisplay should always be valid because lbs_task is > 0, again if you want
to keep the guard that is fine

> +		ndisplay = task->security;
> +		if (ndisplay)
> +			*ndisplay = *odisplay;
> +	}
> +
> +	return 0;
>  }
>  
>  void security_task_free(struct task_struct *task)
> @@ -2038,23 +2071,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	int display = lsm_task_display(current);
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +
> +		/*
> +		 * Only allow getting the current process' display.
> +		 * There are too few reasons to get another process'
> +		 * display and too many LSM policy issues.
> +		 */

It turns out to be fairly important when trying to help people figure
out what is going on. I'm not going to ask for it to be changed here
but this is something we should revisit in the future.

> +		if (current != p)
> +			return -EINVAL;
> +
> +		display = lsm_task_display(p);
> +		if (display != LSMBLOB_INVALID)
> +			slot = display;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && display != LSMBLOB_INVALID &&
> +		    display != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return LSM_RET_DEFAULT(getprocattr);
>  }
>  
> +/**
> + * security_setprocattr - Set process attributes via /proc
> + * @lsm: name of module involved, or NULL
> + * @name: name of the attribute
> + * @value: value to set the attribute to
> + * @size: size of the value
> + *
> + * Set the process attribute for the specified security module
> + * to the specified value. Note that this can only be used to set
> + * the process attributes for the current, or "self" process.
> + * The /proc code has already done this check.
> + *
> + * Returns 0 on success, an appropriate code otherwise.
> + */
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
>  	struct security_hook_list *hp;
> +	char *termed;
> +	char *copy;
> +	int *display = current->security;
> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * Change the "display" value only if all the security
> +		 * modules that support setting a procattr allow it.
> +		 * It is assumed that all such security modules will be
> +		 * cooperative.
> +		 */
> +		if (size == 0)
> +			return -EINVAL;
> +
> +		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
> +				     list) {
> +			rc = hp->hook.setprocattr(name, value, size);
> +			if (rc < 0)
> +				return rc;
> +		}
> +
> +		rc = -EINVAL;
> +
> +		copy = kmemdup_nul(value, size, GFP_KERNEL);
> +		if (copy == NULL)
> +			return -ENOMEM;
> +
> +		termed = strsep(&copy, " \n");
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
> +				*display = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(termed);
> +		return rc;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
>  	return LSM_RET_DEFAULT(setprocattr);
> @@ -2074,15 +2194,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>  	}
>  
>  	return LSM_RET_DEFAULT(secid_to_secctx);
> @@ -2093,16 +2213,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>  
>  	lsmblob_init(blob, 0);
>  	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>  	}
>  	return 0;
>  }
> @@ -2110,7 +2229,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int display = lsm_task_display(current);
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> @@ -2251,8 +2377,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len)
>  {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	int display = lsm_task_display(current);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> +			     list)
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.socket_getpeersec_stream(sock, optval,
> +								 optlen, len);
> +	return -ENOPROTOOPT;
>  }
>  
>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1c821bec7472..bedcf737ff26 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6330,6 +6330,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	/*
>  	 * Basic control over ability to set these attributes at all.
>  	 */
> +
> +	/*
> +	 * For setting display, we only perform a permission check;
> +	 * the actual update to the display value is handled by the
> +	 * LSM framework.
> +	 */
> +	if (!strcmp(name, "display"))
> +		return avc_has_perm(&selinux_state,
> +				    mysid, mysid, SECCLASS_PROCESS2,
> +				    PROCESS2__SETDISPLAY, NULL);
> +
>  	if (!strcmp(name, "exec"))
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 98e1513b608a..905aa184b3cd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "execmem", "execstack", "execheap", "setkeycreate",
>  	    "setsockcreate", "getrlimit", NULL } },
>  	{ "process2",
> -	  { "nnp_transition", "nosuid_transition", NULL } },
> +	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod",
>  	    "syslog_console", "module_request", "module_load", NULL } },
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index d4655dec2d70..8b708cca921a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3494,6 +3494,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	struct smack_known_list_elem *sklep;
>  	int rc;
>  
> +	/*
> +	 * Allow the /proc/.../attr/current and SO_PEERSEC "display"
> +	 * to be reset at will.
> +	 */
> +	if (strcmp(name, "display") == 0)
> +		return 0;
> +
>  	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>  		return -EPERM;
>  
> 

