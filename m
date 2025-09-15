Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA2F22F01
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964405; cv=none; b=uSCqZPEbz2sfqeUB3F1uLn46XklzCEOwPMHJX089VqFJejRXnal/Sh1iiWRVLdpok9X/qs/ox2hcDYXK9gXyFAygftnKnTou3hk9faJa7O5vPpfKDnX6DS4bC2UCjN1Hgl3RVB5hgW1YGQVJ7gbh657Z/awNpyD+9amd/kIoOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964405; c=relaxed/simple;
	bh=uYHKIzkxJB/TtqGmfnEErqUyqrcKbT1tmng8ySe15qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyQZlUCkQY2cSD9O+OycsVCSBydY+mWF+y9irSqwOxOW2mofX3MyxixHvcuIKnm6fUdAtO57FCDRXV/QtTTZQIXulUcDQaPt2d5P7yphNJeqbezrm6XufHvra0+TuJNNtBwsPuYwHtHl8It7YzVWeYAgTZSsVEvBI0k2T6KwWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=di1JWKk8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="di1JWKk8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so46333941cf.0
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1757964402; x=1758569202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK29zNR8X2g0GPqsYOKd6t3kUx5iewNeb7/RXfMPj/Y=;
        b=di1JWKk8UrFQZ3SBmw30bNNycCP4f7598wbki/3PgkAJsAjbbOu4+/CFv/bHXzMYR+
         yXkHYd+xlEa7qHbepZ1m/m4Tz3t4vJI24zn253r8/V1YiCTnkEok3ce4sqovkNx5B3E4
         PccBIWVKm5TPywLooarqHxK+ec5Ri6jNaRarw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964402; x=1758569202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JK29zNR8X2g0GPqsYOKd6t3kUx5iewNeb7/RXfMPj/Y=;
        b=otLTbHEB5B8S8XsRgAYzVRgW3KjGh/izUWP2WyVzelU2AQKsxX7JG/CBSXZq64ASsy
         Bfl86rw35AB2ss3UNKG+HRqXn7Chjg25yzQIwEJ8tkTCh4NiGEhph+GStlVqiBbxj32R
         GYCsO1qRACN8oxB3lp2VYhwT77+lcuSvXUFOhXr12VTcsz7mC8cndzOqe91I/Py69wUa
         Sl236uX24/2/YjQnBBtMJJy8sFRTbjFdaZqJmpmf0YMdmy9D00W5fbPwHAoUexc4+jUA
         QtTbEhm/h3fRA35GNKEZgjhZAAnqkNg1/cG8FMej6NVJDJ0G6F55IPCxNUSNyBAO4eEs
         pu5g==
X-Gm-Message-State: AOJu0Yz8QIV2Pu1MmGf95+82C3hlDXd1hEKo8wgx5u2I+HWpQpNIK4e8
	X0tX0zxBdxggdBA8EN+tTbxsgrHzY78OTPvX+DAuES/vwYB6221V/k5t6aWLF5+Ltw==
X-Gm-Gg: ASbGncsB9ZSvKHMjAwpNFiPpvIDN73dl8+qXc+MluuiKfdzN+ZyX6p7wnlaMxLhLYwK
	mbYJ1YDeWUdNznKuR41UD9CIFuIh3DOC5HjxPRpz7fIyQaye+fmQau+GsdZ2QW/yZezDHPSRk+Q
	06iM+z2Hczssyaim1T4R7rkVGhipufx2CdWBola9oSDrvRWlbyiyjG/rpQyUVgxLnToX3Oo4pCW
	0dwcv7oa3JAfeFmnb+SqVglgK0KtKBNIA1vbi8eITQvrLinG4+l+tm6vOb8cGWX4pcFlJPE4V5d
	+KvbhvIqrTB30yEI4C5dgyh0wsTRPbr16gPVzlGeC/8r68snOAir8rFqeKbJ0hFPVTRKjIj9a1V
	mjR2EUQUS3RxKfaf1lnmRThz9D+PLimNSTPcAuI6hd/bShSav7S3iOih7uE7Nxfre0dMb1X5PtI
	5OC6lxIDDVMXU=
