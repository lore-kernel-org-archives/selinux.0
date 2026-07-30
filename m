Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3C3B994F
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442498; cv=none; b=jGmguVJHgPqlIZsKgZTseWFE1195XsmmdRJhDH/LY5PcbjrWU7WQotmfE0v/e5WHY0ULXcUEkh4x5z2w3JsXHyfs3VTwDIFOr1SSFH3LV+uJ9mod4bz42hKhnK6BPJinQ0T1+AVMlLch7yYXVFYtQFeGravM4bCOLFLhbyCSM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442498; c=relaxed/simple;
	bh=vHcDygPqhdBtu2zJ4o5xxqMzLlUyOEqyaHvavKPGr7U=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QOgGYQfq36eIVhg2+Qf0t2PjnkyHZwSH8+ZCH9tltkcLVqH3FnPXJ3Dm1nOqeY3kyyIKwgLxb/qgaGgTVvqlZyrjcTZuuqKUma5FGidV/9mzrA/oghY5nvdmQQUNFDyzJzS2+rmM/q/BbRz4oR1P35rSonjdxe8DKXqIZkDIU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YeCTy7OQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YeCTy7OQ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c01089e8aso1197361cf.2
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785442489; x=1786047289; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNzYWcuApQUfPM28AwNebBubGci2ntfBO/GAHnoi8nc=;
        b=YeCTy7OQMJznhFU/5UC+rAB1urv9eeCkTTqi3ZiY422RYDyxRfVIq0l27lLx6YK5SB
         nPyoro37vUkGpTuxIem4gRamvsfOmQVkMkcnxRbu74jHcaFDzlV74khrofr5plXhj7IH
         nQcpq5BsKqBpFaOmerVQ9dZHefOZlfEXVTXEY1g/KMqs/GXACUkvSvq1jBAhu7136kIN
         3cNhxVJD2CvNm5tcENiAbonfZOXycKc6232IabJyb1dhvpdTV+bfuXTGB1XhUsKdCcBm
         tXpAzpdex0TqttjT6V1S9V6MBfs1X+4RNWbRhVbWQT7RDKwK1DkxpvAZp7yZGilJJP1h
         8reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442489; x=1786047289;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNzYWcuApQUfPM28AwNebBubGci2ntfBO/GAHnoi8nc=;
        b=AAY1NXRNUY/HFpwXj0fJibTO5EOeXlH7fms1KoInqV1lIWbwnEiqleD2cLY5tsNK9Q
         X6CSMuMMRRnTV01aliQLPJXM39UY6ik//DhomWS7RtZKopPyS/txO1FQ5EeQsMm4wd1m
         idE4pq2ZIldPGbxLTgf9nspadqFZt8/0w3KEgVmnEXxOz48svYssNaN133KkBsaNFRCo
         tffNSNiSLi0A5AXvT7gPvFrmfNulGP1y47tOfmkwZaK8uPMsibGnc9hCU74gIHOa4KWj
         oE1NFD1+OEhPSoRrVFRi0XQ7ALk0ZEo4N3iiCbjFhCWODeeAqGvex3ESCIvfivHFcfsH
         DTaw==
X-Forwarded-Encrypted: i=1; AHgh+RpE1er6IAVBz/LQLkfV6HNYvQrVHRWi843a8CiAbBM0Mwm60stTuQCx1h5HD8tCoZy+qY7n75Vu@vger.kernel.org
X-Gm-Message-State: AOJu0YzqavuYg+5hfGupB3kGAi2v8nyaBBOKw2BWHmUxxn16N8VB6FcB
	PueC0YuMXOvm9rTqYuW9HqNj1tjqsch0bbcTqFYf8W70IcuoRJBTr4uEGbPnTt419Q==
X-Gm-Gg: AR+sD13ZxSk0Gkt4CbZNROfudc/LM7u5Kf87qD+KXykUZXizBcjVqK+EQMdY7u99sZu
	OHkJ3T4YMDoGyf4gCWkG7eOoqKn8V+AwIwTheiITA76wc8c2dZ1DayPLBoOAv/AcpWYOcR39J8T
	2t4/kfLGYIdxv67NuKMiVj4sHjt0HWBiY557/p3IgoJK4U/Fb4S5pTrF0MgCsm1w3PzQMLgrBGQ
	+IJ8dDWStlQfZlTSgZkZ0s0+tEoU3q7dU8jHV9ub7Qucn76c6iZfSlILycLPHFM3xJS+DLJsrCi
	gbb6BpQhitY/EU5h9hDiNSIYzORwNHAjvT4UhFVljnRxoeFJkjtr0AL9wtfqo3BtEU1xAf8qNqA
	+ZYgzk2qsrXTeMv2hsUGCj4l+LFlWQMZzxaBAf9cSzJbdoVefWcPb0eP4PWlIyIDWf9hVF1S0Jg
	8wpqj2IoMOEavJIece3D7LtJA73F815k5yddrXwvJQYYHhqEj9rf8pxcxaoutFwkFd1+O+Ddpd2
	3u5RQaCsUDHoUqTs6a4HzwArqt1bcDsxg==
X-Received: by 2002:a05:622a:5c1b:b0:51c:12bf:d4a6 with SMTP id d75a77b69052e-52b38661f9dmr44260311cf.48.1785442489527;
        Thu, 30 Jul 2026 13:14:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2d826fbsm47640891cf.14.2026.07.30.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:14:48 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:14:48 -0400
Message-ID: <0e717a3fd2a6e59b91aa4d15efde7caf@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260729_1758/pstg-lib:20260730_1437/pstg-pwork:20260729_1758
From: Paul Moore <paul@paul-moore.com>
To: Bryam Vargas <hexlabsecurity@proton.me>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selinux: reject a class permission count below its  inherited common
References: <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>
In-Reply-To: <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>

On Jul 27, 2026 Bryam Vargas <hexlabsecurity@proton.me> wrote:
> 
> security_get_permissions() maps an inherited common's permissions into
> an array sized by the class's own permissions.nprim, but class_read()
> takes that nprim verbatim from the policy image and never checks that it
> covers the common.  A class that inherits a common of N permissions while
> declaring a smaller nprim is accepted, and on load the common's
> permissions are written past the class-sized array -- an out-of-bounds
> heap write.
> 
> Reject a class whose permission count is below its inherited common's.
> Well-formed policies, where the class count already includes the
> inherited permissions, are unaffected.
> 
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Merged into selinux/stable-7.2, thanks!

--
paul-moore.com
