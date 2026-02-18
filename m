Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7433C506
	for <selinux@vger.kernel.org>; Wed, 18 Feb 2026 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406248; cv=none; b=jQq9ExrHFqxNgGgqCIARfyda9eOlYWZzWvWMEpDqzxTTVHVQCkasd8iQEezP/fFrAZWRBZFrQ7PDVmilKF+P9D+kJaYDxVkZKX/GnEmEpp65iTWDFD3tjW8WQ1Fnd71lWNWaERDHDIBYE2C2QvVosbnUXudcqft+QpEmGjyeNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406248; c=relaxed/simple;
	bh=XnA4ayKORW1q6ZfELcTB5jOWEzzvzBRZU+q5rkTqF4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEbRWUHUkCyWzWrXhjs1fO+HlXbOBYhvTeI+tbJKC5Q/fXbwGObv/dU9aGyL+UHt1eC17SPivO5gjauelOZ3xFnyUaNdAr2PBtYeTxhlgReX/DxP2P5hgKcDNeZmo7Pmp7KjuB/yk2A89h1o5Lq1x39fsNlpm0M7cI7Kj83BHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEHBZCmo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZSi3poq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEHBZCmo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZSi3poq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HNlkwm2111750
	for <selinux@vger.kernel.org>; Wed, 18 Feb 2026 09:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BerodE9udH0yTvTl3i3zzvMFVQxy5GnH2IbIXbjYmqU=; b=KEHBZCmo2A8FVxq5
	I9m+x7IUSl8fwuMsuFN2X9xadr95fm5rgMLB1Pg9ydZg/LpKBiWmTu5HS+ILHoKZ
	vjUn+4Dh9nm10+krDfSs4vhKsDqh9zmRtkZXDuyZiBEdchNd0BVXE6zB7FiPDawP
	EOEYV+Q5U2GS8vtNQHc98EdHoo1IhaqY0qRz2N7WY4iTAm7GTG4lptExwsIGeVCD
	6M3SzDnml2e+HWmaB35g3X05EhYZUQcfopPtkpCX1JUrT4itRLKnyu6GVcpyOZqO
	GVYt/jrrB7XBOfIi8/IJ22xB1YehUCda9BybXA+sfoQ15W53zhS6imfG6FMrFJyS
	vhJarg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4m9xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Wed, 18 Feb 2026 09:17:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ad147cdf07so46320235ad.2
        for <selinux@vger.kernel.org>; Wed, 18 Feb 2026 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771406245; x=1772011045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BerodE9udH0yTvTl3i3zzvMFVQxy5GnH2IbIXbjYmqU=;
        b=fZSi3poqf/uUMTHZ/VNCCxUQb1QS99/uoF+JET27AmBRmkKf7Yh0bytyeFK1A6kB+c
         Rz9fcp2aGXb67ld5gFlx+/tG+0yZNsWvGI/kjaFVEfsW0yzEObuclcD26eQTHnu2eHf9
         6BApgrXQR4rspxSZE52DCiQF8lJTEbX8wM8FWKt8mHyUN5EhgC2pbM+/VH12Oqq1H/5S
         HMfzTx4r/Hu/HMXgrjdEr1T/T+oqe+Wq0poOz7KqvHoi8NFCTyGMgsRJkx8Ee7NXibsU
         MjVrZSXKFS+anSQvo5JGBrP6J2AacqAuhjCs0i3Y7B2IWWfY1Rz05eQvLg/Za5lpjq/L
         8Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406245; x=1772011045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BerodE9udH0yTvTl3i3zzvMFVQxy5GnH2IbIXbjYmqU=;
        b=MgJQtsrfTlXCHXX6xI71pKYjeG5RuBTXRl51vRnIIiaavc1eMUbJSicDNuXWHZnPtm
         c+wsdpc3yqhh9RZOrROVLaiSQL3Wz2nCi33iQDeolLY84G2SmjtbENoMtHDD0/+Ufv92
         Nb8p8w9sh03aVkgfuEgH1Z/Nrp1G3FQFbfA026mRnsL1zG3OvcBktTnRsHnC6TlA4hY/
         L8CYzrplmct/5qGFA3FIzy2X54+uOTe3R7H1JgPQOi5u7m0WIDXZlpfVSAcYX72MdTcI
         A6Bu/ZYRrV9hbD8hVeiNZH50rxB8tz7Ftl+cZK7+Si3o6Buv1esx5jzsVKBQ6Q5oibIc
         y3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZXjuDuhsO1ZfzYDLxHzMWK/tB8pLuZ4GEvxhjb4Sds3IOIAXIGA5sSrQlfDpRhnfWJY18YlV3@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9KtYhEfAgi3bSfgv1RJUc+7UvJ5wdNhIw/BcxVs0LYWZnE19
	5XnKmGLpSg5mlCK8t2oQyvlxfP8odr0UQ47bbHo4vyyx5Dtr8MZEkNKLjZUm6oQiq4f+X+d2zBl
	mw/axt49KnOOx0ClvhOlgKeJmm2ZwJj0dCpNWpyD3RSOH7GXcdHmEZ4HVHgTP
