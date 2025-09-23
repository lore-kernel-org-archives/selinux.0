Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40E1E0B9C
	for <selinux@vger.kernel.org>; Tue, 23 Sep 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640962; cv=none; b=ql2mIP0XhFqF+Kcq5tnWPnXe8HvNaqUTDcP7TcrmBYnZSTKIFxz2x6l0ZOWd9MNNcSJiOB/gsCH9Py6VofSzKpY2hGVRj89nK4sh0Fy49PEBlJj8/kMkgW4pMF4th7mmPp40K27gVeFn2OjZ44cir0gXSVsrZTsoq2ayyc0RcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640962; c=relaxed/simple;
	bh=MMRtDJwtHG5yKWr24G8/99hDhk+UTKCMK9/RTKDxNHA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=IhwgjnUF955dkvuozbBfARWdqi8Jh6JjAfXLeukXFefkL+6L7yacJZMu4frPB8kK0dKiSLzgtDCAVrCxNoah/uB2gBpAveUQfntV7xCrDu26EPoMbQYeWdGeKWQno/WuLnVBg0jWQjZ0pA4mwT0ayc+I1TR1UjvYgJmV88j/Hg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=BLn2Amjg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="BLn2Amjg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ca7a71adcbso18994271cf.3
        for <selinux@vger.kernel.org>; Tue, 23 Sep 2025 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1758640959; x=1759245759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEFctr+JmHNwxHeGiNnQBJMTV2oVjFbNJMTk7U+4s5s=;
        b=BLn2AmjgQElaZe1rzwBNxfOrzZYz/4QkvfxNKYAHldbK1Zm+uzn0ULR2B9gDCu5HgF
         PAiUZUx2I6FEdh8DsrJz8ZhX+Jrr9mp0+Eufmwm2v9BNjsKfrgZ6ZrSaMrXY22LHbz9s
         C3PPdNxwR1bhIO3fqPq0FAMJ7BLXXmDScrt2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640959; x=1759245759;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEFctr+JmHNwxHeGiNnQBJMTV2oVjFbNJMTk7U+4s5s=;
        b=HVvdB55df7BZ62vcq4VbRg+7cEmrDC3zgIJKnQmrC0nLqktPYMWSYIidTzXxfxG1kh
         GhKKCZMs8f0EgS5Uu/FJAbaq7fhx5Z2oIR6D87sGCj51+Ecw7HRiL+1bUvHOfjACtLfE
         N2Ooh/+TQSfEe1+tmD5T86S5zGG6fQ1Zm+HDKRfp+7CL6xFNq4wpZ82eJsW+T0e6tB5b
         BEdOp/GoGhgO4bZirBUx2H9+nS+P2b+692w0+BRNJ3xRMaGShvBddqS5hhRY+9x/9xV9
         J7qf4zKwi00PPF/2kzdmqBM57Iiqbgizx1yGsCimXimSGuqsf3q1OxXUQWxngqBkTIZZ
         g+gA==
X-Gm-Message-State: AOJu0Yy2Tqj3xRObZ8nxUe73ojFTHHZvx99qebO2Aue76uD9px0MEm7C
	D5BHsQYZ4rpN7Pr1NR5QjzYt1Mbuw1sCOB6TK1vloaFcxWH82tWeYtH3qdbg5EzwmMk2YvIkGlo
	nXuK+ICRjrl6xWiMFvKyNI1LEeeCguADxbumdgbzeEgpOSTjyaQIKXCulevJpb7yzTwW8tJz3qb
	idfuLgHjqJsrOCZfOw5SpR97KA0SUr4ax5dQ4w
X-Gm-Gg: ASbGncsjZvtAQdRIM4LmVNqWGHmzoRb/TC7Ilce6Vfi5ZSBUKKRhA7iZjTFOaLrqKJe
	Xjno1eN6eq1yVHQEAVoDkL0KWGaBtgoHVc1mZqvFq1yEiDO8+Xp1OtNGe+cwLGnAB+hk43YS4DB
	s5+bBQ6z3r2UL7nNZW3d+osp38MoW9mpy1axrxZOyxviSoPSeACX6IyxySueM8EfnW7O6trt8vt
	rY1LvvD0sYsqHWcKc8DFEqRxdiFJGk50r9y+ywldF1IQOqBCa/3h8rZM4jVroESv0AZ+RVjAxzy
	pzFpVLGnZARoh59QJgyPPsqCoDoHBpPM9CIS4F3ACE1CXNMY39qT+pjbJDSUTb1u75BTt2tsul/
	70/i/bZTBozEotwSj7V1mi/Ukb+XgZv28cyz67VoIJdNl3fAOJWAP/q6XxhVhHAxQhjkVXXD9OG
	ZO4+2JM+A/WAlzRw==
X-Google-Smtp-Source: AGHT+IFuy3EEXLKt7qvZoddOvI7e7NtFKt/I64qYcmBnmWsRaVQHmGJ9HdCUakEwhvny4Zp+g1hEpg==
X-Received: by 2002:a05:622a:13d0:b0:4c9:5199:b948 with SMTP id d75a77b69052e-4d370d5c4b9mr35218641cf.58.1758640959039;
        Tue, 23 Sep 2025 08:22:39 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:db86:5c8a:31ca:2959? ([2601:145:c282:5650:db86:5c8a:31ca:2959])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda23afa1dsm86441321cf.15.2025.09.23.08.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:22:38 -0700 (PDT)
Message-ID: <bd9f17c1-f593-4e24-a06e-a6bf414970c1@ieee.org>
Date: Tue, 23 Sep 2025 11:22:36 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20250923
To: SElinux mailing list <selinux@vger.kernel.org>,
 SELinux Reference Policy mailing list <selinux-refpolicy@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A new release of SELinux Reference Policy is available:

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20250923

Notable Changes:
* Several updates and fixes for systemd
* Add new permissions and policy capabilities
* Drop reiserfs support (it was removed in kernel 6.13)

New Modules
* bubblewrap
* incus
* kanidm
* seatd
* opensnitch

Full Changelog:
https://github.com/SELinuxProject/refpolicy/compare/RELEASE_2_20250618...RELEASE_2_20250923


-- 
Chris PeBenito

