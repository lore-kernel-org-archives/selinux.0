Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C9358D04
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871510; cv=pass; b=eOuWOXGR8tZ7bbgNl1AJBjcNvPjfpeYW/EOpysHB7fyr3lmpnE6ZlB7L3Av0C/l7mUd/tZp/Nub4LFAEjPs+hirx9PfE1E4Z91r783oF3GM+jS8x4896ZUMKB8CYy2VoSmt6NGt7eWTh9IM13bYH/QmNmvAMwZloJqElhrAMHls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871510; c=relaxed/simple;
	bh=XoPjc3FsSnhAH36Ksfm3BAJI9jxzPUWZyt5vdnTXd18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDEkN+2B6dzG9U3LMQL5eFqzgoaak6JMlG5SX4jzCMjX5AU6cYBY3vRW6+2btWeLQE9Zu7ypZKwBLn2s2qhz0JRH3sBlhyY4OLV8cSfDoE9R1G+cnpx8/XD1V897OhNPosM5S+l67IQBwH4lB+5vq4p4ZxGbnVnDloQSWRlqP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvHzB4qP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ik1dSwSL; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvHzB4qP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ik1dSwSL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VDn9L11489330
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=; b=OvHzB4qP/0jw0pjw
	qHWpKU9MTVgAy76IZFOwvomNtT5ojMnLFjv9vAMABxUYDDdhCdM/mdh/1U5ckbR1
	OHXys8Fv+a3PchmsefgHP4EyfqjCbDSoUrH0Z9vDG2TJsjY7dmvbMOIBYgB07cQC
	ID8YMzju3Vh/8MpgAyNwHRivnN+v5eYDr5CIhLCfTj2mGS4XRYyxzAUFh9cINBG3
	4lbqX8kwiPdpC2X1VC+X57Yc4hGnLxfwp4WoeziP1V7KW8OWpTYzBS2/84Kelkij
	c7Hl5zdRcBv8uYhTITx455LsNqpLBdwF+tnJlsXg2fGzqhfqDBQ8OAyarNxVhK3m
	+a43bA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awnrx4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 14:58:27 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-649b6352303so426913d50.2
        for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 06:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769871507; cv=none;
        d=google.com; s=arc-20240605;
        b=bFrbArP3dFQJPKfKtFj8IUg82vxhlJgWk7sJSAzy9FX0rP/PrYbmanCQhEXx1EFuZO
         9c0atBGZKQ1hT4B5hEN9bQzAi2qk/QfWlMQf7uidQ8kD3w+ZYB6MFX68KO+qtPSYm72j
         eD2Bs+JwzW4Ib7+rBCvXV76tyDP1F0PrOjPQ6m/Qicl8L/HFWtg4UFP1NX0a5gzbHCS2
         /c6xxv9V3UhKbd8UAX3yHVyd66G2yFmDQccm/xDk0wdzMHKbgKP1lBB8TjqNtXyNo25/
         3ub46FPI3MqZRN8G40q1Ap4AhQDVdPUu4ixtwlg2RhWjw4Nmp8f4qG5nAnKTG1oB8X+B
         t/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        fh=CGljsa3NBDVBmbBdKPe4iJpn49Nl8rhOEzEbKZIsbGQ=;
        b=ZlXihD8EjKLybKBvjF+dC3bOwTH4VBdE8kNRiWVlZtN3waOBORTPIxFJZqNA9yC3+r
         PAvHH2sm5RZ2nATUOWxa7hq3jQpyyBfbaqPgQCwHZxMliTuKbUXT6nSjjFfSZSlZC/mA
         JPJlON6SLbPVepc0PkgIIHB7nAbKudNVMLEQoTqKlWCIkRVg/aix1P+ExeBu95H/ETvt
         DSpeE3Ay3g+g1NAlhUCX428Q+A2gjEVUZC9K4kpBntsCjHBcNP3qZUR6UMmRM/5/p4yz
         1IzXfiYJXGelRFvzPfAFga6s6qD9eHLrZmGdGQfhdpws53PCUjetJSVgLSMwmsggzN0X
         dYGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769871507; x=1770476307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=ik1dSwSLQ5gKPr8itJihjb1p2ii6Z3jsGGCTSkLMElBTfrxMKk2BzSGAZs6Y3u/2Rm
         5Jc6JSviSstpkzoM62LilXKmZWvAB9DOuIyh5Gb+T0bn5eaFS/fm+ubSY0bwOoKcsOy0
         uUtdXIcMt8Yss89aVvVX6L4TWX7ziVDAwkZMGPY0zF71BzqoENGzauAVtQ4TysgmoZlo
         JTHS3Hq7Z/oREAC5DERRmVVlk1h39H69Q2dO8oZHQipUVCajubHib4a4IvOOCF6qUMnD
         V0QpB+SrFFffsYYxdEviApG9Tsmxy5nAA4c6446S0S+5+7eyl2juS3VlFK3vrM2U/7eF
         ejDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769871507; x=1770476307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjEvOy2WGDJOvuBTZY4HtZUR5P6Q5ANbgXFoz/CfBwA=;
        b=KrgeNq4RgXgnZ3N4ULkYmFkX4AbHRDhesrhANFGqv5thXTI3RXtfEeDWVLyJ+zGeuk
         +G1iCbMmazuRVDMejXiX/umDE13g1wzlzEHgsj/CDvx+k5wYXbzlIxFPzHTgz1kPOa/e
         aemw/Sf0E0W1RwDqpcqOkdW/fopjElGy1lApgzvhEt6GCfGOsiRxHXJ3J5erxNx3wMpR
         tPdDzK4Wxp9HG2aCQpU6wO6S7EVY9FRTyoMTw3aB9uea3FcLVgoQUkjakPDT87BgQGFx
         N1p+CNVEQdgtH8VzAB/+J1D43Za8/Oig4Hz6dTeiDEIJAa6L5Lq5TgGrMDs876J/SEw1
         Re3A==
