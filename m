Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38DEEB3;
	Tue,  7 Jan 2025 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214379; cv=none; b=bSB6HDVs5b38bLT3wmau9C7ps2/hI2YeN+B31w5LQ0xuD+RdhFTU4pgymIfnsK6azGorRuRGQJlcXnKmIHdvLt/zQFQgYc5e8I+fnqRBb9m5Zr/KpGQKJ52FKVUr0f+Rm5JCHMw6ViQs+8vUy6JO05GRj5F2eradJ1IP+uCUIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214379; c=relaxed/simple;
	bh=r1KbG9wSdDJSVyW3QdygxR1AvrQxMBsxsSLcBOEkTw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIUVfQAr6vVJciQXQOkoNWFa9FSfZUuOfCByuSJ2R4dZrjptNkprMK5F8/4hPsyqMjP2Gy7F2aKcS2eUIVDhpVOtL9AaJn1NfBS7GRfj+TAUWSwtq5Ugy17gBcSH3S5ZgFxqqmmfQ3/cMN7XJ4+G36Dut6ouvRbVjapgqfhlFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRv5N5BP3z4f3lDh;
	Tue,  7 Jan 2025 09:45:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 086681A0C24;
	Tue,  7 Jan 2025 09:46:06 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9ch3xnFggDAQ--.39405S3;
	Tue, 07 Jan 2025 09:46:05 +0800 (CST)
Message-ID: <f035cbed-bff9-426d-9da2-1bc34ef644d3@huaweicloud.com>
Date: Tue, 7 Jan 2025 09:46:03 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next 2/2] perf: Return EACCESS when need perfmon
 capability
To: James Clark <james.clark@linaro.org>
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
 <57627eec-10b5-4eb0-bfe2-f404a3492eee@linaro.org>
Content-Language: en-US
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <57627eec-10b5-4eb0-bfe2-f404a3492eee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9ch3xnFggDAQ--.39405S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Jw1xGF4UAFW3ZrW3GFg_yoW8Wr4xpF
	s3Cr1YkayxKr97A34Yvwsru34UJr4Ivr4UJF9YgFs8AF1YgFZ0qF4UW34agr1DuF4xCayj
	ya1DXF98urWDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/1/6 23:59, James Clark wrote:
>
>
> On 23/12/2024 7:06 am, Luo Gengkun wrote:
>> For perf_allow_kernel and perf_allow_cpu, both return EACCES when 
>> require
>> CAP_PERFMON or CAP_SYS_ADMIN permissions, so update 
>> perf_allow_tracepoint
>> to keep them the same.
>>
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
>>   include/linux/perf_event.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 5d2ec4283ebf..c1bc0d7a275b 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1685,7 +1685,7 @@ static inline int perf_allow_cpu(void)
>>   static inline int perf_allow_tracepoint(void)
>>   {
>>       if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
>> -        return -EPERM;
>> +        return -EACCES;
>
> Is this necessary other than for consistency? If not it might be best 
> to leave it inconsistent even if it's wrong. I see quite a few "if 
> EPERM do this..." type things in Perf, so changing this would break 
> error messages being shown to users.
>
> If anything, EPERM seems more correct because EACCESS is more about 
> file access.
I think so, from the perspective of capabilities and 
sysctl_perf_event_paranoid, EPERM is more appropriate.
>
> Thanks
> James


Thanks for your review.

Actually, I am not sure if it's typo or intentional, so this patch is 
more like a consultation. It's okay to keep it the same so it doesn't 
torture the user.


Thanks

Gengkun

