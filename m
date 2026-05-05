Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B53D4108
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009263; cv=none; b=RPBr9bUgaPaxkdajziMor1H5GgNZxvRjDguRq/GV5t9W5qUFT1JJGtBpNoPd4TzNst//UWnK8zRuC+1223JyiuwNyDRlpVnPZZS8F6YL5gCHTLHCXcAqurslfpbQK4x+MNWSKr7GdNxF2E0Oid/k+BONyYrLLfu9bSwtTU4a+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009263; c=relaxed/simple;
	bh=XjqE8e34cnjL6l1/6OEAuPw9002oADGVW+fAEqYQnmw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TP6b+qkhKY8xlEn2Hxo5mx8C6Qequlu6swflcKMzGqvIdtn9RBETaRbty94lvPv1gJbLzNWoYD3ZQv8XoIDHrSP/8i40dpo/rx6cpOW40gyS79FkNAVToPSUxVJhgcycx/9vDKMbUNiMQS8qIFoET8c9w1UFWhde2qj4348t7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gsb1mU6k; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gsb1mU6k"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-512f750d4b2so22447381cf.1
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778009261; x=1778614061; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rT6YccJai4t6v4nby0kND8/2caUzoR13GWvaiyJAWmk=;
        b=Gsb1mU6keATCxQ8HJSm/bxv4jd1aFo5x9TxNTlkvF0FB/Xnb1uLFhW5JiH56w1DfWr
         pfXz8+eI5YrIeSrTmk/B/AvgWBJVGmnpUBpi1/4SlK/WxTxoPSnTvkDVupB0mj6k2O0x
         IJECCCWTp71sQSbfcLHnUTyUye+92TbbHPtFE95H9WVTJyLvx9y4XrZ1VIYZn4j2JGHF
         PW1ib0XNridziFPCNUF/UOuXHkGINYkZzxzSCsIQpy6P0xY8GOnxZZz/dVHJnq1fx/35
         +IU1VJIMU/4r0EH9oNrsYlK4t8UR6zavZC5nJC/TESLpPL6d9zCyB3SQYbWPCpPO/rYs
         88Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009261; x=1778614061;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT6YccJai4t6v4nby0kND8/2caUzoR13GWvaiyJAWmk=;
        b=gaabAl8/J45LZCHKzhnUpIvBG1UPEi4ErlnGGjLkqdbCXJFB1yl/glkmDx6V7K/H/1
         IcvOm2unUXjjsPLbQqn+nYYbbGcbvV9mHk/npgXmQL9ql6UDmKEZ3pqUaRtaFA/9mq5Q
         tNMhg23VmmO4G1D120ODdYtRSXaNQQZXJMB8abUncs5Y1UZuHGKsImN9RvkuSsskMxu8
         BeNRMYeoEC2QvDvLbBwstFWGnfLquwtDzrVpTwA/sqN7xAlS8cjvC8es8nzn3f6P5wrx
         XL9SPXdb2bJqAiCU+DF3xuCONB/bOK7N7jLHWtyiZkdnn0BOg5KpwScsRATiIvOf8oAK
         mDwg==
X-Forwarded-Encrypted: i=1; AFNElJ++w3TcP6EHYJqsWgPbUxquR66cGQk/ZDyo9VVvMUu/GElEJ/kOYZycSz7Q0nR8yJetyhsL77Uh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MQT98CmgnfQV7R4C0FqxN8c/BvopCah5Z/thh5dfzWnKvebV
	ypmvouFG3EdFeil0/UjjHVfMoSTch9Brg5FjsYFOWidoOfyOxrBRs+dhVkquUvmOaQ==
X-Gm-Gg: AeBDiesn2Nz/jTqYCkwtah0m6zIanTy+qR6pgSIwNxvCSoIiG/9Z2dyBzPO/HxP1hM1
	9Oh1o40t0M1afOL81pcrl1K0PuV19YOYkf0H3NbqSy2XvahOcVFLClKJyf9P8SMBb84gfgCRVlB
	QukehCtoJO9iol1+VKUnOmnlC3Wo64yEQ/ES2GjNS2ay6+4HVhFMQ9epPI76HB2ytJyIfBdqpe4
	jpMEde2WbspTmX++MLfSO4WZQgl+Gi7FPAsTxrlXIVDilMXm+Gco0ctyXVQopq3QxL2WdPAVgqF
	mMb+xQj6Zg06wTVZFD/mtStVElORVPyml6CgChV9UoMjYfUzM5ST1Y/dsnfhWaPZTFtya8lW5fz
	DYYrazNdkVpelHOvO/e1OsIImNFZy3nH+hktlNwC823drxTz0JRYD6ezFSDh4R/VeqHCF1JQh1j
	p8C8JdZw/4sONU1Y/bXeqiIMDStUWpgX2HdYZg1m6J+bZ6940Pq1SypX/HQBlC8ICXYbRVSILSg
	+ioscQ=
X-Received: by 2002:a05:622a:5c0d:b0:50e:6183:beea with SMTP id d75a77b69052e-51461c2632amr6029971cf.23.1778009260937;
        Tue, 05 May 2026 12:27:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b8550esm133079581cf.26.2026.05.05.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:27:39 -0700 (PDT)
Date: Tue, 05 May 2026 15:27:39 -0400
Message-ID: <b9983e456fafbd2ea66f1d65db5877cb@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260504_2038/pstg-lib:20260504_1547/pstg-pwork:20260504_2038
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 2/3] selinux: prune /sys/fs/selinux/disable
References: <20260505124949.2541-4-stephen.smalley.work@gmail.com>
In-Reply-To: <20260505124949.2541-4-stephen.smalley.work@gmail.com>

On May  5, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Commit f22f9aaf6c3d ("selinux: remove the runtime disable
> functionality") removed the underlying SELinux runtime disable
> functionality but left everything else intact and started logging an
> error message to warn any residual users.
> 
> Prune it to just log an error message once and to return count
> (i.e. all bytes written successfully) to avoid breaking
> userspace. This also fixes a local DoS from logspam.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 adds a pr_err_once() call as requested. Note that we do not need
> to copy current->comm when using it in pr_*() calls; this is only
> necessary when acting on another task (get_task_comm) or saving
> for later use.
> 
>  security/selinux/selinuxfs.c | 36 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 29 deletions(-)

Merged into selinux/stable-7.1, thanks.

--
paul-moore.com
