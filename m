Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215686;
	b=THQvB0nQQWKYl4MnIqgKS3Fe8Czjq0vyIs16omkTYYJXJrs1HzN/Xk8U6+V4lQktFrv3
	 0adMS+BCZ02+cRj05u8u+9k9QI4p3JIOFqlZKRYbZ86WVbenY92RDUgPC3gEg4uVD2K/j
	 QOA74Q6J/ybvR2bjUx4IpyUErOOPcKN9Hyepk4bipqSiwbl7Gct6anqS0sXdt1kdrV45w
	 5eaxVzkkYiif5ohIO8VAl9jmSAiXE4j39ZtFgJcrrvVjvcGW+qXAJK9O/SFqdbYYgsvvD
	 DxO0ljZ7rYcQ4AxbzyPY22OvAUJ9mJIePchUB64bmu4u6VqlqaRfmWbSc7Tka2wie8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	b=FQ+9HDlfEwimmem919VKp8sSR2dJ12r+p5qpwuvxb4gi3ImMjOorXL4DRZhtNT1OecTf
	 IcjWRIXEG4ksQe5iU02V+YMCs3s8WT/XztmsgGIThdhF7RgV3VfLlcfzmbGhVreDQ3o2C
	 X3GPB3glXiC1p1gSJVJs8Ij8eQv7Swf3CBU3l8t5Oos8RdChGN3c72+Cf1te8+mCva4c0
	 Ium5skZTlbZvvbSvjua9fy252IbhZGgqZoTv7k2/ObeAPCn0rvpBAGGhYiKSytTw3wTpL
	 HN8z01aE/tdjOkrHDxDQifZELqIFI7a4GRns37M6oJseQZ5Ux1Wom2WeWxzx8bi+sJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRuWLWCd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6D606A330
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 09:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB6D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRuWLWCd
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96A1pY3581231
	for <selinux@vger.kernel.org>; Mon, 9 Nov 2026 09:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=CVfpLeBo3svBArcIsMoE8xRGgAiB5mlup0YLE+WU
	miqzZlFGvtGNDDsox8E4acOXK3gFfIwXz4N9NuUoFgsvQYzB36fLfpJjeTRHqc6s
	uy0gSyaVcClNbyTOzA2q8KZ6eX3yeJTqJ/ms2Qw2AhTUM6hxMMbK1fitbXikNI1A
	3N1EEpVY6+IW/Gl778ykaY1gR/3PEmrnDIUD2fTp/fa3Hmb8ffAS6UIbg308OCav
	3+Nx4dhrSnt3yHskSXih/XRxBQbXscbe0NIynFJkTP78h6opo1QkdQ+HiyPEGFcV
	CwIq9i7JbhtLjvjXIsVC9XTOcHDqrOSl9f6bgU8BbCtJVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsv735hwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 09:14:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f37c94ceeso134962585a.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794215684; x=1794820484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=ZRuWLWCdtN65wuVlWtWaew5IbZJQV+xs/PnELoRFpgR+THgXzTvZHHOS6lp+q9i/63
         vG1RLNwSZy/EKgkhLioQy9BvJu6DTvuI72ZPuG8/ZNGhIX27xfpTPHxjQspokzT+CS4w
         mq2ipsL1uBiZh1A8Udd+SM9ptm9xaw9Aazb85UGx3wPDnivcG0l55rJLyxme0XB0pV1N
         ZQoZ1fCQPdtCa7a1K3weoQ5WiLHJL7xD2cFw93ILwjd1phhIsepjgI/zHFTyWW8S7+94
         YChlXmlDmtQB/vMWu+nkqRbdYGmnJ5OOssgzpkC1RENEguS4LhadiD01PH1aMyZUHojQ
         QMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215684; x=1794820484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=otxr0cFNmm0nZahxOk+6hbZ40wWdHsj1K18Jb6GWJlhw9yi1BwtpXbvibLs15Pruym
         eeVXBNIinZMRXVxD+NfFXJFnDhUKw6Fl3z9QJ8ck9FTK6+8KwzEc4uitXdMNlw/+zvh9
         MLmG8X0OgKQDnC5Bah6mSiXphickCd0KNDZxg5TPotFxxzCuP8TdmJjOSKdCoTylpcaT
         IEw5PLMKIVOnBtmVwsOEIHSVcZnFT5izUkEpObMu3ZhvseU/W1bY5yaOmX/O18NuCMGM
         4HbHbnyJrewFkE5zjQk+o3JE31KQJ7jYt9RAldr5FqxxjB9UScM7fve7zXKs//Zrtju7
         /PHg==
