Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF670C43381
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 03:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F7064FF7
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 03:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCJDGG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:06:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60864 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhCJDF7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 22:05:59 -0500
Received: from [50.53.41.238] (helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1lJpAb-00021B-3G; Wed, 10 Mar 2021 03:05:57 +0000
Subject: Re: [RFC PATCH 2/4] selinux: clarify task subjective and objective
 credentials
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377735153.87807.7492842242100187888.stgit@sifl>
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
Message-ID: <b27662cf-4bcf-ec23-92f5-49a5b2f8c119@canonical.com>
Date:   Tue, 9 Mar 2021 19:05:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161377735153.87807.7492842242100187888.stgit@sifl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/21 3:29 PM, Paul Moore wrote:
> SELinux has a function, task_sid(), which returns the task's
> objective credentials, but unfortunately is used in a few places
> where the subjective task credentials should be used.  Most notably
> in the new security_task_getsecid_subj() LSM hook.
> 
> This patch fixes this and attempts to make things more obvious by
> introducing a new function, task_sid_subj(), and renaming the
> existing task_sid() function to task_sid_obj().
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

I have a couple of questions below but the rest looks good

> ---
>  security/selinux/hooks.c |   85 +++++++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 36 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f311541c4972e..1c53000d28e37 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -229,10 +229,23 @@ static inline u32 cred_sid(const struct cred *cred)
>  	return tsec->sid;
>  }
>  
> +/*
> + * get the subjective security ID of a task
> + */
> +static inline u32 task_sid_subj(const struct task_struct *task)
> +{
> +	u32 sid;
> +
> +	rcu_read_lock();
> +	sid = cred_sid(rcu_dereference(task->cred));
> +	rcu_read_unlock();
> +	return sid;
> +}
> +
>  /*
>   * get the objective security ID of a task
>   */
> -static inline u32 task_sid(const struct task_struct *task)
> +static inline u32 task_sid_obj(const struct task_struct *task)
>  {
>  	u32 sid;
>  
> @@ -2034,11 +2047,8 @@ static inline u32 open_file_to_av(struct file *file)
>  
>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  {
> -	u32 mysid = current_sid();
> -	u32 mgrsid = task_sid(mgr);
> -
>  	return avc_has_perm(&selinux_state,
> -			    mysid, mgrsid, SECCLASS_BINDER,
> +			    current_sid(), task_sid_obj(mgr), SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
>  }
>  
> @@ -2046,8 +2056,8 @@ static int selinux_binder_transaction(struct task_struct *from,
>  				      struct task_struct *to)
>  {
>  	u32 mysid = current_sid();
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> +	u32 fromsid = task_sid_subj(from);

fromsid potentially gets used as both the subject and the object the following
permission checks. It makes sense to use the same cred for both checks but
what I am not sure about yet is whether its actually safe to use the subject
sid when the task isn't current.

ie. I am still trying to determine if there is a race here between the transaction
request and the permission check.

> +	u32 tosid = task_sid_subj(to);
its not clear to me that using the subj for to is correct

>  	int rc;
>  
>  	if (mysid != fromsid) {
> @@ -2066,11 +2076,9 @@ static int selinux_binder_transaction(struct task_struct *from,
>  static int selinux_binder_transfer_binder(struct task_struct *from,
>  					  struct task_struct *to)
>  {
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> -
>  	return avc_has_perm(&selinux_state,
> -			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
> +			    task_sid_subj(from), task_sid_obj(to),
> +			    SECCLASS_BINDER, BINDER__TRANSFER,
>  			    NULL);
>  }
>  
> @@ -2078,7 +2086,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  					struct task_struct *to,
>  					struct file *file)
>  {
> -	u32 sid = task_sid(to);
> +	u32 sid = task_sid_subj(to);

same question about safety here

>  	struct file_security_struct *fsec = selinux_file(file);
>  	struct dentry *dentry = file->f_path.dentry;
>  	struct inode_security_struct *isec;
> @@ -2114,10 +2122,10 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  }
>  
>  static int selinux_ptrace_access_check(struct task_struct *child,
> -				     unsigned int mode)
> +				       unsigned int mode)
>  {
>  	u32 sid = current_sid();
> -	u32 csid = task_sid(child);
> +	u32 csid = task_sid_obj(child);
>  
>  	if (mode & PTRACE_MODE_READ)
>  		return avc_has_perm(&selinux_state,
> @@ -2130,15 +2138,15 @@ static int selinux_ptrace_access_check(struct task_struct *child,
>  static int selinux_ptrace_traceme(struct task_struct *parent)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    task_sid(parent), current_sid(), SECCLASS_PROCESS,
> -			    PROCESS__PTRACE, NULL);
> +			    task_sid_subj(parent), task_sid_obj(current),
> +			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>  
>  static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
>  			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(target), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(target), SECCLASS_PROCESS,
>  			    PROCESS__GETCAP, NULL);
>  }
>  
> @@ -2263,7 +2271,7 @@ static u32 ptrace_parent_sid(void)
>  	rcu_read_lock();
>  	tracer = ptrace_parent(current);
>  	if (tracer)
> -		sid = task_sid(tracer);
> +		sid = task_sid_obj(tracer);
>  	rcu_read_unlock();
>  
>  	return sid;
> @@ -3916,7 +3924,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
>  				       struct fown_struct *fown, int signum)
>  {
>  	struct file *file;
> -	u32 sid = task_sid(tsk);
> +	u32 sid = task_sid_obj(tsk);
>  	u32 perm;
>  	struct file_security_struct *fsec;
>  
> @@ -4135,47 +4143,52 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETPGID, NULL);
>  }
>  
>  static int selinux_task_getpgid(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETPGID, NULL);
>  }
>  
>  static int selinux_task_getsid(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSESSION, NULL);
>  }
>  
> -static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
> +static void selinux_task_getsecid_subj(struct task_struct *p, u32 *secid)
> +{
> +	*secid = task_sid_subj(p);
> +}
> +
> +static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
>  {
> -	*secid = task_sid(p);
> +	*secid = task_sid_obj(p);
>  }
>  
>  static int selinux_task_setnice(struct task_struct *p, int nice)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
>  static int selinux_task_setioprio(struct task_struct *p, int ioprio)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
>  static int selinux_task_getioprio(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
>  }
>  
> @@ -4206,7 +4219,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  	   upon context transitions.  See selinux_bprm_committing_creds. */
>  	if (old_rlim->rlim_max != new_rlim->rlim_max)
>  		return avc_has_perm(&selinux_state,
> -				    current_sid(), task_sid(p),
> +				    current_sid(), task_sid_obj(p),
>  				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
>  
>  	return 0;
> @@ -4215,21 +4228,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  static int selinux_task_setscheduler(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
>  static int selinux_task_getscheduler(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
>  }
>  
>  static int selinux_task_movememory(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
> @@ -4248,14 +4261,14 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  	else
>  		secid = cred_sid(cred);
>  	return avc_has_perm(&selinux_state,
> -			    secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
> +			    secid, task_sid_obj(p), SECCLASS_PROCESS, perm, NULL);
>  }
>  
>  static void selinux_task_to_inode(struct task_struct *p,
>  				  struct inode *inode)
>  {
>  	struct inode_security_struct *isec = selinux_inode(inode);
> -	u32 sid = task_sid(p);
> +	u32 sid = task_sid_obj(p);
>  
>  	spin_lock(&isec->lock);
>  	isec->sclass = inode_mode_to_security_class(inode->i_mode);
> @@ -6148,7 +6161,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid = task_sid(target);
> +	u32 sid = task_sid_subj(target);
>  	int rc;
>  
>  	isec = selinux_ipc(msq);
> @@ -7143,8 +7156,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>  	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
>  	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
> -	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid),
> -	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid_subj),
> +	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
>  	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
>  	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
>  	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
> 

