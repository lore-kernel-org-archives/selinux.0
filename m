Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473F178378
	for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763692; cv=none; b=N5lnvxfhcznZLQvt2lRFrZ7n/Hi6HiuDsNxSRnmidLCK/sYs9Hgm/cBuQ3C/TFuLBc8fUVW0mAZhSN/MvZ0yBh1EEi+8UzIC8vE0iPXXperEi1eYJV9iUhbpL9pTEjJ6FZf8dD+X+jppCRFfStWVGAOLBOSF2E8bApFdckCHyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763692; c=relaxed/simple;
	bh=zFqv4WgHRUdEjs8Q5QnfEYHLURJwP1mpKMoQwPZlBms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XYZGGfddwflpb47CAa7OttwbgPTt5rx0Uszlyd5tle7TrWqLckkNxvq81aUSGDSF7AZjtZRRCkna5G4ggtzsq1r4LTVrWWGDudQlM+jhv0Zlh/sbI6pfAqMJyk4DzQBJxHwBL9ox+z2hMblK2ZQhWuc33T/nQb/5GPsyOT6xDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CnHdoxki; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CnHdoxki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726763683; bh=aWJ3Rx86nNVzpTXxQhY7S6MpCMjl3ixKOcRPVKn/ZEo=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=CnHdoxkiWmfEUj/pgHRLpQYf5bA5IowHA/zVHCeBo97vgDflfNss9BI7WAITJ9ojWyQf4L9CSoc/7HfR/404hSnBjDgvXQm+FsEvhzzRlARtIbFlrSb33cZSwwqzgtCA0EnGLmYc2ZOcL3rmjakYhqg1g6MOISzmlorFjmQ0osCJvunVyTNLxID/aIruSRdl3p8bruedZ6cHMAowOGQrW9W9gK1JuzQUGgfd7el6SNqkAyT/2L3W2AtSucT7Ustjs9tOzBs1sgFAKm9z8gIcHC8/gT2ETLrMwIv+IQ11f6LkM+/NEij2DkYA3vxjpPWpvSbD465LXjdzjFygPdbMDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726763683; bh=MwNYhBEh55nNyv9mSYCPTK0fRyZSqHqz/Q0J9T5rJaO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=d7ILgMfIY130o3sk3pMyRYdOIFStVaNjMBxu6c29CL8oRRKHAuAunDl6BC2yQuaO/JK3Tq3y/dvEtOtt6ZqYuvRgXK1k8SSsEtwIxCK7S6i/tPsrIkB3TWShIvXPH+CyDIgKNK84HHacx1w+rCqWqBng6laorl9P9WQrk/SNLUbsyuHCpM/WYP+vpc0/kWZ/Za+iMYsfvLowIcGwh8VPEbDImyVxCfdeX1/n2URNjeIikVA5fs5PPxfoMCQnP+/9FiPR6ba2//oxmEdqcsLkGLLx1QkVsVRNCHNoxIlS1Pj44VCnQ1Gp4p5AaoZnKqq3z6dYdfiK1/rBCx14hAMiGQ==