X-Forwarded-Encrypted: i=1; AL+hErHihKxn86gFEbq44U34aPhLvaT5k9CcMSOP/yXQ7CXgEHwnbmpmDAVBQJ0jV+XSQAfB2FIXhe6l@vger.kernel.org
X-Gm-Message-State: APuU4Z9sGz60eL0jZSVAhtKEk6epRn5DHn/idPjjbxDuLsAjEojihOjf
	ug0o314gYkNmXdurE7cqWg0QHcY7bPzuNsEifHLmCLJcTJgCo98tH2KvKDIf5yFiclbdpWbKbLA
	VhqotTvdYAfEs/V/PtaSISTyH6ZNMQayyXlJYBRwDBsDZIzORbQe+iPIOx07c
X-Gm-Gg: AYBFou2ZQfDD9eEx2T4mwlFHBeMgFsXkD4GDeKsMCsMCUkZm5HTG4nvtcF1zhwTly/+
	yhltvRvdzUKvIEHh4+omsB6OOqkwZJcarrQZ2twdhBzVLtT8YdqU7Ai4dl2/sCV6yL8+92KZ616
	8IR/Ff9sLyQMwahiXRVwqLFHLZK9UivdK/oMom0jO/IGQU1OEA7kwUk2WstwhO5r8oQssUUh5M5
	Oh1nDnKuMSHeS/vu7P59PLFhnXrXPejFriRaW2A1/fZRJAQn3XbwAfpgcg8rexavs2RKHzhQSCP
	K9tXim05RH2lCF/n9Psb8ZReHlmCNIE9jqD6remZJ8D9kyaf5NmMd3uYDA6jJ7UOApSj6RDRhkR
	ebqlXWR04kaRyuHB7NZTR56iTkJoyO53RzMjbtJpLhApYu726e+slqNO9fRjV9M4=
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886326285a.13.1794215683461;
        Mon, 09 Nov 2026 01:14:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886320985a.13.1794215682798;
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm161196965e9.4.2026.11.09.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:14:38 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
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
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <tr3hhmd6gqvvzrngazyovx7jfbw6k45yjw2mipqu3aegsy5oda@7qromidf5btb>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX12KyccHNCDGN
 qxlGeh+Jg/9nPRFzItrycGL+ZJONUUiM6pLEpe80mLGLs+WlDrWk+2+VDY71KQXjBsgUO07VPHl
 VOzKMdfTFwnmuibS1ju8NfSnXfLNLVnBy5Cfq3cDbLFrqV2VuhYdKdU6/PWK45ALGde+r61Dv5y
 CL8B7CQESL7/kjsnQu2qkxdBqn6iGkPBNRcbaJNgQUl4RVRcjRgov2pjP5BDnkqWSniZmPN3M+q
 Nortkq4xLvLXrLGyWhrGyIEV2kGRK1ofQbIn3xzwuJmWfXekQtF2fVfGkeDF3bIOm8vGGVcBfUF
 lqz/PLrYtDskBtspRdt0cwhun6eZFWEXacAcpc/N4qlGOVKHlzhWK0NP1k8nPgfd1Yi6fenetN7
 +rj90rzBvb7KwzyrqOpcSJauM8YVVBA8SOXuwRROBDBlLzuXy2A7SdqOIntfbIEk2hgGU7JJ6ys
 NLs1SG9qxJ76AoL6lKw==
X-Proofpoint-ORIG-GUID: pi5S7JCsSA8gYoDepfLtdHy9UJyIAiwB
X-Authority-Analysis: v=2.4 cv=bcb+w+PB c=1 sm=1 tr=0 ts=6af18f04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX6PgZqaahTO6t
 Q3SRXx1uSMS0Ze7YocO6oG7cfIFy8S6Bir4/CEYqevnIOUN7ItRfVeTfUSGeY8b2mYpxh7vQRfO
 BOYQTM4gBijXuTIkyKsY9nngOtsCQSA=
X-Proofpoint-GUID: pi5S7JCsSA8gYoDepfLtdHy9UJyIAiwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090036

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
