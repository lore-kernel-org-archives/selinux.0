Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505877;
	b=w/Y9J9D7r6D8S/qLRKEKQDNBJSRyMo8MnwVrYwMMgDgKrcridok69myt0UdclOexgWaF
	 41hxaB9v/KXm0z6S5/ismwSllPeGfa+GifJ2aIRDIhFWkW3uTOSEYPRAldzpkAy7EvADq
	 DsVR2Ej6INmG3l35KNhPWHO4ts/gktvIzVDwMIc4u4btVwqTzXMTC7TDaTVDTNnBazwKC
	 iVRQdKUjS659Yp/VXhDgaCu0FxASw876w5CNkkm4vJh+2XyBnseHiVesl74J+Azw0LpIb
	 09CZD9kVFAitaYXtJS257hPWmh0qcv/IhcMqu070QxzYJbKjj0Ii36hsDNcgrMLS8Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505877;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
	b=HdqZXvh33Z+kSI2AXS1UekUCaAvodfvhqMr2zc0FaNliLn4swcRhhxIELrDW7cLQ+PZY
	 xMrA+uXeYPGZoGPeZRL5Ydzpz8LlxhqWUGo2yqvJN2763l9E5BVKd6OqSB3ih3tjmOXVD
	 OWcGkYqCKIdrTgaaxpL9cpwDwMQxg8ZjofTqDQ4IyRPbRrp3Qx7jmISAJQ0mFB/qw65CA
	 pB51LthkQc3+r2qopJmWkteE0lBzPrOWajYb7TGlPqwO714H891PlIdKg7ghxXrVKrGd8
	 Y1RLc7C+LBVDnOHjbsNW0I91PkGRMrT4uKP+oF0LEc0A4XEJvJvawjFvXpv3OfzIqyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1+Iax5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC0606A680
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9AC0606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jB2OhFnb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1+Iax5U
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kDOW197024
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=; b=jB2OhFnb5kcQJfBh
	9PooZCIYHGNUVjDcGwumXONQT2rphRiM+HKb+Z5rBcfoZ9URBb6HmUCKyU398p1z
	0DE3n1unAJCPGSKA9qHqDKxoWrwnFiNfWRaB4F0mZuQ+gIyw7qVkk0rFFWIT+hr0
	xlGvD+nbKD4m1GM6eRm0zn5N+zABS6NWAAQ4zM+xLUUTfkXPLcKrmGNQSuaj6NVk
	LSMFCUkYtOrVzKgsE9JjRJp/p/+NgBxqv/l5UGfpSyCfsEnsySH6HhHWtAFvnFTH
	QiJHfUK8nig+0y+RvbrdRu8nHxWlPz45JWmVSfVxj87VvZ9rM/3qatNGi8g/YvkN
	LVZ85g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukradku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 07:37:56 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67be4f2f42eso7121961d50.0
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 23:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505875; cv=none;
        d=google.com; s=arc-20260327;
        b=sT00v7cryu9+XjlweBP5gW9YJEbFhvZUhwk8I3sZ/dzEF9Bom4rfwvp3QFY/uNNzFI
         eHqsXKh8qB6TfRLz/pg7GT4ukx0n8U4ucFC7vful8/nWu07mNLly5GAML0byOPNElfpM
         LsPqtjsI7Aw35ekQzR5CQPlrJAoUjpxDD1c8pVUf9499z4zav60ePzoCxZko5Ns5yvPA
         TNCRMgRsmLfYS7nYseofXugugZNSSSqjyrACPQoHhhHLEa1WLRznvolWXdlnbIYZbeYk
         WTyZS3ftHuCqNexiH86An60P8P/BusvSLH/6kJCCAfuNU5HjGPpb83MHE/PEryb7EIu/
         iDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        fh=ysjPJNW78l0s8ezl0oRUkgzH34pllOu9ykA+uElSY7M=;
        b=WmDAmmhSNc/pZzEsaUJPBQzRCMrupF3DCWG9e1qh+zuInO0hTf32X5pwuS5E9ZH7tr
         t5V60N0iTqiS0WkxpnX8ECfk5XA7ZHffqR7pfAqHvIRVAgjtw+SJp0THn1oG5CmnwWix
         Y3F9nQeDPS97/1iJPFMzS7lL2FNbWJP/g31gT7q3uVigh3hYKohhlRfwKsyjvQdXbN4P
         Qfl+pg0RK7YMFCAYcc7AmG3AITiimCw5cNSfgZ3W4LJwkp0Exw9+pWM8VfY0VdIwex1o
         MF+8yO8WT19gr7k/0JfdWao6XX3LCCqszzuV6lqOwMG+acIXlwHw5ZLrSLXYZYe/efEz
         b9Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795505875; x=1796110675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=S1+Iax5UjwdrBfjmC61+6GR7Ef9vLvndZMhbV6RF5f5jjGfM0fKOFIGSb9cZxbE499
         ufQ0Iw9iW/MkroytuRNTzxKljpJElsFF8w9uRLGP7Avq+RZTb57Ul1XAJRZ5qQA1kqxg
         7jbG878tFdG6DzFw+/37L1jhd6FV1aCc7/cXrp+cfOfsQhmbgR+jpkWB2+0CyWhWN8/h
         yrF5TtN9QZy1tEKAfvOEpPuv5AnxPa6u6OCgoeLhGxjDwK43OfnV/PUQdhSEXPtDxnYS
         FFlkC6lp8vy68Kr1OCdhQERS5xVbG1XGyggIdSHRH/KZmZy1PSroQztV131DD4SIsduA
         xQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505875; x=1796110675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLDBCseQttjsh+YgjaRZ95arQzmquJXtwPce4pg+uuw=;
        b=SyU9/Pb9Us2bf1/1OAsHWLlJa8bqvSj3jtRrfAcbjMsofoNj2WqbWG/V22R8RNS7F/
         xvnKKhfM4Q0V89ZnU4A/YCMqXOiQtq1p61jR82+mPYOBq4FfTcQ6Mx1lsL4Zw6Nx/XiM
         W2B8AMfGns2lWS3Mv319AXKOZr76Uwzy6ElD57gOTW7lTlQSP0EfIvDYZjbNtWVQA/PY
         rost06//DIciBUcxcDt3kqxt+V4IYJsBvkiV6DpDqqAH/6oxrYJegOwP+pzpCaAXSLcH
         XoPrSW+AQIWANbkCFZ2O4Q82CGquMN5kAPoERgeXAO/E5R0T0c9nBqOxqMJZ+beFty3n
         Fw+g==
