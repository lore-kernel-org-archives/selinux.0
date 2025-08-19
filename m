Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68526280A5E
	for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615402; cv=none; b=rMPr2re7gw6IQaL2KZoDeJjpoQ7zFELyzL8nCrJhMSBh/+wU8HhmgMYgWfam9yH1G5KrMDFhcQhW9mOXDG1vT4y8dN+eOoNwU5mhale18T+CKvvz2ZeWR6Rh4x5A5UDRvBCjPXbyLnQRjW6pCfs/lSD78liFPb7tQJEDYm1456Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615402; c=relaxed/simple;
	bh=ELRQ3hOZwpeTiP42YnBceOBTrxHGJHFkt+FI+54mVyU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=csgvUm1Aqcy6TkARi3xZHc7d3McVOjmhljZSv3CZTbcJXqJbJOyf4B8tOdb7XT8WZLVjvXz4c5Pk44UJoNzfHNksrNdn04GH36N9uNQJ1BoP3SweMBDC3ia/eImZVbxk41aW1B0CHk5rf8WCHZpuNIYDIp/pDllUjfqNdL76lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QGmWCOAa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QGmWCOAa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323267b98a4so4606206a91.1
        for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755615399; x=1756220199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=om8+GylJanYijPqNxQuupiP0PYjgSVTngOJHk0kcsDs=;
        b=QGmWCOAaSnIEPzqU1vqtjpyKIOs8QOuD8qKrxO2rmU3JGj5kFz8CBDafeKG/KwE3IZ
         hK6S7FycWbZIp35iN2VnlKCKkLdL3ZRjq7BS6WGhtBUDuWDeu6UXYTOXejLetrDZjoeE
         fKiD+f0/Pbew9iE5U2mkEKyl7TZUyOZwVqAz07PNPxSy/F6F5I/Pp2s6A6399gNMp6R6
         tFjBxqefz8Jxc/FEW2hpFmau9jZvi560rBXvrDBd5ewvNyWoLbwbyID82Wk23Yvlw6B7
         Z55mgZPIeqGvR/ve2HIt9Qq1C4X9tQR+3KE9aYY+27Xwig2iSShjLe6857i58lWdv45o
         P0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615399; x=1756220199;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=om8+GylJanYijPqNxQuupiP0PYjgSVTngOJHk0kcsDs=;
        b=BNG9V9JELaH1xvqWqSO7DWgfXrrcCwQ/BG6GKB7MFhUc+wh5f6okXRsxw+Uyzbh1o3
         OMG34B+HGR3R0nwy9NZjuS5e5Nw67aiSEBV6iWfK7Vjpfcr8latFFLtT0tZP3FL2bGC6
         j7KL1+DJDwMo4yjPCFXZ93I3IvPAyY1peP/Y76V7OxWF09foYXMOn+IWSvCxLFrsPe3w
         3zRRpCT099h6TTf02AMwOMZhMtcDRTnKYDOUSQ7q5ZlLoLrh50qS3k6Udg3OwPbdZIas
         /I+O/vHry2ejVu1YGWMLtQ+pl20TwuFMNmCp5G0CpdoYyKYN0gojB8SX/FldQ7whwYTE
         Es/A==
X-Forwarded-Encrypted: i=1; AJvYcCVyzTuLmqMLWfUR/CMqVQ8nyQIbNPjrHbe7nhrNSYUQ1wBGWdSlu4C3EPR+3dL8B+bvV4LCrZwb@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqTihqKXlelIChtiTXFMspMBAhxcaFgE+QE0SmSxlYxLhQ787
	soq6MFpGsXa0qbJzotuJz4PXyX1/WCPAcRuY+Fb8dVjR/gE+KTBi7m5gInhMc6FQOVcjsEVm5Mr
	FZgVucw/TPjS/dKJe5w/knvWmDJ/bdFJV8re76XJ3
X-Gm-Gg: ASbGncv8XkcYAyv4iIw9/DflcFRFSCbWRSiTUUJpjnoZukbjHnNChG/44+hpmV4podq
	7bq1gGUYDXxnYsaSpVc1fLSGY9OBNTIbhQtBjZqToPJxa4/iymYEvsCCDOZGilUSUzduGmK1+fW
	zyzBe6MyPUXHia+BfgeAmhs6QIqwX4hHKnRduFXTdrVjV3x7LmJ4JgcTKHRJGxtjtHGKq5FRBuR
	nfGIsw=
X-Google-Smtp-Source: AGHT+IE49+XPnBQc6B8Q5oFF3ZybE61TRrP8sGpydu+cRS/OemldinxpEQ2S7YE7y6mOMXaC6E4L57zujbzwokba3R4=
X-Received: by 2002:a17:90b:39cd:b0:321:b975:abe5 with SMTP id
 98e67ed59e1d1-324423497b4mr4040268a91.0.1755615399425; Tue, 19 Aug 2025
 07:56:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 10:56:27 -0400
X-Gm-Features: Ac12FXwMom27El91QycvjYzBe1ILor1PtOm_viaQq7KOGF6ZD2EdzLeM-qMaBDE
Message-ID: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Subject: LSM namespacing API
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello all,

As most of you are likely aware, Stephen Smalley has been working on
adding namespace support to SELinux, and the work has now progressed
to the point where a serious discussion on the API is warranted.  For
those of you are unfamiliar with the details or Stephen's patchset, or
simply need a refresher, he has some excellent documentation in his
work-in-progress repo:

* https://github.com/stephensmalley/selinuxns

Stephen also gave a (pre-recorded) presentation at LSS-NA this year
about SELinux namespacing, you can watch the presentation here:

* https://www.youtube.com/watch?v=AwzGCOwxLoM

In the past you've heard me state, rather firmly at times, that I
believe namespacing at the LSM framework layer to be a mistake,
although if there is something that can be done to help facilitate the
namespacing of individual LSMs at the framework layer, I would be
supportive of that.  I think that a single LSM namespace API, similar
to our recently added LSM syscalls, may be such a thing, so I'd like
us to have a discussion to see if we all agree on that, and if so,
what such an API might look like.

At LSS-NA this year, John Johansen and I had a brief discussion where
he suggested a single LSM wide clone*(2) flag that individual LSM's
could opt into via callbacks.  John is directly CC'd on this mail, so
I'll let him expand on this idea.

While I agree with John that a fs based API is problematic (see all of
our discussions around the LSM syscalls), I'm concerned that a single
clone*(2) flag will significantly limit our flexibility around how
individual LSMs are namespaced, something I don't want to see happen.
This makes me wonder about the potential for expanding
lsm_set_self_attr(2) to support a new LSM attribute that would support
a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
provide a single LSM framework API for an unshare operation while also
providing a mechanism to pass LSM specific via the lsm_ctx struct if
needed.  Just as we do with the other LSM_ATTR_* flags today,
individual LSMs can opt-in to the API fairly easily by providing a
setselfattr() LSM callback.

Thoughts?

-- 
paul-moore.com
