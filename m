Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920343;
	b=Dp2blVIZFI23IHGCmp0D5mufp1kgzSG9nMSGsYpnfEG70H8EmGH051M0vl88jAUnRvKH
	 LzBqjACmlG42zAHpRyoSNr4uQ8w42a90rs2or6LgapY3KjLT22zgaHcSVhNeZ7pVNL8k2
	 9Q7Qv9TOKy/1pjapwMSwEkkMCrotld0ePnX1E76a1FKrXfjXu+6EeWO5vD7WtAE7q2S2i
	 63swBTsGG1VnQMy5cMovDEr7j4g1tubBrpGTKWkXNUr3nWJERdcdTqDQtfTKAcX/I+jOW
	 MHhcl5z1l/SYm2rVTUUsK7sxHCpJQvJoqoPZW98Ksq9dB72jth5kMzAC7R/Pc3N8Q+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	b=tzP67EyIsFXhFe8Pp2YHeDlkBFylrIwahPz9tkE5+3QY0Pwg/SHUX9JAMd7BBL0kPb6v
	 ZggNvSoXSlN5GKMIvbbgjVEaMyF5HBOj6hGLG47tV9UjdxNYqMYZnIJ02C6gnk1/Ji5bY
	 k6cdKwzsictut/zknLnuZWIAAD/IvLL7YN71EjYbhTb/JEQhK/gfBTUR/o4K3fEspPgK0
	 1Q0YXuHblbiW1v637qV/C9yYJKHObwEWiILaS2JCSHcOUem2jXO9BqwNVAekmzUDVZiJe
	 UAxMg42dH6a6o67m3hyb+gGFGrhx4DE/FFQQKm2IUc7rUox3mcOUQ2ve1qX0G/ip8/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8386606A31B
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 23:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8386606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so21412a12.0
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 15:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2AbV5vfKvIwXgZgJlCSlxLq1FwIiAHYmDmmI/xcc3k65DRm8ueJNjcsMogw3tXWta
         OqTVVRrAs4q/yNzvk7qUD4dMLRoP2K0UMynUnWABYd70LlszdrU7YuTaT8BF3eZu0xXa
         PO7mnPILJahQyh1xYo433BWfo+BuD1FpJae2wLFUv36CuTUELFDpwbFl+f4JwFOROmt2
         IQ29jpRFpa2vg96ajVciZG6m7Z8AsLxt07HFKrJzsgXz29JCDB94QeaR2r8ERatdKcos
         ZMai++b61O5b0fJtRjNYmPdUYGI7Qm+cWpSiuwvwj67+vfJWZmZfsUEwXVtFbkO6k8Hr
         kilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=dm4ZZ1+DtIYCy+WcOMSmROEdBToIQDNPOlpRLLSVMBY=;
        b=b5p82WPxcwmjSnmj1AAqhYRYsJw3aogZV35Is+L8oxDAhTO0Upge+vlfuCuMEFsevA
         U3HTqwJcV3SUz779FiX41TsEUTG8eko12Kp27HziTKrCFVa8Z25FkIkIlxn1gWa5A4vG
         YhedvYqJfo6KnTuZv1AZOCP9a83tsrfomcy4m3JCdsNCYcsrZS62RGJbHAKvAMKo7nFV
         XimGCgFlKP/kj44319kfYgyiIj39VO/5RNNzzhcGbtPDE5a7dTbHv945n162fzAJqJTp
         2z6QM0zTNNdbDG0dUg4Wx9azJ7dnGVF6GfZ6veJfWBIKl8fMHOWc8f29ngHwQ9mRsF1v
         zfNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=ePSbskAwea0d9B6NpBdXuFYsWvLDCToKGcxFrN9C/fQLJKxAOsbctr8qBrrZUslJXJ
         9CLcMCSIkKD7ZW5JSZB/FlpnXL7wVvbFlxAaV35NsJbH9Ct+Vj1AE0PSCxPZMXuxmspf
         S8DzKorUUKYgddL+oYJfDiSPHAXfQ8DdRb1gIJCpXWqjafW5TeuSLk2tBK8Xu5u2Toof
         wmqoUSerZIxxVmbDxgyvtDxt3hKRgQ27SfmnssLj7BFyrZUgbmKG7qeTDPokQzsw8F3e
         sMOi8Cm8Fp7SxcfGGOrWu3vbz980QOeeJXGWbY7zrPoyxcb1MpuMc94aw2AmHxsi0GQi
         jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=E9i2+6jdZ48KcY4lWxx4Hmqmk2ktZ3cP9QWx4wtu9hwUguJhqrUaCKG9ix6SThMSd7
         WgR9CMSxe2tABCnyTPt6Pcefx9Q2Ea2TgMojtTNqxto468XQndQCKu0VQ/YdCvQnhkmc
         fG+HXNk1LVUrvuha4HMmmAnJFxdxkuVyoSNueu3rmxaJf63mXmuXCpLrmiipTg94kWzg
         TDDVZZKaVO5GaspYMgy4tlggo9h1LqiKQHVfygzWYMO0RgAAZaQ3yiN3WnMbeHyxhptQ
         lB5J0KgSo/Ng/eiyOafYq3zIV/kwN1TSSkmv37TgGpbUz+5zOtlsC1Zw7jj4yyozs4JF
         x2yQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF1M+OkrCHNgoTLBT0G/cCWSxikdVetLxoyl3FgObFZsNzGE4VWvozn/qR+XeyxSpuEmOViJGO@vger.kernel.org
X-Gm-Message-State: APuU4Z/AVxQd6F0seHWTzJXd/yo1ZBlX8o+4MLzDgmzM6QtagpkBHxVD
	M1xgyD/TLsDAtcrnzQwYYcdxPo+y8XdQWUAsT1VF1hIuTeo0gJqJTQmfIKDqm3JLQbavOON3cUb
	ekktdvL5PHMkuAbXJiYtrMa4MtzqyxXB+HI/QA9rF
X-Gm-Gg: AYBFou2i942C/e4Tz1XOQC7I9BjnSpbLIByRN3kZN1XaOOi3iUb4hF+1dRrUYep4M5F
	17Oe6mkXkVx+DnAXdbK2v5ZYDRXbCfGsOra7zmBAZ7nwMcJilSQw3ysjKv4bdL+Qt2WPqSkjri1
	NMWY2ICXkbWqY1uh6Pl51L8J/mzXd7sHpoQQFEroJG5AAHw7oAC1hqN812rNJQ+1nSCDZY9iYIm
	7VbgAuBc/RcaMPvhUqLsZXjwi4liS343Mhne+ZxQnaSWhJ92XQO8PZ6ttXLnyJlr0UV9pgcwRJF
	HroS9fNGMUtmmMhb+nqxYPJ/t1HxWBxrwzI+31yJAJhCUCimUnXc2gOdfivetTznAnN5HXS9yYa
	6odykCxZJUasBlh1zVl+KvBpUO6ks5KgIDXWUUSF1+VASIwsV6ss2dnVVSKRFiOrhUQYi
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com
