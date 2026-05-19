Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679332860B
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214072; cv=pass; b=gU6yzcfCRd7tE6/LuSx+6FWuprPqLAkOCvtw6pmfJH2g13XEMYR6ZscyUreQNkiVvRCLgyO8urjkhaO3MVUWAID2RQVMg8EAnMJ0fb7jh8iN7MZQSwi7tH+MIpMcUbuYsLGFrmB7CiGY4tlJVPZaL62x6bS59NgVr4ugoZ8Ms+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214072; c=relaxed/simple;
	bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL9SEJkjvg0lO5K54g9IFf/MkcPKAS/vmzOvFlfmY5ji/shFznQcKFutiOxLggeyDTtD/EW5FGDFkkvqoEmKSkHJU6L2fOE+4HdBOnQVn09sAe/I9gzuRu+qDqZ4cEnlqi14ZrFRP9/lcvX6p0xamBBjZlgI6NovXNdTiAh/H6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWeWeIWF; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWeWeIWF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso2155e9.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 11:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779214069; cv=none;
        d=google.com; s=arc-20240605;
        b=VbC6slEymTovnDgVdf9QUL7eYaF5EgNpkBOBXqfb4MREPymzCb4UZ89Ltg0uexphg7
         FQtHZtNmO/7SXGyTegKZnXdjCRtQ8MU1uuUz2cO2fVzyAn3W82iLTs4MV83oQddCz7sR
         H+0EH3UxJwqTG1bTCty2JFsNzYlFN2HTd+RBbK95d/yYucbj7dJzUb2WsUs+iumklxpb
         3gbzblC8yMjxYD9J3TZf7KUq0kM9gWBjAh4PT9M6UYaPmmyaj60r6wyp24WScloVCyR5
         9WklHcFX3/6Ph1R5TebX+8RQoBesFwjpVgh5ULbYvq0HlbzWIICUyHATvR2lWJkR0KNv
         /4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
        fh=FN6Gq1rtIblY546vnFpor5LevqLa/ABO1PJ9Vqc+nOo=;
        b=Fgw4VsL/6rNQJ7JBR+A1nm00mNS/dLkgCPzfoQd1DNlvM4L5Ixuke0NeiyFFV5irCq
         1ld8q/9v9wE2fZq0y8kCtFehBu8vV+xdydxTrYvWtSXvouXbFdYv+ZxqZomtZFYm2w0j
         P7ycaGL0XVpp6oJ2Q3lkNFbUQTHzsWH20JWMThjDG/Fc7sPqLUK2maPysS+no3kEOxXH
         4YmW8aCgZGFPgVtBETPtf75JZJE6qc2PcQ4NQ7tcU3rXwVtKpjYY4P47hXJaIDoNDJR1
         xeQatQkiY6MxbKr4g05OHV6qS15S2Z3Pa+47VrTAk5ZsRhVLP/XSVdmFtjaWk2jE1INx
         vbUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779214069; x=1779818869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
        b=eWeWeIWFQkhgJUMtdPmPfch1gHn6y0RMODHat6KPHaMDF1OFqbY09x0XUxRQFve3Tw
         GKjCah7Z65qJy9VtD0Xk6PUxhM5gbnnmPIGPlCEpuxQohywyZ9YAuoDmCOa+72a1xeKs
         S5qZzMKHV2zKB0B9JpYcPsctQUH8Gb9XlVy0HShMsnSXwU9pIA+pP9rjSi9x+ZD9Bs3Y
         xBy3CLTe7d2Swwrnwd+u7NE7MUJinmvcZbLWYQOcJWO1eQ/orFirzO/2qg5Fq/nAfiyC
         1yInXJBRFkQP2HD67p/H19TSSyUE2k1fRPB2hpYAyVhjvkSF0KrJKlfI3BtcNnVD4Hai
         iiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214069; x=1779818869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xssGkiKE0NLLgIm8hq0sx4z1JVWvwtNlxiDz+CYQuyY=;
        b=SxlUfDaaDVNEyGht9afixpwmUyeUMf4f24E30DqTeoyu7bvR/OqfQw2QWvuOc9rE3B
         tvQ4rOpqpT+QL1d3GXpL31BJioLyDzT9CAyY5VMdAGkkZCjo3k7nILZDUmZnoWN1pWU+
         rJOjz9rS4ToXYe6X4ZXRnkuOOo4YA9TriCDIoE6rST4hgSPwm2qCb6z8jFjbNXCfHsEM
         3Se5f7tr+am/ituxMOwcYPF1je/WpbpUdq+YHuSr5n3gDSsHYfqrN/tFxVjD0Pai3ID3
         jKkxpMsLegXiMnlQTPoBt0E+aaV7g++tbftqi05p+xe2oytIvO1/3zNAdILN2SAmsU4D
         VRDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1oN0N8RvIKp6DZ/LOYRG1X0CN5lYxvRa/In/9kk2/uQvB071ssjlOGmYCvkwDaF/22fiQxWMx@vger.kernel.org
X-Gm-Message-State: AOJu0YweJLq2BBkgd+db3YvEgbEuS6sRgct29zgCmbmoTC93hnDtYxge
	6PwT2XSvggGydQNUqGs+LkyEFSqMZX9+lIRI/LOfYz2GByqyAw0KFLxX777EfcOEY7oGFAtixe/
	A9KSIei5IPrHPy1r7z4aTfjAj+OZHNNNKbwVx60OE
X-Gm-Gg: Acq92OGPbLmG4kkvCY21il+HRFf2jLCGxUE8ZsNXzU7tyaBKsQ2Ns3yJaw/9xo3MqkC
	QduLjxkFHd8rthk6qM5b2atKLlNoc/pCQqx+yrmx+Nm3Leqgj1K8uChDIbq6llKgMTlTu37aWMn
	FYigOckYuwbC5k7JU46HjnfFwzs/GvTI5TXP6fkKy9dNFGnQWtDuPyPOKTfaCG/OeozpMH0FvSe
	JPIQabYOkBeG11+/gflfD7dgEBd6iombZDmFmK4xf+LUgswf818TRyW6yhYFZSdnRsJbv5oeVGz
	JTBNjn99AZVvtrHrep1FrNnlnIEsMlb/dnR9RKPuzwEP8rDh
X-Received: by 2002:a7b:cc8b:0:b0:48f:de33:777a with SMTP id
 5b1f17b1804b1-48ffd857abfmr3637845e9.11.1779214068422; Tue, 19 May 2026
 11:07:48 -0700 (PDT)
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
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 19 May 2026 11:07:36 -0700
X-Gm-Features: AVHnY4JsuFzXOj8AzAQ7jEDe53JgzbJyOG548qhgZV3zTdsbu0QldI49eMqYz9w
Message-ID: <CABdmKX1wLoLuWPUEY3D7afQhO0AUnOE7c3iE-VkPuKdeQixBxA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
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

On Tue, May 19, 2026 at 12:19=E2=80=AFAM Christian K=C3=B6nig
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

Oh I see, thanks.

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
>
> But good point, charging against a pid wouldn't work in this use case.

It would be pretty low overhead to put a process doing while(1)
pause(); in a separate cgroup for this purpose, but I guess a fd for
the actual cgroup would be a little cleaner in this case.

> Regards,
> Christian.