X-YMail-OSG: Qtw02OAVM1l4y_Pp01yFPxKMRJnS1ZJb0ytYes4qJi3dG4_in8KNDp5YunqUkI8
 c0qz1A5uQTu9MPEIzZezK9hdDBVZ.kv5G6XOHxcuMfXhFtn.bWqfj5v3NZ.CzEof7XDg9oWTgVwj
 pwQmN.ReQHs7vjmd5rbwv831q0yR_NVrYA2OR.MG35.vJE_BiIlWJgV4bvpucMyuQh88e6IvhArV
 ELqJZp9RO9XCT_1klSIkgoajE9IdzvhIwHI.tB9qlQ51hxf_.YwKqnrI8Hrvf0hliAWdlOSCPbcw
 dmqbDazenMxE0tgKTxZU8sWDi_iOyGITmhM0TMlDUC79Bh1ahLtCoEh5gC4.0aNAvjSF8sOBLCES
 FaaR86wEQ48phXO2lOOC9wNI5QeGCOyCwqANSFZTUnMW5QmjSBECr6Jn7vH0SUdALSPvTNmZSW2u
 FyekiA17dyjAKHCZgN0s_RaEXr3VZQujintoBXrtfprPA85d2QvUMBeP3STE4JY5VIugn30n1xK9
 kPNiryu1lAIiWPCxkrRDHyJAjNTuA83IhLGRpPRiLZUvC9nT82dCQADet2NzjfrUulbbO3eniCED
 69BeA_Gph95KkulwC9lNC8ttU6eBKrh79D3vwCt2qnGi5OX6lUokrbU9eYzg_6IJ6i6McJuDcn7o
 Nb8vIKWydMNpr8I03cGaZmHtIjg5vl0ZyztBnuWwznKUdxvTY4o.7gZJUWnTyDFMxVtSWXr0vrky
 MSZbCQWdpUCuZ3fVEVQTbo_ER5oTSdnSf9uM4ztBh7DBLJsmzKWqnP_TchncS7QPGB3Nor8E7ms6
 d97Nky_ermFncCoWH1KzvgF1rpud6XKWXPK60jHknZCJJDlhpL.rSZ.yHTfSh9fueF.vQF9e23EK
 IcVL3ZcjmyHs_7azE.CpB0cMBFyWHdSbAVmdEx_PKZsjeVRlPs3JUBrQg.gU7_by0qqvQAbdiWzC
 1ie79NfAjF4DTiJoofFq95nJUbZrQvzDPrUPAOX3FrKu88XnG3pF7dqlGbJ61PBmEYIaUEJNhsXV
 ng6oe06OD3gDRyyRwikUJv5oRLz1Coc87ofMWAxwLxiehcGCu1nFTygJ5ljBpddljg8BBrQ0gP2l
 Axufo.aPM1QJrfDNzvePbOjd7UIfSodX0pGIwsLCQ6TYWbVOu97vzxcD0oOE7nQg0NlX9DwuLeQR
 tcNdTGugor3omRcF_R8nYIdDVIDaLbiw7vp279uf6GQaModB6UIPFnIYxeaB2ZQKbO8gvmKeF0_7
 q.mjYPWb2P0lEyqmbEqZ.0ZMR_h0rxXQVrmSpC7JD4ZLGfr9j_PAdz4myLCpRZoTDy8fedZbD55e
 bb4vJzG9zKGI2HimpHJfXDHMMCWNF8e30I8LSgXvsk4g_XwEL8H6a_KzKBWZtluuCNp27qOkTS4H
 KQWHKP9dodOSWQ5OyQ8m11VjhmaisQrw4VgnT3yr5xFTzYLbuYNlMWQcaxrCZ.aPwGJWuAvIvpwo
 OY_SX2sju1tVd71sXw_Dos3g_PRXi5ZOm2sw0z5CysYkPPH2BJcHZakeAepc9cXSH4y.CA.ZVw7j
 2CplNT7fJKa1CeVumAGDWhktaInWWayHokBshHfXSytSK9ZUPMhbcbpM5ZFTwaKD_BEPMdJJbILP
 t8GsgYyk02hYKXwONvvBJei7cLG6e6F5knSicV08ODj3tMNZSOEdEBUmrtn24VvjW4woesM1zBMm
 oW4WfBDKw63k6rfveLiA7xXyQY8ED0RovAPfRwPyDFUSVjU1PsXhDjXoQ4K7Lirk4jndL1zkBtat
 7joOGVR0jpFMhVezLAOfe0ENkJrRPLKWrlZJ6BMP0JodSl97MVexOSyTrkW_JahT7eztH2182VDA
 1AUtrc6MeC_thnMuV2lROLZFwaU.ISPPMzCtzgibzNusKjzG3mbnX2zXlZIjLnw9JkFJwjmc4FnY
 c0ffoI4er37Y2lhCQBIS2fBRK_xK.3vVq4jAu1GNHmzpjg.7r4nH8Cd9obam.nVRxOyAhBgdVCxS
 grwWjA41vQ9c.1PShe_8FdVFntabyBLTwACLj4P0jngzzdlmgyqBhLE1xJjLZ4VeLd_DzvnF0yM4
 _G1fNQWW3KwZxNLYdUP8Yoe4NzVPjSA.Law91Xep12b7RTFR.EVDLz3IdOERZmscPtrnJNyUbyjR
 nguo1M8K8nZ4hQ2BLkRvs01v.gygTIUKqg_FyiJrH6sXO1Fkef44TpWIW72fqZd7cgOZS1.8T1LK
 mJsflUcAdqqmLCbtmkNerlat.JCC.pFK3azqDVxQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 48e6cc76-187b-4598-9e37-a27bc7befb08
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Sep 2024 16:34:43 +0000
Received: by hermes--production-gq1-5d95dc458-m8nfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ef3b6a98c6bcfef906696630f893e828;
          Thu, 19 Sep 2024 16:34:41 +0000 (UTC)
