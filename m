Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA523AF66F
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583105; cv=none; b=FwU7F/SIEclmveZKgyoX99g6xmciuylPpuwh9ymMu8oGj6Sj4UNa1YOvbbJXMTEFZiYGBPDTxeVMX0WUGXT8I4vRToN/kmDPbNx5gb15qbsH0NPxJ9E5uLRYX2MAzw2H89LunBvfSW7M4tiPhRwbJCL9N8wZb3AzSUKNTRqTYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583105; c=relaxed/simple;
	bh=j7r7FU7PUvwJX7ba+XZIA7lLvirV5wUQ1BpGam8tLG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dysmx+/iOWyvYA7OxN8LQg/LAOLBI6wcU5qznn6MhL8X2eHDmyeHVceZ32F3QIpxDHwMYlqmV/+2G+no21I/K6gdkux+3+oMB+CxyS1nGeGlrQousiYlDoLLPdIrH2C1uxzUlXwumfUXw7IKQoqLaY7I4udZN4j2Ea8k5IvqPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=cxWTfciq; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="cxWTfciq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HJNWEtNOQqxM4UEtYkIu8yOQr1o0vsCFtQG6Y4AthJQ=; b=cxWTfciqq1O8yJY/hK9tuOXVB/
	0975vLQFX5sZU2XPwW67Hzo+M1r0mcbDdUL8MZZT5H5cluRcg70lUKvLI54utWinFNiObB6q7DxN2
	NvDzfNwiZ7XBzN7S3OwjWxR1wNc/6V+MZM1J5g7K8HAxJH40jcSOqBLq9sv1ugcZxfdWwRcNf5L0Q
	zEaruLlmxPGoNR7XlF8FweHOU5a9wV6Qcw1maldUAOSGkpF0GL6Tr/Gi/gxxZijnov40P1OAjzrfc
	uFSDluSC7ZnxC99xCwh03jauTK+BWZie8v5ZaTFSV3w/1hQmVmwDLUg1YUT9BnP8P0VcD8NB9z+I0
	hNOs8ksw==;
Received: from 37-33-136-133.bb.dnainternet.fi ([37.33.136.133]:13482 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIYZ9-00000008qnB-0wxg;
	Fri, 01 May 2026 00:04:59 +0300
Date: Fri, 1 May 2026 00:04:56 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Subject: Re: [PATCH] selinux: tighten type and boolean validation
Message-ID: <afPD-AGMyVacgwDK@14-5A-FC-31-E8-67>
References: <20260430202033.1865-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430202033.1865-1-stephen.smalley.work@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Thu, Apr 30, 2026 at 04:20:32PM -0400, Stephen Smalley wrote:
> Tighten type and boolean validation during policy load
> to improve robustness in the face of ill-formed policies.
> 
> Some or all of this might be redundant with the patches
> previously posted in the series linked below:
> https://lore.kernel.org/all/20250511173055.406906-15-cgoettsche@seltendoof.de/
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/conditional.c |  7 +++++--
>  security/selinux/ss/policydb.c    | 23 +++++++++++++++++++----
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 64f1bbb8caa0..342153ecdcb3 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -357,12 +357,15 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
>  
>  static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
>  {
> -	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
> +	if (!expr->expr_type || expr->expr_type > COND_LAST) {

Is this correct? Previous check included the '< 0' case but your
new test omits it.

br,
KK
