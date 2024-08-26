Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27B19D075
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711359; cv=none; b=aeNV7AAlCR1ddVTPhg6rZqq6/Yivvlr3RehUAz5z9JwUqysfPnfyAiB1CvtzmrxW1W/Mzj9KZraa8gK8136Yghs12h4+7QV0pqjPjAQBuZj56Yq0T/6qOV5GGAStO8b5P1bGb1qaRpG7zRifNoL0zdIDZqMkXpWTCy7TFsTgzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711359; c=relaxed/simple;
	bh=NSc4Okt+VC5KhhcI4GjwMNyiCG8ff6DKOAXyZDKWKwg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=hfxxX2RtGzmIH+7IIWFQlEJyl6nQzMeVMP2eieyDTRnAWSvNkcAdoyaLLUo6VHTMlaDThWBmsTnDSwQCcQ7hcjic75e6sIKXVH6VMpf+yGA03kAQJ8djD5jzkAunuZ03jrsqyFA+YQkUtKUgYHv+fF3mi3ZP6eRKL0HPte7jOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WJZ3qFsE; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WJZ3qFsE"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a337501630so321391085a.3
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724711356; x=1725316156; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3N09dlUeLDWnGTOZ4n6d5/3QJlaJZT1Youw+FJ2C4po=;
        b=WJZ3qFsEJlCOjjVv70lDYOGCojujLiMZFHAc55qUEIpvOwN6zAUz/oyCLv6nTn2gva
         v9I8lO2w20KUj6tsgMpBIWCggmiswdcrYqhr0RNXSoVFhvtiWmf0IjZk1JMAjhVBVShK
         4E4FUzp1y9VGo6ylEKDpsUIQEntHQuD8OBsKgg5fCDnlr2nm4YZH8TK19Pk7owAwU3GY
         6prh89062RpF4CDYIyQ1T92O15fGO1y0A8/mf5aDeGHYyV81+FHGrdRHHrRg+9gNa6Km
         gFZc/+NKvrIqRf2wOewBb6uIDACZnnDD7O3bKHBEhqJMQgAFWRUFxqEvBGl+a5PrSlRa
         JaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711356; x=1725316156;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3N09dlUeLDWnGTOZ4n6d5/3QJlaJZT1Youw+FJ2C4po=;
        b=BGg60BOvmXOSnbtBNEjsEQWej8FdxLYgKZ1uO4Yy9+D5b8NaNGNy9HrFaKdjuUeo+4
         q+DAB6oV+WQYNqktPPDe6ad52QH65IMZTqKDBEWVESuaW4mUe39xioBJmFlVI7uOdT0a
         MlcpevgJUn5bC1LycIspoQB1G2HbreuCmW9TccoPsnrBsFGv/5HpQTd9dZpljPpLcknK
         UFKP1H+vD9EWs12903esIBrhqKji7eFOJKYSnCqzzpFnncGZa2+HokAd+LL1mESlAFDY
         syvpn1bepn4b4C4J1Gn+HSJnD+zXTqd+n64bFv8vSz1V86OMXDQ+MLtva6MXYaZDQ8DP
         9/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVtR3/Jc2P2b2/77c5w1enq5aZGBytzaFSCYPphGz08lqhEsmmEi+bcuGVMX8lG/tEaI+MT+GFA@vger.kernel.org
X-Gm-Message-State: AOJu0YzBa7rzQz7jnl3Pi5LVo+eH0jogVyBRwcybz++HissiLyv/rbMM
	ArTjyqP77+DEoCqlcApotHWlI2hVpDXuVRNzNFlQYxQ3fUgZgkVCFTjeztWkfg==
X-Google-Smtp-Source: AGHT+IFQn+z4i4PvF96htJxu0pzdb+NNPCs7QRfIEw0WlBnCJXtMyEadU8DR0+0TjKzAkjXI62fJtA==
X-Received: by 2002:a05:6214:3c98:b0:6bf:95a7:e230 with SMTP id 6a1803df08f44-6c32b8094b0mr11868556d6.36.1724711355689;
        Mon, 26 Aug 2024 15:29:15 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d27bsm50635416d6.7.2024.08.26.15.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:29:15 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:29:14 -0400
Message-ID: <a769ce9fc949c03f91a4ee1d1cc6ebf6@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc: Xin Long <lucien.xin@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, linux-sctp@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: fix association labeling in the duplicate  COOKIE-ECHO case
References: <20240826130711.141271-1-omosnace@redhat.com>
In-Reply-To: <20240826130711.141271-1-omosnace@redhat.com>

On Aug 26, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
> on new_asoc, but as it turns out, this association is always discarded
> and the LSM labels never get into the final association (asoc).
> 
> This can be reproduced by having two SCTP endpoints try to initiate an
> association with each other at approximately the same time and then peel
> off the association into a new socket, which exposes the unitialized
> labels and triggers SELinux denials.
> 
> Fix it by calling security_sctp_assoc_request() on asoc instead of
> new_asoc. Xin Long also suggested limit calling the hook only to cases
> A, B, and D, since in cases C and E the COOKIE ECHO chunk is discarded
> and the association doesn't enter the ESTABLISHED state, so rectify that
> as well.
> 
> One related caveat with SELinux and peer labeling: When an SCTP
> connection is set up simultaneously in this way, we will end up with an
> association that is initialized with security_sctp_assoc_request() on
> both sides, so the MLS component of the security context of the
> association will get swapped between the peers, instead of just one side
> setting it to the other's MLS component. However, at that point
> security_sctp_assoc_request() had already been called on both sides in
> sctp_sf_do_unexpected_init() (on a temporary association) and thus if
> the exchange didn't fail before due to MLS, it won't fail now either
> (most likely both endpoints have the same MLS range).
> 
> Tested by:
>  - reproducer from https://src.fedoraproject.org/tests/selinux/pull-request/530
>  - selinux-testsuite (https://github.com/SELinuxProject/selinux-testsuite/)
>  - sctp-tests (https://github.com/sctp/sctp-tests) - no tests failed
>    that wouldn't fail also without the patch applied
> 
> Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/sm_statefuns.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--
paul-moore.com
