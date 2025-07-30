Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E562DCF40
	for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891859; cv=none; b=dtPR37KyFMORqrvvvAjrdZJwIG6ulcZ8iDNeVN4NSIY0iZhP+tkQjrJBGIBpNxkBzbyAM/qqJnKn/Rof4Y57wSDvLBahg1d3y9rpQ92VWxbOMLLbKXqeIgp4BBTnspuvmDJsGhZ/SfRfDXuPZZh1r+FYmovSrwSqRksb9rairRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891859; c=relaxed/simple;
	bh=Xe6c8jY3+gbGQXhob7vsYHqis+TEwd7SlbyZMEE52hI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=K2TnGDRTLyENeEVZjQ/3Jzsgh1FTd2Fl+N725UK03K3F2MTo0uh1t9qjBN+ikVYe9KsTl9xWvXEKW+aY0PaSFY5JAKW9AgE4JxgU5tOrzE+AXdYfg7/kvmOzMmwPIu3jCumBoApjy3xaqQgLmGJlpf/dmUhrG4Xav7eMDs5xjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPtrF5Yo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPtrF5Yo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so7794005e9.1
        for <selinux@vger.kernel.org>; Wed, 30 Jul 2025 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753891856; x=1754496656; darn=vger.kernel.org;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqKE2Wmpz8b7XfQpTqmdtoyrrpUVs1wy676r+WwNf7c=;
        b=KPtrF5YoTKBYh95bcTT0gKp0+qc3X4C2V7ZnfycbVa27iweYc6OnEhFf7VoClq7G67
         HWPhtFikK/HRg+zmlNA1o0CIc5cyS7qrzZ0eWkf9QhUlF4Xs8Cc9d+XcDjQ3x9nm/EXn
         DoOyOYuqy92s7kpM/ZgpiUDDSLNacwN0clxfwC3ZBE/PNlB+JA73M0skJ4LV9h+zlZlS
         E87231P1KGPoSQsAyauMWTBNjgdmS9j0lLK4cG5mGEJCXudVskO9pAkZe7CZTPHQmfgH
         dNk90CbYOBERK6qKScqPA5XzGBTCryUGW9sBu8LRwhKs6dmGeCXnU+rLdt7UTaoY1znY
         54PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753891856; x=1754496656;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqKE2Wmpz8b7XfQpTqmdtoyrrpUVs1wy676r+WwNf7c=;
        b=DG+O0EaZohbpdSJkv8N3w5X00SN2JLySWzNQd6f/XbJZimkgjN0ANnfBeiLjXC9DYu
         p/FYPOyvKHNrxhDWOL5huwEoNWJU1AI4W6jpFFRuttCSmTLJv9XAKnlZpItmgZMOMbCU
         7DizzxzLH0HRFrOw483DY525B/7ztroK7IxDT7VdXYDvJoawnlfbX0gNJxYs/6S2bWIO
         RKtaNlUn4d4LZ/+/Xs+FlH69P4D68IecJp4347UR7EO1pNguBt0QCFgGYdBN4JkA8hWj
         KkqouPqQptt8qVIdiUHC3Z89F/1hVdxyukpbjTxi45i46GdH9bi3tTm5WL6iY/w5/dzw
         /i9A==
X-Gm-Message-State: AOJu0YwXbesdBgh+6WHtqmO5rfoFO3yGEA9UMRJbNs0pSKXk9eBCTnD/
	3NbF+JM+OellQk9rDxaoT959dKld+11xg1j39e5ogJW7z8bqfr3p2UsA/CbZDg==
X-Gm-Gg: ASbGncuz8WJ2ZpeeLgxw2Ht557h9lfDfK0+iRDLvFw9YWQCCuMbTRUc2uQvAokvC+4B
	B74UAnydZXZFYpAm8HtS/GCunzeZCjf3F+o2x/3v+hkXwW7iQFtxpWz9H3RwANbatsunSpg6bgM
	bQEprHzENO2CrdyHkmwAePjiuaOccE91CngxnQRBp3OpZJ4VuJ5iadB7Wx5yotR9jJV89bI36P0
	ccJVxGuNGlxOknBw9P2Yr4rMO40Vx0dzl+Vh1F1YK6V5VNJkipphgla+O5GSBHX9eGwQVXXGby2
	1maHu48WL3osivKeFTVqupBHCEXkHVnO8qpUGpyaZMCb68VkauvwRMvw55yAINXM5GijIvanCyh
	wLkWJDXySRFZxGtlY
X-Google-Smtp-Source: AGHT+IF2SQbEIJ7dUCFnWzLbqgVvA1lh/WhWxuSb89MQ/Wcwwz8jwRpEeuxDMynRPmevAh/ePiarRA==
X-Received: by 2002:a05:600c:1d91:b0:456:2832:f98d with SMTP id 5b1f17b1804b1-45892bd1af8mr39725095e9.27.1753891855565;
        Wed, 30 Jul 2025 09:10:55 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536b3b4sm33270305e9.3.2025.07.30.09.10.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 17:10:54 +0100
Message-Id: <DBPIRUM77DL6.AEMZQHEO7W71@gmail.com>
Subject: Possibly re-expose the enforcing kernel cmdline parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1

Hi,

This is more of a question for the kernel guys.  Currently, libselinux
also checks the enforcing kernel cmdline parameter by *mounting /proc*.
This is... not ideal; granted many situations in early boot where the
policy is loaded with selinux_init_load_policy (3) will require /proc
mounted later for things like getcon to work (given they use the /proc
api), however I don't really think this is ideal at all, especially as
often the thing loading the policy is init.  Would it be possible to
reexpose the enforcing kernel cmdline parameter as part of PID 1's env?
I think would be cleaner, however I'm not sure if this goes against the
kernel's policy for anything or isn't feasible for some reason.

If this seems both reasonable and feasible, I'd be happy to send over a
patch.

Best Regards,
Rahul
