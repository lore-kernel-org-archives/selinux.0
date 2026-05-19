Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68543E5578
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179124; cv=pass; b=BiSZ7v6ve9YwiG7zG0W+0ZTv7ZaiGmIVksxHgMECUwSplUdGMao/lLkGOnna4kVpy5hSMswwdGBiXiDjSzFxMe94+32HSCg+EbXrawphdJSkwPIvfOmpW/k4KpARK5EPl37aleRTYVonAu5mEDThE83GvFy8eq/WwzIEPPRUMLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179124; c=relaxed/simple;
	bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmNbaQycAtgJcPRnr6zTmUVSRWeXb0Hayh0vkAbZij99b7D/VGoUlVI1jtSs/v/E26eFFkvFXUqn/WIbgC5d5Xi3Aq4z8PAowsMkVx5nfO9AS/yvlHK7hE9jeLJBTcdO119DJiYQupTOKFmVnmRYY1xKFOjnG8f7OWbvgKkzWNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSeEuK8H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTM7iW8X; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSeEuK8H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTM7iW8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779179122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
	b=XSeEuK8HhLnqAehTPjnPbJXtjiAhAQjl05LpHXwKxBsTFS/6Pk5HZn/lKE4HTVxBmODFnH
	eimlojeysh9zo2NOw9SetmuwyvhqDbeZCYC4BfpJLyGDeUTLGvOUsnEvGowuxcFb1l7VPh
	EQnnd59yVXCa41wY257j8AcLwWHY50Y=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-rawJrxFIM4iPGTZDxGG4Ag-1; Tue, 19 May 2026 04:25:20 -0400
X-MC-Unique: rawJrxFIM4iPGTZDxGG4Ag-1
X-Mimecast-MFC-AGG-ID: rawJrxFIM4iPGTZDxGG4Ag_1779179119
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7c027fb7a62so8299977b3.1
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 01:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179119; cv=none;
        d=google.com; s=arc-20240605;
        b=hCj6+A4JU4fu9RU6hhgbuXA7DgY0i1GUIiGcW1UjaRC3KEbi/qIPGdFnk3ufH6QgIE
         Vt1NO7dVmhuTUeVdofYXtWeOePk5AlpN9ftURo0d1els6JF73ExyhIZ5sY3vquFBlCh+
         3Qm4y8NBxYpggFFpWIDVOPS6zom79gGkGfZtWKjhs1t3GqoOj8ky22fIE/qR21p//Z25
         9m2pYUhlAy6h2LnfKXL+DNqjFJiRAyJ3PXIPcpaYQHPJXXalmiUIh9bFP7F84YbtHy9/
         TPA9mOa9eQenD9bXBJO9S4kX/SIgs0TJcDuLMb1TqSWBwdn+s1GcsIL71Ahw6voXE0zk
         AaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
        fh=AI9qUMn8AwZnI0ILsLhyFFPpt6zfMRyNkJThCtaaj1I=;
        b=VH22T88DNEr5zHW5KtQVmtNhiB/+GExZYRd/SNkOPqMhGh1xjNmjANJefQzSnwvQ6i
         NjdZbrFiovGXQNHl68ePBFTrsk+Och2hxJPK5ACmCcVH14z20lK1vav1PVDhCYXpuHS/
         y7NTBSYSmOMnQSvYReYjAbZ+X223UHLNOtg7M6c0URGCCKNh5rOq0C1D86c2l9AzxiEu
         dqf4b2NdkGCuQV6oaIs7u8NIKO1RhjPgK2CwqhjCG2s8S0Yq93DU8eV43oYRpS/0s8Q5
         5dC+pz4/OzqYURLlWq9igIY81kZxif+OXB47pPoe5xe9FNoMRBuHZ/wnuySMoYJWLkoQ
         AC5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779179119; x=1779783919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
        b=PTM7iW8XX7Fc+svTNvQEPyrabuPKevYgU4wwNa0E2GH8kYNmCTP076uluaszhaEraK
         v/CYuBcnqj0wOzxgH7z1HHOr6Wa9fIE/4W5rKBG0UW/t69AbbsSzrRlZ+tpCYksa1jyb
         ly/65qoT2WsmO/uRyZm4CoZxr+3IjVuIa8dazFTmDVs+YwG4skJU54pbMzwUjZtIEgkl
         j9HrbNhe1ZDSSgEV1+zP3CDzfLrH/a3gdTDNbhpOR09W8o/DsT383zAysKPGV6RnqBmY
         Q7tDkwuSEgOTUbmEdCyswSIz4kSFHRgVMVyG2cHf/lMXFdxONybSi0MZANYMekQRnSGz
         I7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179119; x=1779783919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zmlcsxs7JMP5bdHZ5kThghYTTdo51TjoA70ut3zJssU=;
        b=LL13YlJKY5CGxmlOR64JHv0Bg0Wcz1T/3n3eI4DEvFMmhcmASgL1iZAwd5MAlFuOCH
         vnqFLNXDLInwq1EdF7vNONN3XCBla4pP2xmpNUQGtcf1kyWz69kDNGCEZeERLcxTfGBF
         hovVoBumvR16mnjrsM6OTFlUWwjpJROYjeP7gHhkydZNYO0S5v9qw0FF9BU8xlrQgbtZ
         oRJ3WVj1tBAnuiyXuLoopJhGlwIWUR7FDARrOo5zfx/cK8bo3GHasIXUdKnYX3tkxP+o
         RIQ4Wf5BeFg+h86gOaPIIJ53N3R4ea8wwvLWZG1JepWU0DV8lQAB1/J536eK/xJ7ix+1
         Tp+w==
