Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEED481225
	for <selinux@vger.kernel.org>; Wed, 21 Jan 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009127; cv=none; b=e8rOxLfz0T6SANGEshRibOTMPqhfWSZT7MmgqtLLFlod5KEB1WtX5pwLIPqHEZP5Hc3HlBn8KcTpe7SxZ5wG7syc+6EVs4d16QFwtrUSAzGvniq99UmijOfno1jawr9YpsiV+7kFB6/yNYdVpCk3lokmG4WHMuAjVrTAzrQYI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009127; c=relaxed/simple;
	bh=I28lZ8uGfEZzT6PVdSlBc93gOfZgY894ScG4Hunp6tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S6s2GEjV/+eNkmSFiRUiYYs6E3NV3hrCus3nGbCDzgAjIeUwJ8Z5I6OqXb0v9BPe+2qB4mO6/51jdpRVe/R33oZ90qKQ80h8BIAzHSVB3LLS+6qdR92Ht+W95NoO+rJ6B3tIW5qcRiKh33fD9JdAkmhZbcoW9+nV5NafyexioV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOto8TEk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP2Qda6l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOto8TEk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP2Qda6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769009124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JArNFph+cXC9KhfJvR0KgN3ElV63Ko7Y1GVL73fRYw=;
	b=SOto8TEktkqyLVenqLjiQw/LcRT130AKGwW9f/isC9waVneNDz4nWKYZxstzGJg+3fe9HA
	1nfo88qn8dJisZjf17tNc1+wa6lcbJjotTnjybGSIlOadLCr4POVUwqPCUxA/OmZxDUKG5
	gkqPICwYbA6v9W9Q0YPwr4+nex9W0RE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Tpy916lpOkWC57PwlI3AGQ-1; Wed, 21 Jan 2026 10:25:23 -0500
X-MC-Unique: Tpy916lpOkWC57PwlI3AGQ-1
X-Mimecast-MFC-AGG-ID: Tpy916lpOkWC57PwlI3AGQ_1769009121
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432db1a9589so4449027f8f.0
        for <selinux@vger.kernel.org>; Wed, 21 Jan 2026 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769009121; x=1769613921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JArNFph+cXC9KhfJvR0KgN3ElV63Ko7Y1GVL73fRYw=;
        b=CP2Qda6lI3PjEJokaE5LyB250maKAhb3C5+EkkNmS0aUksnVxw3nSOvZ9vKPLZ6tfX
         Uty8AVlSEV14GYEfWF43BDvlspQw6VSaZP5jNnGRIEt9JkXbwS7/tFsmXk7WnX5oBlqS
         n694sbwxQKjo8FktxMCuIgA39tNSH2u4uNjSYXVvbEe7lmzoQec3iqHl0ci75u4rGb0l
         UQ3h9R/OZLCA1blNX9waN4Dxwyg/DupWitjDdAcxx8oUE2fHSN+QdIWt3y9bfqoQZSmO
         KLL3cFRglacsY6oBkyv8ECHzR51JzTYdlvy8ZMx7k7HwkVtXCbJf51Pnf8/caCVxSzVi
         +Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009121; x=1769613921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JArNFph+cXC9KhfJvR0KgN3ElV63Ko7Y1GVL73fRYw=;
        b=MTUk/xX71gMBoYVjmRRDHdn+6IcQtiEk82vXZVTW/JzjX5VBSoZh53TJ1fKKtXbNZm
         O1KdW4W9Jo2/QA36ls4S4iKOsjZnmjTYW909lQBIgjgoW0FU2M0nh6ATDNpbWnnG8jZY
         tSAyfOFZbkYl3VomzKLEAdHFQc20Pzk9Lxd8/F+xqNqMkigVtwQDj5uq/dMrLKQLK0IV
         dvu+EUmbZRwGhpzGUH//cFGHhb5m/Q0n3CgF/rhgc9/2jMWMzgqPbfgCjxqTP/Ddinko
         j9n7ukei1IMS19iILAy0mruFv4t4hyO56IwEMyRco8/P1+30MpS2xm+pD7j3M6IXPTXR
         9QZA==
