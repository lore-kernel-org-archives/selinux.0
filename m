Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180D2E3E5
	for <selinux@vger.kernel.org>; Sun, 28 Jan 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465130; cv=none; b=XkxmbjvAYuB+Nl5avZKZ+vbcOpzrJsL85S8g4/wcf6zL15WPM5Ey7GcjE7EXYxIr4KpEwnrbdDvezZJ0yj0PdfoaP0X+njfrs+yih18VsgGT3ybnoDTFWY0lQkLwgn4hyUdZR5pDy6POGSDrtcCmqShQLqftcpZu62Zrw0XlWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465130; c=relaxed/simple;
	bh=GG5f3vhL/2G5hqFqfxdQJ4+z+u9EINj0vJr9TjYhhw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfQT7skXMPEF7SmEfPXr7qTOoBBtKWSEUIDG6r2ZS4f55uyteTPh899FqqzIvoV54jNQxBGlww+oo4ij1Ey3yQFSEEcFN32cA9Y7qQl2xweGgWLZaB0OPbBWu1F4imPsfbwKtIGd/L+hLBaJ8VbGdAb7Bh2kheua35xJdHggvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nY0ontWa; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nY0ontWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706465127; bh=+z5w3Vch9lcwscXSHb88wkSY23yuXbRBxIs2jvwLMPg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nY0ontWajf3pwUYGqros9pSc4SGVAw4fYPsW4FLAlXrcQa8+fqwV2CbfcPqqEFbCoa2BBnHpx3XzL/qwJ6sOo9lLYRwAsCxl6ilKYp0YKonqQxkmvpDHSFm9KisYh7gtlfS8VWLZXoVxpcPzFnuO1mMECEstm53NhJe1AeejKZtKp+MmUzDZjRsNeODbxFC+vDMNsL1XOrxl9LB0ByvKn2JRljJxhuKYe76acaRavi6xVte1zOpFbZnf13GsTFpAc+oDPd6HC9xx+bAh/mKWmE6gL3AI8M9eCZ7H+NL+swgSn7CgSlOvLoR6H3skAKxw6a8eXUToYq5bA2GgQGgZtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706465127; bh=bOm19HY3wwv7X2nqSJAc7nT58PLZWbafBhteKTV+pQC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N0ZdxoNMFDGaZaaMzVBUa6/YFe5HvBJluEGW+vrWD+azWTrudc/I2M/ZPDMJCg02ZblPMpVWPZinaZ9yPhNZlS5h0Ai7fxfr9ASH1TLFf7ymci4hEXhep184R9BS4JwXFaFqffF60vLFTMM6jPCiBvp+7Iw6WvWn3Ts4pameRZkCogELigMbbdaRIMLqnJ2xrVYOQWSA5xDwDX/qjPpdstQ48EBSAqExqzF/2P68NE1ccFWGYvDE7CT7ERM414cxJdtMogOo2Xyncc7Q/Sj0vtVzNcbapDhi7dVM1XkwSP6xCeCwv6zsoASwvJE7COPiDnZUywQfiENGL4YNq1izNg==
