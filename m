Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5523DE
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271434; cv=none; b=jxpSAJlcmEXCpG/9aWKs7X3xLMy5qvdeDgKDfEhkq45bfEIq67EWDWxBH3PJGcVLPacsKS9C4K4LenNZJ9yj/uRgUPnu2uyXSJc71QN69+lTDQOI4JDyxPT5z3c4CXHjeGBZfZfZB0qWcUHWNSM/NgSxdrlqxLHrj5rPUrNLi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271434; c=relaxed/simple;
	bh=O89J9H4rRKomTI72BHU7e4gP9WvH5tJDzaqOg9xtGcg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=KPbcYxVMjS8OYwF0pw5Vku5bZA/0boMLkT72S6UbExrAKpA0/y+lU35PCbCTieE95Rfm3ObUdP6lEw3XjmyfnwgPyTNdli3HeJAQggMzztS3oVs++ZQQKTdMPMVYuzirnFTa1w89/c4kP9axFtuIOj1vqxYucLd4lSrG5Mzl9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fdY4WrEO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fdY4WrEO"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facc3b9559so105204736d6.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1750271429; x=1750876229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuUEe6gCFjiWNM1z1GOgV/5fVk90tEK6DnkDu36oOVI=;
        b=fdY4WrEOWO6PnDhnOUIuoIry7MlefS/2BeAR6Rvue1wDetXl+HP/LwJwo83zJTbdfq
         kFrJqnOSJyw9IIQX/NYa+2Uv9ByK+DBlTo5XJOuk+G0feGpd19iw+5JeJSJnr54UAUjj
         yQvMMydm1mfOEWmoD0o/y8SBfDjxUuthC+I7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271429; x=1750876229;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yuUEe6gCFjiWNM1z1GOgV/5fVk90tEK6DnkDu36oOVI=;
        b=shWMxBxIh9rL/GInRMRbA87jzmBLCeksdWMqkjjIAV2xOoDo1EBJrPG/9WeSH6DA7v
         cE8b5eJ0vjayksibJ3NYiwW87spl6RIzgXQF0S73mffFqGULgC/Wh2JbbGDwFhawzh05
         Cemvq5Dq8gMzK+efob/sSun7B8QIQhLPsit29kPhK4JQ3dSQcgkJ9l9/ztzFkYlbLDgn
         oJRSiWN7DMrg2XPJ59Oe/Zm3O6QptqGHfRz3FLhGinLNBNGZ5OJ0xNyuWhg+KlI777tb
         VApXf1L4WXQA7S6pM5D1D0+cofkqN2iBzuCF/DrXQX3r62VvjHhVw2FIX0tvSyOEwFPF
         +jDg==
X-Gm-Message-State: AOJu0YyKM4DVlmwYcp0SIM/5uh85ZaBbqxDQ+lvSzw9nlbhPjIQh0SMZ
	eYxFOWb3/4MIm1Q39q+tiPy5tdSxcN06ze3smAjpd16oCXNATksiCXBPyQgCfmzR6NCjfPuwAky
	m7RxUF/05AFxdtTttv2+4ZY68Z09gtlFohdcwysYwdOp+1s2hF3+1Q0rTfvEbTxdQ6vTh93JEeT
	QpkMFbEvriRnRm3lkE0nUj2P6KbfzTEEl9imRC
X-Gm-Gg: ASbGncucAPK696Vy+/sp7LWRj7GVfLSTfh2dMJulgUv4fDdHqDsfInD5JnbVSMggiXG
	pRWQHtHD17ElxoVGcQdR/ilkFK66O2IcVG7aV4v+IJjjLpuFyFaFwY2H+RY289NH2bRmHuQg2pp
	ejKsYLlxLxVA16+wL4OhwilNeFTsVsKmQTOhNeNJzgZNLdO1lb7ggMiJXBZRqQYPsSnCTeUj52e
	L3fca/Q/xwwY/QNH9Dsd/NXzJUJR2ZA2n4KAN0VCrSZ7yIsmEd8+njLTI928OGrziJMZoK5Mpq3
	C8Rf7VvERW+YabPj3UcGagVA3EgcMXdxF/BTRZ5WFCKSEDcCH1wyvSEb8wR0qBBF9lYZokZNst7
	uoOzrdIqot1K/GWeG52003nVwiya6SMjO4D/K
X-Google-Smtp-Source: AGHT+IFc3x77JCPpppN1YJ06suXm3ER6hxqMJ4up28orCZYtW+PUTDVHjVq8Qsvz/TSIqyB49mx5tA==
X-Received: by 2002:a05:6214:2243:b0:6fb:5559:b3d1 with SMTP id 6a1803df08f44-6fb5559b3f2mr206878566d6.1.1750271429339;
        Wed, 18 Jun 2025 11:30:29 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:2c70:89ae:8cba:b38c:db3c? ([2601:145:c200:2c70:89ae:8cba:b38c:db3c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c31604sm75617506d6.75.2025.06.18.11.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 11:30:28 -0700 (PDT)
Message-ID: <3fbd1d89-3c6d-4159-b412-5f91348cc0ab@ieee.org>
Date: Wed, 18 Jun 2025 14:30:21 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20250618
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20250618

Notable Changes
* Updates to support screen 5.0.
* Add labeling for bcachefs.
* Various systemd updates and fixes.

New Modules
* feedbackd
* ipmitool
* fwupd
* needrestart

Full Changelog:
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20250213...RELEASE_2_20250618

-- 
Chris PeBenito

