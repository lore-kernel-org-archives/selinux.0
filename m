Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C971A08DB
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070151; cv=none; b=FaVxIGVFnaLru7QhS9V+0QThJxe81SVEpWeKWAbQWYjfLCTzpNqeAFdcoaQSMRl2p4tlbN/L8RHgXYWnToZv3ff68JkUes/0Bn5+tjTvqyMfEd2BShjQYJ0LaM5vOF37m4jS5KjNSv28bqwH2S41TiZLo9/Z2QDTq3uc1Bu6RAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070151; c=relaxed/simple;
	bh=aOGGG0rZ+7TipqLaOKx57RQuSKJwkmKtZi9OBosKJpM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=jkuhbNMOEddHKql+npdw9a/7h2Qxho0uUPBwZI2L1GOqcRh+0O4FuLq0C2bdlwR0RArzqdTds+zf84dHPQhRqMZdD6WYx9YulU9Eya5Ci3iL17yIRROkOnJJZraOwogy8x2Sn6ZMHhuOIa4tErkTrKTDv2cDsICingGDH15daNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAKfVcPy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAKfVcPy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b79bdc9a7dso809172f8f.1
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754070148; x=1754674948; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kln08c8at0hzpgN7oiKSFYtXsA7xtYSBTcygxkmiDtg=;
        b=fAKfVcPycg7DKdZ3paJ1sBojv+YPU5UUP+LyX8lwqnE5Ot+vAYX6Oj0ifHbe9LOPyf
         DB2vwoNV5y6O3qpCEHAGU/QABWqZUuxW69JehYXxfuDXkHSWJ7TQF4Oz92DE259j/QBY
         8u3Cbb4E5DGvudSjtLhQcVs9gyzzxLjcL2Xcoeqpy8Cnr1xn3Eb2+qF4+NbUZNs5HzPo
         U9oo5j9rgyLF2w1G5K0AO/befSAiVEdtf7w4Tnom903ZlLnXhUEJhsNd0V/JIIwmj5Cp
         mrBOvgHBrJ/aMk7pfof1dsbu04n3JDSHEB0lbNjk2IU3hOmTk17HU9HHIV4Xk6AJtAEz
         GfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070148; x=1754674948;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kln08c8at0hzpgN7oiKSFYtXsA7xtYSBTcygxkmiDtg=;
        b=t2VnGSnjG3s+g3lbfqInYXX4/pLRgvnRgh03XR4EUy6xlbOyAr0FP6TREag5qJJk59
         AtDGEYJVk0s+SWxjd2rLRtNmhNkfZRgBSAI3BlFtVxwU0aTE2sWLMy0fPAGAnKH9gDzF
         TZQYw8kjTdfRihschxxo7HqaWN0q4p6ATVlnKbAAg7lC3eL+i4+A0eBMQyt8RLt307IS
         4UPbU/ZkySfab7CsH3q2r3I+P6doNsSwdoepddtRbhO9bukRAOUSrzaM7bcBHoietNlQ
         45xQ/doZW7UyLhZANV59jACJ5LMRbWQOuKC6owRdlo3bAsREtAnjwTo0pmdi7Hzf814N
         aTDw==
X-Forwarded-Encrypted: i=1; AJvYcCVVhpSRB6m3fp3LrAoebN4gFWjnEarXok+GChaM6ArkNsDhwXSBBM2ykgGVt0jCJIUt2VYDLeGr@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxJX/ejN6Zms9za6FycytXoyFv8T50egELDrZP9tXfjdYuOVm
	Ey5nf+LFTlxRELqhNRhQGhrGBcq52xCVaYofk9DzppDBWKUw1xdfbxK0
X-Gm-Gg: ASbGnctMlcBQO2D9NtJtvj1toDBiiazj80yAsH68l+XehE8DStV1cXZ9wo0u3E31ip2
	FDtAbUp3eKd4045Drk/QsiV1iwcyxXZ6QYxHG8o8MNL6mj/kzGDqW8g5FWcxNNd1CELyExuEkC9
	Eqa84/py+DIEFlesQEPCEvRsADecmKfjocV5QHT0CbtUE8a2jmPWBsiUcLcA8MuEW1KsRIHAWfs
	72FvVIYXH3+I8Y2Yr40pnmzGqVt/Dr1gcOjffGkrgjyKxbZYQwy7iUrmJd1tutZfCi8HWK+k+tB
	pUzFI2f0gukbhE8CBu/Xu+3rr1uTfe3J4mv58Y8R5Dx0HAqbLfN5JAzrBwNI6xNWfK0ngm/opby
	6qBRxe/fsyHu3SWc8TVVxBsByKx8=
X-Google-Smtp-Source: AGHT+IFP5AMIqr6+meVZJbgaky7K/ZZoMPjU9HYvQeNLvBUTGbRJaa5qIswAGyuqHksheNyc1pDywA==
X-Received: by 2002:a05:6000:228a:b0:3b7:825e:2d28 with SMTP id ffacd0b85a97d-3b8d946c027mr551483f8f.9.1754070147830;
        Fri, 01 Aug 2025 10:42:27 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm6733560f8f.44.2025.08.01.10.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 18:42:27 +0100
Message-Id: <DBR9Z1C82MG9.J5SX2WJQ0UBS@gmail.com>
Cc: <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: refactor selinux_check_securetty_context
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ60msaQXmD3kWOPoLb-=Fx1WK2TdGObpg
 Vq40-yJEfTw@mail.gmail.com>

> No need for { } for single-statement bodies.

Thanks, I wasn't sure about the correct style here as I couldn't find a
style guide.  Is there one I could read, and if there is could we link
to it in the CONTRIBUTING guide[1]?

[1] https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md
