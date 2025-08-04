Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989516F8E9
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754338408; cv=none; b=exasVl6wU3qV8kKkMfxU0NdUE0WKNKy/KmhCSsMPlFUN6HzD6QaoEZx+07wvOcxH9gdg+jkqisRqm9AhJIdWyuDyt2yljmyTfOCP0GODbFiUEyweXcThf9ECGJKVxVqsnUeG01nrCfHUPvVHT2lA6ByfuArVhNK42DPMJDb1BwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754338408; c=relaxed/simple;
	bh=iAMISEL+whP0rmBAPPY6XSoEe/4DsdxED+mdUwdbF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrkWbDMonoko0YRAYlzEBBaAGYyqbeC5ALgH0BnA4Gz4WH0dbfMpDiIgVuRdqRVBmSFHMcuPWjvgxXcuMFOiwhX9nDFW162C55+JvGPAN58Ol77AZ5At1fJvfVhQxhr69Wzv6BtWWkmRiNWngOF6fKplHdmiLmC7EHGOs9RYQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BueDQMmS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BueDQMmS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2403c13cac3so44671055ad.0
        for <selinux@vger.kernel.org>; Mon, 04 Aug 2025 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754338406; x=1754943206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcjys6HWaz5UdeMdJ3p3iW42X5qoPCofECgkzkZ/hAA=;
        b=BueDQMmSWvg0JvqoCzYeHQoOA4D97xMMNGRdDL0oWvicEAtO31zTcIV3NcCUHpvZPJ
         mjG/jBoB6giCD58a54xfdzwMFvTTIoHiOKWAmD7NEYiT/6fx/Rp9jLO4cNKKTPQROmd5
         JlHMC4z4q3sNlJ7sm037gXcrSYw/bbZftxJYHpLydktKsVUi9kEJleMLRIcwQNWbaauL
         jogQgKQk9R7ZdS79sHgfekK0jAieeFIwqEMeAkmT/CcMX1pgyJ7oFgG6HlreweQkuepH
         g/3+ot0mWRIHVY1q0+CwnaG7HwQDHDus/yppF62dLtUIyGWvHCEUUDraaziyDHq9Ogja
         5E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754338406; x=1754943206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jcjys6HWaz5UdeMdJ3p3iW42X5qoPCofECgkzkZ/hAA=;
        b=Err01IEDLf+rU5BOf4WHcz04sYW4ZRhcqKQNtZr7eDENKFieFIyrJJd7aI6A98G5WD
         htBW8J0T4jc4/07FCRnMxzONhQ72BTMyeWBzVpTfxgixQUYvL30bYNifLs5fQQN0zVcf
         5ow2TfZ6IPFaqfvRbFyb0g+BoS8w3l7U/AtGUd+JNt1dzE/SXKE5feXHTF6PwKyZyRJB
         snFm53SbCal60aee1+ZtkaQ5FhxvSvwC1EqCNwAXQIqwWHu0hSNUN5SUFGs6GuR/nbwy
         /rG8iNcJRp70XeXuqtXLdSYbRE+K6F/CqgbCEqz4QkHwmTsaHgeHsRWETAlsuPJptj+M
         pNNQ==
X-Gm-Message-State: AOJu0Yw13sVG67M1THHCU4bGThEUAxijTFfkgxoRuJCKmR9GWG51vNGu
	qPqY29+xbw6HE21qnuOC+v2XdbZGj6+psYZyhXlVQE6p6aXm7DM4xRTcBboOtN5UM2J72xQDVUi
	z3TfJTpwLsFPe4MakCWiSjjCKju5SiB9nD3WN4r9v
X-Gm-Gg: ASbGncuwU2zMSejOFtmwbhGc8puV9G/bF9R93S284FXjJyVIvEKRPIue1WCN/FJuLL4
	/mI54IATd0ZeNBycEwryvcU+VIeOUy6TavkyX4qelK6R8skI7HHH8/DvfZXqcyku8STK5Prgew/
	EzEDS7UsNMBPZLVGNUQxAErtO/FKlFEF4NWs40p7SWwVTNtbmJMbp95zEfewXCtWMqo4rupzcBr
	fx7BcG78yDKU4JajA==
X-Google-Smtp-Source: AGHT+IGhCkKqJ+aOvbVhrvlmO+rJgVP0ZLaIQsUjuEk8JTm5H5T9RMp74mA7ju2ajCsP93eAvIL774lsQ0lYmIDCP7s=
X-Received: by 2002:a17:902:e809:b0:240:72d8:96fa with SMTP id
 d9443c01a7336-24288dfe502mr10180085ad.20.1754338406316; Mon, 04 Aug 2025
 13:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801154637.143931-1-danieldurning.work@gmail.com>
 <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
 <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com>
 <1986fe81af8.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CAEjxPJ6wM2Jv6J7Vdmk8H4GYXGgoeQFqZfRK3EZkv=9MgOdAXQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6wM2Jv6J7Vdmk8H4GYXGgoeQFqZfRK3EZkv=9MgOdAXQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Aug 2025 16:13:14 -0400
X-Gm-Features: Ac12FXwkYMg8emeau8xYYFcXliB8qOc1Yqs26pSQD1BK5n3WbxIT9HYfQ1CZzOY
Message-ID: <CAHC9VhSmgVM07r=ogDq69gxhVUSMvTh73h6db1dcYiX8XuTdBg@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
To: Stephen Smalley <stephen.smalley.work@gmail.com>, danieldurning.work@gmail.com, 
	ericsu@linux.microsoft.com
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:18=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Eric - note that Daniel also posted a patch for the selinux-testsuite
> to exercise these hooks and checks based on the Linux kernel self-test
> for bpf tokens, see
> https://lore.kernel.org/selinux/CAEjxPJ7DBDnZEFvgpe58K4B+4kZdOqUGMHvGC2vK=
t-4Zget=3DHg@mail.gmail.com/T/#t

FWIW, I believe Eric has some basic tests too, although I will admit
to losing track of that aspect, as we have had several months of
setbacks lately due to package building, email, etc.

> Paul - it would be good to avoid such duplication of effort in the
> future, maybe we should be tracking such things in the GitHub project?

Yes, it's unfortunate when we see duplicated work, but thankfully it
happens very rarely in our case.  We can track things on GitHub, but
with development happening largely on the mailing list I'm skeptical
about how successful that will end up being.  Our GH related efforts
have been very mixed thus far.  Another option might simply be to tell
people to announce a development effort on the mailing list, although
I can see that having problems too.

If there are some positives, it may be that both Daniel and Eric's
work are still in the early stages, so there is likely room for the
two of them to cooperate together on a solution.  Daniel, Eric, what
do you think about that?

--=20
paul-moore.com