Message-ID: <45b4a802-6f4a-42fb-85f3-ee2b97c64c07@schaufler-ca.com>
Date: Thu, 19 Sep 2024 09:34:39 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux,smack: properly reference the LSM blob in
 security_watch_key()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240919155740.29539-2-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240919155740.29539-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/19/2024 8:57 AM, Paul Moore wrote:
> Unfortunately when we migrated the lifecycle management of the key LSM
> blob to the LSM framework we forgot to convert the security_watch_key()
> callbacks for SELinux and Smack.  This patch corrects this by making use
> of the selinux_key() and smack_key() helper functions respectively.
>
> This patch also removes some input checking in the Smack callback as it
> is no longer needed.
>
> Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
> Fixes: 5f8d28f6d7d5 ("lsm: infrastructure management of the key security blob")
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/hooks.c   |  2 +-
>  security/smack/smack_lsm.c | 13 +++----------
>  2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 81fbfa5b80d4..67baa487cf7a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6720,7 +6720,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  #ifdef CONFIG_KEY_NOTIFICATIONS
>  static int selinux_watch_key(struct key *key)
>  {
> -	struct key_security_struct *ksec = key->security;
> +	struct key_security_struct *ksec = selinux_key(key);
>  	u32 sid = current_sid();
>  
>  	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, KEY__VIEW, NULL);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index da0c2bffbd08..563fb404f659 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4629,16 +4629,9 @@ static int smack_watch_key(struct key *key)
>  {
>  	struct smk_audit_info ad;
>  	struct smack_known *tkp = smk_of_current();
> +	struct smack_known **blob = smack_key(key);
>  	int rc;
>  
> -	if (key == NULL)
> -		return -EINVAL;
> -	/*
> -	 * If the key hasn't been initialized give it access so that
> -	 * it may do so.
> -	 */
> -	if (key->security == NULL)
> -		return 0;
>  	/*
>  	 * This should not occur
>  	 */
> @@ -4653,8 +4646,8 @@ static int smack_watch_key(struct key *key)
>  	ad.a.u.key_struct.key = key->serial;
>  	ad.a.u.key_struct.key_desc = key->description;
>  #endif
> -	rc = smk_access(tkp, key->security, MAY_READ, &ad);
> -	rc = smk_bu_note("key watch", tkp, key->security, MAY_READ, rc);
> +	rc = smk_access(tkp, *blob, MAY_READ, &ad);
> +	rc = smk_bu_note("key watch", tkp, *blob, MAY_READ, rc);
>  	return rc;
>  }
>  #endif /* CONFIG_KEY_NOTIFICATIONS */