X-Forwarded-Encrypted: i=1; AFNElJ/sc/a5qBANW3Z0G9pJBsDd/e12sNJou+c4UhVr44299u16K61z0cQaLwIn5jXjopQHyVKLXF2T@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWUqtrQVjysOOsM5rJy1e9TtDeH7dr1dHQeksxeuv6A4KWzFf
	rR1i6+citQMVVrUBFEwYl6lKGVcZnGw/HHlIMRFO4VIwqFzpWulz8MA3yccJhjbzA6pLZL5o+oJ
	35LyytVI9Qrq89XKto1t3f6ffDrcWNcHpVYvRkuiFuxTUUwjaVeb2upuV5ffMubeql/XHPVto4O
	8L0mz3x96lb+2SFsRCGOuF8BADQRX9xDBZ4w==
X-Gm-Gg: Acq92OFPLzLd1uRAq6DtCfp70XXs2ciQmb0ecvw2vX6jgWh/Ui0nttf55AQTbNm+Aq4
	y+b0jMyCaiz8PovBc6hn9AFJlRwS+iTwXOoT0CvrWjNqP/kBgYdYW++hUeGBtT/R85IrM5Z7zSd
	y8cwewfhVbKRDssGelIfxECZpXkCksGs5QG0SubA2PV2u3rHy6zLblbbgctXCYvtWAZlFUi6uQi
	6wGvQ==
X-Received: by 2002:a05:690c:e041:b0:7b3:edc7:9bb8 with SMTP id 00721157ae682-7c955b970femr172557217b3.0.1779179119486;
        Tue, 19 May 2026 01:25:19 -0700 (PDT)
X-Received: by 2002:a05:690c:e041:b0:7b3:edc7:9bb8 with SMTP id
 00721157ae682-7c955b970femr172556607b3.0.1779179118837; Tue, 19 May 2026
 01:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner> <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com> <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com> <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
 <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
In-Reply-To: <01b6eefc-c107-4f8c-9d7c-3b86f54cabaa@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 10:25:07 +0200
X-Gm-Features: AVHnY4K5LncaNoVhZCnb-g1Oej_4CFtS9sUy70LBQyTJDD76MUlJZifB3Hgf-cg
Message-ID: <CADSE00KCpCHOu2GMJ++ozXXbwF13fd2ZfmC3CnZBdLM_0p+ZMg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
	echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/26 01:39, T.J. Mercier wrote:
> > On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/18/26 14:50, Albert Esteve wrote:
> >>> On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>>
> >>>> On 5/15/26 19:06, T.J. Mercier wrote:
> >>>>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
> >>>>>>
> >>>>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>>>> On embedded platforms a central process often allocates dma-buf
> >>>>>>> memory on behalf of client applications. Without a way to
> >>>>>>> attribute the charge to the requesting client's cgroup, the
> >>>>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>>>> ineffective for the actual consumers.
> >>>>>>>
> >>>>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>>>
> >>>>>> Please be aware that pidfds come in two flavors:
> >>>>>>
> >>>>>> thread-group pidfds and thread-specific pidfds. Make sure that you=
r API
> >>>>>> doesn't implicitly depend on this distinction not existing.
> >>>>>
> >>>>> Hi Christian,
> >>>>>
> >>>>> Memcg is not a controller that supports "thread mode" so all thread=
s
> >>>>> in a group should belong to the same memcg.
> >>>>
> >>>> BTW: Exactly that is the requirement automotive has with their nativ=
e context use case.
> >>>>
> >>>> The use case is that you have a deamon which has multiple threads we=
re each one is acting on behalve of some other process.
> >>>>
> >>>> At the moment we basically say they are simply not using cgroups for=
 that use case, but it would be really nice if we could handle that as well=