X-Forwarded-Encrypted: i=1; AL+hErFEzla2X7h0zqRP0nxprW+8lHOaOh8te9OxN4K1GUlmYX68V3ihp5RsgVOwJj3kVUZg2rbqKsks@vger.kernel.org
X-Gm-Message-State: APuU4Z/c214RrQukz6cENjsbZbLZogIYl6INIolx+5N4SeHBdUECdJJ+
	gRF0jPkOpdPf2sdFoM9eQnB32c+J/casyPc6oTCGJS6YVeeHyJwihuwTA+EtTwyNkxdbS6JVKHZ
	ag380gS2urUtlIKODHAj4W4GYp1SeplxxGyb3p+pH05ZK4lr6nTJF0P/rrbdQ6q0/vQ0qakYK/t
	Rtm1kQ/3Zl32Dor44TkqBmNxanu19PbaMpenA=
X-Gm-Gg: AZFdTZfDkaPPwgnVuLX2SOGRlHORMTCwS2XRNen1gN+of5BY1WMdag0ibx+y/Zm8P6i
	Z+mIf92xVQYH38C8N0Z2qSgw7OTAhy83aqhFFO8tHXiaZyKe0m5a6TX5AhZWuvu4txmfAyqb/1O
	VwomK9NDbsgziRpnakXt5IhB9SiJfsaE2EByvIg06+UjKyAva7F3IJckK8Ba/brgl4B4i58ca6L
	NoVyQ7LxtNd32wUkZ7WVFFhaMfKYYHO2Wj5EaOv
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id 956f58d0204a3-67df447c2b9mr2926891d50.75.1795505874977;
        Mon, 23 Nov 2026 23:37:54 -0800 (PST)