X-Gm-Gg: AZuq6aLVy+fMYsYjXGkdumDQ3bCg888Kz+B3V7GUOUTIyHu8Q9rEDu8kFlzKFL8q+fG
	P5h2i8yeUL0in6JYdGURXwAGFY8ikZbJcCuV4rZAwzb6SWDOe6jQdCnkwT4fsxXbW69LkiFgfvs
	R8fqutLGi2w/Y+KDJ+D01BECXPDG2JYwoPM6C47biD2JpaEodqwHcwBcTSIDPmpLJeAaFJ3o3JV
	kc9kg1hueJeh4AO/T4TMa7EG3xFfS/nVo5Fd/FVNS+xWkoQ0aMO6ZQxMyP1qK0GSh1d+3yJSskW
	hK/+mCduB4Duc+HnHuRU/MP4lb/c2yi0bgGWZtAwNscY96vbYfpVK56O7sCTl4dZBvasjDcHeWH
	s7dy/jMQfrPswLSsGiTM2Cx3U2h/yuGchgQjOvWoD0iDLNrnI287ELLA=
X-Received: by 2002:a17:903:41c3:b0:2a9:4c2:e51 with SMTP id d9443c01a7336-2ad17543e89mr154207875ad.55.1771406244535;
        Wed, 18 Feb 2026 01:17:24 -0800 (PST)
X-Received: by 2002:a17:903:41c3:b0:2a9:4c2:e51 with SMTP id d9443c01a7336-2ad17543e89mr154207595ad.55.1771406244019;
        Wed, 18 Feb 2026 01:17:24 -0800 (PST)
Received: from [10.92.201.171] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c3esm133417595ad.47.2026.02.18.01.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:17:23 -0800 (PST)
Message-ID: <c247a57d-b4a9-4c77-9334-c338e5457a48@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 14:47:17 +0530
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        rsiddoji@oss.qualcomm.com, quic_sasikuma@quicinc.com
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
 <20260206183657.0477e50a@kernel.org>
 <5b2fm4nbceqdmeu532vsr26il7jroli2sh6azcwirzm43b32da@grqzpgmmdvyp>
 <CAEjxPJ4VA58rtSEEZpxeUZHMjURtrUbZCvV8kAkWwJaoR1YN2A@mail.gmail.com>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <CAEjxPJ4VA58rtSEEZpxeUZHMjURtrUbZCvV8kAkWwJaoR1YN2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=699583a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=9YfBhDUXH9MDG8CxehwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA4MSBTYWx0ZWRfXzLv7sjLMG/V6
 UfOHRQJ5HflE2vAu2JPRYlM9MbSdXS7J0jk+OKMdO0iDmTZc/7Ym+MAjeugQ8mo6XrS9IE6bsY3
 dtAh3c44mMSFgxSdpUc5xBliciPOPDBsfIWXeAjnoyI92resvvzRcpR/qztMBGcRdAxaS9gLzn9
 1ej8QNl6ItZGV6bBY6iu8FFi2VMzZdCveXm83FHn7KqiWoWi19OShOzuKOKI+EPsIKhQKUIolME
 uOdocbIeEF918JkMeniU9Xn2tp3zzgTpqOonKQE4MX1k6RxAjbiSId06xg5P1L+QBq3P/imguDa
 +cudOAl7ZDUwx5rr3X/PUZ2vdQAoiBb5TsV9/maG2DImN0Dv+KPosledMcQdvYW7F8Vk5FRzTiV
 0w6c831guZbUA6MGoYE9MPlCfrXZv1kwQaI95xORiZLNL+dNNtQ1A/OSVQxHIpjB2CC8YsnWVav
 w87aeDFdjMdElJ5ydJA==
