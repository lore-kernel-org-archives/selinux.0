Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91CC433DB
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534BE64EF5
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 12:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUM6M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 07:58:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33941 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUM6M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 07:58:12 -0500
Received: from [50.53.41.238] (helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1lDoIi-0005iM-1K; Sun, 21 Feb 2021 12:57:28 +0000
Subject: Re: [RFC PATCH 4/4] apparmor: differentiate between subjective and
 objective task credentials
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377736385.87807.7033400948278183233.stgit@sifl>
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
Message-ID: <28174118-93d2-e7a5-50fb-004185354625@canonical.com>
Date:   Sun, 21 Feb 2021 04:57:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161377736385.87807.7033400948278183233.stgit@sifl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/21 3:29 PM, Paul Moore wrote:
> With the split of the security_task_getsecid() into subjective and
> objective variants it's time to update AppArmor to ensure it is
> using the correct task creds.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

This has a couple problems, that I will work on addressing


> ---
>  security/apparmor/domain.c       |    2 +-
>  security/apparmor/include/cred.h |   19 ++++++++++++++++---
>  security/apparmor/include/task.h |    3 ++-
>  security/apparmor/lsm.c          |   23 +++++++++++++++--------
>  security/apparmor/task.c         |   23 ++++++++++++++++++++---
>  5 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index f919ebd042fd2..9ed00b8dcdf0c 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -67,7 +67,7 @@ static int may_change_ptraced_domain(struct aa_label *to_label,
>  	tracer = ptrace_parent(current);
>  	if (tracer)
>  		/* released below */
> -		tracerl = aa_get_task_label(tracer);
> +		tracerl = aa_get_task_label_subj(tracer);
>  
>  	/* not ptraced */
>  	if (!tracer || unconfined(tracerl))
> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
> index 0b9ae4804ef73..43c21ef5568ab 100644
> --- a/security/apparmor/include/cred.h
> +++ b/security/apparmor/include/cred.h
> @@ -64,14 +64,27 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>  }
>  
>  /**
> - * __aa_task_raw_label - retrieve another task's label
> + * __aa_task_raw_label_subj - retrieve another task's subjective label
>   * @task: task to query  (NOT NULL)
>   *
> - * Returns: @task's label without incrementing its ref count
> + * Returns: @task's subjective label without incrementing its ref count
>   *
>   * If @task != current needs to be called in RCU safe critical section
>   */
> -static inline struct aa_label *__aa_task_raw_label(struct task_struct *task)
> +static inline struct aa_label *__aa_task_raw_label_subj(struct task_struct *task)
> +{
> +	return aa_cred_raw_label(rcu_dereference(task->cred));
> +}
> +
> +/**
> + * __aa_task_raw_label_obj - retrieve another task's objective label
> + * @task: task to query  (NOT NULL)
> + *
> + * Returns: @task's objective label without incrementing its ref count
> + *
> + * If @task != current needs to be called in RCU safe critical section
> + */
> +static inline struct aa_label *__aa_task_raw_label_obj(struct task_struct *task)
>  {
>  	return aa_cred_raw_label(__task_cred(task));
>  }
> diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
> index f13d12373b25e..27a2961558555 100644
> --- a/security/apparmor/include/task.h
> +++ b/security/apparmor/include/task.h
> @@ -33,7 +33,8 @@ int aa_replace_current_label(struct aa_label *label);
>  int aa_set_current_onexec(struct aa_label *label, bool stack);
>  int aa_set_current_hat(struct aa_label *label, u64 token);
>  int aa_restore_previous_label(u64 cookie);
> -struct aa_label *aa_get_task_label(struct task_struct *task);
> +struct aa_label *aa_get_task_label_subj(struct task_struct *task);
> +struct aa_label *aa_get_task_label_obj(struct task_struct *task);
>  
>  /**
>   * aa_free_task_ctx - free a task_ctx
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 15e37b9132679..38430851675b9 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -119,7 +119,7 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
>  	int error;
>  
>  	tracer = __begin_current_label_crit_section();
> -	tracee = aa_get_task_label(child);
> +	tracee = aa_get_task_label_obj(child);
>  	error = aa_may_ptrace(tracer, tracee,
>  			(mode & PTRACE_MODE_READ) ? AA_PTRACE_READ
>  						  : AA_PTRACE_TRACE);
> @@ -135,7 +135,7 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
>  	int error;
>  
>  	tracee = __begin_current_label_crit_section();
> -	tracer = aa_get_task_label(parent);
> +	tracer = aa_get_task_label_subj(parent);
>  	error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE);
>  	aa_put_label(tracer);
>  	__end_current_label_crit_section(tracee);
> @@ -719,9 +719,16 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
>  	return;
>  }
>  
> -static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
> +static void apparmor_task_getsecid_subj(struct task_struct *p, u32 *secid)
>  {
> -	struct aa_label *label = aa_get_task_label(p);
> +	struct aa_label *label = aa_get_task_label_subj(p);
> +	*secid = label->secid;
> +	aa_put_label(label);
> +}
> +
> +static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
> +{
> +	struct aa_label *label = aa_get_task_label_obj(p);
>  	*secid = label->secid;
>  	aa_put_label(label);
>  }
> @@ -750,7 +757,7 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
>  		 * Dealing with USB IO specific behavior
>  		 */
>  		cl = aa_get_newest_cred_label(cred);
> -		tl = aa_get_task_label(target);
> +		tl = aa_get_task_label_obj(target);
>  		error = aa_may_signal(cl, tl, sig);
>  		aa_put_label(cl);
>  		aa_put_label(tl);
> @@ -758,7 +765,7 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
>  	}
>  
>  	cl = __begin_current_label_crit_section();
> -	tl = aa_get_task_label(target);
> +	tl = aa_get_task_label_obj(target);
>  	error = aa_may_signal(cl, tl, sig);
>  	aa_put_label(tl);
>  	__end_current_label_crit_section(cl);
> @@ -1243,8 +1250,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(task_free, apparmor_task_free),
>  	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
> -	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid),
> -	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid_subj),
> +	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
>  	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
>  	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
>  
> diff --git a/security/apparmor/task.c b/security/apparmor/task.c
> index d17130ee6795d..c03c8e3928055 100644
> --- a/security/apparmor/task.c
> +++ b/security/apparmor/task.c
> @@ -16,17 +16,34 @@
>  #include "include/task.h"
>  
>  /**
> - * aa_get_task_label - Get another task's label
> + * aa_get_task_label_subj - Get another task's subjective label
>   * @task: task to query  (NOT NULL)
>   *
>   * Returns: counted reference to @task's label
>   */
> -struct aa_label *aa_get_task_label(struct task_struct *task)
> +struct aa_label *aa_get_task_label_subj(struct task_struct *task)
>  {
>  	struct aa_label *p;
>  
>  	rcu_read_lock();
> -	p = aa_get_newest_label(__aa_task_raw_label(task));
> +	p = aa_get_newest_label(__aa_task_raw_label_subj(task));
> +	rcu_read_unlock();
> +
> +	return p;
> +}
> +
> +/**
> + * aa_get_task_label_obj - Get another task's objective label
> + * @task: task to query  (NOT NULL)
> + *
> + * Returns: counted reference to @task's label
> + */
> +struct aa_label *aa_get_task_label_obj(struct task_struct *task)
> +{
> +	struct aa_label *p;
> +
> +	rcu_read_lock();
> +	p = aa_get_newest_label(__aa_task_raw_label_obj(task));
>  	rcu_read_unlock();
>  
>  	return p;
> 

