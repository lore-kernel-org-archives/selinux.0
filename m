Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AC494824
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405561; cv=pass; b=sxjGu2WiT47K0Ou9VBjsxLF5W0FifpA/oL8qb1e/x6N0Vr69tzosRrN5nCANEcoBplD7i7yHq+qr1n6j7GGyVJEQWbQbdxvRzEk3U18cpN41/RS95ULnWVavKS2+W2xoXibzSYG5ns3RpGcoCk44KOJeyu+/ibpX3hGyY69JYIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405561; c=relaxed/simple;
	bh=jUNXLbhXWn3k3vtDnvsdLvoggUO4T9CBTRnFjm1YrVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzsKFQczcOtqME+u5xqOCbnDZrNSGEU26goeR6M3zH5V6S9dTm3Cf16gsHJR/DHSyOh7GIUvoQbBbcD9Ckjb3Egme16mKtC7FiTrVS2+5eI2R1QSGA4c4YkDayqzaTkzvc5AyRt7N74WAMrmg3UcgbITi9KkyUO8iZq8ge2t6qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a1fBxC47; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a1fBxC47"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so19295845ad.3
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 10:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789405553; cv=none;
        d=google.com; s=arc-20260327;
        b=LcagEMwfYby+MQE0mo13XQXHQqfO82ouiz1MlN+a6sA2A2lq4fZN0/fxaGu6eRaleq
         yWKMtXffPZsfzberKQ1zHeu3+ALw2p6O2D8eEAHhso4jWSsWuMqAiKZHY1JDfUZg43Ix
         mQljcf3VgGWOLPP7HV80bH4Wd2pdStp6m6DoIJ41bsW4R7SmlHwQQv2xF+QEc5l/ht0J
         eLjDKg/y7t1YSqKCmm0fZ524it8wchetaheSfrTmGISyFG+m/ZCTcPMR7JL/nXQE1gh5
         4C47BmDpoOe9UPjvd0b3UVmTEejqKxOmKLGzdJ3ziH9Olc45dT+tepj9u+nW4EWS+HQy
         OaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=avx3LuQUj0eIvtk4vMhq4fafE3JrorX2BSEZUs9YMHI=;
        fh=3GFm15ZZQlIcePenrKk+saW/OXTrnkAqb8TvHBUz5qw=;
        b=lbb6DEF2jMn9SMJ0UGILB1fOnK/l+XkXLtSEsEV/k5yYAKyHJtCMIzfvT37enmiNm2
         69wtYLOs/O+RUm/Lpy6edP46PaUhdrcX33EWOEeIa2EK04VCP3EnI3AwN0oH9N3pZafh
         4RU0L9Zga1YqJN617TSP+Alh5Tj/AUecL0FqPTfTNxD7tgGTii4pipNlEeucJsq6P6ZU
         nMYZV+BopHk7Brxgl5lO9iQ/vEQkBUERT2/TF5fnILgB05qxZmQj0hL1vNzQZhlRst3m
         K5YkdwdWKb4AfVoRwKMCK1GPoUvfsFG7N43M92rn8rPrRGXidK6x+V8i12T3QSxAtSCR
         tleA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789405553; x=1790010353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avx3LuQUj0eIvtk4vMhq4fafE3JrorX2BSEZUs9YMHI=;
        b=a1fBxC470vf3gxUdvMqxfHcMHafJCFiwxvZ/34cxN5DMhy5NefppljZG3+7bfXsvBp
         kTcTa71VdbJ9ubCpfuDGkg/TmTtaHiWP4bLh5MTjx2JUpl+tcyOsVsdzJMUknGwxAih2
         mDcxs6pqVHw6A6ce0jhz16k9evy5J/1vGA39mGNoMWGJavGmXv0VyNqJkWVYqQ1IdWef
         o5yM3BsjYetzoV0xWaA6d5iFaMmEFxsCNch0sgNZbQfF8RCQ+Xdte8v7OmFCq5Dl9/oL
         c3FShJpn/SiNI6MH3I9OzvW29aUWIxa5d5SDLSHjcrxoRSSgKOXMA0xjkmy1dRA32cKU
         f9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789405553; x=1790010353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avx3LuQUj0eIvtk4vMhq4fafE3JrorX2BSEZUs9YMHI=;
        b=A5Yzz4iGL+TaI7hfk7YmWehjWieZp94a4URmCk8WmI4tfTB8c87R1s5q6zS2rn9BI2
         PeIxGPWtMBQjrCvxjlYTERwPzQUvutuUhtpon/gBFZgr4NHrzc4aQJVd1wizSjDfjXwd
         5wvxeg6UsfC1Qwo5SIhI9q4TciGu84w8AQGPoyxs3g3BP4zc6cFGRsN24AG/wt75dqwK
         aUERP0IrAb1U4RJQhqvD+q8qKOm6sxCoHMsM28rwQALi9NVyh+1woIp78b1SbwMG36Ul
         srA4VICF7HuDTeS4MC7bRMl2ETxbjX1tYr2FYoBkZ5hPMC8aOg3OJwd3Oy+yPV/B9VIm
         tMKw==
