Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B80448399
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588551; cv=pass; b=mjOvaFcxs5Xd0OqGabM4yc0oxpu8cyTwf/korP6QWCBUcO44/Nbv4zurr5/P8N+bwsBu5OfV1F7LdEooCDIMiB+4/fZW4nyANavl4wIbQrf3xBSV8bdWbsxv8UJRxzmKa5IohmJ5NTfN1rVD0FoT7mRoHJx39u85cxIfo7RtWzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588551; c=relaxed/simple;
	bh=7WCQXHRe+Qk7nQb1TQW5P+PPYDe3dpEZVvMFA99TJxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l00PkoJcvFgaelyY9dvXSFIBdRRPvIx+mUY44vcghBsikBKGee1Uosq6xh77CInZlwfB8/FHKsHZhf6ePizKY4GJYfJb2EE/PpJLtdAbOpUtOJ5Oh0hEQ5warpOIA9/DBZVHqRmhhm7zSHyTvAqCSCcFKdWxFxVtPBU09zMTEaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNt+v2jE; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNt+v2jE"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so893720fac.3
        for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 12:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789588534; cv=none;
        d=google.com; s=arc-20260327;
        b=ljhqXvxZDM7mM6xpgQnhUO7HzSzy8nS8DIvgR+DzB0mlS3CEmOLUM3c5ydN7lh35j1
         btz2d+mCFDHLA/TYlLhds7VaeGKSvOOH95CwqbMRD0h10ZVVOvJv1FU6Q3d2oGX1HCQP
         4UrRvFlXmYOXKePFmbQCJZBeG2x20lay9TKXBzFdV2hm18JqJDCfY++XqUG1WFuc869Q
         t5A0QHoaD9zcwRxflRBuOrKDRfQGckRPNC0mP0sRsuJF8k+MrARVK/PXsijwbdgO36WS
         c0OU6OOAagVXcTxOzzbLQm4iVjL+MmlneiZ2wSk/PGECIC1CvbfeR9xMl5ebsWqMrq3b
         99yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gM2e8rZLVUGW/dFYfG5F2I3FBZ9Q6TbZpMQ4NV02iSg=;
        fh=i5DMMCNtK5zGzY60uNBdf2AUNjIRWlIAsQt/y+elw6o=;
        b=MVD8f9e0T02NzYToNJSfvc0YVLMSV8DSSvMCUkVwpIW5Qbya/NO3TK/WMhJmbanaEl
         iGUMWvVKCYmBZAmUJhZtarcaq5AvluiWLvGs14TiHJ0vYMpYT3GOdRt6roBEO6usxC8X
         VOtjNH+2Sr93T7/8i6JvBRaijwT3EnZCSP1PTILqc0FdEfYPloB/NTzT7dg08BvAGr24
         v1lM1Vf2FMe5IDKHchvQ8fofQ1h0Ij3HTX9VGtv+KUuqWSgQTxwk3ltHvW/IosxoCwkI
         SoJIlqgD3IW+tXCuqFr/hbZywJOXxvaKzsEA/KemzzABG69Lb1GHWeJ1KBrdC29Fz4b+
         ArDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789588534; x=1790193334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gM2e8rZLVUGW/dFYfG5F2I3FBZ9Q6TbZpMQ4NV02iSg=;
        b=RNt+v2jEqrfDTz6nH1+X6I2Jkh6Oy3npaYt7gO2lCmKEl93qn+5DZcdlNAKgOWiOG1
         R2EMvAGgJ0KHRv4S5sy1kf0cbEwCfLHh4DNm/eA46SLMlrMZckwgNrP8eLGG6chjCwqD
         bJJR5Xfz6N39FVvD3qILjmDoIAJpBEwSnGOkRrg3dmn/3GUhMgWgPEj+sjwCijBY08rO
         s81XPXFYiTXpH5JhngJEDObh17JxyPmbWOYMZvtAopfqFl4KfGZxtlMEGiC9oA52Vw15
         rvmpTkIwfnnOd7NuhmdLPTYqC6UILxTOdlj9dwVyOwOJhLTnQSbwbaXVhPtMOcBmbo8J
         8AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588534; x=1790193334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gM2e8rZLVUGW/dFYfG5F2I3FBZ9Q6TbZpMQ4NV02iSg=;
        b=SwvoElhZpZrC+HUxpjIw9aLI/YQJXhRHJb3Z1+gFXoxAnbQ5G0ql8cjvwv3sEStqLm
         3E3GL3eOMZarMyoID0Ga5QwDHiSkx5WetK7ZO1jYGSDm5TDoXuknb82VElhaSU6WhM58
         HngHMXPp99nngiTnf7waknVqGyFCkjNwlUns2etghg+3MpJxqKat5Vb5Bui77psGXSuI
         iZmn0wfNZDLgDI8aefIIjLbAJfod5R1FByR8kWe6m3x5+vrU5zdKggxm0hOaSUE57QAO
         5tp2GySen7xpc0kaZGtLEYuSsmiWBWwoSzzDY/38Kcny7ju/Tn+vxkQdj2kna/rjSGz0
         IHOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0xdTEt+SV7+8aiF6HErb85VwWdd2AK15zLYEbJoVE5GR8nOiPa0XP5cdNU5gE0t9l1jEsxBz0@vger.kernel.org