X-Forwarded-Encrypted: i=1; AJvYcCXSLNLb+LwOCZ4Y7laVls3AA4Hq89cNCP9E5tyEAHERb2/UfrpMKNHBH3EyeAacgIsf3mZcGYO0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DgfWwhUXofWRIshdq+exefaId/XeVwr2BZUPEsMG8IJ7LVwB
	iPtEKew2Eb45vL6VIGxoSQ9gy7yXAKK+gL/kIPPmi+JhfjG/46AuKD1AuRmqvUcL01s3FqidNN/
	FSQqFjRXO830SjEhF5sBszn/iSnTxFzSzL9TGrqFd7vpv9/+Vh0EZErIIIa9++wCh/B2rf2S0dV
	DkTXAWEKqxbUhXPet5pgZ2O14C77os1M04fJI=
X-Gm-Gg: AZuq6aKhhOjA6TN27LzZy6OmEXSujiZs6x61mWX5qQNH3QdAI+jgULgaa2dkETF58qZ
	3FltFNnle7fRdJgiqvOdyBaP/8upQI/WITHPlX/yU9gnsC9fcHSAkrdCCve/qeBRBOqNEjW2w/J
	ZV3n/5oehSxF0DwDs8QXyEm99x0pI0TpZ1bcktljlaj2XiymkFvategX5aBlyk8/b/Uec=
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id 956f58d0204a3-649a8547db8mr4403461d50.95.1769871506944;
        Sat, 31 Jan 2026 06:58:26 -0800 (PST)
X-Received: by 2002:a05:690e:4107:b0:649:7c5c:88e3 with SMTP id
 956f58d0204a3-649a8547db8mr4403441d50.95.1769871506570; Sat, 31 Jan 2026
 06:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV> <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
