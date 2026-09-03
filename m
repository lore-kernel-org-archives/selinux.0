Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A71F0E29
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402292; cv=none; b=aHrrKpw6LtUZL7YoWSAOr28fc4TA2PLsXd/3wconzkvs4NoDSoYMz0m9IJ6ILKdbtvDulFOJSCSRRryKZBEY4uVVxPAQUSTqxsy3JySBuKBsdn4Z4khCReJ8lq8nl6tfKN1rgnDgMM+NCIQSnXqZrQqCofSRSVhxoKZRKRBcroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402292; c=relaxed/simple;
	bh=6F03+qm0Bre/VKnLmITkhCR03ciDfFHEPe4T3bI/rIU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HomdUhwYn/2kaNlZ2vD8MtHpqkaSz9wwhzDIBCN20m2IDz8rPNKh8CV3EIIhV/KJCyxVHxp81HkCF2Pp65+qVi+cBlTbAnLgVysUXIpiZS+xTx+PUOlPHNn8Q+/M8EYhEpIpct+m2kQ5ogUUDQVnJHuGtuh/nTk09HbODhBmjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZwwlnofS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZwwlnofS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90cd0e6fd80so18098776d6.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788402285; x=1789007085; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxbHCn+xq0JEsuYb7obCbCtymJ2U1zlmOJGfFx1MyWs=;
        b=ZwwlnofSQfofkCxmGYsAlobwDi6Pxfluy578oMPrDxRdFlhmCm3PZ0zphrhcFtncy5
         VjqLHGSFGeGHDLfnAb+h5oAtX3K0Gx88bqiM78Ivtdsn3hPq0xwuvCwsD+viT26aRsYF
         DUyHRkvO4ipDZtQ+22eBmKq7Ps0aWG1XnTKspWB3bpLWpWpamr3kK5NEnKx4ZDflmd02
         YR57O7LBKAHPrbNFZLlRDvYmXYzyXEQGldyotIMa/Iax4krGpY5IAlaD8z0FHj09Swki
         l1neNnlSbY8Bp9BUjr5mHOSQ7Id8ucLKF2Ab15Na4nsGQAeV0iJ817oRy9eFmvAbQvJL
         UDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402285; x=1789007085;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxbHCn+xq0JEsuYb7obCbCtymJ2U1zlmOJGfFx1MyWs=;
        b=LS1wUWdzo7R89cz5EvDb1/kbgmcGHHlkHi487My1TgDhKm2h7AQZ2+66/6eRn0zeu/
         VSFY+tdXhIRGqX5wspV8kJ1fmb37DM/3pGSJwhpTLNOzyrkXcAoP6W47eMKEqcQidn3l
         BoDdkMXsw5nvdPBL0DGzH0IijJns8PvUPVYh0Mpbh5ZpMv4oBLQFTXGXlZsjei2dHbTc
         o9nlJH9Mhqzu5DBIGxbYmQPDND0WCCgEispDOCYRpsJIjRaOzeHBuIenUyk2xoo0am/f
         dbYUIMqP/d+VxYECG0RgCcYhVKAIMScenVSD0m4PO9zINUlCttD93AD1/SF2nIuigz9l
         s+8A==
X-Forwarded-Encrypted: i=1; AKwUvBxsSHKqTbFJSM6mrNwb8PJORmNC+7GHOTMfSYgjlPWBG0LjCYh3xiLkMk2S0pW4qhbROwCrOgZq@vger.kernel.org
X-Gm-Message-State: AFuF++mNwOAFjmRGB9T9+HoXseJAxzEWM2F5CK+MxEjU1KyTVS4aq7Mf
	8kN7EsbSDygE6JgsLdcBobKqv+riCcG8WVjuGJwo74QQVpwqjvJopbNqAi4e0PEw5g==
X-Gm-Gg: AYBFou3sjIIampBM4CBqK2gTRkjcPO94fe00pMo5DN7TltIPuiCjEimDfzllym5C5TI
	WIZXNHJepYVkWrz3IglUUJF7HXNwbwxfjWww0O7n6ZLtz1TxY/EusSUSxvDKP2ubgsFk+oNy3AG
	kcJnlqsVjPb1/taG4GezxQCfFPOoM+pHsfglkObCepZARbEXoT/Ww4HfMq0ZJnNsRZiPn6cIsK/
	kub4Ru1mtIwX/k6P17ULx/jKFL7K1deZEO8ntRoDpc9tTRsoEu55GFGlwx+5zwQGJMA0bNc9Y4Q
	nc2C4eTRZqeUWO/OLwrcCzKu63UH6u0BOYkqEn24yfeR8Z5aroUFVKc1NHh1Zs20P3KTT5525XB
	mbRdogNfQ70FAaRAyM4p/j4LRnwlA9k6/LzUwzZAAO8quDpAtfKTPXOhOhmSQDMlK/xZhaEYuqR
	tyR37KVXVgRdGV4epYBw3jTt8sWHivg4EtVFQLpUKmdwyZ48cDHwe82bX5cHDOSFktXfbWew9s9
	SFadRdSUpXNLG9UK1jXH89tw0R4Lh92OA==
