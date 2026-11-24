Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546431;
	b=2MNcO8RQvC9q23UDCEgTLq3nJJ3Df93rdwJoNXS0HSdeMcnKx1g2l43qFNGh5V88ItUW
	 /NTbJFCgIIHiJ84swYq0roCfgxX4vy/f1lRYqX8SpvG2gk1loHdo8zsZoULCBHT/7Fn0d
	 JEBNVmM+4ze2fEs3Qw4cv5oTEFOMcj1opHa1cNtOIXjS4BXZUZqn/TLwd5gUAYvI7Lj6H
	 A/V7jdGk6C/TOhYB2FkJtw5gA0KT0/ufMKlUv4H0H9v/txIyTT3mS3iiZMks/+2yTI0Eh
	 2TsoqAz3kgU4wCPxIVmfQ6mtnwKuOwBCFLeoSLXm22R+WWp28o5sYskR+r3PX0PZ+OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546431;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=;
	b=o77qSxPmqlLRM73MRI7KSFfE3lrOVRwPvlav1bV9QsAyToYlqtsRa1XC/Q1Hw8zsiF8+
	 a7zOYZFM95pO11QK7uiOIkIJrgW+OtoR+sTo4nMkGJ87ttOzq/keep8JBLJfdz3Mdzpom
	 D8mrVl+V90zm6PwHB8E/8MPf3XYfbgAkVj1fpWwZYEEawg1TkAdNNGyP975Dn+7wKcAOk
	 3qOeRggFAV17FCzSu1e6cJHlK3Qr08gSC+wEZccdAIOmpLYvDTVm3yFrgIXSKVigqI2MR
	 PuI1vGQHK2vBZPBdE43Tkaufp8kT3eyiUUp97GQVi0bp8tedv7CgmuXyS2uXcD5pgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b="fGXI/q/Y";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=huROl1+l;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E4606A339
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 18:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2E4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=fGXI/q/Y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=huROl1+l
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACF151400098
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 13:53:49 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 13:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795546424;
	 x=1795632824; bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=; b=
	fGXI/q/YJJHPRt+gPRHUOreFU8JCB/tfsdHtsBhf3X18rgt21ZbX+26No5IKTAyj
	AgCv1KdKfbX+I2Pn0iSzwyBZk/aTQmKDh3dYxkQQL/J3WM2z84vb6vO7x4DW8EGZ
	sS/Wz7MJP+BtoLKLQr++7Yye1Hsyu2ULf9M/Y/cIxiPBp83DUaCzMY/wHmvrh3HQ
	z0r0HeF0cnvWAkVDWpNLHekIzdnkWlD1MFqa+H5YTnUhFB6PA6aA1HC0BYrnek2G
	nxpAYgIinmvsD/fk1yNzG29c7eKf94wnqayGmqr0U9/LtCL0vr89WbcpVgVwSl8H
	4qYzW/d7q4DzqRxNHb/J/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795546424; x=
	1795632824; bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=; b=h
	uROl1+lk1kz0AnE8Bzw9moeUjMay7vJ5VuuqfueaPUl4m/AI84UJOgAisOoaqFn/
	yCBo+vSL4a5lisI4l5/Z7saj2VUfqomUlV+2KVyBVQmUCOe3jgRYI6qYr4Y8R8jl
	LJRf+DSl7GQbE5lW+g+FmCFL/3myijCtekiyTHImxIeNkj8OLVv/bdsJJh85iU2r
	kJL7uUdjE61XSRiNNPNUtgWPIDQt/CfqMCs9Y72c8jKv8clrGSuuWvjDW+ZxoYRm
	lUNq6g0Cq11j4GRLpY9a5Fciy4M+OD5s4ikjAzA6YUPUcczieH5Iq3irJUrRl+0o
	JIyX3BUC16aX/QKYzqm+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795546424; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNlbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:MLSiVm0glYBJ+1BZ3PCWNGOnT6LUK56X5OWFyMjJtNGRU24
	HfAUFqxkWi+gog14QdNUa50jjLZz7IoLXP5ZQgg/b1WPOzTc8ox7ysJnpdjZ7Cvx
	7lqUVGKtOEk22PXhAKKvGptDAa8J0VxTpWBU2yRClmKTc5bymg8BLmoBgLmKSEba
	kakPMBPGDk6qe/kE/3J9KDZnStEH+J1U3O3reTiBplyuq/srYhvxRooevZ869Zc6
	W+A//wL7yhXIf/lmUk5wI2vyJbQg6mEKd8sSEQSu5IZhlva1o+pp0k1X+nDzPtc3
	kkqJSbzx4UQu+HCbcFISh88f6kaW6pGtkIEMG/g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JE9Pf+dIuvBMDyw467eQ/Tr4tyY4SBvJ9vbnWlDmBbU=:iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=;
