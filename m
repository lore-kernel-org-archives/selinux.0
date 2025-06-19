Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C41E7C1C
	for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750368185; cv=none; b=pGcV63d7+u/rd8BblegwNHA/WZRmcRcahmSzqN51/U1HLrwKXMQme1HttMPQXCGWU+wyZObZ467ySYwQtNNsJIEVUt+y01iAPbOMKygkE3eK3sS5RQPY90cenuXyo2trlWAr/LxH/EbvRLaARqPi2XiJJqlfeN2Gl0hcRRaj8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750368185; c=relaxed/simple;
	bh=Hfs8VqEWcCkQM4IMbrnLuaQZYIHU/H3hYNlAGG0dkYs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Xi75cXrZL5/ZJPNu31QYZzXA669mzP4J9eNgV0CCdoqDCtNiqbtbydW0Do1sBB9t80pD2VlYsdw5PiJ40JMUt4a7O2N3qSm6oob/9qzyI7aRhRCuDUzOAbTH9KG6F/DksRi2nkymQSQzYzPvMo6KbYlu+WCl90iRHqvw3Pwsn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Epq0GSIH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Epq0GSIH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d2107eb668so200227285a.1
        for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750368183; x=1750972983; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvfMubSfTeQXEEqR8xwohfWbwiB02+hyZJfwBxcWhIk=;
        b=Epq0GSIHu2/6XXLmrbmmVkjsDAG6UYYW/lRFofyE5sgbV9nugl2Iu6QfiEuIeCZ4JM
         bcagrEgnaaVAokvziidD7HgIvBzWe21YVYBSYUO8Lbx2MKOrHIUORuT+/HlTGktQgAvQ
         Z8OXpDVGsdSOlk1gg1rC7X/WVUsO77/HXClUvGvyvA2CZIojC8M3j3ZHHQ2UpSWaIcge
         8LdM10mVklooKRQUUzmtPIX2sSEMdH7dBUH8bNuSOq++Q52PjcBaNpTt3ie7TWAKW/jo
         f8yEt3sRTT84FSSDhCzRrEh1rb5Bl/oir+aSwlQhylpczH192KVyQ2vbxBOg3hXXwScE
         VePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750368183; x=1750972983;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZvfMubSfTeQXEEqR8xwohfWbwiB02+hyZJfwBxcWhIk=;
        b=EliFylVobtGslCj1FE/SiWFucbqOlKBFT0IGzH1WZujmdsO9MnGWswNh+UR4ZLQ6UE
         KBzqu+JPEAtgCg15Wz6Y52JgbRohVMws9QqUN2/YkU3UczA6hYGvCqI+PL2MyzhSOGxP
         mjoqwsUPOjkPeRAGf3Wo+yZ3FWEJXRTuK5sexAgLvYWvu/nbP8PT/DESE7rIhtlJ0MW1
         C76Sk8iP+62SmoxwjIF2ok0ZYZTTx+hH5AKZHF3bmmKuqlaI6hk630RfbuZsAv1sxyw4
         03N6OpQpeRnbwLKCPlrVGz58tjd397XtZOECO/r66L5/tKbCcWmWwPn1j1AOZ2IF86be
         xp/w==
X-Forwarded-Encrypted: i=1; AJvYcCU02iGP5bKcXLoRmJyI1N00g4QCRvFcSrzbY+Bb2APwio3HhcrWIUiudxSx4bsSrsSl+NVdmHWP@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7xFvIPqVLI7Gr5i+XVBXvzMU1UZusjVzqYBq7ev6rQL6GBZd
	AO15MKpQIdwqY1RlEs0TAvqDul+tsJXHWn439wbmrYAvuIp6wgq1Oj3knXUB0vfq/A==
X-Gm-Gg: ASbGncvjA/NTb3vU0HComsGbKIe36XeofIsAuMDsnURDEG5ZgFi1vmw3A/cHbOTHk9K
	E6we7V9i9CKrT3xV+Bmlt3a1N8rj14fTZ85PJqBPMFTFyMZCQjRS3G8j7c4fCkWmYkkkL+xktx3
	kOogtp0655Dy4lJK0snovRnJvLA7Ip14MNqVpLTO9JfSPXX3rnPr9Xda3Ff+mRBMYP/4+G/U8g6
	47ePbHybBGfsOS6s/ZWYIUQLYXgx1t+VTvrKm+3aeMQ+ESEtiXDXilDLIcPhBKw+Om1JwWZ2yey
	x1CDFrl6nra4TEnSjpLX59rXZrWBBvCEGJgVOFPj9biFjrpqYHmZulPL7dyH4V3rBXlO0IyPDnq
	6ivRV4SeroH/1P+UBEEVhrxBo5ymOGVE=
X-Google-Smtp-Source: AGHT+IHAWjnLbhK7L8TQ0blwVFjqg4LS22cu5+Rg7EvYsHB39KhenjZ2LLgA/F81uq0JbAm1qLwmww==
X-Received: by 2002:a05:620a:2605:b0:7c5:3e89:c6df with SMTP id af79cd13be357-7d3f98ca8bfmr87132585a.12.1750368183179;
        Thu, 19 Jun 2025 14:23:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3f999a156sm21946885a.22.2025.06.19.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 14:23:02 -0700 (PDT)
Date: Thu, 19 Jun 2025 17:23:02 -0400
Message-ID: <874b27417084cce57c50f145aeca80d8@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250619_1608/pstg-lib:20250618_2237/pstg-pwork:20250619_1608
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: introduce neveraudit types
References: <20250521144123.199370-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250521144123.199370-2-stephen.smalley.work@gmail.com>

On May 21, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Introduce neveraudit types i.e. types that should never trigger
> audit messages. This allows the AVC to skip all audit-related
> processing for such types. Note that neveraudit differs from
> dontaudit not only wrt being applied for all checks with a given
> source type but also in that it disables all auditing, not just
> permission denials.
> 
> When a type is both a permissive type and a neveraudit type,
> the security server can short-circuit the security_compute_av()
> logic, allowing all permissions and not auditing any permissions.
> 
> This change just introduces the basic support but does not yet
> further optimize the AVC or hook function logic when a type
> is both a permissive type and a dontaudit type.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 eliminates all references to "unconfined".
> 
>  security/selinux/include/avc.h      |  4 ++++
>  security/selinux/include/security.h |  4 +++-
>  security/selinux/ss/policydb.c      | 19 +++++++++++++++++++
>  security/selinux/ss/policydb.h      |  2 ++
>  security/selinux/ss/services.c      | 20 ++++++++++++++++++++
>  5 files changed, 48 insertions(+), 1 deletion(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
