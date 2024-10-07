Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7492320F
	for <selinux@vger.kernel.org>; Mon,  7 Oct 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333331; cv=none; b=ShBriAfq0VRk1m5d2ihfVzOB3fqaudJYh7l9pU1G6vrzzGUbw9rZOZQC7BuvaDPSBDEDLqbSTwdFBDZzXsd77v6ZDU8qZepUXuSMMkFDltfV/h5z8CyNij0P65deyhwBhvwfFslO89diiw2Nt0th11mVKe01u5oeX4S/zJXUp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333331; c=relaxed/simple;
	bh=A0F6QojDVNEND8PY6hzbHxg1Ncj9HnKZUIKLcCWPXdY=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=hAnG5EQtrVD8zW2W6PcVqJUnBSZ8KlISevlmXcAlQ3UUeT5Vu+rzWAFufn0EGpL9YaJr0yWLK85AFdri54orEcw3fQm27TjgY4HXLllOsh2AJz2eJ1ctGX5L8H5I0Qeko28lC+xP8zEKaClC5851v6gBj2k/HV790G2hMgOjCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XIE5SmAC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XIE5SmAC"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7acdd65fbceso386372385a.3
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2024 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728333328; x=1728938128; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3u9CUGIviQYa543JAkqLQQZe7PjJmlB2004JCZveiOg=;
        b=XIE5SmACFm6/j90O0xTOPsOTHg61ZOG9UcVBpBpkKSGMuF7KiHOhAg6imZmF53yDCY
         5IaDAjKyjbln6ZNme2OWUT8qCmCD47rmXR7PJborhLNPWWescW+uBHvZCuzLAz9AOc/l
         fGS1hQlNVSUiRd8VVR/d/Bhb+dTFzqyBrZofO55V5PGCKjg0WSFzRb0GcjM1qcrX99Yc
         5I4Cw6xriDI5rIVxelvBof8P/6cK+1yirDkZTX2rdRvEgaohngMYFbaNOe8pCYP2SY3s
         vHofD58kspsW76b6MpcLBIvwjbrTc6Qt67bT3c1rTykxuEh2et0OTZgJhzxwpzcCuUeg
         DDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333328; x=1728938128;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3u9CUGIviQYa543JAkqLQQZe7PjJmlB2004JCZveiOg=;
        b=boI2+l9slTDy59ntXhyRVpdOIgmmcDusI4OF/JgtjN/wfZKbID2SY0jUAXhqImhR3l
         ve0Px9GNuOv4PKZ0OIvjeOSYRhCEdsfs1gpxO35/rugKiDo6T22yBGLdLliEs+jNCww3
         ohLfvwwyZZZ7vxA0rTUybyk8PMhhiQlA7hRpB3dQI7QC+6ZzJIF01T7/GHdOseQ5AFOa
         yQxsPAA0exCDp2fk9PyDU1sy+S5gZ2KoE/j1v+hgpWeeM8YD3vApmWIRhVVjPUcRFsKw
         4XHKNYrNfn6DOlLcODZZ4tfG8zsl26FZlRq19bfXgyCPBgYiaYA4XZu77F9sPXdk7lbL
         ZuvQ==
X-Gm-Message-State: AOJu0Yyp0tp8STGneZXQ41w7gcEXhFH5HVMISILqdbMa2uaW/p+27cCl
	nfXT0hlT5mn6of1mMKxGlQzb9OpBJ6fT59p3CtQLMYkHy2p3RSEz6HCLrg7g+ZB6poZmigQe4/8
	=
X-Google-Smtp-Source: AGHT+IGJiKfdGbJMS00N8JcfzvGGWLZ14bTeU+f/HHwfk7SgtxDEeBI6kxyr4jZ3wK6iDHXGTnqEhg==
X-Received: by 2002:a05:620a:1921:b0:7ac:b197:2341 with SMTP id af79cd13be357-7ae6f436ff5mr2059261085a.15.1728333328540;
        Mon, 07 Oct 2024 13:35:28 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7562e1dbsm290048785a.48.2024.10.07.13.35.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:35:28 -0700 (PDT)
Date: Mon, 07 Oct 2024 16:35:27 -0400
Message-ID: <edad7f07074e83ef9aa3dcc975a85f3c@paul-moore.com>
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
To: selinux@vger.kernel.org
Subject: Re: [PATCH 1/2] selinux: streamline selinux_nlmsg_lookup()
References: <20240925201106.16134-3-paul@paul-moore.com>
In-Reply-To: <20240925201106.16134-3-paul@paul-moore.com>

On Sep 25, 2024 Paul Moore <paul@paul-moore.com> wrote:
> 
> Streamline the code in selinux_nlmsg_lookup() to improve the code flow,
> readability, and remove the unnecessary local variables.
> 
> Tested-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/nlmsgtab.c | 90 ++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 51 deletions(-)

Merged into selinux/dev with the correction from Thiébaud.

--
paul-moore.com