X-Forwarded-Encrypted: i=1; AKwUvBxB2/fqLghVDtS+rB+jhfqKOJPd+AakZpu5HKQQkkW33NMp2xLfGlfAVFcmS++kIYnCZRl3unot@vger.kernel.org
X-Gm-Message-State: AFuF++kcvi+8g+gpiHR0nbeYKP3xGZulosx1f0osIArcD1w449QX2cXD
	lkVm6vW5ytAWoLY+tyjoDXBxESUXRjDdVBM44jifb8Znanfc4KSZf2/ywglNdl/WN43mZOrjone
	6R2o8ht29KedYZ7sHu9VyUPx9n109cS4bWiceuHMq
X-Gm-Gg: AYBFou0jBrz2Q7Iyf3yuOr68eqtwaxg1ZSENoVQX7KoCvJdGYwPC4LHoFBMSAfAOiz4
	51E9cv2UUyW5JYKk8skeml66BAE817Jtm9P4qv6dK1EUQASj8Uw9GDDua40PPYvx4yZYvmc4j9D
	VFCLxEm+rTY19jXH1GS/4Yfg+aTveBlHbE162U2lWp152XmLox77JvPrRBojGgqEwLNLb3M+nqC
	71uESOySiY6n8125GN1LJrpIVb716Od5Ox4ZQM7N/fONB3Bq8auRC0PTql/dT4rML2e09RC3YPk
	6yj5kbXiR4PGVciMHMG93tcpgNrRX3CcIID4QmvSdezFaNwYvBM9OpwJ5YFseHEwWcJt9HmZtGA
	f1TOLMc16rUA=
X-Received: by 2002:a17:903:2cf:b0:2db:56da:6a0e with SMTP id
 d9443c01a7336-2dd6c5f140dmr73526135ad.9.1789405552920; Mon, 14 Sep 2026
 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com> <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
In-Reply-To: <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 13:05:39 -0400
X-Gm-Features: AcwNN1Wk1GrQXU1YfDdXmUukQFqj25lXZKtxh5blfh1kI19p2jakplNL0VfIjvw
Message-ID: <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:48=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> > proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/mem
> >
> > The goal of this series is to let SELinux prevent the use of FOLL_FORCE
> > when a process writes into /proc/self/mem and the system is configured
> > with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
> > is still used by current Android devices).
> >
> > [...]
>
> Let's move this on a shared branch that both the vfs tree and the lsm
> tree pull. That's the standard way of handling dependencies between two
> subsystems that want to route code that touches both of them. Branch is
> stable.

For some reason (/me looks at gmail) your email never hit my inbox, I
only noticed it now while reviewing Jann's patchset.

Christian, can you explain why you merged LSM code that I haven't
ACK'd?  We've talked about this in the past and I think I've been
fairly clear about it; I wouldn't merge VFS code without an
ACK/Reviewed-by/etc. from you or Al, I've been expecting the same
consideration from you.

While I don't have a problem with a topic branch for this, can you
also explain why this topic branch should live in the VFS tree?  There
are more changes under security/ than fs/, and unless I've misread
Jann's cover letter, this entire patchset is focused around enabling
LSM/SELinux controls and not necessarily anything really new from a
VFS perspective.

> ---
>
> Applied to the vfs-7.4.shared.lsm.foll_force branch of the vfs/vfs.git tr=
ee.
> Patches in the vfs-7.4.shared.lsm.foll_force branch should appear in linu=
x-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.4.shared.lsm.foll_force
>
> [1/3] proc: refactor /proc/$pid/mem to use struct as private_data
>       https://git.kernel.org/vfs/vfs/c/d5662602d178
> [2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_AL=
WAYS)
>       https://git.kernel.org/vfs/vfs/c/9f90f96af73d
> [3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
>       https://git.kernel.org/vfs/vfs/c/5dac8c291d9b

--=20
paul-moore.com