X-Gm-Message-State: AFuF++lgE9bkOYsVJsYls7LmeLo5Gr+SlJagSINhNJOpELTz6den245l
	Fcv+c+FxZuqFsKXSgKDWcN2LxwkSbA4bSa4QvBzq21/i1Zxzuicas5hJQ1aPLpjbx4m4/5UHkGI
	PfC1AVnd8qy5PJXJ/bkEZURiETwTd3os=
X-Gm-Gg: AYBFou0Qk2VEXXgFg6yv1IoneUSrmVcyU/Yq55e5q1HOMxHDL/lF48Pqgsl3sS5WrfP
	UsODvQelcmXKsh0C+aCCRaCzVdEK+upWq/2pEIIS/JP7J1et5Kes5N1Uf5zbHNyVC1NMab+T0WX
	rspU8eAkEaFztfEJZb0bHD9eGf8CWkBzQK7TTUQuR9sqjSokWnCk0bgvXcCvvqXGWfjMWOoSMQb
	KEOBu9p62URY30Rcexk5/KAEnl6zG42YluqMKb7DKICiMALkpmXjX0AY+oTTkBfsA2SnXeqWnRi
	90pIRp0GMPJz0FAs07+W+30jHIahVwvNZ7x4mExqW6Ql+Wpz9ZE196c=
X-Received: by 2002:a05:6870:c28b:b0:456:bebb:a894 with SMTP id
 586e51a60fabf-4847596c678mr7637603fac.8.1789588534489; Wed, 16 Sep 2026
 12:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
 <876b917a5d999b14351073aba6aece2d@paul-moore.com> <CAEjxPJ60Wh-Mb1b5fEXXtjjABtz=9mHH8rYFwXagv4YcAgRuvQ@mail.gmail.com>
 <CAEjxPJ5h9rqLTkmK0pdtOUxNdn-J61jHa+TboUpUUmS-ysMuWw@mail.gmail.com>
 <CAHC9VhSuLRMSrOjH9S1RHQpscNhYEUADa1Kb_7gYePUcUw6NbA@mail.gmail.com>
 <CAEjxPJ41irF+1T=ntzL5pB2UMBAWDv3yMwtSJB69J_tvq=Ao9A@mail.gmail.com> <CAHC9VhQU4VUac7DqC6FLYbH8-BV+uYivnncTQy5KV+cKpCd4aQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQU4VUac7DqC6FLYbH8-BV+uYivnncTQy5KV+cKpCd4aQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 16 Sep 2026 15:55:23 -0400
X-Gm-Features: AcwNN1XXLJxBvb_3WWOH5IJJoytqVAj6scUkRErmdcK14_IhoUBKZ48hGag5lzU
Message-ID: <CAEjxPJ7q8x4rFxtKyef3qpyYGupVgiNRxPWk3yg7HncS5h1NMw@mail.gmail.com>
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and
 namespace_install hooks
To: Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, selinux@vger.kernel.org, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Aug 28, 2026 at 2:32=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > > > If we wanted to fix that, we'd need the patch that introduces the L=
SM
> > > > hooks for namespaces to also update security_init() to alloc the ns=
sec
> > > > for the initial namespaces, maybe?
> > >
> > > Somewhat independent of my concern above, but yes, that's probably a
> > > good idea regardless.  Assuming that the namespaces are properly setu=
p
> > > before the call to security_init(), call lsm_ns_alloc() for each
> > > namespace in security_init() and then each LSM can initialize init's
> > > namespace blobs as necessary in their own init function, e.g.
> > > selinux_init().
> >
> > Ok, I've lost the plot on that patch - where is it at this stage?
>
> Merged in lsm/dev-staging with the expectation that it will move to
> lsm/dev next week after the merge window closes on Sunday (it's in the
> LSM tree as both Landlock and SELinux have pending patches that depend
> on those hooks).  If you want to submit a patch to allocate init's
> namespace blobs in security_init() (which would be very welcome) go
> ahead and base it off that branch.

A patch that does this can be found at:
https://lore.kernel.org/linux-security-module/20260916194824.37332-1-stephe=
n.smalley.work@gmail.com/