X-YMail-OSG: nkufe.gVM1mprXgjZpM9PDmP76K1EEDubykiexF5dO_InF.ercGnxNPZRucuWcq
 kPPSiIcfgxCG.4M13zSHGDsyLLWas54lJuqVlWWj_ZMYb2QYMvuxpGzh9ABlqHqpEsIm2Vx.p1Au
 xIZ.M2sFsRXLMO5HV6VaQlG5muxg64aTNJwSAPQ1Z7r07Gf8nP6JBefaZWe.wI5oUA7V9kj7bNBf
 OwQbK5MzUN9A8HsMqk1pFp5my9I.CQaWdNEIXnmYk.JkmM9WJDRcsvx6M8i9jWVBVab4rN7zRMR8
 uWt3VBO95L7yDy4l5NQZbLhHX418uk7qm.wlh_GczfuZ3Xh0ndXopODjLMe.rWOH9XBLBKIjuEA.
 E7hB7pFEeEcfN8mOd_ajgNzZjf00fDZlIIi43LfdCZOfaHkCyWv1NiJaxH1RuQlqR2AtWKNRLYjn
 yvUWz5_LvYgCZZRG5ySrdmdlrwSYtlGb0Iyn2un7FgQqQAzEVcj410Bqk5NrGqPKY4JGY5p8O6ym
 NsaqVZnjHIkgWl6PBWZClg4wyJrXGo5JKfJDQi2aKFpGK0CWCTIB3MUVVanhXZxtHwXjGPe2MovV
 n.gdCBjhyu8xSqellakAwJ8VzLDMIvdp8wZnriZ.7l9eqL4DmXHQPwu8jGP28rb2iI.ShoanC0J5
 dYKsyO_N4CcMbiAIdlmtgZ9rD_6PRzSYtMm_qWR2Pg9tdNuXjmH5eK1MzNRXjNhuzw5OaW7ztiwp
 3m97SH_m1GH5ZLMN.lHvIXawCLef3.SCB0MVCiUWN7h.wtY1UukCfUoyOZmFTw8lF_QMmmIbBj.1
 TMjoM0MX9qHUEMoqjSXJhWRM9myA6TbkZPG91HQ.ZEc9ZqmA75P8waARN.aqUAZoLcd87IywGmug
 1g4x3Rc1lI_z7aamzYPNiVfE2OU7CCQoBKKYicl5N9uezYQgn50eOa2KkNw9PE1N9IdXWJ0ER8iN
 u9k8cFnMRkVevUI0ADSCtOgZLAYjWp9NopeszprgcQgkVVw7_g5FCcH2ABDWMSrWu3XhJ079eIt.
 AWwI0rohEMlBb9.Aiwb.CqyAhM8MTgM3DRUNZYhjNe4FwGdG2DN2GfkTUvxU0gMN8kLapf6hOgR3
 oJ1lk_3yCgSw5OXHis.q3LmVemydOMNSPFrxVew.h1rvLjYSvSlD2a5cXZ8Ebpk0Q.FFS6SZLyxm
 yFa0Px5QvL3N7t2FFE7Pzl6mbsTwVmiEmzZWPzlXlGroGO3UBa01yVUULrlJ4zUuhuqW.eHXwmo4
 _OqeI9GMut83xRQkakJWIcAFBjesv76L17OTFTbxqCoDnRoOEZBOlJr_X4VqH4XesIt6rF9wdY_R
 yqSQZe2pvFX4.b4yvpkyHsmBuu6nFIe6co2XsV.RwzceG9EsxlrUyvX0ILkMkJS90WVOJbeJLyk8
 fWcUcbn0n6BgPS40ssdfRK7OkeWhq9ZyksQl7L..7AsYVzYoQV0_GhOgwSPn.KIdc5B5_oYmJQm2
 MIjSqyNve2IVglWDL.r2oxd18uGSoHGqddQBaePjcuvyRMRnxioPzebw.SUmSv58YM.IEDOOHRpq
 c.HrnAavL43hXZhNcZ0VK3fVxMv6qAiywuncZoSZmb7QDpjdvFwBQfJsw4J4NVNfnbtKnFxX7m92
 TAgb0nBaviFurBXPGPM7_gCu.dTUcJjTxHYfuAZtJ4SvANefTixalMYKEsw0phOg1KXvqTy2JcHW
 vzOwwgW7foAFPbI2.GP3KjzMuP8FkrkgjjaBwhIUqYaY1s9o0JvmM.pHacpntJ3vshOLq80Epr4i
 KLZycjJc3kcpjNoPUBJCo.zC3iwA0QnIsV2XnkMbXBxu5CCmYhe_Prt7W7TEpUqQ8S9hDxbBP0aG
 g44Rj2ilr31Nmdh9FH7cjAf1GcVwus06EJASrtZb3mCVJUCw23RH4us3Tn5JSlIdgVdF2tjxsZBE
 VgQ2FyCWOgiYnb97UxFGd.2y_SgGffqbRakHQZ.BRrneEcFZkCzK.RVbSIrgpavo5FrL_3yEHb.s
 AtsHEnIgflQnLdQVbHJBLFqLb4UVaygM9T6ufl8lhNUGG0Hi2IJPyumQ8hQ1IakpTK3emIY1eBux
 yLpiSHHb9l.COTO9U2G497VEtBTeiY3u13Az2wF5JIEZMRV_PbWNnBdohQYSnGrFvB8A3VYucOt7
 rHbraBRyF_Tv2dart0V6OnYLHRLo9sNm.BHgCQ6p8AXZZzyIOYl7PkI2iSRGnBEEPqxM61bWd24g
 9XwEryflowNRDPEeiQphYfYULtavcOSJMt7Qlz.756ty_KMzwZHDfqgPrCBV6ZMx3BS7zPyppt4Y
 fGzCq.7D0SNbb
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8008d834-fcb6-4dd5-a9f7-a48ab668da24
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sun, 28 Jan 2024 18:05:27 +0000
Received: by hermes--production-gq1-5c57879fdf-7xbd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c939bc87805a9e6c97498467bf419f3e;
          Sun, 28 Jan 2024 18:05:24 +0000 (UTC)
Message-ID: <911d0873-5937-4598-84c1-c890ac4bd186@schaufler-ca.com>
Date: Sun, 28 Jan 2024 10:05:22 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: Use kfree_sensitive for certain code paths of
 security
Content-Language: en-US
To: Ronald Monthero <debug.penguin32@gmail.com>, paul@paul-moore.com
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
 cgzones@googlemail.com, omosnace@redhat.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240128100035.82170-1-debug.penguin32@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240128100035.82170-1-debug.penguin32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/28/2024 2:00 AM, Ronald Monthero wrote:
