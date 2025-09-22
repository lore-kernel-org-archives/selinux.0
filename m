Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EB302155
	for <selinux@vger.kernel.org>; Mon, 22 Sep 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555947; cv=none; b=Iy3ZiSq1haTjA7BOckU/ETb+jobadLoO03BjUO81pH6rqUzcYkENWaIZyaewrKnjftLdej43omtLO019STKxGHObarjW8W48Vl9jb7pFVsO99gJ9fk9tAdVBhsmr3mSZy/p4EBErDMQSUWqgbXWCOycc/sGscPb3C9AuQyfSynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555947; c=relaxed/simple;
	bh=FXW+261CGMVH6qiGheXzMvww+fJ7VwKaM61cgKurRWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+T2m0X11BxbOTdT645QXMJI3zMVrhkK+PJf4zu6Zpvf1cAzFKtTBX6+WJ7gOOa5nvV34+wMNTduEl4fQGEBO71yRY8joC2Umd4qzNwcD3irf0Gp/VNozIuAGsDJeUIOtpUWa8QIlEh2ZAFdA2GaiNUI0xYhSwwGn5MNf+gd5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=m2zG7Z3z; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m2zG7Z3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758555943; bh=LwYmxImU1FDRzTsaYIpyazYmsI7vzpHu3vO3tJmpTkY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=m2zG7Z3z8aeCXOvGOim65tFBPbTAI86tnSqXFf1GHrK16HdHHRcT0MITC+mc+jkKCtWLvvv0gyfJuMDrxvV2bU3zC1Ym/f84pA3gB5b9Cwu3uigu3O6BjR4j8JcnRmdHRrdWx56wH9zCBXOx+FwYvoskuSYHaFMm2TVlnrJHqRRvbPijGTcXYgqWHvPzM1KxeUMqInprYTn9GfwDRPupFWAcXfkxfRccZ3SQJzX3kyYM93OlpZkajZfwAqbLgw8US/RBacNuUmDRKG+guktH5b570CV0yU687XVkOn3c6EEmXxa0Vnb+l/hcXz7lp58vRj3jmFala+GvWr0ACrbQMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758555943; bh=ApOeJFWJmg4413C1R8zLRbgVpt2hdO3/T0UiiHv8SFF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hGqY2yu3lvdHsO8t9l8uKyFir3Q9WpW3T0viW3+tw85V3s/LarEL8tXMm0WA4TJI98FKFZZMNcNFOaLLvvrXg99qPpphMi5mY2SjPJiZLBrZuQFGybEOFHO0mUnGsALX8nrx0yleroINJDcLn9OkK7sfHUIxnalU1OYSpn8lTt7SmAYcCAFnmWE6uAwjtxVqmyqdJeyuIDGbIijAjFm91U90bL31OGMV6YmVSWDo9PpVxivfm/Yx6iU1+biSf2zB+xjxIOKFJ4wfQsqRAn+dj5K82V+aqmVrAzwwNwVuS67K9Pw3RBHcJOIEBufnTO5KCc5DD4X0N5s95noh5mDLqw==