.
> >>>>
> >>>> Summarizing the requirement of that use case: You need a different c=
group for each thread of a process.
> >>>
> >>> Hi Christian,
> >>>
> >>> Thanks for sharing this atuomotive usecase. If I understand correctly=
,
> >>> the actual requirement is attributing dma-buf charges to the right
> >>> client, not putting each daemon thread in a different cgroup?
> >>
> >> Nope, exactly that's the difference.
> >>
> >> The thread acts as a filtering agent for both memory allocation and co=
mmand submission for somebody else, the process on which behalve the daemon=
 does things can even be in a client VM, completely remote over some networ=
k or even something like a microcontroller.
> >>
> >> Everything the thread does regarding CPU time, GPU driver memory alloc=
ation as well as resources like GPU processing and I/O time etc.. needs to =
be accounted to one client which can be different for each thread of the pr=
ocess.
> >>
> >> The only thing which is shared with the main process thread is CPU mem=
ory resources, e.g. malloc() because that is basically just needed for hous=
ekeeping and pretty much irrelevant for this kind of use case.
> >>
> >> The problem is now you can't do that with cgroups at the moment but un=
fortunately only the kernel has the information you need to know to do this=
.
> >>
> >> So what you end up with is to define tons of interfaces just to get th=
e necessary information from the kernel into userspace and then essentially=
 duplicate the same infrastructure cgroup provides in the kernel in userspa=
ce again.
> >>
> >>> If so,
> >>> the `charge_pid_fd` approach achieves this directly by passing the
> >>> client's `pid_fd`, without needing to add per-thread cgroup
> >>> infrastructure.
> >>
> >> Well it's already a massive improvemt, we could basically stop doing t=
he whole duplication part for the GPU driver stack and just use cgroups for=
 this part.
> >>
> >> Doing that automatically for CPU and I/O time would just be nice to ha=
ve additionally.
> >>
> >> Regards,
> >> Christian.
> >
> > Hopefully I'm following correctly here.... So you are duplicating the
> > GPU driver stack to achieve remote accounting on a per-thread basis?
>
> Not quite, we are duplicating the handling cgroup provides in the kernel =
in userspace.
>
> For this memory usage information as well as execution times of the GPU k=
ernel driver is exposed in fdinfo for example.
>
> > Does this mean for GPU allocations you currently have some GFP_ACCOUNT
> > magic in your driver to attribute GPU memory to the correct remote
> > client?
>
> No, we just expose what the kernel driver has allocated for itself. E.g. =
page tables, buffers etc...
>
> When userspace allocates something using memfd_create() for example we ju=
st ignore that.


>
> > So this series would close the gap for dma-buf allocations,
> > but what about private GPU driver memory allocated on behalf of a
> > client?
>
> Well we would need a cgroup which isn't associated with any process were =
we could charge the GPU driver allocations against.

I think I better understand your framing for this now. Thanks again
for taking the time to explain.

I was looking for a way to pass cgroup around to do the charge. I
found that `struct cgroup *cgroup_get_from_fd(int fd)` already exists
in cgroups available symbols to handle cgroup directories.

So here's an idea...

Rename the charge_pid_fd to charge_fd:
- If it is a pidfd (`!IS_ERR(pidfd_pid(fget(charge_fd)))`) then we do
what we're already doing here.
- If it is a cgroup_fd (`!IS_ERR(cgroup_get_from_fd(charge_fd))`) then
we charge to that cgroup.

Also we could add add an ioctl for the generic fd path similar to what
we have for dma-buf heaps. Or have a new flavour for memfd_create:
```
memfd_create2(name, flags, charge_fd);
```

The transfer ioctl could also be made generic to accept both pidfds
and cgroup_fds.

For this series we could move forward as is, and make the generic
solution a follow-up series, knowing that the field can be reused for
cgroup fds.

>
> But good point, charging against a pid wouldn't work in this use case.
>
> Regards,
> Christian.
>