> As with kfree_sensitive() it does kfree() and memzero_explicit()
> internally to clear sensitive data. The patch includes some of
> the code paths to free data such as keys, hash table and
> scontext and tcontext of selinux, which would benefit
> from kfree_sensitive() to replace kfree()

What about the data being freed makes it "sensitive"? Generally
security attributes are not themselves considered sensitive.

>
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  security/selinux/avc.c            |  4 ++--
>  security/selinux/ima.c            |  2 +-
>  security/selinux/selinuxfs.c      | 16 ++++++++--------
>  security/selinux/ss/conditional.c |  4 ++--
>  security/selinux/ss/hashtab.c     |  2 +-
>  security/selinux/ss/policydb.c    |  6 +++---
>  6 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 32eb67fb3e42..c6d7f52a11c1 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -723,8 +723,8 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>  		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
>  
>  	trace_selinux_audited(sad, scontext, tcontext, tclass);
> -	kfree(tcontext);
> -	kfree(scontext);
> +	kfree_sensitive(tcontext);
> +	kfree_sensitive(scontext);
>  
>  	/* in case of invalid context report also the actual context string */
>  	rc = security_sid_to_context_inval(sad->ssid, &scontext,
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index aa34da9b0aeb..b5d923d272a0 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -86,7 +86,7 @@ void selinux_ima_measure_state_locked(void)
>  				  state_str, strlen(state_str), false,
>  				  NULL, 0);
>  
> -	kfree(state_str);
> +	kfree_sensitive(state_str);
>  
>  	/*
>  	 * Measure SELinux policy only after initialization is completed.
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 6c596ae7fef9..6c2490dbfaa6 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -183,7 +183,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>  	}
>  	length = count;
>  out:
> -	kfree(page);
> +	kfree_sensitive(page);
>  	return length;
>  }
>  #else
> @@ -299,7 +299,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>  	}
>  
>  out:
> -	kfree(page);
> +	kfree_sensitive(page);
>  	return length;
>  }
>  
> @@ -725,7 +725,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>  	selinux_ima_measure_state();
>  
>  out:
> -	kfree(page);
> +	kfree_sensitive(page);
>  	return length;
>  }
>  static const struct file_operations sel_checkreqprot_ops = {
> @@ -1290,7 +1290,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>  
>  out:
>  	mutex_unlock(&selinux_state.policy_mutex);
> -	kfree(page);
> +	kfree_sensitive(page);
>  	return length;
>  }
>  
> @@ -1342,7 +1342,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>  
>  out:
>  	mutex_unlock(&selinux_state.policy_mutex);
> -	kfree(page);
> +	kfree_sensitive(page);
>  	return length;
>  }
>  
> @@ -1481,7 +1481,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
>  
>  	ret = count;
>  out:
> -	kfree(page);
> +	kfree_sensitive(page);
>  	return ret;
>  }
>  
> @@ -1831,7 +1831,7 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
>  out:
>  	for (i = 0; i < nperms; i++)
>  		kfree(perms[i]);
> -	kfree(perms);
> +	kfree_sensitive(perms);
>  	return rc;
>  }
>  
> @@ -1900,7 +1900,7 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
>  out:
>  	for (i = 0; i < nclasses; i++)
>  		kfree(classes[i]);
> -	kfree(classes);
> +	kfree_sensitive(classes);
>  	return rc;
>  }
>  
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 81ff676f209a..51409a74eb74 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -176,8 +176,8 @@ int cond_init_bool_indexes(struct policydb *p)
>  
>  int cond_destroy_bool(void *key, void *datum, void *p)
>  {
> -	kfree(key);
> -	kfree(datum);
> +	kfree_sensitive(key);
> +	kfree_sensitive(datum);
>  	return 0;
>  }
>  
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index c05d8346a94a..73b867fa4726 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -79,7 +79,7 @@ void hashtab_destroy(struct hashtab *h)
>  		h->htable[i] = NULL;
>  	}
>  
> -	kfree(h->htable);
> +	kfree_sensitive(h->htable);
>  	h->htable = NULL;
>  }
>  
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 595a435ea9c8..fd58a6a1ef8f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -179,8 +179,8 @@ static const struct policydb_compat_info *policydb_lookup_compat(unsigned int ve
>  
>  static int perm_destroy(void *key, void *datum, void *p)
>  {
> -	kfree(key);
> -	kfree(datum);
> +	kfree_sensitive(key);
> +	kfree_sensitive(datum);
>  	return 0;
>  }
>  
> @@ -369,7 +369,7 @@ static void ocontext_destroy(struct ocontext *c, unsigned int i)
>  	if (i == OCON_ISID || i == OCON_FS ||
>  	    i == OCON_NETIF || i == OCON_FSUSE)
>  		kfree(c->u.name);
> -	kfree(c);
> +	kfree_sensitive(c);
>  }
>  
>  /*
