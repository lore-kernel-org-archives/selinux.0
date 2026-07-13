Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91E33A005
	for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977979; cv=none; b=FFqSp+DiREuhmmmoeu9I3HFGA5+It6SgRThBFEDnsRwfOtUFu4FQDYBIcyjEuSMTtSdxpE7gcm2XVsyOFqnTmb872QVVAi/HOcrdduQpwKHGlQ/TECYNROkX4KO0dQ+spMpXOq/HVQZ7XH7uw9BncAA2j0ld1dUHezYHd0DPnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977979; c=relaxed/simple;
	bh=bSHPUWMst9oeN1KLXSieCoIbfGActjrSPQnre2t0kwY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pqYqBXCx5G3qew0wr8tG6OzP6LGOzn/To/+94oZs0PWLIiogVBydcONFRvfwe5AVCrg4NI4w3pqrxVIL2TbbruMXE3dSB5UEHH9OeiIIyY7PEN3OOKcDsT9ZiyWnjskF0fvp/ZBU+uBFLuCY6h94Av9sLnkc2TyfSWRXHNsOMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IC3/TDWP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IC3/TDWP"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5cb052edso26229685a.2
        for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783977977; x=1784582777; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SyrDd1Epo+USefjom9SIfBpLQKzji25twyn58eJRLIo=;
        b=IC3/TDWPG3gQ8O6F26I+xtygR3eAD/Fwc27vDncgpmvDxl7RzxMxqi+v0oIgT/qNVK
         6INa6BILs6kfRa9LsPkCj4DDzHTVqMmFpP2ZyrRPvrj83Pda613ICQg812sBApJl7U7P
         sYx3HtTE/uXyFYxHDD1yKIH684UHbuzs99ulEWUMA1sqrhnnSk42ofRpyVTioKDIzXSP
         FLfABsgLDnI3sh1/gPXfbFzuSN/5BgH40MVKargkYtqUH9femUBVZk+zInd6VJ/zQ4gJ
         /vZdjm6BzhHyOYLiH6rzfRyOjTC/K/pKi/gpqQFSNtBek3HIUS0P5aOhiU8J4eHeFJMq
         olzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977977; x=1784582777;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyrDd1Epo+USefjom9SIfBpLQKzji25twyn58eJRLIo=;
        b=i27JWjoaak/WEHbPE5vwFxmAi0zJH2aKcN5W6WAXZ92bwd0RBXiMpuM1JPFYKns3yT
         lOHb8vmKiJZVJyTinsKpjGz0sFCs/tgIq2bu1t4wfNYfU3Z9GB2LH6nea1z+idHYudPm
         2jf8F2IyS44B8tS13KibTlhmORqH93jaWKL42xOJGuy49FqPMS1MV0tAl9NSDRFMLvEv
         HQYY8t0q6rDomkz3VXzlHRTgZ1DrgXypv6H3CdiurhjlubQJ2QuuJabCtyl17Uhr1Pmb
         JQZBRKJplI44uwTISAudBfJSkzHnzHSI+YYrqIEhuizRX55tgTD8H2bzvBr5KoaLeolO
         FF0g==
X-Gm-Message-State: AOJu0YxVb2MT9H+9PlQ8wOw/BLYwxoSuiI+BvKfZDf3iSTwwWmeekYDr
	DJmdLvir2z0Xm/seAx2gI1UF4jtvrGSQO9feo26EooQ7J00SUP/1dWdletI4EV4Tcjn54dyBTMF
	/bZFUeQ==
X-Gm-Gg: AfdE7cm0cgkUIrG9Gj4DtqT6ib5as4WpQqc3EPPImEZKYXeYWlJyURSlFSVbFrwxE5R
	LjsVnGSyMqujmnaOPnj5BDGtiFzj6CB8O0VJtZNy4lafm+973F2qTBT09LyZsqJHOIsWQJ0M0sR
	V8bsilxP8eYTIFj0ipqwsx6vQwP2BQ0bmsJtDJmFiFU7DyiwZ0RkVGuaJxJABrXylSQ8wgdHhGq
	pEVU7hmfny0nMxKkTx52W/kw1BCXhXl0EM77TdT5+6O6kFYWQtjSfD8FT8KFIv0jy/wXvS4l4XA
	+WyZn+VoiHvGtF3irTm35KklmiM9M1l/BNbebp2/MV7+TdkDSSiyxPjAeKrwP5oq6zddQfrAXhj
	RLbDHjR5zh68IjU7jhCePtCKLbmJ8CDc5M38lg33dgr0akWrZurTZTudj0rFu85BT1HpRJNRqqi
	m2vtamcA+oHZyiq1mWuIhDQsognOh/Ir0i21901gC2pqiX2AIw/HgfJtsp/g==
X-Received: by 2002:a05:620a:410f:b0:92b:6805:917e with SMTP id af79cd13be357-92ef2c13adcmr1130430485a.70.1783977976811;
        Mon, 13 Jul 2026 14:26:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b38dsm1316621685a.10.2026.07.13.14.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:26:16 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:26:15 -0400
Message-ID: <320c725b64257c13d8c3422fdb227046@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260713_1552/pstg-lib:20260713_1057/pstg-pwork:20260713_1552
From: Paul Moore <paul@paul-moore.com>
To: Yafang Shao <laoar.shao@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, kuba@kernel.org, kuniyu@google.com
Cc: selinux@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v3] selinux: suppress warning flood for retired DCCP  netlink messages
References: <20260709063128.75873-1-laoar.shao@gmail.com>
In-Reply-To: <20260709063128.75873-1-laoar.shao@gmail.com>

On Jul  9, 2026 Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> When deploying linux-6.18.y stable kernel to production servers, we
> observed kernel dmesg being flooded with SELinux warnings when running
> `ss -l`:
> 
>   SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
>     sclass=netlink_tcpdiag_socket pid=188945 comm=ss
> 
> The root cause is that DCCP support was retired in
> commit 2a63dd0edf38 ("net: Retire DCCP socket."). Consequently,
> DCCPDIAG_GETSOCK was removed from nlmsg_tcpdiag_perms. This causes
> nlmsg_perm() to return -EINVAL, triggering the SELinux warning for every
> `ss -l` invocation [0].
> 
> Use pr_warn_once() for the retired DCCPDIAG_GETSOCK to prevent message
> flooding.
> 
> Link: https://github.com/iproute2/iproute2/blob/main/misc/ss.c#L3901 [0]
> Fixes: 2a63dd0edf38 ("net: Retire DCCP socket.")
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> v2->v3: check also the sclass (sashiko-bot, Stephen)
> v1->v2: use pr_warn_once for the removed DCCPDIAG_GETSOCK (Paul)

Merged into selinux/dev, thanks!

--
paul-moore.com
