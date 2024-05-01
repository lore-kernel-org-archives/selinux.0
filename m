Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EA5024E
	for <selinux@vger.kernel.org>; Wed,  1 May 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586426; cv=none; b=BEcHvfME34AEZOIDwUZ1bZ/YFXcJDkRejO0sOty/hSTtrcxCgpWHkV9+ol7tvJRtflAWBGTl3tVDPXX5c05hS3+YkLQgO07WsOd342nfz7ucFPjhhvbfivKDxjl1QbxNCCErBxXfofie7snliUaCjp2SKTMGjTYNY7Sx4wVdGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586426; c=relaxed/simple;
	bh=FPd+L2d2s8qz32WmOFtDSPtXLoOasxHDgbQMBRdgeJo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=sTw+802cgz9qoiq2u5e8vDoJVZLxg4eWsj9DuxWrnmQ2buKakuY6NHDYPfr11a0Nx5fY+w57NrcEE4zwSfYNiBS2edVnzNYDc6gERIKbYNu+OD41ufG1CAMSZ/467+buPvLm8cw9E1BbkrxAqhOYyXRNyDOSYy2et21Y7IXrUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=DoBBo3WR; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DoBBo3WR"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23c74f391c8so1806806fac.3
        for <selinux@vger.kernel.org>; Wed, 01 May 2024 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1714586422; x=1715191222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv7+3YQMoWDkxmfxV2j54hZTjg1pMcQ5Zl9Iye0XRuA=;
        b=DoBBo3WRvTTwDIP0kMiGaABcNyEkn3OoZMyX4ryDT/05D34/VYjxhfHARpbJtojpOq
         B/7Wsah6AUGH1bR9ljQ/m0cpZlbacqkSnYTXOS7wbIBHokqjYq4rF9fKl9yXm3UKZfwv
         9+Yo+HOFaa5L3e+eKg89izvZRtGuclg1wxpi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586422; x=1715191222;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sv7+3YQMoWDkxmfxV2j54hZTjg1pMcQ5Zl9Iye0XRuA=;
        b=hTvGIvldjvkGIJlnudyMGfeuMyQ8VTrElF4c3NOhy5zXrFt3rCSLJ1gB26c1sMA/pK
         VkStLZyb3VCuqyR/Qm8W6MCBs1Y5Q7Mgv7k0xUKvTBKmRWLP6ibBi7ZUyeKKJ2KSM+gL
         1OucA3inTZjYJHpfyhB/GNIFe1IkmHEjauhdGIWXhGXu6/1q6scZxkS6q1Oq8pqvnS96
         4Iar7ya1Bo0Gmn89BI6M1tal9VJMHcuqn5awzEWuGnDljXK/bhn9rQ2X1nM4GqkvmdWe
         rbL8NDJ2ybcBcfdxn/Sx19pbvHYjcww2YHEpvriQPrLjZV9180iG1ygA61h+Y/WnS860
         Ub0Q==
X-Gm-Message-State: AOJu0YymVGIPcQ4fDASrdmyXvswFQQpMjNp9Q8xYgoBY0t+8CxtZNCSv
	QIb+SMal5PIoPeWdq/ucV6F8ECaIuvLd+MYUNU2WZMAe/m7V/JHeW4BrZNWWr6rN8nduKju9bTW
	VG5GRrt/5EMeVxdLTB3sJ0zhUO+EOxFpz56AVUj96TUbmP1CC917n7OWkYh3UzyzZwAshJ4yss6
	cJM8siHjoXDbDQvL+DJERObJ6PF77pxW+i
X-Google-Smtp-Source: AGHT+IFQQ4aY/YzSMM/nvidtFQ5jOWaFqg25qrqu7hLNxt53jkqYRNfHLZnMo6gkWBFD8sZrAzqnSg==
X-Received: by 2002:a05:6870:5248:b0:23c:737f:5add with SMTP id o8-20020a056870524800b0023c737f5addmr3926025oai.13.1714586421665;
        Wed, 01 May 2024 11:00:21 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:59c2:306c:efd6:f023? ([2601:145:c200:2c70:59c2:306c:efd6:f023])
        by smtp.gmail.com with ESMTPSA id e25-20020a05620a209900b00790f4d8f7c1sm2921819qka.47.2024.05.01.11.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 11:00:21 -0700 (PDT)
Message-ID: <96cf7de6-8d72-4308-9916-619ed1547be2@ieee.org>
Date: Wed, 1 May 2024 14:00:18 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.5.1
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.5.1


* Correct annotations of NetworkX types to make it optional again.
* Fix packaging issue for apol's style sheet (apol.css).

-- 
Chris PeBenito