X-YMail-OSG: IW1SymYVM1ki3niRNFfY_eqobWuH3aPeEqYJ9d9wmU.71SJlTsl15gqWKqz8xr5
 QihOXaYiwAAWEXntjrRu5iLsB6Obh_7pBttMj_iT3HRmNA.U2IIYiBS7l4T5jwXFcohuod0l95.t
 7OnZyeDgflHR.XZ2_F_WDkArhP5xUanuwKiivW5IGXOlLQMtbiy6E0onHgyMvDYDevR3JiXuscmw
 yKA7vIvR5JmGHDjuXPol_RnJpYqcF52SNV2Up7nxZ7ZuL8K8rSF4f6FjGRenfYgt98yXiyflpIx6
 rcu4riWW9jKDKQyWEPYoiOHwLw1xXy8gSlfftqOoLEVFnE_uWWncAMYzSTgOU15Ro7XBW1X.co__
 W.hD_4b_xrpZvyhbLYYrHyCZFTsM4qVa5lXw4GQ4oNN3xteiLCL0SKtWx7AeOe9vRAPl8yb4VsOm
 2AYOHPPRl2pm4TzIToZI46va_QelHBo1IEjlvrf0vB90nsrkQlTK2w1ymFWxspbKR3KUeYlUVEGu
 Hv.mKFqIEcExU8OmYxj5C0DdQ35nIN79QKG09xxoX_n1UCmWy.myh4Kn9OYWrEmNCjWDSyKVDbtj
 SNhlTAUP.TmNDbsYs3A7yGcJR63wh_9u0yab715APEModt3LoP8fg0IaTK0SjDbX_9VLmJpMygnw
 fjL9DNVIqpAfru9E3UefP3BRRh9ant9SYs1bppUQuoIyz.XcsG5ilfg44TV1xgtsN_iNtJbx97RY
 tQrM_Klv.pUrc8bmUiSitKbUEIKMJUj6OQ97KrgBvf.Go9NJxh13ALIc5M152V8m6R1LHGzLQfXT
 bGEmt3ZkVxt3Ph1EaaV7Ezz1y27C1qrRKw41kgJUvVbHqG61c6mQvOe6W_ulUhhaf.rb5qnlxukq
 c24TW8xJ2lAcwLjv3fTQ_h5Zwb09QUJ7AIzxBleYsLUYYSgQ_tcrY2kg0.FAIbN12Zb.PuKLbjF.
 D.FU5zpJ6vr2tjCF8Oy3IjUOsyaj533Rwxt7FxjAwHAakyw80Ny_7bw59nbXWxbOPEBay4lk03lY
 iJXOenynHbkhEUgY7o.iO3ld3cGWmL4Datxq2uz3hD6bouY8Jh0aDt5DzcBS33QxZWqQfmRmM82F
 EU7tmTIAwyEZ8oNGnOyOVI3ipdUavEeRDUmr_Z7woVJdrVsyk_kof.YuKzVL5qpE3V81VnBUZUrF
 Ss3o8BwPhQycGzr.PPLCZw7waxmbqaKGJWjJDynl3swDxbkPiimwwRiqNV0IfDT2K8eDRFMhzZln
 wf_dVB1f.S61Ispgs_MVWCbepi0GHrSC3.YFEuNJB.FvCMmj0Z3r3att7cwS9nZ5fZypGbHvMyHi
 314uy.kQEz18MgDL_TXPeB3d9K3PsJt5rck1RaU1yFIVUby6rkgSQtZuOWb07SYhUqth0eW4v2gh
 IqmvJ2aWBRH0GdRAqVkmAIWgcFXMnSn5eXdDw3q0WdzFBLGZwa_E7IMDan2gBcec1TxR.uBF261x
 Vbe.54HzWS4u6iGnrNJfDiVWtObi.5mIaF2OdYC60RBvnArDS0g8G.0X.a0PZbV4SQqDe35AjpgT
 hlXa.Mt3vIaiRSLqClfTsKUJy.nbGDJOc0AwF0f7a.em0EjMYmUJk9t9Z.kZ5kObv8AXkeul8Dhs
 T3p02T_hyh3xTwpTLqBYQwezKNy5xYgFygfJmiGRqCZZ8_kb.yY0CE2KROHmEBcbXf5MG4F7yGBS
 JL0m0VoErq.qvoW7T7JLa_5hxGA3ApX6lIqyFPTuXc8UEfA5KWVVMf8HrJsr0vn_TK1Gbv8eoSOA
 M7va2GonEq6AieJpgfH_IrOIKxIMg1zdzVh8LRoFT4G09PgKi7nGpXUgg_.caNs3GAw.NwvxP47R
 NzPtJr__GgSWy.WaMIiflTIwN_QehuMFHc8kXR8U2N952c086XFMrx.yR8ExtNzo6vJtPdVIjUJj
 jRlB_YiXre.JtXpM_6GSroPAGrzRig45TN6oPDLIt61MGZcG.IxUP2mRRIIFAUzuqJCQ3St5TsMR
 xDqdrT9GD8bBQFBaKGKST3M2Ei53qJZSq9xe39RYcttJo.PeE4rhr7OXbfuE8OCtZEG7V0gk8JJd
 Fa9rajOUhw5YiruR1BhH4qt3VbnqWhdRaBOaIE297wTkcgNHG85zbKN.KFVKBUBPLc1HKV4QtB2K
 N72ZQKOfAl.rZKKPsUCyjI7IAGGBb_G62YUXTME9of.BluTvZ6wCnH46uzGiloM5qc.CtDQaXA6a
 lkrCao6Xytk2p65hA1sLbNOHyEKaR9LbrwwQUcevkfGaT9cJy8w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4855642b-4653-4731-83f2-24b1fbb159fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Sep 2025 15:45:43 +0000
