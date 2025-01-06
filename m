Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959251791F4
	for <selinux@vger.kernel.org>; Mon,  6 Jan 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179190; cv=none; b=Lo1K5aPK67BX+5KeSPBTxdc0tIb67Aatz4EEWuoE0PSv6bQRXRHQ8xagsQ534FPTjVKVwQ8nUgi2SMT0TQiXMSXqpxv0UsthdvdW+FZc0NRmKjClcX1xxF8RFM3SaQZXriHIYGThFU1y/NWp0//OGIep5j/R4wzcFK7J38Pep4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179190; c=relaxed/simple;
	bh=6gnDGMIOxppdGHB/yf8LoNP9GKGmL4ydJ7hG20q8fZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB5xVEEdwRQXKSIwJnf5IIWBd+p03d8VKzfj5w592QD16inOo9JDitIw34XVe5T2vLuxEm/rubhADWVvX0MoTiC7BHWjcgkExrR+qB4f3EN7/hdfwAo89+LtzmMSYFP4CrMM+3K6b2Q2cBV5fVeX7dUXtmyQbraEZP4Z04OK4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtwJuadq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtwJuadq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436345cc17bso105364545e9.0
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2025 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736179187; x=1736783987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cL83fy9fUiyWAQO9Y10o5TV/KydC3Qa+Hru6k+93+SU=;
        b=EtwJuadquAmIwoOQBgAyqg6C4/KcuTxVUKV0MVvos3gZawxL8Ao2LnTu4BJh2viBLQ
         yTMDQh/fR1MtAJGQhtzEwfOHe+bKpVqgRf0PoekBrJwVpNUHmZgYwSQ9019qB6rVVO1b
         qRjD4LKCvCvjjDXJA/dFywIySAl4Ettp3X/L4Cyrmz0gJ55mDUeZjJnb6rj9oHkj1Vtl
         o8NoUWgIwmqaPeIdVM/GUClMzBu45BEO8MBSPwgL2c1V7gcCpAx00Htxro5auZ2HBYs3
         Zm4pr8oaT05eXu4M0jOyGe3gP6gZKXde5Drybyj8joAkk8BJAw3xajBgrgAyij1wwUQM
         1h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736179187; x=1736783987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL83fy9fUiyWAQO9Y10o5TV/KydC3Qa+Hru6k+93+SU=;
        b=PgTbjkFqz/WSFFQecbkizRA5+zFe6PEzJB6jxeSixA//QaquvRlJ6Ra/1KGprdlJW5
         AlmRPiAzic46khmiQ3k8X2O5SmkeXr0gjIKVDyGf8t58QLfB9S0T1MRDV4b6sUynBjJl
         bhtgwX046RTswJ2piZdkbnCEA9e8p8ri+Fd6dyRMddvL0yFoTOPSYN5aamhHA+dKeIwf
         4lbwDgr6cmBtUQmN5eVGvemhj0RxwUvhGiVpHUcGnD+/8lkGt10GfugL4OnkTzeqFCA2
         giKXwJUbFi391JYKigzZ61up06A9NJsvdwYmtHsY1qLSoVSDMvCbhkEoveKfLPODJZJl
         lw9A==
X-Forwarded-Encrypted: i=1; AJvYcCVMB5H66yUDadT4BCyt39I0ovwXeFwJgok/pWP30acCtRv7NU/GY4yKxEVteklLKwMFDLwv6W10@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KDIL0+C6xagUYrtzp14eCBClx159+JrUamM4r1b3s2TUqD0r
	7YBAvF9SvPq7ZZOwlXjlALpmW2EI60yBymBqPlMkWYTD6w/7LFwPACRoIDSCBJE=
X-Gm-Gg: ASbGncvJJebYsKu+fesfvHhhcPd2JQENqNw5uUZdZ+fr/W0fkDuHAKGnG8M/bNJeJVj
	HFDxP0eK66OQacJSX+31CHv0+ld+GJ9L7YB62inI2nB9iTeG1gHJJu9ggrBjiJOR/StDCKg6FNV
	BxSpxs80sHHwmxJbT9CrN169yEqttpmwY1fXlISAjCckk6ndF95pwKh6Ra8ZnA+aAEE8ducSdjN
	MNHrxZS9+eO5pmZkrNpmcSSkDb+KHzZNVhQpd21pe4YQ/z/4U2koLNBotzlDh9C8/k=
X-Google-Smtp-Source: AGHT+IFuwfTtqezqCyqXjnvoll9stdZwnDMHbjcpJGGm/Jkum+CB4+ty+n/TPU5uXnz6f5z8AKwJSA==
X-Received: by 2002:a05:600c:1d1d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-43668b5e172mr471554025e9.22.1736179186712;
        Mon, 06 Jan 2025 07:59:46 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b14f241sm535958045e9.1.2025.01.06.07.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:59:46 -0800 (PST)
Message-ID: <57627eec-10b5-4eb0-bfe2-f404a3492eee@linaro.org>
Date: Mon, 6 Jan 2025 15:59:43 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next 2/2] perf: Return EACCESS when need perfmon
 capability
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, will@kernel.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 stephen.smalley.work@gmail.com, omosnace@redhat.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <20241223070650.2810747-1-luogengkun@huaweicloud.com>
 <20241223070650.2810747-3-luogengkun@huaweicloud.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241223070650.2810747-3-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/12/2024 7:06 am, Luo Gengkun wrote:
> For perf_allow_kernel and perf_allow_cpu, both return EACCES when require
> CAP_PERFMON or CAP_SYS_ADMIN permissions, so update perf_allow_tracepoint
> to keep them the same.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>   include/linux/perf_event.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5d2ec4283ebf..c1bc0d7a275b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1685,7 +1685,7 @@ static inline int perf_allow_cpu(void)
>   static inline int perf_allow_tracepoint(void)
>   {
>   	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
> -		return -EPERM;
> +		return -EACCES;
>   

Is this necessary other than for consistency? If not it might be best to 
leave it inconsistent even if it's wrong. I see quite a few "if EPERM do 
this..." type things in Perf, so changing this would break error 
messages being shown to users.

If anything, EPERM seems more correct because EACCESS is more about file 
access.

Thanks
James

