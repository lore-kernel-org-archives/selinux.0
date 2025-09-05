Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BC1FF7C8
	for <selinux@vger.kernel.org>; Fri,  5 Sep 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112493; cv=none; b=CxOzlTODeO7iqhXI6h9kxImr154s2t66Ke8b3cUULoK4N1TpWBTYH//hW/GeTSFj1u+KUu7BSv2oG4BkUcxXwnhDXgLsFw2BNArGNU02ZUNT6DazeKLojZXS57RJfhVLMq7TyhAzNVar8G+aILFAG6Kj4y0LZo+/2QuQusn3p/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112493; c=relaxed/simple;
	bh=/NeEPoYmo/i+0mCtYCXzvr6NHSeL+V/e7VCNvcbNorE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enkUYCaGC843KiDogJOFh4AfIAMe34gG+JpKN9NOgPd2T92DrnfnzK3IcAzYiY4NvX/fhwIalD/0tgNqRmr+V0lphnjL/GmJB61g5GfgWB7AFPFpBUlOqNUhlQjOpEWxZ7r0f8rxOkxGG+U1vqE9vnokrGSySGsNMBdX8UIlRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHb1V8bG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHb1V8bG"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3f1bff268c2so12657725ab.3
        for <selinux@vger.kernel.org>; Fri, 05 Sep 2025 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757112491; x=1757717291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WdnLhIU8eeSscRHjrKmNdJs/lkEli5/RHH0KzOqfe0=;
        b=VHb1V8bGMo2farAf3P13aEdYcPOc9g4nG2kFTMekl6BmMkfVGbkO/qXDKTiZXzGB5Z
         Gf4CjNCy4PWr/5HOyuyg9oW1vprp2xk6amwn+EmdpJ2oxHlKj+gvAhAy3tx9QZO8NAPo
         yyRFExnei29FbdpQQW20mK9j09oLBRmddh7x9R2C/DDoY2Mzv/rHJHLkGMpoiXxVEpUw
         xC+0vJ0fwO6jzthbFp9VRkZghgvUm9bSnQV59GSfZqMAhH1s7g5MYr32rtxPrBpQAzFl
         clfrPuYYLGbNFkwZTwB6ncBNdWRTflwEBvBFNa+UtXgtSkMW+YpQmplhkRJgutJm560Q
         wbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112491; x=1757717291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WdnLhIU8eeSscRHjrKmNdJs/lkEli5/RHH0KzOqfe0=;
        b=cyRcBv1ntumhFQ1vP/G6FRf9tXt0wsu86QMJgwQeNCVCKrJHt4naZwbBnbVFQJst8O
         IeTg47ifvUbw4BeqEbBTBsq6b8fVk4izPgeEPpzCuXR11Nu2Cqz0BKnn4tlgwAXXbP6y
         KcWWvB0mEMbDIZjqG5mOHxmz2Na9KANpKjE+hZRBIr03slFTQJVe//oMjUcs4j9KMsdM
         29ZB5n82AwIqBdFmEttnZR9bysD8d0zp8JxQm4NQ1d+ua+KjczRvja2VKNxnBjL4oyBX
         aG6Tv0TgIGqq6omD6YA8IKH/UvG32UVu1J7zncf3kmnwr/OFeqLI7qIj+u5DXEzMmrAK
         6CwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLL/Td8dDd2JEmUS2b+Mb/T01kT/lhMA2P9TZ2VuNNIwvKlZ/KFTYl2LbcSuAtM2DHuhA3d2bG@vger.kernel.org
X-Gm-Message-State: AOJu0YykH8XUTkmoR8Nyn1qZHgiJde0ahDFyDmN80/iNHegHRD9AVRAU
	7XptzcTJi1n+Rz2yxOk6TF6gaNkKpqX3AgVYIiK4s3Vm2tYQQaLZ9IMeSJ6dmF96JQ==
X-Gm-Gg: ASbGncvyhA3r/FDXC/E+v5Y0Ru3DOoxpMp4C+1t1B/S3Ax/ftMhF6DrHHfSGfYuz93X
	A+14FOgbtx6tIoBKRZxdoKm1OK1+9/+Hlhnd4whCChX3JnspXaEou3K1yEwNhleHqCWIokxFaYa
	fKXy6/VUFI2VGcLvwt+7j5I7kF2sAZV+xFYJnrIeeFPGsOVNfkVRQIe/Biv5IextWs7VB5tgfn/
	utyPl21K+g0sL4Kf1WivCyTfTqjpiyiYTiVpYWliE4GDptczDJfcuZweSdtybsTEz8U0RP9Ke5g
	Dg4my8hpsi/TrQL+ft7y/Dg+mvO5GbFEjsdrDNXrwIRblugF1Q8iwm0pCaFJ1waLW+elvvQBfuO
	9oY0YPjNOA37U7eNe0DM+OcroN++c/KJ64XCo4zw5TieX4wGQrtWw5hJQDT5Q+q+29w==
X-Google-Smtp-Source: AGHT+IGteJPTUg7Q4dY55bVPcXcRiRPHeCcc/yp3td6K98DG8HYiAWfdNzDYCCb8HPGJ8iqvMzuTDQ==
X-Received: by 2002:a05:6e02:1a41:b0:3f6:5688:a088 with SMTP id e9e14a558f8ab-3fd7fc2166fmr11006485ab.10.1757112490698;
        Fri, 05 Sep 2025 15:48:10 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5104e42de56sm1991680173.32.2025.09.05.15.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:48:10 -0700 (PDT)
Date: Fri, 5 Sep 2025 22:48:08 +0000
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
Message-ID: <aLtoqKL8plKOF0Ed@google.com>
References: <20250828170317.2322582-1-nkapron@google.com>
 <e2c4c055ff356b4fe5d49bc9df3fd2ab@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c4c055ff356b4fe5d49bc9df3fd2ab@paul-moore.com>

On Thu, Sep 04, 2025 at 04:15:52PM -0400, Paul Moore wrote:
> 
> Merged into selinux/dev, thanks!
>

My appologies, I introduced a logic bug between v1 and v2, and have sent
a patch which fixes it [1].

Thanks,
Neill

[1] https://lore.kernel.org/selinux/20250905222656.3692837-1-nkapron@google.com/
