Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802C47DF86
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248222; cv=none; b=mGO8VuqiurEYDs4NrG9L+m71QiGzfL1V2jg+/dS6Qm6k3c2z/c0K6vDwcKIJoVJGBTkmgFhIZ4zrhJByMtYCNglRkmRy0O+Bc5JrB8BnM39zyL0ALiXc/l7xy8Xk1eBgpJNWRUWmuM7V/2LspkFCZae++/psxukfkpgpyunbGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248222; c=relaxed/simple;
	bh=azL6pMfssI+o4ECBFo82B22ejlVXeit8z7j5FK+aJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOVIJi6HFb9B9L8TxbyL8aFRssTbNSW1xdI9LHzl0QgfOxbsEd2GJzLtBfQ+U0hkenzAPgOAPMECUte74ngrt/0vH1tRqIvBFW9aPTaEjRtnlv8xnDejWo4Xb+CqPg7qDjHhMy5+3G9zyL31vfixX1v+fQ53921xb3+K/j2rlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKXuBNHU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKXuBNHU"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so112206e87.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248219; x=1787853019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jFMUvzYyyAGffP4UVV5ruK5O8NFOvkXY87WGr65ihE=;
        b=EKXuBNHUhQabJzXgvkEafdwQxBYUfaB8PCYxTWoXW5+SJTPQcDSJiAaOiE8TwcPI2G
         9GQBntgiatGHZQtjpC72sClJe6UldGgTDYyUaZHl7VSRmZEs4pUZBzCynYn373dRpH4/
         whSIPpmNh+WmH7i1BE/lCxCa08LLJYjs4hU4MZOWn2NnTUUpglQXeuCPmsmFKQp+FjT6
         RfpJGHoXV3wrnR/v+R9/UeCcZoWDCjkm2w/d/jiqM2n5lQduGxTF+lvT6/RtVGt9YYx7
         B0qWRE/80rP1a9GvBEU1Xuk2AtFtBrT/w5dRchJsouqdFuA+cHJhP9rMygbb6PagM4hS
         3I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248219; x=1787853019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jFMUvzYyyAGffP4UVV5ruK5O8NFOvkXY87WGr65ihE=;
        b=qwDJxC41CKZpnBBzB+FVV0JCWGBI4c+dD1xmH0wfjiaFhbk01F2Br/GPjrQ0Dlwg8h
         ZYSmW+d8orjDYAz7KHfCrXvmMVve/1j3t4yvhQawejT6UX/2L4fjAFTrwOCmA4Bh0c1Q
         IsOtlYNkAN7pWdnmsD+iIiA8CR3itpMr6XhntNnLolE0dS3tEMoL31A7k/Hhw/exBW5D
         WyYePqLw4g7SSQuPupWPJNK487Gwi78a/n8oQ2n38NSvZLVxoLYy7zN0n/i8hPhFd9/v
         GubGIRMsdfkv6ekzx2CWUbS/HUVmob/Vk/rrN3r+/0Py4TUaeieO3nAdTdmSDseYiwRY
         vJaA==
X-Gm-Message-State: AFuF++m3aw7JNUw1ADtXl1To7vevUfU2QA93sICmRcx3lkIhrtkKhQ5m
	xh8jbrxZkG3nltLAse2FmbqfcnNNKQ04apnz1MmMElW4sMoPuXK1jAk1
X-Gm-Gg: AR+sD11ytIESBvInNr4CqNtQ6z/HdhBsOnLZL1YUPLAw+XbNt1jbLP5jxVD1LjNGQqa
	P5ZfohOCK9efaf2O20bGLA8APNfJC6xTOinRpnbwcrA/MlVpC6gUw3GkGR9SDr2tBlOY6qF88Ep
	3RNaVrMq43pZxfIOFZh/W/f78DJXvvmaUCIXhCj2f9UxvUsHAyQC3eWKz0tjvKJEZ/wInIVTMax
	jXhEamm55d8NvALi81jR4p5JhEVdOmW5MmfBks3icKcnIfD5BJErUxrvUcYjKVGxQ1ZNm8pFO5C
	1Wv4snixoH5bEuKP6ME1USu11qe29EXz3hXEG/9tFx344CzuQG0Pdb9g6CMad2Jx0mDwW4dUn72
	uUc2szBwyrxAu98sdwabhP5x4UujYoeGLbSbmbhtcTzzFgZmW/DE2MKUsJksztU5yIxzkO724WJ
	xhBuOGxzVnIRQNBOLodef2yiPRKNxSI+VMG8EjImuZ8wuY4y4gWCg4gHduyHJtCwDTxIQkEbSTy
	vwtSr9OeiM1YbF/xGdRmg1Ykfiwu6jVg4PI4lMmmgjzteqrx9t4St2UGqt0wQWrN5TrJeOjkV07
	1utJtVNr5cNgDyOo9sZLFkGZoTMCSg8AtTjui+1FMaPuhTCTo+xzTPVza8B3rQ+qC+I+kc4=
X-Received: by 2002:a05:6512:304e:b0:5b0:22a6:6b13 with SMTP id 2adb3069b0e04-5b48408197amr57328e87.0.1787248219056;
        Thu, 20 Aug 2026 10:50:19 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a476-1a01-141e-2b69-987c-d72d.310.pool.telefonica.de. [2a02:3100:a476:1a01:141e:2b69:987c:d72d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478860c85sm1419706e87.35.2026.08.20.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:50:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 19:50:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
Message-ID: <aoc9pAzSVOzCaHS5@gmail.com>
References: <20260820061349.10542-1-kmehltretter@gmail.com>
 <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>

On Thu, Aug 20, 2026 at 04:32:28PM +0100, Amir Goldstein wrote:
> Sigh, this is so confusing.
> 
> The fix looks correct to me but I would use a helper selinux_user_file() akin
> to file_user_path() instead of open coding the condition above.
> 

Good idea. I initially had a helper and should have kept it.

I'll send a v2.

Thanks,
Karl