X-Received: by 2002:a05:690e:450d:10b0:677:cbfc:be28 with SMTP id
 956f58d0204a3-67df447c2b9mr2926857d50.75.1795505874551; Mon, 23 Nov 2026
 23:37:54 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:37:43 +0100
X-Gm-Features: Aa3M54q5vxZ2pH5GHxV6_gcu1Tnc83EBXhtYw1pJ9H77Fl7U3CQoqAKpEumRrbk
Message-ID: <CAGgiveX=Z5gS7iJWBanyysVUStDRbgTnVktQwJySXw_-xL+sUA@mail.gmail.com>
Subject: Re: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX11HtciWeld+E
 gcHO+4kD2ggqX0oJaJbx+oVSuZfv4aEEsBZFxmdDYrDjXAbvEHPEQ5IBgqMEc9pJbc25kQu9CtM
 yI9JrUa774rHDuyNMqvsrpAwR0WqldI=
X-Proofpoint-ORIG-GUID: uVVUMBzdF9bY7vJ3noaJiwwumkcSr1XD
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b053ed4 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=97S62Xg_vF6B0O42EdoA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX2rlimM91D7dR
 hcm7fAib8yq7TZQmGxiWA/nNr5eTjZdhxqx28kNSPiO4P5ECdOGnE9T79I8Lgf/DvzDHXSro71O
 xFGYbfp75ekXa8EM/znLYt2zEvwRqwfyohc97V/1Qr/mztw/xib5RYl2bF2+0neTeEq6JnFqtQ7
 f3uNC9/NeaM/WvU9Nc9pVk2yz9Y/BisZS9k7emdoiIhevXJ69MYPz37bVgJn3TlykgD8eHJN5EN
 8Q7c1MXSYs94vXImEh8h/2TP3ZK7xfWs9PEEkDH94gryVg8Ezogs5hPl00d90UwGMCJh0+5blxt
 L7YQ3tFiDeGICoP5uha+X/TQJHG0JqchvDddgpxXz0Z0kekveRF+qkowlFpYCy3xUycrxcSxqe1
 tVCVtFVNVRhmhwY3BDzfF78G2mEzc+IjQODWvxwmMXlSdFQB+VMtM93m8STbKUFYBjRcdyE+P7T
 lojGQ+zOp6ItRyvn7CA==
X-Proofpoint-GUID: uVVUMBzdF9bY7vJ3noaJiwwumkcSr1XD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240030

On Thu, Nov 5, 2026 at 10:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook, using th=
e
> PFN remap mmap action to map the shared memory.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  drivers/tee/tee_shm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1e089e..8fcbf0232aeb 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, =
struct file *filp)
>         return 0;
>  }
>
> -static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vm=
a)
> +static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       struct tee_shm *shm =3D filp->private_data;
> -       size_t size =3D vma->vm_end - vma->vm_start;
> +       struct tee_shm *shm =3D desc->file->private_data;
>
>         /* Refuse sharing shared memory provided by application */
>         if (shm->flags & TEE_SHM_USER_MAPPED)
> @@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, stru=
ct vm_area_struct *vma)
>                 return -EINVAL;
>
>         /* check for overflowing the buffer's size */
> -       if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
> +       if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
>                 return -EINVAL;
>
> -       return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHI=
FT,
> -                              size, vma->vm_page_prot);
> +       mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
> +
> +       return 0;
>  }
>
>  static const struct file_operations tee_shm_fops =3D {
>         .owner =3D THIS_MODULE,
>         .release =3D tee_shm_fop_release,
> -       .mmap =3D tee_shm_fop_mmap,
> +       .mmap_prepare =3D tee_shm_fop_mmap_prepare,
>  };
>
>  /**
>
> --
> 2.56.0
>