X-Google-Smtp-Source: AGHT+IGsW1lehV0aBkP2EVfCqw8/zXlw3gtIgAukVtQJ3wSTapoUmwy4UbnPuKk0JvwU48fDrtMWmQ==
X-Received: by 2002:a05:622a:13cf:b0:4b7:8a96:a623 with SMTP id d75a77b69052e-4b78b13906dmr110577561cf.19.1757964401430;
        Mon, 15 Sep 2025 12:26:41 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:b902:615a:edd4:262? ([2601:145:c282:5650:b902:615a:edd4:262])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dc8d9bsm75382851cf.38.2025.09.15.12.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:26:40 -0700 (PDT)
Message-ID: <1ea8829c-7b4a-4048-8045-768b5af70218@ieee.org>
Date: Mon, 15 Sep 2025 15:26:37 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lack of official hosted macro documentation
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ian Pilcher <ian@penurio.us>
Cc: SElinux list <selinux@vger.kernel.org>
References: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
 <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com>
Content-Language: en-US
From: Chris PeBenito <pebenito@ieee.org>
In-Reply-To: <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/2025 2:01 PM, Stephen Smalley wrote:
> On Mon, Sep 15, 2025 at 1:56 PM Ian Pilcher <ian@penurio.us> wrote:
>>
>> TL;DR - Writing policy modules is harder than it needs to be, because
>> the documentation for the macros/interfaces in the reference policy is
>> not easily discoverable.  This could be helped by hosting the generated
>> HTML documentation in a location that would be indexed/processed by
>> search engines and AI chatbots.
>>
>> Over the weekend, I wrote a policy module that allows a containerized
>> service (running as container_t) to access shared content
>> (public_content_t and/or public_content_rw_t).
>>
>>> policy_module(container-public-content, 0)
>>>
>>> require {
>>>        type container_t;
>>> };
>>>
>>> bool container_read_public_content false;
>>> if container_read_public_content {
>>>        miscfiles_read_public_files(container_t)
>>> }
>>>
>>> bool container_manage_public_content false;
>>> if container_manage_public_content {
>>>        miscfiles_manage_public_files(container_t)
>>> }
>>
>> In the end, it turned out to be extremely simple, but it took me most of
>> a day to do this, because it took me that long to figure out the names
>> of the macros that I should be using.  I finally discovered the
>> miscfiles_read_public_files and miscfiles_manage_public_files in the
>> apache.te source file, but that was only after I wasted several hours
>> asking search engines and AI chatbots what macro I should use for this
>> purpose.
>>
>> I was pretty sure that macros like these had to exist, but I was never
>> able to discover them through Google searches, Google Gemini, or
>> ChatGPT.  (Google Gemini hallucinated a non-existent fs_read_access
>> macro; ChatGPT did a bit better and referred me to
>> files_read_public_content, which was real, but has been removed.)
>>
>>   From my POV, the problem is that documentation of the macros and
>> interfaces in the reference policy is *reference* documentation, which
>> is helpful if one needs the details of a known thing, but isn't helpful
>> in actually identifying what thing one should use to accomplish a given
>> task.
>>
>> Fortunately, search engines and AIs have become pretty darn good at
>> processing reference-style documentation and answering "what should I
>> use to do this thing?" type questions (occasional hallucinations aside).
>> But this only works if said reference documentation is available for the
>> search engine/AI to index/process.  AFAICT, the generated HTML docs are
>> not available online anywhere (at least not anywhere that seems remotely
>> official).
>>
>> It feels like having this documentation hosted in a place where it is
>> visible to these tools and given the appropriate weight (i.e. not just
>> a copy of the docs on Joe Rando's web site) would go a long way toward
>> making these macros more discoverable, which would make it much easier
>> for policy authors to use them.
>>
>> Thanks for reading my screed.  :-)
> 
> Great idea. I thought we actually used to have something like this but
> am not finding it now.
> Chris, any clues?

We did have some generated pages, but when the project moved to GitHub, 
there wasn't a place to put them.  There hadn't been any requests for it 
to return, so I never looked into it.

`make html` in the repo checkout will generate them in the doc/html/ 
directory (from the repo root).


-- 
Chris PeBenito
