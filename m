Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A91EA84
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094508; cv=none; b=Jj0Un4gMzMhVCUI0R1YrZXVcR9HVcw35usl/XqUCXqKRVXwOcKby82+HwvSax1xomzkF4m5D+Kwb2ZZt3YGZB4+Wn4WycJhgHUka1FqSfo2rOAY/VupQEuMFdU0XBNBGDbhIemOGPw4MYYckxRXo5R9JA/nxoRbbdkVnvWPFKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094508; c=relaxed/simple;
	bh=p3CYaph+dH7AhaJEKohZY9qcrUZQ3FZlhIlcpLpCr9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRa1xVUALc0bB+/D3zNUdkDAU9lmE9VNJDKUxgW0PW05EvbgSZRbL1JbgX7uAWkUwi+LJKQo20mxgSOj+ZR9Jcje9xt2f4534fQWnlaNoF37cEuGJLrbGbrB+WBROO4A6SGLbVKdvl81knQW6k1C1feY5+7s94j0PdM0ZvbNbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=RawFaoCC; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="RawFaoCC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p3CYaph+dH7AhaJEKohZY9qcrUZQ3FZlhIlcpLpCr9E=; b=RawFaoCCQX9kqtfHa09uAbr6Hz
	a7FYqwFOtwVr0gxlRsDYCP/L5eo2H58Sc1hcqboyINFMHO1riyk2gvOLXmO7L3V5BMX47bYet/UIp
	vQJnoWmJ+vpxhVT/Lu7Cpmu/sdyInmvtX1MnpKq3ZggHIb3q6SG5kDiJG0NZvzhyxeFpxUH9bJedJ
	8aQfuVfhZh7BV+cR6OWE2XlilV9YogvVChfoLaJiYgzZ+K/owjru5GVUDAYVnsB/SEJXSAGaA2p4k
	ETlDE1MOSpPo/Dn5D+eicCL+R8zpD22KpuGy05vW9hm8J4wU8abNZWzX312tiELgkjS9ZeB2IbvFI
	9cW8iZcg==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11405 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKhbc-00000003YQd-2vM7;
	Wed, 06 May 2026 22:08:24 +0300
Date: Wed, 6 May 2026 22:08:22 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: libsemanage: why is expand_check integer?
Message-ID: <afuRpnptNj08Ii7u@14-5A-FC-31-E8-67>
References: <aftvCdG7qZ5TeQhI@14-5A-FC-31-E8-67>
 <CAEjxPJ5PVu=ypZ1coyq5B9kNNFkyE2s2HM2m+fmBSBv=ObxwHg@mail.gmail.com>
 <afuKhEPR1zPlsN1P@14-5A-FC-31-E8-67>
 <CAEjxPJ4_oecko_vwtfdzkpw_z10ckCBrNTRvjkAJ6WPq2boX=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4_oecko_vwtfdzkpw_z10ckCBrNTRvjkAJ6WPq2boX=w@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Wed, May 06, 2026 at 02:39:02PM -0400, Stephen Smalley wrote:
> I wouldn't object but it is far from our highest priority at the moment.

I am sure you have more important things to do, but for the peace of
mind I just sent the patch.

I know fully well that these are not crucial changes but using 'bool'
instead of 'int' in the boolean contexts makes the code a little bit
more readable because then you know right away that these variables
accept just two values.

Yes, I too am old enough to remember the times before stdbool.

br,
KK
