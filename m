Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A5C433E5
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 20:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD362074F
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 20:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgG1U3u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:29:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgG1U3t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 16:29:49 -0400
Received: from static-50-53-54-182.bvtn.or.frontiernet.net ([50.53.54.182] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1k0WEA-0004uU-Dm; Tue, 28 Jul 2020 20:29:34 +0000
Subject: Re: [PATCH v19 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
References: <20200724203226.16374-1-casey@schaufler-ca.com>
 <20200724203226.16374-3-casey@schaufler-ca.com>
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
Message-ID: <d5ff5d7c-633c-68d6-cf74-29ae2d72fb3d@canonical.com>
Date:   Tue, 28 Jul 2020 12:50:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724203226.16374-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/24/20 1:32 PM, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.
> 
assuming the config issue Stephan found is fixed
you can have my

Acked-by: John Johansen <john.johansen@canonical.com>

> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h               |  4 +-
>  include/linux/lsm_hooks.h           | 12 ++++-
>  include/linux/security.h            | 66 ++++++++++++++++++++++++--
>  kernel/auditfilter.c                | 24 +++++-----
>  kernel/auditsc.c                    | 12 ++---
>  security/apparmor/lsm.c             |  7 ++-
>  security/commoncap.c                |  7 ++-
>  security/integrity/ima/ima_policy.c | 40 +++++++++++-----
>  security/loadpin/loadpin.c          |  8 +++-
>  security/lockdown/lockdown.c        |  7 ++-
>  security/safesetid/lsm.c            |  8 +++-
>  security/security.c                 | 72 ++++++++++++++++++++++++-----
>  security/selinux/hooks.c            |  8 +++-
>  security/smack/smack_lsm.c          |  7 ++-
>  security/tomoyo/tomoyo.c            |  8 +++-
>  security/yama/yama_lsm.c            |  7 ++-
>  16 files changed, 242 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 3fcd9ee49734..aabbbe6d9296 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/ptrace.h>
> +#include <linux/security.h>
>  #include <uapi/linux/audit.h>
>  
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
> @@ -64,8 +65,9 @@ struct audit_field {
>  		kuid_t			uid;
>  		kgid_t			gid;
>  		struct {
> +			bool		lsm_isset;
>  			char		*lsm_str;
> -			void		*lsm_rule;
> +			void		*lsm_rules[LSMBLOB_ENTRIES];
>  		};
>  	};
>  	u32				op;
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b4bcafc79e0b..c9f792066d86 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1532,6 +1532,14 @@ struct security_hook_heads {
>  	#undef LSM_HOOK
>  } __randomize_layout;
>  
> +/*
> + * Information that identifies a security module.
> + */
> +struct lsm_id {
> +	const char	*lsm;	/* Name of the LSM */
> +	int		slot;	/* Slot in lsmblob if one is allocated */
> +};
> +
>  /*
>   * Security module hook list structure.
>   * For use with generic list macros for common operations.
> @@ -1540,7 +1548,7 @@ struct security_hook_list {
>  	struct hlist_node		list;
>  	struct hlist_head		*head;
>  	union security_list_options	hook;
> -	char				*lsm;
> +	struct lsm_id			*lsmid;
>  } __randomize_layout;
>  
>  /*
> @@ -1575,7 +1583,7 @@ extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +			       struct lsm_id *lsmid);
>  
>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0a0a03b36a3b..591dae299c6f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -131,6 +131,64 @@ enum lockdown_reason {
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>  
> +/*
> + * Data exported by the security modules
> + *
> + * Any LSM that provides secid or secctx based hooks must be included.
> + */
> +#define LSMBLOB_ENTRIES ( \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
> +
> +struct lsmblob {
> +	u32     secid[LSMBLOB_ENTRIES];
> +};
> +
> +#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
> +#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
> +#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.
> + * @blob: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		blob->secid[i] = secid;
> +}
> +
> +/**
> + * lsmblob_is_set - report if there is an value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a secid set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	struct lsmblob empty = {};
> +
> +	return !!memcmp(blob, &empty, sizeof(*blob));
> +}
> +
> +/**
> + * lsmblob_equal - report if the two lsmblob's are equal
> + * @bloba: Pointer to one LSM data
> + * @blobb: Pointer to the other LSM data
> + *
> + * Returns true if all entries in the two are equal, false otherwise
> + */
> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
> +{
> +	return !memcmp(bloba, blobb, sizeof(*bloba));
> +}
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> @@ -1820,8 +1878,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  #ifdef CONFIG_SECURITY
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> -void security_audit_rule_free(void *lsmrule);
> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
> +void security_audit_rule_free(void **lsmrule);
>  
>  #else
>  
> @@ -1837,12 +1895,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>  }
>  
>  static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +					    void **lsmrule)
>  {
>  	return 0;
>  }
>  
> -static inline void security_audit_rule_free(void *lsmrule)
> +static inline void security_audit_rule_free(void **lsmrule)
>  { }
>  
>  #endif /* CONFIG_SECURITY */
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index a10e2997aa6c..f9a632ae7be1 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -74,7 +74,7 @@ static void audit_free_lsm_field(struct audit_field *f)
>  	case AUDIT_OBJ_LEV_LOW:
>  	case AUDIT_OBJ_LEV_HIGH:
>  		kfree(f->lsm_str);
> -		security_audit_rule_free(f->lsm_rule);
> +		security_audit_rule_free(f->lsm_rules);
>  	}
>  }
>  
> @@ -519,9 +519,10 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
>  				goto exit_free;
>  			}
>  			entry->rule.buflen += f_val;
> +			f->lsm_isset = true;
>  			f->lsm_str = str;
>  			err = security_audit_rule_init(f->type, f->op, str,
> -						       (void **)&f->lsm_rule);
> +						       f->lsm_rules);
>  			/* Keep currently invalid fields around in case they
>  			 * become valid after a policy reload. */
>  			if (err == -EINVAL) {
> @@ -774,7 +775,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
>  	return 0;
>  }
>  
> -/* Duplicate LSM field information.  The lsm_rule is opaque, so must be
> +/* Duplicate LSM field information.  The lsm_rules is opaque, so must be
>   * re-initialized. */
>  static inline int audit_dupe_lsm_field(struct audit_field *df,
>  					   struct audit_field *sf)
> @@ -788,9 +789,9 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
>  		return -ENOMEM;
>  	df->lsm_str = lsm_str;
>  
> -	/* our own (refreshed) copy of lsm_rule */
> +	/* our own (refreshed) copy of lsm_rules */
>  	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
> -				       (void **)&df->lsm_rule);
> +				       df->lsm_rules);
>  	/* Keep currently invalid fields around in case they
>  	 * become valid after a policy reload. */
>  	if (ret == -EINVAL) {
> @@ -842,7 +843,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
>  	new->tree = old->tree;
>  	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
>  
> -	/* deep copy this information, updating the lsm_rule fields, because
> +	/* deep copy this information, updating the lsm_rules fields, because
>  	 * the originals will all be freed when the old rule is freed. */
>  	for (i = 0; i < fcount; i++) {
>  		switch (new->fields[i].type) {
> @@ -1358,10 +1359,11 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_TYPE:
>  			case AUDIT_SUBJ_SEN:
>  			case AUDIT_SUBJ_CLR:
> -				if (f->lsm_rule) {
> +				if (f->lsm_isset) {
>  					security_task_getsecid(current, &sid);
>  					result = security_audit_rule_match(sid,
> -						   f->type, f->op, f->lsm_rule);
> +						   f->type, f->op,
> +						   f->lsm_rules);
>  				}
>  				break;
>  			case AUDIT_EXE:
> @@ -1388,7 +1390,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>  	return ret;
>  }
>  
> -static int update_lsm_rule(struct audit_krule *r)
> +static int update_lsm_rules(struct audit_krule *r)
>  {
>  	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
>  	struct audit_entry *nentry;
> @@ -1420,7 +1422,7 @@ static int update_lsm_rule(struct audit_krule *r)
>  	return err;
>  }
>  
> -/* This function will re-initialize the lsm_rule field of all applicable rules.
> +/* This function will re-initialize the lsm_rules field of all applicable rules.
>   * It will traverse the filter lists serarching for rules that contain LSM
>   * specific filter fields.  When such a rule is found, it is copied, the
>   * LSM field is re-initialized, and the old rule is replaced with the
> @@ -1435,7 +1437,7 @@ int audit_update_lsm_rules(void)
>  
>  	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
>  		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
> -			int res = update_lsm_rule(r);
> +			int res = update_lsm_rules(r);
>  			if (!err)
>  				err = res;
>  		}
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 468a23390457..bafa03a5c866 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -649,14 +649,14 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			   match for now to avoid losing information that
>  			   may be wanted.   An error message will also be
>  			   logged upon error */
> -			if (f->lsm_rule) {
> +			if (f->lsm_isset) {
>  				if (need_sid) {
>  					security_task_getsecid(tsk, &sid);
>  					need_sid = 0;
>  				}
>  				result = security_audit_rule_match(sid, f->type,
>  								   f->op,
> -								   f->lsm_rule);
> +								   f->lsm_rules);
>  			}
>  			break;
>  		case AUDIT_OBJ_USER:
> @@ -666,21 +666,21 @@ static int audit_filter_rules(struct task_struct *tsk,
>  		case AUDIT_OBJ_LEV_HIGH:
>  			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
>  			   also applies here */
> -			if (f->lsm_rule) {
> +			if (f->lsm_isset) {
>  				/* Find files that match */
>  				if (name) {
>  					result = security_audit_rule_match(
>  								name->osid,
>  								f->type,
>  								f->op,
> -								f->lsm_rule);
> +								f->lsm_rules);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
>  						if (security_audit_rule_match(
>  								n->osid,
>  								f->type,
>  								f->op,
> -								f->lsm_rule)) {
> +								f->lsm_rules)) {
>  							++result;
>  							break;
>  						}
> @@ -691,7 +691,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  					break;
>  				if (security_audit_rule_match(ctx->ipc.osid,
>  							      f->type, f->op,
> -							      f->lsm_rule))
> +							      f->lsm_rules))
>  					++result;
>  			}
>  			break;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f1c365905d5e..432915c1d427 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1152,6 +1152,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>  	.lbs_sock = sizeof(struct aa_sk_ctx),
>  };
>  
> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
> +	.lsm  = "apparmor",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>  static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
> @@ -1852,7 +1857,7 @@ static int __init apparmor_init(void)
>  		goto buffers_out;
>  	}
>  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				&apparmor_lsmid);
>  
>  	/* Report that AppArmor successfully initialized */
>  	apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 59bf3c1674c8..959a9f96b7f1 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1341,6 +1341,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>  
>  #ifdef CONFIG_SECURITY
>  
> +static struct lsm_id capability_lsmid __lsm_ro_after_init = {
> +	.lsm  = "capability",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(capable, cap_capable),
>  	LSM_HOOK_INIT(settime, cap_settime),
> @@ -1365,7 +1370,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  static int __init capability_init(void)
>  {
>  	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> -				"capability");
> +			   &capability_lsmid);
>  	return 0;
>  }
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e493063a3c34..a442b8940e93 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -73,7 +73,7 @@ struct ima_rule_entry {
>  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
>  	int pcr;
>  	struct {
> -		void *rule;	/* LSM file metadata specific */
> +		void *rules[LSMBLOB_ENTRIES];
>  		void *args_p;	/* audit value */
>  		int type;	/* audit type */
>  	} lsm[MAX_LSM_RULES];
> @@ -82,6 +82,22 @@ struct ima_rule_entry {
>  	struct ima_template_desc *template;
>  };
>  
> +/**
> + * ima_lsm_isset - Is a rule set for any of the active security modules
> + * @rules: The set of IMA rules to check.
> + *
> + * If a rule is set for any LSM return true, otherwise return false.
> + */
> +static inline bool ima_lsm_isset(void *rules[])
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (rules[i])
> +			return true;
> +	return false;
> +}
> +
>  /*
>   * Without LSM specific knowledge, the default policy can only be
>   * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
> @@ -256,9 +272,11 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
>  static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  {
>  	int i;
> +	int r;
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		kfree(entry->lsm[i].rule);
> +		for (r = 0; r < LSMBLOB_ENTRIES; r++)
> +			kfree(entry->lsm[i].rules[r]);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  	kfree(entry);
> @@ -293,8 +311,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  		security_filter_rule_init(nentry->lsm[i].type,
>  					  Audit_equal,
>  					  nentry->lsm[i].args_p,
> -					  &nentry->lsm[i].rule);
> -		if (!nentry->lsm[i].rule)
> +					  nentry->lsm[i].rules);
> +		if (!ima_lsm_isset(nentry->lsm[i].rules))
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				(char *)entry->lsm[i].args_p);
>  	}
> @@ -463,7 +481,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		int rc = 0;
>  		u32 osid;
>  
> -		if (!rule->lsm[i].rule) {
> +		if (!ima_lsm_isset(rule->lsm[i].rules)) {
>  			if (!rule->lsm[i].args_p)
>  				continue;
>  			else
> @@ -477,7 +495,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			rc = security_filter_rule_match(osid,
>  							rule->lsm[i].type,
>  							Audit_equal,
> -							rule->lsm[i].rule);
> +							rule->lsm[i].rules);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
> @@ -485,7 +503,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  			rc = security_filter_rule_match(secid,
>  							rule->lsm[i].type,
>  							Audit_equal,
> -							rule->lsm[i].rule);
> +							rule->lsm[i].rules);
>  		default:
>  			break;
>  		}
> @@ -872,7 +890,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  {
>  	int result;
>  
> -	if (entry->lsm[lsm_rule].rule)
> +	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
>  		return -EINVAL;
>  
>  	entry->lsm[lsm_rule].args_p = match_strdup(args);
> @@ -883,8 +901,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
>  					   Audit_equal,
>  					   entry->lsm[lsm_rule].args_p,
> -					   &entry->lsm[lsm_rule].rule);
> -	if (!entry->lsm[lsm_rule].rule) {
> +					   entry->lsm[lsm_rule].rules);
> +	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>  			(char *)entry->lsm[lsm_rule].args_p);
>  
> @@ -1585,7 +1603,7 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		if (entry->lsm[i].rule) {
> +		if (ima_lsm_isset(entry->lsm[i].rules)) {
>  			switch (i) {
>  			case LSM_OBJ_USER:
>  				seq_printf(m, pt(Opt_obj_user),
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index ee5cb944f4ad..86317e78899f 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -180,6 +180,11 @@ static int loadpin_load_data(enum kernel_load_data_id id)
>  	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>  }
>  
> +static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
> +	.lsm  = "loadpin",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> @@ -227,7 +232,8 @@ static int __init loadpin_init(void)
>  	pr_info("ready to pin (currently %senforcing)\n",
>  		enforce ? "" : "not ");
>  	parse_exclude();
> -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> +	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
> +			   &loadpin_lsmid);
>  	return 0;
>  }
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 87cbdc64d272..4e24ea3f7b7e 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -75,6 +75,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>  };
>  
> +static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
> +	.lsm = "lockdown",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>  static int __init lockdown_lsm_init(void)
>  {
>  #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
> @@ -83,7 +88,7 @@ static int __init lockdown_lsm_init(void)
>  	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
>  #endif
>  	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
> -			   "lockdown");
> +			   &lockdown_lsmid);
>  	return 0;
>  }
>  
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 7760019ad35d..950dfb7f931e 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -149,6 +149,11 @@ static int safesetid_task_fix_setuid(struct cred *new,
>  	return -EACCES;
>  }
>  
> +static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
> +	.lsm  = "safesetid",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list safesetid_security_hooks[] = {
>  	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>  	LSM_HOOK_INIT(capable, safesetid_security_capable)
> @@ -157,7 +162,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
>  static int __init safesetid_security_init(void)
>  {
>  	security_add_hooks(safesetid_security_hooks,
> -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> +			   ARRAY_SIZE(safesetid_security_hooks),
> +			   &safesetid_lsmid);
>  
>  	/* Report that SafeSetID successfully initialized */
>  	safesetid_initialized = 1;
> diff --git a/security/security.c b/security/security.c
> index d2366c694cd8..17d701cd7f69 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -340,6 +340,7 @@ static void __init ordered_lsm_init(void)
>  	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
>  	init_debug("sock blob size     = %d\n", blob_sizes.lbs_sock);
>  	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
> +	init_debug("lsmblob size       = %zu\n", sizeof(struct lsmblob));
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -467,21 +468,36 @@ static int lsm_append(const char *new, char **result)
>  	return 0;
>  }
>  
> +/*
> + * Current index to use while initializing the lsmblob secid list.
> + */
> +static int lsm_slot __lsm_ro_after_init;
> +
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
>   * @hooks: the hooks to add
>   * @count: the number of hooks to add
> - * @lsm: the name of the security module
> + * @lsmid: the the identification information for the security module
>   *
>   * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>   */
>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +			       struct lsm_id *lsmid)
>  {
>  	int i;
>  
> +	if (lsmid->slot == LSMBLOB_NEEDED) {
> +		if (lsm_slot >= LSMBLOB_ENTRIES)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsmid->slot = lsm_slot++;
> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
> +			   lsmid->slot);
> +	}
> +
>  	for (i = 0; i < count; i++) {
> -		hooks[i].lsm = lsm;
> +		hooks[i].lsmid = lsmid;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>  	}
>  
> @@ -490,7 +506,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	 * and fix this up afterwards.
>  	 */
>  	if (slab_is_available()) {
> -		if (lsm_append(lsm, &lsm_names) < 0)
> +		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
>  			panic("%s - Cannot get early memory.\n", __func__);
>  	}
>  }
> @@ -1989,7 +2005,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
> @@ -2002,7 +2018,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
> @@ -2494,7 +2510,24 @@ int security_key_getsecurity(struct key *key, char **_buffer)
>  
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
>  {
> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +	struct security_hook_list *hp;
> +	bool one_is_good = false;
> +	int rc = 0;
> +	int trc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		trc = hp->hook.audit_rule_init(field, op, rulestr,
> +					       &lsmrule[hp->lsmid->slot]);
> +		if (trc == 0)
> +			one_is_good = true;
> +		else
> +			rc = trc;
> +	}
> +	if (one_is_good)
> +		return 0;
> +	return rc;
>  }
>  
>  int security_audit_rule_known(struct audit_krule *krule)
> @@ -2502,14 +2535,31 @@ int security_audit_rule_known(struct audit_krule *krule)
>  	return call_int_hook(audit_rule_known, 0, krule);
>  }
>  
> -void security_audit_rule_free(void *lsmrule)
> +void security_audit_rule_free(void **lsmrule)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
> +	}
>  }
>  
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.audit_rule_match(secid, field, op,
> +					       &lsmrule[hp->lsmid->slot]);
> +		if (rc)
> +			return rc;
> +	}
> +	return 0;
>  }
>  #endif /* CONFIG_AUDIT */
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7f312714d96a..1c821bec7472 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6929,6 +6929,11 @@ static int selinux_perf_event_write(struct perf_event *event)
>  }
>  #endif
>  
> +static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
> +	.lsm  = "selinux",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>  /*
>   * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
>   * 1. any hooks that don't belong to (2.) or (3.) below,
> @@ -7240,7 +7245,8 @@ static __init int selinux_init(void)
>  
>  	hashtab_cache_init();
>  
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
> +			   &selinux_lsmid);
>  
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4f9023f7f219..d4655dec2d70 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4649,6 +4649,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_sock = sizeof(struct socket_smack),
>  };
>  
> +static struct lsm_id smack_lsmid __lsm_ro_after_init = {
> +	.lsm  = "smack",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
> @@ -4848,7 +4853,7 @@ static __init int smack_init(void)
>  	/*
>  	 * Register with LSM
>  	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
>  	smack_enabled = 1;
>  
>  	pr_info("Smack:  Initializing.\n");
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index f9adddc42ac8..e5848069af34 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -523,6 +523,11 @@ static void tomoyo_task_free(struct task_struct *task)
>  	}
>  }
>  
> +static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
> +	.lsm  = "tomoyo",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>  /*
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
> @@ -575,7 +580,8 @@ static int __init tomoyo_init(void)
>  	struct tomoyo_task *s = tomoyo_task(current);
>  
>  	/* register ourselves with the security framework */
> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
> +	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
> +			   &tomoyo_lsmid);
>  	pr_info("TOMOYO Linux initialized\n");
>  	s->domain_info = &tomoyo_kernel_domain;
>  	atomic_inc(&tomoyo_kernel_domain.users);
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 536c99646f6a..c582757669f6 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -421,6 +421,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> +static struct lsm_id yama_lsmid __lsm_ro_after_init = {
> +	.lsm  = "yama",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
> @@ -477,7 +482,7 @@ static inline void yama_init_sysctl(void) { }
>  static int __init yama_init(void)
>  {
>  	pr_info("Yama: becoming mindful.\n");
> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
> +	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
>  	yama_init_sysctl();
>  	return 0;
>  }
> 