X-Received: by 2002:a05:6214:21e6:b0:908:8f6e:52bd with SMTP id 6a1803df08f44-90ebabbeff6mr111657566d6.23.1788402280160;
        Wed, 02 Sep 2026 19:24:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ef0fbfbsm32797076d6.49.2026.09.02.19.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:24:39 -0700 (PDT)
Date: Wed, 02 Sep 2026 22:24:38 -0400
Message-ID: <5be8f666e660371dbc964c2348422a25@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260902_1617/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Tristan Madani <tristmd@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2] selinux: use socket SID for SCTP ASCONF permission  checks
References: <20260830201157.2084730-1-tristmd@gmail.com>
In-Reply-To: <20260830201157.2084730-1-tristmd@gmail.com>

On Aug 30, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> 
> __selinux_socket_bind() and selinux_socket_connect_helper() call
> sock_has_perm() which uses current_sid() as the AVC subject.  When
> selinux_sctp_bind_connect() is invoked from the ASCONF processing
> path (sctp_process_asconf), current refers to whichever task was
> interrupted, so the permission check evaluates an unrelated subject.
> 
> Fix by extracting the sock_has_perm() call out of
> __selinux_socket_bind() and selinux_socket_connect_helper() into
> their callers.  The process-context wrappers (selinux_socket_bind,
> selinux_socket_connect) call sock_has_perm() directly.
> 
> For selinux_sctp_bind_connect(), determine the caller SID based on
> the optname: SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF
> chunk parameter types only passed from the softirq processing path,
> so use the socket own SID (sksec->sid), consistent with other
> softirq-context hooks such as selinux_socket_sock_rcv_skb() and
> selinux_sctp_assoc_request().  All other optnames originate from
> process-context syscalls and use current_sid().
> 
> Factor out __sock_has_perm() with an explicit subject SID parameter
> so that sock_has_perm() remains unchanged for all other callers.
> 
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes in v2:
>   - Do not use sksec->sid unconditionally; determine the caller SID
>     based on the optname so that process-context callers (bind, connect,
>     connectx, sendmsg) still use current_sid()  [Paul Moore, Sashiko]
>   - Factor out __sock_has_perm() with an explicit SID parameter and keep
>     sock_has_perm() as a thin wrapper for all other callers
>   - Move the sock_has_perm() call out of __selinux_socket_bind() and
>     selinux_socket_connect_helper() into their respective callers
>     (selinux_socket_bind, selinux_socket_connect, selinux_sctp_bind_connect)
>  security/selinux/hooks.c | 47 ++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 12 deletions(-)

Hi Tristan, this looks much better thank you for putting together this
revised patch.  Unfortunately, while looking at it I did notice one thing
(below) which I think we need to change ...

> @@ -5731,13 +5737,25 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>  				     struct sockaddr *address,
>  				     int addrlen)
>  {
> +	struct sk_security_struct *sksec = selinux_sock(sk);
>  	int len, err = 0, walk_size = 0;
>  	void *addr_buf;
>  	struct sockaddr *addr;
> +	u32 caller_sid;
>  
>  	if (!selinux_policycap_extsockclass())
>  		return 0;
>  
> +	/* SCTP_PARAM_SET_PRIMARY and SCTP_PARAM_ADD_IP are ASCONF chunk
> +	 * parameter types passed from sctp_process_asconf() in softirq
> +	 * context where current is not meaningful. Use the socket own
> +	 * SID for permission checks in that case; all other optnames
> +	 * originate from process-context syscalls.
> +	 */
> +	caller_sid = (optname == SCTP_PARAM_SET_PRIMARY ||
> +		      optname == SCTP_PARAM_ADD_IP) ?
> +		     sksec->sid : current_sid();

This should have caught my eye in the previous iteration, I'm sorry about
that, but now that I'm looking at this it occurs to me that the sock's
label isn't the subject in the ASCONF case, it's the label of the remote
node (sksec->peer_sid).  After all, the ASCONF operation doesn't originate
with the local socket, as would be implied by sksec->sid, it comes from the
remote endpoint which is represented by sksec->peer_sid.

>  	/* Process one or more addresses that may be IPv4 or IPv6 */
>  	addr_buf = address;
>  
> @@ -5767,13 +5785,18 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>  		case SCTP_PRIMARY_ADDR:
>  		case SCTP_SET_PEER_PRIMARY_ADDR:
>  		case SCTP_SOCKOPT_BINDX_ADD:
> -			err = __selinux_socket_bind(sk, addr, len);
> +			err = __sock_has_perm(sk, caller_sid, SOCKET__BIND);
> +			if (!err)
> +				err = __selinux_socket_bind(sk, addr, len);
>  			break;
>  		/* Connect checks */
>  		case SCTP_SOCKOPT_CONNECTX:
>  		case SCTP_PARAM_SET_PRIMARY:
>  		case SCTP_PARAM_ADD_IP:
>  		case SCTP_SENDMSG_CONNECT:
> +			err = __sock_has_perm(sk, caller_sid, SOCKET__CONNECT);
> +			if (err)
> +				return err;
>  			err = selinux_socket_connect_helper(sk, addr, len);
>  			if (err)
>  				return err;
> -- 
> 2.47.3

--
paul-moore.com
