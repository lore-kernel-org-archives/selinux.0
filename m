Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E722F83CC
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483573; cv=none; b=YnboL9rvRf7gC5dj+n9q8TE6HAS+Derl+Lh2Mn3EWsMoXHXRl44qK+TKtYd2vF/3lHsyl+gzb9Zkq+HQ4vZ+c29D3NddPlts/OwyGshK+NayFeennRYTZ00lgjVLkHaB2lnRFXssbAMxBjJ8ovLqMSVyD8zUax6Zis2cULD14hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483573; c=relaxed/simple;
	bh=uSN4FXEH/3MuffBTCj2UYI2kGTHCWhQlnhaFfdx8IkU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kKIKuGnTKJAArCUBeeTLhZGMkeCUiQ+l5y2pfcd72p05BjiDDSfHWWuwdTAe8D30ELPvxLUJZerKkNwu5/Sk2pl04A4wtUOSm0+q+lJVRLgRn64WsY5Kjnqr3AVSsuUAbNsydyrahEQDQxI4ju6kbEow1UwR9N2DNYi7hdRF7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J+cgwIPm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J+cgwIPm"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7960d69f14bso46052426d6.2
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483571; x=1761088371; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWvPskZ+a5ABD4yOHJLWshlzE1qsBPvU8Eyo2RkT7/U=;
        b=J+cgwIPmIeXNQNd2aqaNp4EwgZMRN0nTy1A1qxO+DCYGlQ+5TmPjYWZay/7B+UJxmY
         hRCOploooNk+X6W9qkzr56EIjWijWciQVXzdyaTmFV27azILROFQedAiQTog55nT3CZn
         GNZCP4LsHSEf+XssbeNDWjs81InSeC4mijblXPqyZEpNYcRop2sOEE5Vi8YfqVUdyLj5
         a2nXYg1Ru8L5+kPQZk++Rs2Znl8rrDlzPNYE3yNS34UAqDvWnyj9otwMr8q4FoWsNMle
         2KzcykpUaIsCfnD8QLOwqTQA/ZNqDtXvdKSBgCq27SBy2FuvRXm0IvHd2ABTl6lslHLZ
         Yn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483571; x=1761088371;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWvPskZ+a5ABD4yOHJLWshlzE1qsBPvU8Eyo2RkT7/U=;
        b=tSfA8moRyFBhr6M3Fd4hPBxwsuOcYzIocsc2IFaZR9/YyeOOM7UU2dASroti6aHhok
         abVrQmw8InnR51Lka10w8eHcGw9ZDCIRAhPiJLoeDsspwnqxbK6iEp/CqaB+xb6udMC3
         sO0yXLTeNa+kCrxZ/jNb1TltWAQLqc9sKctjTgtsDxsj8bhUWB8dRWuZCJgwqiPakRrg
         lYfbuH8aDgX2U3elBXB33+iV/xZLrTO7ohuzXcNjWvA5SAPMPG7yAmJ7B7Pe5zhD35gC
         siDerPfrdF6v+ShtD6sfjzcolX2/2ndyS9Brg5Oj4wI/yyFx5EH66dobj/XpA/O2QV4m
         AHhg==
X-Forwarded-Encrypted: i=1; AJvYcCXYJNYbHhvE8YW4sjJArZ+dmzZHgUI6sYRYGYtj2AVEbd1jPQt0Cp5GucbQbC7nhnRGdkLzLK2X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3n8cqoWbhOH6Mu+Tdk2FCb7i4MtHhJ0bVtIvLMod8quL3u+cj
	RvD91KLl015g6O2tWLw1Mo6T7jp9ALmJcBEsPoMd7joQqme4I+sMNVLnDnuhJsv3cqb35lwBMR6
	nRO88SQ==
X-Gm-Gg: ASbGnctjxmeDR2rKiO7WwyDIg2b1/u11lH8g1r1qFZpnuUNJ6gYWcUahoITBsKEgo0/
	PD96VxHGCXHJcF+vBkXW6mbu8L4aQDg2RnWEgkgNcpj6QfzjGW5GnVVsNft79B5vRpVPdgsZZJN
	ASUMedZhUZ7iF8/Re9pgg5LoQivNXykp+Lxjs0PoCu+DoXskthEegdlyniTEqPwaHsW+dBrHIpK
	ErpS+cAHn3yaxtGh0CRR8EXjF5RN6JiK/1oI17TghQdf00uu60CeYzbpLqXZxwbOC42cOYzHKae
	2HsYhcSqXUE484XKxj7hu4T5Hn56u45eidKhgvXwq/hqxT+7P6+KIT5mGktYRQr1YDV4VrNpHWa
	Xibb6KGO12SlRmmPrbvpVpMtY5XLa90QNOcjuXzQ8pf1WRO/j2+e/juoQd/F1ZpkMc3yM9HjL1U
	UUs4d0AHQirycOMq3ixHpeIg==
X-Google-Smtp-Source: AGHT+IHCPlsD9zAsKBhE3Wi8fF8+vdSGhRlXGGKb3DnpK8wXKCrf1dLszTeWmxiFrIx4cZK1oq7OBA==
X-Received: by 2002:a05:622a:4814:b0:4b7:964d:a473 with SMTP id d75a77b69052e-4e6ead5803bmr401868921cf.52.1760483571078;
        Tue, 14 Oct 2025 16:12:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c0120ce79sm7028506d6.10.2025.10.14.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:49 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:48 -0400
Message-ID: <7cccbd87d3ca12f377fca6cbc564eb69@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 6/15] LSM: Exclusive secmark usage
References: <20250621171851.5869-7-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-7-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules
> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and
> AppArmor.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/lsm_init.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com
