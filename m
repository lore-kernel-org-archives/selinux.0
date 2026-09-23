Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404053AC0E4
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173879; cv=pass; b=FUfqXo5IR9ISVUC3bN0/zmLWYs3hKlF88qsvapsyDpXObEByyt2TGmAkYrg3cgUbvtuNZc+dFC4QlyF2xKJ9C+II6Necb/zdJr1xuJrGq6Bd0COxc1ZpPzXGMHIh/IwQVPWcGcIMbYeMvGcnAdiZDI90qpbxWpmS+8jIBdfeCb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173879; c=relaxed/simple;
	bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joOMuYgqO8yQkYljmF7ZtwyGi/TDFLkUy6vbsrM76KX3iG/zLoJlLogaMiF21iZN3INycNFv0kH4+vJ+dBQK3YrVpT4bvd7KjooC67oSEa0DYilYSrY6wpRa2i5oEvbXaZbeWS3WmwVgl5jtG1ZLzHlFXMfb0Zv3/wonBVEVi4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+1Ohl3z; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+1Ohl3z"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-532e9ad9a1eso208171cf.0
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 07:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790173876; cv=none;
        d=google.com; s=arc-20260327;
        b=mhLslfNV61OZFMCQ7lQ6BBA6QvyeNiMX4MB7ysU/m1wvdHPrE6DgDPu0/g0CZLgDgK
         tW4cV+HuQz7WBKCcg68M/rZkN+PpodaU6r5/F8xnBfUYdWFbc5qnXLdUT+B5m37nkuQS
         WByQhNigYqkOA5q9KuH8ZI45j1IcipVYZEjP75GuuJYcFoio9oJ4euStMGpW41Gt4iCu
         r1huvcLGUXY/HydllSnDe5GZtZe8ug3v8ZcntEYN8bhYWPhZDLXlGvchuTf3CFAs7mpx
         qtajbNQokRn2F5YgCz/YUW0ySPvONJoSIQdFCEoGwcyvBU4AI2jYq9KkMXq5eaTLxwsc
         RjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        fh=9TxSc3sLHTDnEjT1fE5q1o/i6fsoq0TLhB1CWjniqK8=;
        b=ZJb7cMB9i03UAcxRrHoQrCWho2F9RH1xaiyncNCLpoWO8QC0DoWjxi1cuf+UZmugLB
         WPGKRm7lXJUt7scVpa5ixh+7J4mMdI3aCD4Mq2O3jcAnHELhYvcPQRRORp22lMc2PW24
         zcp/SNd0SCZK8EHD2D74UWsAKjykY1+4soTz9rSg/I+0arQwyIPn0zqZtJWwWxdmjnW5
         QLpp0Nk4AUFcG8K9tRsBmRHiH+wixraD5yj8xOVGvAcY/rd7DCTZ0eRss1O6DM57GaaV
         NHTyWMFMnGQrfNUqCK7ZX0BFCpKLImOPHY+cvPVP2k6CuNgYXMpciV3d5PYyItxWDGg4
         3ZYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173876; x=1790778676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        b=C+1Ohl3zbsMrjh1dB/zOjZD8WctelSpuD7HSjz83HtCzxAu2uQCdrvdk6mQA/qDmED
         XPmCruc/0qesoh5ZaUY/8kYU55YuQDkrL+NWB4/GzBktzO6vR8i1QACk+3pme9wnGQCn
         VZQmjl8KrY0HTHromA139b+tgbWQilZ3lTmZ8bgk7A7cwz+FVWfgOIYzhOmTDxAQ89K+
         VZ5tGKKWdn2SxsyXoo0ZRNPy/7aL5Z2Tdfk7aj0pDU/c4b+4zxQCe6XqJRfIBBmHEG8r
         fY+QEIfNks1XUT2d6WUeW6MkoHO+EYXflKlYvUF0fbOWU0DbvpsKlrTvHc30tBgH/z4n
         u9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173876; x=1790778676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IRQTfCkVu29EAhzhIq8HL8xV9bhN+vmwTvfaTzW1hg=;
        b=DK+XTq/bn1Qbe3/i9W+DCCmPV+XdCzfilyi/mBAAg6ShX0lEHLYrMsaNRzOD9VJcyq
         87fT+Ylm0wjDgoFdTkU40TMNLmVVETcMD2cN7RF2AqTDG12N4bEvI38RVoFQcoSKgUml
         GEXO02EUlEWDe+HjRuOe7LMHcqa1uC2M5Y+UE4Szy9xsh+jFK+5u0N93XwjcZiRYbEgo
         lIebpLNZO0HAtZKwe5xc5/VnzgSl7vfHGN8Jupv0VlS+XviwBOwVonrqOuyNsfmacba7
         guKR1rSRS9hEf7DFu3nbARucchRKnL1YYJUugB1K+qC1aez9swxIutZWulEh8JQ9m3ZY
         jphg==
