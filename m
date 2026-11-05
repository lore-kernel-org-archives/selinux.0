Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920457;
	b=bqx21jFHkuXW1zSUtprgnlA71X68jOV0hbMSTz9EdYiJC01ZCq+2vPOrsfVWwYOztIm7
	 T/6wOJR4kWfPSoXPp+7s3MnIm+hEqVecqaZ7fpumpSZOSjBfPCx5dGVIF2wgIhfX1Roeo
	 icywx4/Y+zH1jBwN19tF25b9F97FPcQSyWtA4BPb2H9noyteLQAdXx78PLl831k40eMg3
	 aebX7BYvBuwjiI0ldUn1ul7edVGFEx10icwOeP3QUcDqFP+F1flZneKds736vigVM19YT
	 FXtS2hphsmWHnVDeDNzs6FFtOx1LR19A+k/lBYZLQc3cXYyQkOVD2psRPvQ/0Shy5Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	b=26/Oc7sz9l2wNS4BTJWSABGZKc8FLKQAc2QwwDwCewxuCgEQDWxdFzq4HQLhrPAUprag
	 vjnr4m02o2ryU6K4EHil3ght4fWFJvepVg1qe1YOFH6KwGxRAeMGBAAIa8+y6IBPrMDh2
	 /v/ESqoIZqOCDt5IPlpEp9AQpPvq3kXiytoSsm5+D50EyCm81M+zs0Um0ntTrvJmYG7df
	 UPdJTUIaSmzIc3jr/MBjmnQdTFxk6IgFCj9gn4zJthNdWtYFe5vVv7zxpiECwJsAH9cNv
	 h2YrfTtfrAmL/CW0aFz0/M/5RnjHx3PDmikAnJgobJCPcJpy9gsOcEjnoYq1ms6XFTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E73606A32D
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E73606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso42563a91.2
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 15:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=dZBDTNPAA2dvVwKEeSGIIHk1ddYZPnBGcUlzRYLa85BmgbZdGv2FwzDR79MhJ2LoUT
         tr+bCWfQil8dUtTKEaC2d40ZXww9mqL0a243MGd4i9ZdvQmsfygyhjgGvqBUva2tzNyL
         S3Flpm6TnvfPaHqsbvddTSxulaac5H8ug8BqFa15afwflvwPa2lMQwEsgOtY1/B7OMDj
         kjgtEpZnqb+I1qcGA1PF9+/uRPxnzc6bVj1CdxSWVyJsB7HVx8v1+KeAkMPZbKnPa7cw
         ImiGb129pxQuUx6FgWONlJ9pVophgiPEh2Ot9hGhSYE3kWTOcaKso96b2ogzPgHNo06N
         LewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=NJrpX8QVttR/AkjqYmCNCUkfSl9N99DySM/TbMsqgYA=;
        b=WN/67FuwS+eLKUVg9Ly5L6KXmU4TWGofgcr0D0xCnUyCYkjCXHL3AwznIm8CXZx+Jz
         p5zI8Z+w1a813m3g6OmHNvi/0aT1Ml9JjJB45H0+OZG5rjvBSlSiDIHS9wjZf1QjNqqI
         H4kIHIWN+HmXrKPDAv3d9Kj5vtFCLhYKFK/hGrreXj3xLF8Ypc4Xk+jYVtelanDES4Db
         zhHcI1iUkjJXYqr6jK/jXbvGgv+rwfe55ZQwFyPmfMU8+jTgWcavosbu4c6FS93azc5r
         D2Jh30rJ6JoUF96vs0G+j0L2PDwolR3WM/8wqy7folHoFL1UZ4Jix+a3ZRL7VJipsXJG
         9F4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=IU6i1Fwv/0w/cks1e2nfs6t6sk022zL/8GvQwys2lPo33xKyfU4+rlcYd/DQAZEHG/
         pOKIazGTVuNB5nr366kMh62Z8mKuK+0wykvjpk6nMnF62dQEPqXhVYv3AiAUQh2yheQg
         Wv57SCnVaPWXfP0Spf5ZrgQ+6Qros/0dGKzT5Ct8KPvTnGxmERS9srU07KlGSKT3u7rc
         WSDGWK1HJ7ZHGpFoQ0kLcdKEj3NsCe6oNqECA6Dmye2YgKsYtmlI/U8g/CwAwltsgKHy
         7lk6f9CpVk0uzXD9qAsG8lDByv90XfisBUHNR3hzhw22DDDhGO8biMGoTBxSg1pPVUNx
         pPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=FovBfQniFvxaUv0AyZN+9yJVmIR31h1s/jMFGAiquVmF40sVPkNhgOwOKCAO3sIe0a
         QBPUkvbgsXqYWCimDo32FIRJ8lAA8NRPDB5hoXDk3Gl9i+4u1PFdrmmFJLEDxFXMHWn1
         fdRmUVYb+wFkPiH8z1WXMZ0UucUDhkngbuOhUf3ECUh/veCwOgzZkdq7ZC/fzUI+2CEg
         wQCoiRctFA7r9Gw3TNg6owG4QsEYQ8kZ96Fi+1ibjrH/CnruSw0F5zOICyErdahsnITr
         70ULz+oqLMxC8cO18+24s9Etnh18naFd8bVDaVgM4IX97V85kqA88EgUcTAW5k0aYe4X
         rVjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxguDv56KXW3T5HkiDv82YDAFNUYfR5is1GniMve+ismjK1Y/i/i2j2XIlTo0k0cevQ3XDnlHNy@vger.kernel.org
X-Gm-Message-State: APuU4Z8KNW+FXLABqOrdgqNy+bXz+o37LUQvn7iZbTM7NvX+GMRgxVc8
	J7GnOpTTCtewbfFZK1jMS0nbkr89g3zNY/J9VbAaTyz0W+VdV7Yr7Pax4byIGs5ikGSrMUBJtDZ
	z+3048yEDwMfMXYZRUjE/Z5MEViPtyNdpFfD0CKHC
X-Gm-Gg: AYBFou1k29HaYC1i9K4Mp0OsayaV38A7e98GPhW+YPqA5Bc9dx8F3HtzdAP1ZZHVsf6
	vzx8ZEBdCcEbkus+Lr4QuRkc0S42qBLrq9lwnHelBP+8OtXLK8nDrj5aEaek89zAWF0F5wJ5Wqx
	2PgjpFDT+VapmyFqVlx0un1c+qlojXZVmoXq8U5t9ilQON6ABxFkJk5snXdAdZsuKoeYHYu1C84
	GbgRPk3TCt/eQD9G/tE7o6KEkk2qMIT3OyI5hjWGneCBbyScubhZziQPYjxUCaqdISXhbdt79DW
	FUhNKkJchN9jRs9OKB5cuFiMDCD6bWXAubLdBewXXZGj+cH4JaC9muabJBe0UqK2tA6kKXV/f96
	HKg9vNuYFMZRPna85ngh5gAZDbcY+vpGhXCj1GXexehnNzXWWJ3gx9gHvA+nu7uLk4FOj
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
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

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
