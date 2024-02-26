Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48012F5A1
	for <selinux@vger.kernel.org>; Mon, 26 Feb 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975643; cv=none; b=We8fOwEDHgF/0867vaO+D9R0u+OSzqdm1t1EosMOVFOoPwJ3iZwtgVC01w4VElcJWul3hOjEfmmtzvz7EUboU+SDLndMo2xPQPYlAeNKEew3T3uVGdA64RJrEv4Gu5WnPNFXLpRBJCR+NXs6QKX8pAvqpadriaA8+4W72GxirYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975643; c=relaxed/simple;
	bh=1mSQ+FAC925lDxW8XQMAf50wpPuYE+kx8jBCDfMuZMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=h+6tVV4XrB9uPuoTs//3CYKI7BNWrIPsRoZEXkDRewLfge9YT1PPnOCCAytavxeYKaClDT7pvNnFmaFsDkQZLDgaTpf3eDrS5K/18mTF27gxsmr3798nOgTiUEzrnkqEmHMz3YwfWxQiNxvBthVtXUxjPkaAvrjBsz7/miH04lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=ZXRkr/Yl; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ZXRkr/Yl"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4cb26623dc1so461623e0c.2
        for <selinux@vger.kernel.org>; Mon, 26 Feb 2024 11:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1708975639; x=1709580439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rFR6d/NL4IVp5TKIUbkOgsk4rCgEbDGj+g99IIKwAE=;
        b=ZXRkr/YlqTPSsRPg0+XlJZBjnplBVu1pBiBUvxVKhlrCrIcUBqsrzdSIHYaS4GIg//
         sFKyAe/dD+kGTUQGzRrm42OvhmIq0/3pawE3uC+yyTYuIg9wHRM1/JzVKNvmZlg7mbi/
         kJfXrjC76GcWLbjSmujsy8B7WhxGaom73NAlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975639; x=1709580439;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rFR6d/NL4IVp5TKIUbkOgsk4rCgEbDGj+g99IIKwAE=;
        b=nxxwT2RRHbghO7XsgZYMRVugSbqsLqKneZat+ZKRHFsLenMXW/kErLs5dGjOfzmeXe
         MtS+MutpR/wFnSvuy/idMNAy6QUj8pe6XPr8KKDn8aOQmE3O6G/4FpX9BSVRtzvfYaY8
         rOMK53ZbsenSzfEoxYfMZ7QEKon4oKVhMG0oeAMNOGhBYCKgOWGZ06XPrlI+9FhIqeTZ
         FMlhFQVfScgR1hS/BYQrr/PXXwMw664uq+LvUcpAyBP4xlT810itQqVvtw9qdToytJ2A
         vSSvf2BS9GwjKoONhVv+r+YzDy7PZLsPOIKpb7S6EYkrJW3pbSIEFFxqH2C8ji5w1qGX
         Pkkg==
X-Gm-Message-State: AOJu0Yw81bHKQNmTEhkawho0fwxL8jlp+0YLL1DZYWJydRpc6cGrIz7e
	B+AVm1ftInrPiD0ot1Y2iyOFdLeId/sCGdcsbxgFBm+85SuvrKdlKgFyiRqzxufoLuEoQxZ7UI7
	EAvTIN5put/flkJBpIsXDHcZAWuDJ3iMAloXzcU8cKNPKiC7Ncdid8S2pF0qtC+g6/Sa2dVEvDO
	qoRtzksRJmMke+WFp7Q6MLwctA7yGR41FP
X-Google-Smtp-Source: AGHT+IGGa0gUR3icb8PHLgJ9LoW/l5dEaIKZ+D53EXmkiKWLu0bDgwwVoLmemv2w9hTJGwIpUpZ0qQ==
X-Received: by 2002:a1f:e044:0:b0:4c8:90e5:6790 with SMTP id x65-20020a1fe044000000b004c890e56790mr5045464vkg.5.1708975638755;
        Mon, 26 Feb 2024 11:27:18 -0800 (PST)
Received: from ?IPV6:2601:145:c200:960:fdc0:2d2f:c29e:305d? ([2601:145:c200:960:fdc0:2d2f:c29e:305d])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068ffe48ea51sm2041133qvb.36.2024.02.26.11.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 11:27:18 -0800 (PST)
Message-ID: <5c9ed2b7-e680-43b1-8308-c3d4db3a2713@ieee.org>
Date: Mon, 26 Feb 2024 14:25:13 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20240226
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new (very overdue) release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20240226

Notable Changes:
* Many systemd updates up to v255.
* RPM and dnf fixes
* Tighten private key handling for Apache
* Many container and kubernetes improvements
* Add support for Cilium
* Update object class definitions up to io_uring:cmd.
* Add additional rules to cloud-init based on sysadm_t.

New Modules/Domains:
* cockpit

Full Changelog: 
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20231002...RELEASE_2_20240226

-- 
Chris PeBenito