X-Proofpoint-GUID: VHBwcaNFaeY-vrUJIA5q0y_vcch8oA5d
X-Proofpoint-ORIG-GUID: VHBwcaNFaeY-vrUJIA5q0y_vcch8oA5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180081


On 2/12/2026 12:07 AM, Stephen Smalley wrote:
> On Wed, Feb 11, 2026 at 12:20 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
>> + SELinux folks
>>
>> On Fri, Feb 06, 2026 at 06:36:57PM -0800, Jakub Kicinski wrote:
>>> On Thu, 05 Feb 2026 13:51:31 +0530 Vishnu Santhosh wrote:
>>>> When qrtr is loaded as module, qrtr-ns runs from SELinux kmod_t
>>>> domain. On targets using upstream SELinux policies, this domain
>>>> does not receive CAP_NET_ADMIN, which prevents it from binding
>>>> control port even though qrtr-ns is a trusted system component.
>>>>
>>>> Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
>>>> but not desirable, as kmod_t is not expected to perform networking
>>>> operations and widening its capability set is discouraged.
>>>>
>>>> To address this in a contained way within qrtr, extend the control
>>>> port permission check to allow binding when either:
>>>>
>>>>    - the process has CAP_NET_ADMIN, or
>>>>    - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)
>>>>
>>>> This permits qrtr-ns to successfully bind its control port in
>>>> kmod_t restricted environments without broadening SELinux capability
>>>> assignments.
>>> This really feels like a one-off hack, but it's far from my area
>>> of expertise.. Could you get an ack or review tag from some kernel
>>> maintainer working on security, capabilities or permissions?
>> I'm also not too sure about the problem because it looks like kmod_t has almost
>> near root privileges, but cannot do network administration.
>>
>> Maybe there is a valid reason for that?
> On Fedora, kmod_t is an unconfined domain and is allowed all capabilities.
> Upstream refpolicy likely hasn't encountered a need for net_admin
> during module initialization previously and thus doesn't allow it just
> as a matter of least privilege.
> Since you referenced kmod_t, I assume this is just for Linux, not
> Android (which has an entirely different policy).
> I would fix this in policy rather than changing the kernel module code.
Thanks for the detailed suggestion, Stephen.

To address the QRTR NS initialization failure, I initially tested the
following change in our downstream policy (modutils.te):

allow kmod_t self:capability net_admin;

Since the kmod_t domain is only used for module insertion via
insmod/modprobe and does not perform networking operations, our SELinux
team were initially hesitant to pick up this change. Based on that
internal feedback, I made this change in QRTR NS.

After your comment, it is clear that the correct resolution is to adjust
the SELinux policy rather than modifying the kernel module.

Our SELinux team (CC’d Ravi and Sasi) agreed to submit a separate patch to
extend kmod_t with net_admin in the upstream refpolicy so that the 
module can
initialize correctly without kernel driver changes.