X-ME-Sender: <xms:NN0Fa5lZfMH0GpBjo4FIFqOt82WeXvEcO71uXdjmCA-N2thUNBatiw>
    <xme:NN0Fa_pvDD3LDB1hOkMvebnpeZhjQXIK0f9ynC0uvxvma-6WyPByvi9RrkBtXqg9y
    e_gVWNjeonSUqLlGosp6V90-QYv-zweVwSgzUpAtHBmrbfHPTWWgCM>
X-ME-Proxy-Cause: dmFkZTGa89Pla2pwx0UHvBE2KEVG1Wwjhw7C4B1uLpGYODU+3QVMsGx/6XmpkdoJQ4Wdng
    HJTQ5P6n+mDkd8Vd2SQqD6fTHTLkP7Wuqcj4e4FsRmjjuwJVAvdIAMxwY7PgDDXvm7pBQb
    V+0M7Ws/ERhpYm8SiiloduyrTQZspJvg6qB1K46OCCPXGc+eEW+Hddr+7C00h0r6ZEOFYl
    AEnzqIf48e5UMJEtOynuealgFc8qv49e4alT0/cDtM0pgI+fA63AVgOKJjxR0/XZ5jCWkf
    ckqnEAFz7mzjehKRip86Ki3aHb//QV7agR0ciNvsOQftXZwZGwrw1biaGXQM2h508lVilu
    dX1Rs8y5CwzC5NJ/X0naYSrSH/L5OxpOwwf5dMWqDQZcTdKTK/2PBgPmihT/fQy1TuHY6j
    6M64lDHfRNX+gNElC1DL1ODauxSmwduu+m13I/SkB7IYOCXjuB2jqg7U4sW3fILD4Xxxix
    /zzH26H2NJT/sw+csOTXwQOv0Ri5PI/gUUSUcz2DmXFV+dyZ2fG3dvBz4DLITo/r44riPy
    Wkq3g4kLNXDJfPLtgJRoV3tB0JzWzIZNdWxrQK2e5XaTmoTp8JRX1v76d2nM+qmgUUFhFc
    nvxsvy7PpPJFKIOSP8JO3v1DBFfZIowhnT7qZYA23jX7CcPrraaLXwRUkr+A
X-ME-Proxy: <xmx:Nt0Fa2g9uImOLqunkhPoWGl1ltxY8JqHe77aesgUgd62JLxGu-1Ofw>
    <xmx:Nt0Fa8Pc_Sbu-G_3abCwqPB7HUsT9kKEIkC0CdR_sFWt4SE3pgeVEw>
    <xmx:Nt0Faxe5nGuWdBNu6u7jyT24MgZMbK0VdAI8O7B5j3SfiCxKfSR2AQ>
    <xmx:Nt0Fa-y3V9ESX_COIXxaEavSOJ21EMmGaPaOG4nz8Qt9gqswRMc_CQ>
    <xmx:ON0Fa2FN0OUPrjWXja9RK6szCLu_hXTZd05XGyCHHDqNdf-Ig_ZmCfL3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4968232A0099; Tue, 24 Nov 2026 13:53:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Ai76fMdDSoMo
Date: Tue, 24 Nov 2026 19:53:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <ljs@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Juergen Gross" <jgross@suse.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Shrikanth Hegde" <sshegde@linux.ibm.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Ryan Chen" <ryan_chen@aspeedtech.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Abel Vesa" <abelvesa@kernel.org>,
 "Jens Wiklander" <jenswi@kernel.org>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Scott Branden" <scott.branden@broadcom.com>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org
Message-Id: <3208cde3-c5cf-4888-88f7-c77d7b0e5940@app.fastmail.com>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
Subject: Re: [PATCH v2 08/13] soc: aspeed: convert LPC and P2A control mmap hooks to
 mmap_prepare
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 24, 2026, at 15:02, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook for both
> the LPC control and P2A control drivers.
>
> Both remap a range of their reserved memory region, so use the PFN remap
> mmap action to do so, retaining the -EAGAIN error on failure via the action
> error override.
>
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
