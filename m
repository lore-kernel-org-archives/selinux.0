Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12A1514F7
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949510; cv=none; b=QM3wCo/qQ5Tjtc/fx1NCqxUWdwgZtUwY/EKpcrMZ6A3c90Xq+JTivJqbQpnGv/p/hxK+rPFh+0P0RtmPD/WKM6bjNKfMMd5VU4dr/oilRSx1DLAxg4rJBefXjeozUspQeWBTjJwPHZHFYNbNANfUiwtTKg0kQ3XQkuwM0FBxgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949510; c=relaxed/simple;
	bh=+Sd041o0IBizE8TQ77+dnPeVAa/TdHEAWNIrsovcBzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFslp/EzTPucjQu/JhjenifqvCnia/I5f6Ex/RDJJrY8Thyi8SeuQ2cq6KknTfQ3nXclj2agDQrRjRqw1w/Y0O5y7ZEq9gxKYAQUe3Z+9QR25wY7r/Xgoy1iRjdRosgtQ/HT59YTRiGAY7mhoKU/ut4GbXQbutFe7nj7lObyrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWoxVb1L; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWoxVb1L"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-621cecfcc04so861615eaf.2
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757949506; x=1758554306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VATRbp4ln6aAJFWnchoiOaZGjI67YkidPi4RbOzjmgc=;
        b=kWoxVb1LKROUdcxaLn3g0BVjP+8mLoW0HeBlxFcxtOF8nwC/DhFEaKZ9FcqcXMptD2
         Rs+n3kM9ETmHUUqPSZ/TJsF8mSYhEySBQfnwqhKjdx3fX2a28Hkjhy7Pyzbfv4y9Bafd
         FsAVMWr5fxU9zyiVq9IsO5Uc21oo7TcaSwy9GxiiSb4tFVi8G1s/57K6zM81WRP399Ob
         nnxda6KnN0m9+2hskGQlRyAdCrfE7elyLqkCjbMc+IT50OB4qeHKgX55ugOr7ufrGEDP
         dMI4VMiAJ5GSibR3UwAncWl7mYUQVKOq0EaYNwoCQ80FYswPDcL0mPnNbg8EktQbl0Rw
         rbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757949506; x=1758554306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VATRbp4ln6aAJFWnchoiOaZGjI67YkidPi4RbOzjmgc=;
        b=Q3cjTdGh8ofGvCyI63roClR/m5SxQRO3GQSxbP2v9ARl6wk1S3XrT4fAH5hBOVLWkR
         WtJE5hZP3REZmEnEXjSWXDN7E7ta8KXnONEXUTjiQTtQFLrJclaliwidYyOU7as11Glh
         rPBppEksPLXuj3QPSwlLXX10upg+EBAq+XhbeKJ2R96b668XD11CrLwpiB68hmMrrztY
         ULdql2QwL/LdVRSKgxyJwr+1D7FAvGhqKs4RdKkz6iemBXHbPgAaIM0JUKBPNWV280eQ
         kxbW2usaNz5K8GGdFApxxPvcJPpgdRn/0Iy33JSF0czA6K3Mysl09NUexGG8YPDapCd6
         ddLw==
X-Gm-Message-State: AOJu0YxsxN3UnVejJ56oXiqaFef+urq3b29HiHoiepOaR6xxfXBD411x
	MM/vmzbOu0KQEGDMD5Ln4O02LDKzvhUoasfh8K1lAfKkqMfPxJ590OvgoiRf3Q==
X-Gm-Gg: ASbGncs4eiJhgWBfSJMe6ofrcfm4MIyIe6e5LzCNI6ERRLeZTtdIY+gdKhKJ3fiJoO2
	OUkWlE4KANkN5xulZAT/F06M0pLoarR5haGZp1CjH+ovtgiiruE9V6Y79w4MhOIkVjR9PKQ52Q4
	KT1pW20Wcuzvne1nFTjyJDNh23z2bNGY9mCl7JjlvbKZ5f4ry90YIqdzmzBZcExmHqtUqAiLGIp
	RJm6w52Mkq2c32QDhcPUhPFfz1vIQh+ckhqdF0/zRRDzGk5fZD3FTlMsTN6uxk9LkQQZBuKAyld
	4rXu93LVN0GI4BvtzHbs6Dj4rKsfCP+5XwFc43wG3Zx+kNNAXXtkyN8I5AKO3+cOVDHreV/kSiP
	E+4zB2V6XZfBj5KUDDwsnDZ36HIXizg2kglsJWjbQaQGQwDsi3FA/suVl0DO+h254K2nRSQ9WTf
	s7doU=
X-Google-Smtp-Source: AGHT+IGan1PSrzFCwOcY1OOSscLurz0rifX9P4Rmw9KszVPfx17QPxRhAtuUWewaVSV2sY6t5ZIvow==
X-Received: by 2002:a05:6870:a915:b0:322:2712:c89d with SMTP id 586e51a60fabf-32e54d7be8dmr6290120fac.11.1757949505838;
        Mon, 15 Sep 2025 08:18:25 -0700 (PDT)
Received: from [172.31.250.1] (47-162-145-207.bng01.plan.tx.frontiernet.net. [47.162.145.207])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d56557sm3494188fac.1.2025.09.15.08.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 08:18:25 -0700 (PDT)
Message-ID: <04030abe-6caa-4f94-ae0e-b67af88fc1b1@gmail.com>
Date: Mon, 15 Sep 2025 10:18:24 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: File access macros
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: SElinux list <selinux@vger.kernel.org>
References: <78602e06-7db0-4e0c-9415-75098682e58a@gmail.com>
 <87frcpfvox.fsf@defensec.nl>
Content-Language: en-US
From: Ian Pilcher <arequipeno@gmail.com>
In-Reply-To: <87frcpfvox.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 12:29 AM, Dominick Grift wrote:
> I can give you an example of how the public content feature might be
> implemented with an example. the refpolicy ftp module:
> 
> There are two scenario's there:
> 
> 1. by default ftpd_t can read(only) public_content_t and public_content_rw_t
> dirs, files and symlinks:
> 
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/services/ftp.te#L251
> 
> This interface is defined here:
> 
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/system/miscfiles.if#L915
> 
> 2. write access to public_content_rw_t is conditional in this
> example (with a boolean):
> 
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/services/ftp.te#L16
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/services/ftp.te#L260
> 
> This interface is defined here:
> 
> https://github.com/SELinuxProject/refpolicy/blob/main/policy/modules/system/miscfiles.if#L937

I did finally find the miscfiles_read_public_files and
miscfiles_manage_public_files macros by looking at the Apache policy
module (apache.te), so I ended up with this simple module:

	policy_module(container-public-content, 0)

	require {
		type container_t;
	};

	bool container_read_public_content false;
	if container_read_public_content {
		miscfiles_read_public_files(container_t)
	}

	bool container_manage_public_content false;
	if container_manage_public_content {
		miscfiles_manage_public_files(container_t)
	}

Thanks!

-- 
========================================================================
If your user interface is intuitive in retrospect ... it isn't intuitive
========================================================================
