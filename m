Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129B1A9F9B
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827865; cv=none; b=RXiElCZ5ia+wIQDX+zw01q6c2YDtkRYndfb5VYczY595SuqdKn5MZbE5mDbAK8DYkipid5SCy7PXDiXfximPgfE5FuHYSZltBZVuzZXV3Lbp3YmxbrpEvysvX63NoQwCbQ1oXIQZucF2TpF+tiEpuQw0w0R/nIxAdycWD52cG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827865; c=relaxed/simple;
	bh=HDX1vDIz38irxRzjmhKxNAsgi3hHXTFvqpG5Z+AVS30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcvTuzBL8xAqVAPats1e9GlKlDyLa+LIH1u8jO6LJ2CsKq/hOZgIfVoHbRB4Y9wIszzwZMJMA+FVHmlDF5YHh/kMYYjYH4FxSnFN4MrFJ9iOFFMKAws7KWRmVwmvyHmNCe9pHfl6FV49RxDFENq8Smsmt/tNJw4SASZ+8kHZPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z7sLC5UY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z7sLC5UY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4717390ad7so1070459a12.1
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755827863; x=1756432663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcBAWRWLzV8vtHRJ/EsUJUqne4oZl3PFu9tayvpjkk4=;
        b=Z7sLC5UYgRndZdeJEyH7I0of2R+NfeQKux4stXUk0WwVZtlQfSuh19W1yW0OLfJN6b
         pYB+nDCViksrSXrHJR80kKSJaq/Z5YKtImQgd/mx1Yn79USjXFpKZqNhhogXDRd5k3mf
         pPBYeI2Vi7VRJahUiZBmPTWx2DDneDibMKS1FJi0GidCT389c2ypnkj4azIvwj4LbkQg
         tG0sJ9kUD6uhyRTMFCZL7AmU42jwmDynlo3ANlo0MmMteCKED++4bOdeLLjX0DCOAMNV
         cRcjeaeWa4jo6KkDQ0uuczMQkDqsX/54qTEbPVFuebE6rHRg/+ikHzzFBWpUKGKu9La/
         HrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827863; x=1756432663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcBAWRWLzV8vtHRJ/EsUJUqne4oZl3PFu9tayvpjkk4=;
        b=RP8LmR3WtKrxvf1bbJqI5gWj4YOMtBbNPJzFSoYIQI0noltyd6tiehBAgAiBu71wA2
         VWZAhJMtwgYIi+DXQNWKH3CHYwpxNSepkKAILFVSdlCQt6CV6cQIGUhJPy6HVp0yzI+l
         PsHn2BQVJuHJv1tSPwfXiAqKGUxOtzlYXJ5CR47lIgdkSJPf6tNya70w482NaNenAMVQ
         +SSXFiaAp0jCfe26w2xiTXGANz8WBPUYmQ0Ov0zIEexYxQPPP0KpxZLrJ7J8YKq14/ke
         yulzlhzFHUo8d2Pznhpl4lQjmYcKNfxnBzBJD46xYaZTIoLQNIPJxgrQjze3pqJzfzCZ
         mndw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ueBuMnsMOc10gatAqWHROXPs/Uyf9g7JTBdKeWjaMquZD8Hv2Un1jtGOLi23/bHfkBFwl46g@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRV18OQIYC8k2vuMMUhK5cVKwa+gCH7kwwqtpiyPx1Aj5oA+F
	w5wxm8kA4hCoWrYuDTtchkcG+NX0atCv4x4gyjK4roAnrPWqNL5yRDgOBBOyZb4jbNbizjBGKzH
	2HoE7K5+bEwuF3sfk56wbwDdF1UrCvsL0dwNGZuADoj89mdyM4Sg=
X-Gm-Gg: ASbGnctM0Fr/ONgiqlqqrp0DSN/bD7260vTepS/WSJ8SojYrsscXvO5ooR79dNHq/mn
	CEf+3i5FGUMAXg4Nvd1cP827KFBZ6gCxBkr1WVwPZrySbXTNKxpwFIi6HMPS/5Lc/SHPeOIfrpC
	xIRp34BUoX2EwXzJZgpJS2STd3YiLj02B1E3P8CQHEiy2/Kb8EroB89yHGfJsY+uUKM4XsZjGU5
	WupysU=
X-Google-Smtp-Source: AGHT+IH1ZNLlrreE+FgUP32WDzmZEEGJ35VFFAoRBIDSZnK7lVhaDwQEoGoFQeeB2hiGhWT/z4O7Mb90t+H3MSdKkm4=
X-Received: by 2002:a17:90b:3ec2:b0:321:c53c:4e50 with SMTP id
 98e67ed59e1d1-3251774af1emr1953469a91.18.1755827862963; Thu, 21 Aug 2025
 18:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com> <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <7d4d60d6-fe50-4646-9f9b-0cb524aef3fb@canonical.com>
In-Reply-To: <7d4d60d6-fe50-4646-9f9b-0cb524aef3fb@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 21:57:31 -0400
X-Gm-Features: Ac12FXy3E6XDKd9eaGMKRCdxhTTgCYLxDzvUXMH19j3rU9CkgbY9aMGY9kit2rY
Message-ID: <CAHC9VhTE3cf80U0BRJLhYcWj9vc6+S_8fotrEHo7eRfFkLnveA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:23=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/19/25 11:40, Paul Moore wrote:
> > On Tue, Aug 19, 2025 at 1:11=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >>
> >> The advantage of a clone flag is that the operation is atomic with
> >> the other namespace flag based behaviors. Having a two step process
> >>
> >>          clone(); lsm_set_self_attr(); - or -
> >>          lsm_set_self_attr(); clone();
> >>
> >> is going to lead to cases where neither order really works correctly.
> >
> > I was envisioning something that works similarly to LSM_ATTR_EXEC
> > where the unshare isn't immediate, but rather happens at a future
> > event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
> > LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
>
> I do think something like this is needed to deal well with the two
> step process. Without it is fairly easy to get into situations
> where you either need more permissions, than strictly necessary,
> because of steps in between or as Casey says things just don't work
> correctly.

I think we're starting to all coalesce on this basic idea now, at
least for creating new LSM namespace sets, that's good.  As the only
LSM that really has a namespace currently, would AppArmor be able to
work within the lsm_set_self_attr(2) approach, or would you need
something a bit different?  If so, can you give us a basic idea of
what AA would need to work?

> There will need to be an additional call that allows entering a
> namespace separately from clone/unshare, but that covers a different
> use case.

In this particular case I've been thinking of not allowing the same
level of arbitrary LSM namespace composability, but rather limiting
the caller to the set of LSM namespaces already configured for a given
process, using the procfs/setns(2) mechanism.  Does that work for your
use case(s), or do you need more flexibility?

--=20
paul-moore.com
