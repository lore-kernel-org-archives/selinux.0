Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99376125D5
	for <selinux@vger.kernel.org>; Tue, 17 Sep 2024 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539864; cv=none; b=J2nvZkMh3zJWZSgdfzR9YeWEIXnpwOPx2JQv5lR8LsvkOY7nkk/zGDFeC26WIuECdjNy9C32M5/3ynXF6oG0w8WhIgmfLhofmqjX5KB5IeuHhGyCDrjUyDEvOBDBK5wTC20mindQzmd7IkhHWg6mhPjnaxCvFDDV690huV7walg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539864; c=relaxed/simple;
	bh=imw43ZxZnxSMkGSBaGcTT6qZruqK3OcjYzR1pXVsAxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rsx69zsiDQ1WSDuJSBujFyVG9inzsKX2A1BZ20KX3jDna1x0+pI1wCfxGYmXT+ly8S7TxJnuKR6FtK9x4Cp6loEqhKpDrCCTJPymNRofJbXktXc5D8g4RyPdboYmxH+zYB9uW3pFfltp4UI9rxnspxZFJt8A+XE1Wk66AhYLieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjrBTSrz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjrBTSrz"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so7208a12.1
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726539861; x=1727144661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LBy6DCx7BMpiqsnkARibBX1FTddH83tJVGeY6jKmNsA=;
        b=KjrBTSrzgzXN3pMs/1qnH4vHU2CjDJehKFfWnIx+ziJRVk4DFLrh8gZvb/QPg5gQey
         S5hzCjfBzvgaPt6TXBH2TmGzVuwbo6aPozJAqcthjN3C+DpboVR0Ocv04ElCNE4zYjhB
         2X3u2mxVg1rMHXEtbXScreZQY03Ul6NHkQq82GKT2j7xXUHXez7wqtitguAnMOb1GFKa
         GrG94iOYWDnqQ1++fF5MIHZa80Vwo+zS1GV+HlVVzhobUANQdzcOQMp550YW/Dv0iw2l
         qDcjMrl8DqbotACOJZOKVKyWb4nDqWnwQZ1Zny5Cr8C1HFpBVMzZis5PNLe/KXiUozOI
         D+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539861; x=1727144661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBy6DCx7BMpiqsnkARibBX1FTddH83tJVGeY6jKmNsA=;
        b=CZb3Ba8hxattc7f/bBmLzWffSMWSt9jTmqE0D/MCvbIJnn+/GQcoq8tFzlmCsVTbyC
         asdspnAbmH75ThV4QN+8yccQO/2jaInaBM9fOCmWpZOCprn1gUrdApAJRh9qsu9T3Gb0
         7I83bYxHoIDBzIZ1ZSHnBH/dfxVZNTwJ0cUVCY6uOMq2lRiJuefXpISVauH/aU6n5oWL
         jrAEJQMg/+th2pNTY/sv+UUyGUxQpXU9rx9Iem0CBcNLVeLhLQx61SCHDFfR0p+EoI2l
         jr/E2k0wtVLFtr4MjahgY5THviUBEP+p7MqJrRxrJZoPMtMhN/MVhHS+PuoV6kh4Yn6H
         7Wmg==
X-Forwarded-Encrypted: i=1; AJvYcCXUhFhRHkjggOnltUbva6lC+3NAm4NJWJkYBxcdlVzQg4IMrzpc87kLu4sY0osO8lGWPDKdYteb@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoana4v9oTeZUOSIh2d1aY14/G96nODP5Ah7WAQm2dOY05yoV
	nzVw/i9IWha2M2Hz8HfXCTsjnNPe/yiAfS20ID6j/WLFb1XjGr7fVE4QGPnxoT3cUhV8Bn3TOWd
	m8NRt5pF9LupnOc4HaYH+PeIdwoLdkL+IMqpH
X-Google-Smtp-Source: AGHT+IEoO7zbjo836idZ8otONsX268DRBgPLIA5wlJyGAWKPPYM/akc3kOVMeMuc7Il7FYKVwmRg3s+QGlved0wQXkA=
X-Received: by 2002:a05:6402:35c3:b0:5c2:5251:ba5c with SMTP id
 4fb4d7f45d1cf-5c4468150f6mr256302a12.0.1726539860040; Mon, 16 Sep 2024
 19:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912014503.835759-1-tweek@google.com> <34803d945f405dc2e4e798cdaf057994@paul-moore.com>
In-Reply-To: <34803d945f405dc2e4e798cdaf057994@paul-moore.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 17 Sep 2024 12:24:02 +1000
Message-ID: <CA+zpnLd4AhhSUc=+pmGGwDPbRSjDPT3uKy1rn=R=h3H9oW3GCw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Add netlink xperm support
To: Paul Moore <paul@paul-moore.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Looks good to me, thanks for the revision.  We're in the merge window
> right now so I'm going to merge this into selinux/dev-staging now and
> I'll move it into selinux/dev after -rc1 is released.

Great, thanks Paul. I've also created a pull request to update the notebook:
https://github.com/SELinuxProject/selinux-notebook/pull/40