In-Reply-To: <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 20:28:15 +0530
X-Gm-Features: AZwV_Qjt6-X-XbfNyo2_bleHjewtRG1qoA5gEXW9Hu9LjqRyKmxz-97xcVzcIio
Message-ID: <CAEiyvppoiL2EiSmVvNV3DEkr7wwyC1Fbwhm14h7Rfus4Z8uP7g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Samuel Wu <wusamuel@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu,
        neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com,
        linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, borntraeger@linux.ibm.com,
        bpf@vger.kernel.org, clm@meta.com,
        android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=697e1893 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=drOt6m5kAAAA:8 a=wEBb_YokH4NsbSDSc3AA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: n0j8u5th7KTSNtyctD3aehzG4H7jfSzX
X-Proofpoint-ORIG-GUID: n0j8u5th7KTSNtyctD3aehzG4H7jfSzX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDEyNSBTYWx0ZWRfX8ZjIEm5CfTlR
 RnfnDF5VeBBlIgV/uCgPl98kTzsQbA5dVebQecK8IHqOCGpej9a+HlxHWdWBcJ4LZjgUfbJ+ktv
 a1c/DjcRw5TaIwrFa+UqI+evv9MLDbwcu64v7z20rvjBpqfHdI9d8fDqwuaLI1URVCUJThPO1Eg
 7Wi4WFHa9FUxo2ggRkdYAmalsxyuwfuC2Ylvzkr7ZoCkRIMLq87TTBsbGyrVyT1nnvH6Ouxc2kQ
 mazomiWQlsm6fxvQOrd5IejrwdJeFGlU394+Hkn3uUNUy3XSrMwIbSXhxaeCA+AGtO9HGZnTctd
 BqX25Oeu3NhnxnQoNIoksOZstSVEIRA1MT/YJCsbaVKg243Oy5C+4F3S4znsbFqpelLr3fHziLJ
 jOO2DyEsn41A1KT58TMtGOigCySbbzGuscd0EgRhEjYJGuZ/wE1l29L+yTh8hOOBI3vCegYZCPt
 hpRZPg0ekaMAPS3lxvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310125

On Fri, Jan 30, 2026 at 6:46=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Thu, Jan 29, 2026 at 2:52=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
>

[...]

> I'm exploring a few other paths, but not having USB access makes
> traditional tools a bit difficult. One thing I'm rechecking and is
> worth mentioning is the lockdep below: it's been present for quite
> some time now, but I'm not sure if it would have some undesired
> interaction with your patch.
>
> [ BUG: Invalid wait context ]
> 6.18.0-rc5-mainline-maybe-dirty-4k
> -----------------------------
> irq/360-dwc3/352 is trying to lock:
> ffffff800792deb8 (&psy->extensions_sem){.+.+}-{3:3}, at:
> __power_supply_set_property+0x40/0x180
> other info that might help us debug this:
> context-{4:4}
> 1 lock held by irq/360-dwc3/352:
>  #0: ffffff8017bb98f0 (&gi->spinlock){....}-{2:2}, at:
> configfs_composite_suspend+0x28/0x68
> Call trace:
>  show_stack+0x18/0x28 (C)
>  __dump_stack+0x28/0x3c
>  dump_stack_lvl+0xac/0xf0
>  dump_stack+0x18/0x3c
>  __lock_acquire+0x794/0x2bec
>  lock_acquire+0x148/0x2cc
>  down_read+0x3c/0x194
>  __power_supply_set_property+0x40/0x180
>  power_supply_set_property+0x14/0x20
>  dwc3_gadget_vbus_draw+0x8c/0xcc
>  usb_gadget_vbus_draw+0x48/0x130
>  composite_suspend+0xcc/0xe4
>  configfs_composite_suspend+0x44/0x68
>  dwc3_thread_interrupt+0x8f8/0xc88
>  irq_thread_fn+0x48/0xa8
>  irq_thread+0x150/0x31c
>  kthread+0x150/0x280
>  ret_from_fork+0x10/0x20
>

Hi Samuel,

 Not sure if it helps, but Prashanth recently pushed a patch to
address this vbus_draw kernel panic:
 https://lore.kernel.org/all/20260129111403.3081730-1-prashanth.k@oss.qualc=
omm.com/

 Can you check if it fixes the above crash in vbus_draw.

Regards,
Krishna,