X-Forwarded-Encrypted: i=1; AJvYcCWt4SiZSfhFgZ2PAsbIfTiS6SH7+rC/WRuXSAyK/n8mzun43KV2oW8pOaHJO6yvU7t7dCW5Rba1@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6D96uIA9QEIJ3mlwOCJQlU7McKqhJbSDU4iVVTHMnV4d176F
	kvlaUIh8M0yF6VqnwZLfghCR0SBHUAIOkSpQKKrWFYz7vLmJC3iEuI61zkQiQ/w5eSF29H/wn1y
	9iG9stEt8VKMRb7SimxwyCsCzgOttpSNubCBGKnW08K4kOV8aXkHCZXkMgdw=
X-Gm-Gg: AZuq6aLzGhUQw7gvwew7h4uhuh2T3TLONDcOfSikh0KbcFiKCfBfhRIM1abDrXMDbfZ
	DwzUM5z4uyx/HlvEZP9/9oljfpOjUhNce3aDVMWW7IB2qvJU0/Jll4L7Eq/vS5kRY/PfI+hokCF
	7iWMGQcs/AQ3EpmgrO4qfbXS0ryTREshYx+ljcvIVNgCVCHhX5GoF9Ga7yQG3AjqSUQwOHrXYbk
	ZoTCnJ5TJ8oRPQ6N1UnH5KLtK6rn2+N8BTW2Sgn7M49PR1bjKeU8bT83vIk+atmlB1K0yoXzfz2
	VNIBbCs+fZXaK60hnEJzG1CrTSC0MhvCgl+J7ZXfV4ZAXJEP437VHtoBHYGZ2CY8lTXts/8bdjI
	=
X-Received: by 2002:a5d:5f43:0:b0:431:4b7:a309 with SMTP id ffacd0b85a97d-4358ff4477cmr9592168f8f.20.1769009121005;
        Wed, 21 Jan 2026 07:25:21 -0800 (PST)
X-Received: by 2002:a5d:5f43:0:b0:431:4b7:a309 with SMTP id ffacd0b85a97d-4358ff4477cmr9592121f8f.20.1769009120545;
        Wed, 21 Jan 2026 07:25:20 -0800 (PST)
Received: from [10.43.3.233] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm38421360f8f.32.2026.01.21.07.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 07:25:19 -0800 (PST)
Message-ID: <f4f9d222-6d93-4fe4-a3c5-94abf58def03@redhat.com>
Date: Wed, 21 Jan 2026 16:25:19 +0100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Ignore files that vanish during relabeling if
 ignore_noent is set
To: Johannes Segitz <jsegitz@suse.de>, selinux@vger.kernel.org
References: <aWe3J9UVT9WIBiuF@suse.com>
Content-Language: en-US
From: Vit Mojzis <vmojzis@redhat.com>
In-Reply-To: <aWe3J9UVT9WIBiuF@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
does this still happen with 
https://github.com/SELinuxProject/selinux/commit/54c79a74f5b9154762abaadf8194665598b24115 
applied?

Vit

On 1/14/26 4:32 PM, Johannes Segitz wrote:
> This happens e.g. when temporary files vanish during labeling the file
> system. I don't like it that this is now in the err: handler, but
> otherwise it would need to be repeated above a couple of times
> 
> Signed-off-by: Johannes Segitz <jsegitz@suse.com>
> ---
>   libselinux/src/selinux_restorecon.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 7ef2d45d..6c55125c 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -768,10 +768,15 @@ out1:
>          freecon(newcon);
>          return rc;
>   err:
> -       selinux_log(SELINUX_ERROR,
> -                   "Could not set context for %s:  %m\n",
> -                   pathname);
> -       rc = -1;
> +       if (flags->ignore_noent && errno == ENOENT) {
> +    // Sometimes files gets deleted while the relabeling happens
> +               goto out;
> +       } else {
> +               selinux_log(SELINUX_ERROR,
> +                                       "Could not set context for %s:  %m\n",
> +                                       pathname);
> +               rc = -1;
> +       }
>          goto out1;
>   }
> 
> --
> 2.52.0