X-Forwarded-Encrypted: i=1; AKwUvByysZsoDY+sJYNal7FbfZilY/IdlaH4BBCczzQ5RwweTKuXjexXFuo5ocKQVH7lyhZXOOhTvoCk@vger.kernel.org
X-Gm-Message-State: AFuF++msH4ns0ImWIngrHYm3PKNdBBZnEjTF3EjeUCuQhj5bLL+Vn3PK
	rrZBSyAwhuos8sbbWhILKikGR7bWzaVGwahme2UNbZgTUOdxPQiWwRYAGsRSBiCfJMWExY28gso
	6htZYMUaLOMoSnH/Wpm8R+AaiQ74hgr/0NwzNlBef
X-Gm-Gg: AYBFou0Fh1jkEEAkncguLP/eRBOxlTJoFHSzJRTgPBA1ZAdlif9OauN1zN56Hh0MJKh
	MyeECYsFA+1V92WTPMvpaSTsDNJM3fZ4Z2HnuJgbkE+oBpIagHLOhKOa5e8hTXEViVDotP0/qvm
	wCmtq0H96JAYuuxQCXRgm0ruD+tzkfAeP5VOXsnyYqYajiu7WqLsWVOK2k123EwV2huUSh7VBHd
	mTxlwVRInEun6tFQ6kP7QljgvxLH6fMc8Qq4WqppFkewBUQohKUgdsILa1NpkPAaP35WWQ0+kaP
	PzWp3KQ0ZWPqHsAxgKOMnSxDVzsdowYW+7Nw/lTtM9V4cWPwyEevJjLEz/DNY7Whl6sahIl6v6+
	kqKQJr9tGpA==
X-Received: by 2002:a05:622a:260e:b0:532:9d15:2e5a with SMTP id
 d75a77b69052e-532ede89b29mr14598791cf.1.1790173874906; Wed, 23 Sep 2026
 07:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914180811.057cba8fcc48d6e0b53a2683@linux-foundation.org>
 <0b064fe6-ddb3-4f26-a1f2-2e9dd88d590f@kernel.org> <CAJuCfpFBichJH4OcmSHTb1rOuQBT6k5pXeua9_KgpWjDBKvsYw@mail.gmail.com>
 <aq6kzpK7wPl3iFGe@gremlin> <aq6lW9FvL69QeA9H@gremlin> <arOCPN02xB7mykju@gremlin>
 <b007cd0f-29ef-457a-8e44-63ab26f3bcd0@kernel.org>
In-Reply-To: <b007cd0f-29ef-457a-8e44-63ab26f3bcd0@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 07:31:02 -0700
X-Gm-Features: AclHuK_ZGTwaB8ygIyiOyIIeQNRzbEtns-G_Cds8CuZ4q61CHw7YMjTifucik0o
Message-ID: <CAJuCfpHL=dHjT=O4S88ZBvT1DyodAtCL9QTryepzs3EMwoECDQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mm: make VMA flag semantics explicit, eliminate VM_SPECIAL
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:40=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/23/26 10:13, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Sep 19, 2026 at 04:09:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> >> On Sat, Sep 19, 2026 at 04:05:57PM +0100, Lorenzo Stoakes (ARM) wrote:
> >>>
> >>> Thanks guys!
> >>
> >> Note v3 has been posted to fix a stupid bug in 1/40 + attack some very=
 trivial
> >> sashiko stuff
> >>
> >> https://lore.kernel.org/linux-mm/20260917-b4-mmap-prepare-vma-flag-san=
ify-v3-0-4583d8a23bca@kernel.org/
> >
> > Just a gentle nudge on this :)
> >
> > If you guys or anybody else has some time it'd be appreciated! (obv. th=
e v3 as
> > linked above not this v2!)
> >
> > I know the series seems intimidating but most of the commits are very s=
mall and
> > it's been in -next for a while.
>
> Busy with too many other things sorry. Its time will come.

Had to take care of the pile of bugs but I'm on it now.

>
> --
> Cheers,
>
> David
