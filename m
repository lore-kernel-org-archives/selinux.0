Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA03EEAC3
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103317; cv=none; b=Wh0CVk49T6yePN5DbnWP7WJFv4TTdJR1fp+T4L1inYu7b+JyJMeTUQ7+jXy1LRhy9lpwLZWLtzHuwf1DLr15WvmMa/AqL3zNASWzl0I3YoIVcD0/YoSV/kAYA54Mq43JILLaM4Glx7XFYuql+AaE5XzhPPohPTyOQqTbuBSi35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103317; c=relaxed/simple;
	bh=83HDBSp7HZKr/WllyF99yilTLkhY2ibKs/VHLY0gfXs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=mHUl6Uph+GV0O0kbSFUU4DEj9U//QFyeRukJibVCx6ThEouBXnaUaeKXzmLNYc/QssPpAPMEe2M3yovE6IcDDD8NJPI1OBYpHAOE0z1U9XKxH0EMnbRwl76bSY8ChG5D9neeyQ4DO040y/pvgx+psiN8q6XQCrAhQD1Jw3V8nTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=QPPmoKDI; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QPPmoKDI"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso201727a91.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1790103314; x=1790708114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sRMSf5H0mGbkZ50eOGhHFCwZ0ZLM7+G+4kyNdMWVQ2o=;
        b=QPPmoKDIINd0HF4BoBmPliJmVqKukEhDVbwOSmQ4a2DgcTR1lMbiAaAI94DBy0yGAP
         v9quSVifyu2K1GN8MlWXH4sK4gDORdKfIOduwCi6pjb2LAiWstIspGXjYqzpArzOw1h4
         WYertRcc1zsSxj9BYYwpX3DV8ll0HJNutCdoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790103314; x=1790708114;
        h=content-transfer-encoding:content-type:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sRMSf5H0mGbkZ50eOGhHFCwZ0ZLM7+G+4kyNdMWVQ2o=;
        b=OTIcy31U+dlr8Y/RBUdOylcxK8GVj62pp1cy7Lg/+ZLNaZHRIHDRF9TQkAqwpBVwxP
         41EJvVAuLWv64d5CDR2OyttWzXpW7K3NeznLjJGciH4e6V3t6foSRfVprLwGHuCC8+Uf
         atoqajuJ2mQWgqeDTt1XWG+sCwOcKfCtnXBf79KB402yHheZirr0PoIS7r+PJ0KZIIno
         wUOhA81mlijRm5LmBZ4Ov5uicoRZ50ueBUSVaWvBJkC7XaVfLq+x28+OY8KFMCmdLqp2
         MEx657BeIz8o7pwICPVOdyxlo9NK8Sb2jHhLTxuNdaau6FSLdS/7kg+v/AHqzFXr8A05
         cpbA==
X-Gm-Message-State: AFuF++mH7zhCTk20t0VTYR6uTL/nCbpNOFg5ZjPSM02fYnoTUrDFaiiF
	ZPqYbE28Uu11/53S0DWxPiDIZnzX90j4H5MWFokncuW1axGF5nZGazDGaOeEdWxKhT7VgpENm2V
	AeV7ooFUVTvsd5e8LZq77crQASVJ7kUHp8Nqdt05z+VQ7BIly6QXG8hMYMVaoYZ8Inl9HrMr5kE
	ZoJjeh8lXw2bu5wJzsBFH2FYffevYNtUOuy15nta8=
X-Gm-Gg: AYBFou0qYSfC+Zk+wkBZdWq3T4IwDHxDtdrLaQKhaVTa4VNXG2KTmb2ti//SyQOBrTz
	HB1ciBGFIMKTAnlHIsRCybrbON8pfs1uQwZJYzscwW1JvU+4r3/y51cL8JznwHAb6DfNYuATr9w
	VGe85rAJLCBGsq+8T5b6kVeNcORCj1GMWlecrydFGObcvi2uEAMsoHJA/eRqQ6w/upKd/SJApP/
	AVAN6OCikEnve19L1Pa4yNlSVgjqEV/rm+OvmYuOU8YentAMEVPjbk24tsqS+lvqhLSZ3xRk5ny
	NElsXa57wsCDomDYXhF9MKJWmCuRJqNTp/0sdlZy5EzP4BmmQSbQ4oAnlO9EYVKem+VvVdYRpe3
	kNK8Z8I7POoPxjqRDp3JGcMAjpXL0hSNOzGLuMF+duNnx7RpOQO9gAPGqF2cq8ZchCwsspyuVNi
	k5fyARK92Qya3UEd6Q8mIlnj8AIQCg8yK8S0+6YwBFTclt+asPSexVScdIbhJhZBQpasx5kxmR0
	vzsbLFaKHdUxRN224Cc+QCguf5gOZPk+wvQiCmM
X-Received: by 2002:a17:90b:4fc7:b0:39e:6c69:9b96 with SMTP id 98e67ed59e1d1-3a07e6cc5b6mr335087a91.59.1790103314206;
        Tue, 22 Sep 2026 11:55:14 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:71bd:20d:33ea:4d98? ([2601:145:c282:5650:71bd:20d:33ea:4d98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc32086sm710120a91.13.2026.09.22.11.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:55:13 -0700 (PDT)
Message-ID: <bc6aef31-856c-4b10-af51-c0104de167a7@ieee.org>
Date: Tue, 22 Sep 2026 14:55:12 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20260922
To: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20260922

* Enable policy capabilities that require libsepol 3.9, except 
netlink_xperm.
* Move documentation from wiki to source tarball.
* Add security goals and security architecture documents.
* Convert existing documentation, e.g. README to markdown.
* Update all standard constraints, UBAC, MCS, and MLS to add constraints 
object classes and permissions that were missing.

## New Modules
* docportal

## Removed Modules
* aisexec
* hddtemp
* i18n_input
* openct
* pads
* portmap
* prelink
* pxe
* qpid
* quantum
* remotelogin
* rlogin
* rshd
* rssh
* slpd
* telnet
* tzdata
* usbmodules
* wdmd
* xfs
* zarafa

Full Chagelog:
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20260616...RELEASE_2_20260922


-- 
Chris PeBenito