Received: by hermes--production-gq1-6f9f7cb74b-4gzdx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c957ca06ddf2fb82d9e193af5e36e355;
          Mon, 22 Sep 2025 15:45:40 +0000 (UTC)
Message-ID: <033e25d3-8a0b-41d1-86a2-d0ab471348ba@schaufler-ca.com>
Date: Mon, 22 Sep 2025 08:45:39 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire
 it up for SELinux
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, john.johansen@canonical.com,
 serge@hallyn.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250918135904.9997-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24425 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/18/2025 6:59 AM, Stephen Smalley wrote:
> RFC-only, will ultimately split the LSM-only changes to their own
> patch for submission. I have now tested this with the corresponding
> selinux userspace change that you can find at
> https://lore.kernel.org/selinux/20250918135118.9896-2-stephen.smalley.work@gmail.com/
> and also verified that my modified systemd-nspawn still works when
> starting containers with their own SELinux namespace.
>
> This defines a new LSM_ATTR_UNSHARE attribute for the
> lsm_set_self_attr(2) system call and wires it up for SELinux to invoke
> the underlying function for unsharing the SELinux namespace. As with
> the selinuxfs interface, this immediately unshares the SELinux
> namespace of the current process just like an unshare(2) system call
> would do for other namespaces. I have not yet explored the
> alternatives of deferring the unshare to the next unshare(2),
> clone(2), or execve(2) call and would want to first confirm that doing
> so does not introduce any issues in the kernel or make it harder to
> integrate with existing container runtimes.
>
> Differences between this syscall interface and the selinuxfs interface
> that need discussion before moving forward:
>
> 1. The syscall interface does not currently check any Linux capability
> or DAC permissions, whereas the selinuxfs interface can only be set by
> uid-0 or CAP_DAC_OVERRIDE processes. We need to decide what if any
> capability or DAC check should apply to this syscall interface and if
> any, add the checks to either the LSM framework code or to the SELinux
> hook function.
>
> Pros: Checking a capability or DAC permissions prevents misuse of this
> interface by unprivileged processes, particularly on systems with
> policies that do not yet define any of the new SELinux permissions
> introduced for controlling this operation. This is a potential concern
> on Linux distributions that do not tightly coordinate kernel updates
> with policy updates (or where users may choose to deploy upstream
> kernels on their own), but not on Android.
>
> Cons: Checking a capability or DAC permissions requires any process
> that uses this facility to have the corresponding capability or
> permissions, which might otherwise be unnecessary and create
> additional risks. This is less likely if we use a capability already
> required by container runtimes and similar components that might
> leverage this facility for unsharing SELinux namespaces.
>
> 2. The syscall interface checks a new SELinux unshare_selinuxns
> permission in the process2 class between the task SID and itself,
> similar to other checks for setting process attributes. This means
> that:
>     allow domain self:process2 *; -or-
>     allow domain self:process2 ~anything-other-than-unshare_selinuxns; -or-
>     allow domain self:process2 unshare_selinuxns;
> would allow a process to unshare its SELinux namespace.
>
> The selinuxfs interface checks a new unshare permission in the
> security class between the task SID and the security initial SID,
> likewise similar to other checks for setting selinuxfs attributes.
> This means that:
>     allow domain security_t:security *; -or-
>     allow domain security_t:security ~anything-other-than-unshare; -or-
>     allow domain security_t:security unshare;
> would allow a process to unshare its SELinux namespace.
>
> Technically, the selinuxfs interface also currently requires open and
> write access to the selinuxfs node; hence:
>     allow domain security_t:file { open write };
> is also required for the selinuxfs interface.
>
> We need to decide what we want the SELinux check(s) to be for the
> syscall and whether it should be more like the former (process
> attributes) or more like the latter (security policy settings). Note
> that the permission name itself is unimportant here and only differs
> because it seemed less evident in the process2 class that we are
> talking about a SELinux namespace otherwise.
>
> Regardless, either form of allow rule can be prohibited in policies
> via neverallow rules on systems that enforce their usage
> (e.g. Android, not necessarily on Linux distributions).
>
> 3. The selinuxfs interface currently offers more functionality than I
> have implemented here for the sycall interface, including:
>
> a) the ability to read the selinuxfs node to see if your namespace has
> been unshared, which should be easily implementable via
> lsm_get_self_attr(2).  However, questions remain as to when that
> should return 1 versus 0 (currently returns 1 whenever your namespace
> is NOT the initial SELinux namespace, useful for the testsuite to
> detect it is in a child, but could instead be reset to 0 by a
> subsequent policy load to indicate completion of the setup of the
> namespace, thus hiding from child processes that they are in a child
> namespace once its policy has been loaded).
>
> b) the abilities to get and set the maximum number of SELinux
> namespaces (via a /sys/fs/selinux/maxns node) and to get and set the
> maximum depth for SELinux namespaces (via a /sys/fs/selinux/maxnsdepth
> node). These could be left in selinuxfs or migrated to some other LSM
> management APIs since they are global in scope, not per-process
> attributes.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This looks like an appropriate use of lsm_set_self_attr() to me.
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> v2 fixes a typo (PROCESS->PROCESS2) and is now tested.
>
>  include/uapi/linux/lsm.h            | 1 +
>  security/selinux/hooks.c            | 8 ++++++++
>  security/selinux/include/classmap.h | 4 +++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..fb1b4a8aa639 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -83,6 +83,7 @@ struct lsm_ctx {
>  #define LSM_ATTR_KEYCREATE	103
>  #define LSM_ATTR_PREV		104
>  #define LSM_ATTR_SOCKCREATE	105
> +#define LSM_ATTR_UNSHARE	106
>  
>  /*
>   * LSM_FLAG_XXX definitions identify special handling instructions
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f48483383d6e..1e34a16b7954 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6816,6 +6816,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETCURRENT, NULL);
>  		break;
> +	case LSM_ATTR_UNSHARE:
> +		error = avc_has_perm(state, mysid, mysid, SECCLASS_PROCESS2,
> +				     PROCESS2__UNSHARE_SELINUXNS, NULL);
> +		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  		break;
> @@ -6927,6 +6931,10 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  		}
>  
>  		tsec->sid = sid;
> +	} else if (attr == LSM_ATTR_UNSHARE) {
> +		error = selinux_state_create(new);
> +		if (error)
> +			goto abort_change;
>  	} else {
>  		error = -EINVAL;
>  		goto abort_change;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index be52ebb6b94a..07fe316308cd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -60,7 +60,9 @@ const struct security_class_mapping secclass_map[] = {
>  	    "siginh",	    "setrlimit",     "rlimitinh",   "dyntransition",
>  	    "setcurrent",   "execmem",	     "execstack",   "execheap",
>  	    "setkeycreate", "setsockcreate", "getrlimit",   NULL } },
> -	{ "process2", { "nnp_transition", "nosuid_transition", NULL } },
> +	{ "process2",
> +	  { "nnp_transition", "nosuid_transition", "unshare_selinuxns",
> +	    NULL } },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
>  	    "module_request", "module_load", "firmware_load",
