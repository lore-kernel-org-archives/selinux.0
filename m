Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0101AB501
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349679; cv=none; b=tOHartSMDuc29x5cf+OxlkacW5P3D3cG2lr5brrOZqlBOLgHcpw7moG/VwxKVDVHq0cx0VkhQqc5k5OxB0UipN+rUN8bws9hekxOb2tJUX4ZBeSLj5jBq0aqOHp6QvGfZk8d8y3E50aFPHXSbA5sOIv5SYzQt9F9pSdYUUDA7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349679; c=relaxed/simple;
	bh=Lg1KmTu4CP+ujYbYYnn4g2HSjXM04jtn276K7f8dWJI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=OENetDFJx/sv32gruk6O98bC8boof/MjCsbLzRldB7fRlvkoAsoHWFS7vT/UiC0jpA+zsVIviuG1LgX59PlpteM5dXG/qG8RVH3H/R2hbFLCp3P5AFQEYR/UOwX6h+DgF38tkhxoM2y3ay8Akoi4B30oGo8S6L4ufsceE3jClhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egKDUVBD; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egKDUVBD"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5ffbc6acbso2868522b6e.3
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 10:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731349677; x=1731954477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSrIYMkSjgBJbwohOII5KOi6OzEMAiOk0etEQMK5fRk=;
        b=egKDUVBDpX74nZZR2ebM9mYsEpwfDCKjHwBtCkDV/wCL7nT0RGrONQYPt45H20lYZH
         16qEUzujT2KF2l/uBCSOZb5t2rUw6HI2cQcRJCuE2TrbZA82qSBKW5LpGcedUs8XVxhv
         1DqYZLu5Y0Fxd+U+uF7PgfkJpphxfgvr4YKdjhiBvN8mLXR66Q3XJorzejY4fkZaixoB
         G2YU3l3dF+Xafb+6y9rYSPMESC/2hBcbziuPyztMm+SrHP70WBLPs5BwZykn3oN+XU5v
         jqa/HR/VuImgsKYavRt/LozYTXhHoWsekawHY228lw1vcE+JtR701MQjO3kjh+wtoIZG
         CexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349677; x=1731954477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSrIYMkSjgBJbwohOII5KOi6OzEMAiOk0etEQMK5fRk=;
        b=qrlob7U+wIqpJXblQGEqsCPf4d3zLFDT38MY8eRoBiEvGtXrLHSODQANkEN3t2WjZ+
         M0A2slktr/HwRywZWXS4HHFsrnOkStlAPQjzL1OU9UY7dplgzHmi829m+OTC1V97r8EN
         VuUGgkGZo5OWzPK3+D/Kb2OB7GDoadqfBE36BB2sjKIoe/uJCXFgm81Fq5bXksXJzlLT
         dvwnwiuWZNo6iyv318YOKkHtp4pybdvEw96cvjNtkc3VzidGo+Ebd0Vo7xnTml4O+R3/
         sEGS37NqQBAenqc7/15u0NKneRJP9mQ6fMVAqmazC4uHDz4yT6eonIbdQPu3WS3edkTQ
         adIA==
X-Gm-Message-State: AOJu0YzzPu/+l1LNGhB3ZRARmufNIMB0mlIFDxo8q0/5WFKEjEq6gSSN
	jyU43je0UXDot85YXT4NMBuI38rY9AizuMHdJ88gGgYnUVMpoYESIV42HRIN
X-Google-Smtp-Source: AGHT+IFa58YQZEPT1KRIR7UI9YNwy8tWb5/65p1Vrozn7klMMqSnf9Mh1cuT1hSggwlqr0H6QG+jMw==
X-Received: by 2002:a05:6808:3194:b0:3e7:5ab1:35b4 with SMTP id 5614622812f47-3e794706397mr12513453b6e.30.1731349676787;
        Mon, 11 Nov 2024 10:27:56 -0800 (PST)
Received: from [172.31.250.1] (syn-192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc677bdsm2184413b6e.3.2024.11.11.10.27.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 10:27:55 -0800 (PST)
Message-ID: <9fae3474-2b18-4b4b-afc4-517b73548e6f@gmail.com>
Date: Mon, 11 Nov 2024 12:27:54 -0600
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: SOLVED: Allow rule not having any effect?!
From: Ian Pilcher <arequipeno@gmail.com>
To: SElinux list <selinux@vger.kernel.org>
References: <3df128ad-cd76-4fea-a905-60d7f02ca4ee@gmail.com>
Content-Language: en-US
In-Reply-To: <3df128ad-cd76-4fea-a905-60d7f02ca4ee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ran the AVC through audit2allow, just to see if it would give me any
clues, and sure enough, it actually did.  The problem was that the
SELinux users didn't match, i.e. system_u != unconfined_u.

Ironically, I actually hit this exact same problem 8 years ago.

https://selinux.tycho.nsa.narkive.com/lPRcuGbE/cannot-write-policy-to-allow-relabelto

On 11/11/24 11:30 AM, Ian Pilcher wrote:
> I'm either missing something incredibly obvious, or something really,
> really weird is going on.
> 
> I have a policy module that includes this rule.
> 
>    allow runcp_t etc_t:file { create write setattr };
> 
> And I can see that the rule is loaded.
> 
>    $ sesearch --allow -s runcp_t -t etc_t -c file -ds -dt
>    allow runcp_t etc_t:file { create setattr write };
> 
> Nonetheless, I am still getting this denial.
> 
>    type=AVC msg=audit(1731345803.780:3765): avc:  denied  { create } for
>    pid=289668 comm="cp" name="config"
>    scontext=system_u:system_r:runcp_t:s0
>    tcontext=unconfined_u:object_r:etc_t:s0 tclass=file permissive=0
> 
> AFAICT, this makes no sense at all.
> 
> Any ideas?
> 
-- 
========================================================================
If your user interface is intuitive in retrospect ... it isn't intuitive
========================================================================
