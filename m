Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793978519;
	b=3pB1ni6VjubEJYVK9ALh7XUFUitIibpzNaGclb9lCPn2i54sz1TEvPkuQhyUXiVnf8Qj
	 FiXNGAdW2zJ27A4SILw8UzLqRdGxqlwB66PX98GRZdc//t/8r7Fq+TER2mudiRFN3u8In
	 U3O5r0aWcrnVr5ReuUcpbScYkZakz1S4dd3xo5gjnlp4qkBufwCItUcAO7eKe17KoJRbU
	 /JrAoXAY6SOBrpMGvEXdEnJ5pAsQP5JDXg9aov+JoiQ+w5iIQwSvaoKzt9fATVGhYezg0
	 tkl2e1TZ1dm5Ob/Xyh0vnTAFJ+mFmPbcBuiV4OgahBT376viZ3eNNS1smPBo53wGb1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978519;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
	b=JfAPJAt8Et12suXSvUMfSDrOBPthOkMk6xt8OIEXfx93kUmD0ZFrJu13V/j3Tj7ib8Dt
	 Hvhy3GT+fBV/pFfHgEAbAltb2KLEE8rUhYxBmAJifAPQMNcjVlrPzUevs2O42o2xeP+oV
	 Nmt4J/qidqooPEdyHw+zBahcP00IUBw2afh476ylx4XiydQHBtNXVaaucR1zhJlhiyRDX
	 BQ404xdWOF8ZnagaHJDdJAN9S/vjzG83oIyVpT/LH1b7rkP+QJoZkZ0SiQ5Hcptva1cXd
	 w0j1bQaFFJko/owmGJbD0TQhRx6+tbBT5Znofr/JE78G39r/HEw7XTXC2W5L5KgpDgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WXybZmrT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s8OZ3Fjz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34D606D80F
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 15:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E34D606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WXybZmrT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=s8OZ3Fjz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793978518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
	b=WXybZmrT/LPDkBI7De79JA5UZD+YajPWsIQ8kFzTJLLFQeP6WeGOHVcZiCf2PEimyFr4Mv
	S5YZ62KWna8KaEzfielefe67qh8r0HQUr21lUehIAfyYIMM1AlKj5s2gvZlfpMJxz58bLa
	HH8e7XZz6te7uiSe3hJjdC7ziuZVBLs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-6LYA00T5MlSfyl8J1O8ocQ-1; Fri, 06 Nov 2026 10:21:55 -0500
X-MC-Unique: 6LYA00T5MlSfyl8J1O8ocQ-1
X-Mimecast-MFC-AGG-ID: 6LYA00T5MlSfyl8J1O8ocQ_1793978512
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-843cf077bf7so1201423a34.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 07:21:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793978512; cv=none;
        d=google.com; s=arc-20260327;
        b=EGHKmKCY5aEth/xJD+ANsEp53qMFJi+0iJ/GzpHSGTyFhu44GGS6Nwn3WkfAdZaNAB
         uZlVdtaSWJZRpR0QWjtfU4YKwHq/q6IzRO5rhOH7CKfaglHUdByCPpiHl5O5Udgvhj/C
         DKBSOjXiLltEt8Xbn6nXnq2LUXRu2Nyds7rdZBD+SYiJE3jtXKg4PZHJmjCzkeqnda8h
         u8v60XPNDJV0ZggahrO4Nh05RlYJ+FlYMmkRsaQrFXAN7VaArXroAyLxkBygBGs4/gfu
         pZ0iCqfNwtDKYeth/xTpfneTJ7dZ6SveQNgHRq1kskNM9NN6rlKtoizcisTS9ncAGImj
         bYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
        fh=Jca0w/YrDi6owiUIoj3m4OHt3WrxZtJ4AzcZxF0lnDE=;
        b=UDf0iYwlU7fYeQdDvDUf3VdUPMiSvQx7XmrzvT/DkTVV1j0WVkKA/tL/fAxk5Ni0Ue
         7c37aQetONTqHIlb+uVFBfGYBPOk2sOVkZ3ZwHL4elmuMS2/jV2355Uo6y7ZlMICivNM
         9ZfCZL24ZtAD2S6cNevuKGfiH6IgcSYpBc1ZsOwjCqtndchXsroOGCcMjtzLaqc1FcY9
         UAf8hAHaRNutW4k0PQtmplb6PvQj6w9kMWDw3MzKEIIIdHJcwMAhtZJSoIR2i+/sczT8
         xicm2mj1cX426yVTs1gjKFmXlKQH2/QEXUaP2wLEhqYIQclkL91ySJ1465WMoZVbCv0o
         qFRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793978512; x=1794583312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
        b=s8OZ3FjzHURNyBqkqIBU1Bg8DoKgxzEWVuozmHY19KhKFA2dCgDz9cUW8YyLpMBdmE
         lTBo4b+VaFcPoEDEYdkRPHb4kdCbDm21vf9OrO+KZgAMDeBJnM8+pb8i/BXTsvVpokqj
         HoO8pQbI31Qd9XtPwTG0Qa6+jZ6kDv6F+76vhl5ydemxmOZB4TsAgIem2B+cBpW26x4E
         BCVq5wtr5Z2/ELwPD2wCZ5HKTdtNP8OGCbaOromawRYTrODwsJzhiGUOnS2TgxcZhUM+
         ietb50h4MKGBTficTllREZT6vRv2lQOj3sqija+kHQJMbr65cPuQ6nyHlsKsp7BXUn3l
         Ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978512; x=1794583312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1rxOFc+cZPr208SIBHT4IjzKUbYQTfkbGhsqB2LqDE4=;
        b=IzhIlWu54Bux3i/cMVqKoMGVGuMlwbzYoX0H+3wqdtDVOCbgRJuziruhyMddgU437v
         KH0s2d+OqtgDuIrPnTIcT693oH1OUGcw8tDwCxdQyI4PnJfNp82Rv8MH5LLelg4VZVDl
         PZXyAP/cA4zHD7Uv/1TB5vaaEvW+nAOB0hxljdao+5avRYxF5PPge/KRwwi5+7/DItmS
         nlpuoCtBk/qlhlX1UztTdHv1hQvzdf+GFkTX5CnjxsnYTzZlVWTLBi9EfJ0Pqi0PSEX3
         oF86m0BmZrHAOlVwxhHCVDF0X0ehEEv3yHLv3uJoZYURgfhBAlcbJNKIX4SxwSQHstSa
         +DlA==
X-Forwarded-Encrypted: i=1; AKwUvBzgpEqKDtsRUE2EpubRG4wD8weBwV5ML3meOSJiwRyw1y3cfKCT63tk1R8TyHRTugbkmEJREyJI@vger.kernel.org
X-Gm-Message-State: APuU4Z849vYkf+1nu4/mBw/sTxiZ7tR309d4wPGt9QCJZJWfa7geZAeD
	RYY5Cw6b0Evz5i1hVsiRdRPGazIaK2zIitz4XhxXuNw2uNixH0Wf0CuEb3GJR1axBlLwLCJTfaJ
	JUYs6KQV+bi878JWIKMcyBCBA03DYEQpBMynOSIJiEp9B1FI1FlKtb7yVOCfWzpdh9BByko+Van
	74QWvIYSu1rssgdZFDEeqd/NWoI83h4fJKQQ==
X-Gm-Gg: AYBFou0smLQDkIayOEPhM1s+MGjfVCILUjYk9j+rQbbWWOnIZbuTmoRvOSeesEsaTgX
	4HIo3ms7lNHtIs3LzwNCl8psMqemEZ3oTlvLV8IfpB94vUWGaNuISHxvoXVwymVKJVuvjtR6YRN
	IzYGTYFuE0sEeRXbWCdNXtr41BsN81PSh9RCKO3qqDWd7G/TdFEielN4es
X-Received: by 2002:a05:6808:181f:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-567e098b040mr2230473b6e.9.1793978512057;
        Fri, 06 Nov 2026 07:21:52 -0800 (PST)
X-Received: by 2002:a05:6808:181f:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-567e098b040mr2230427b6e.9.1793978511464; Fri, 06 Nov 2026
 07:21:51 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-3-1819a017000b@redhat.com> <fb40349c-18d2-45d6-9278-8f20e1b8dc74@amd.com>
In-Reply-To: <fb40349c-18d2-45d6-9278-8f20e1b8dc74@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 6 Nov 2026 16:21:40 +0100
X-Gm-Features: AclHuK8xPUV12Kp92h3MGmY0EG1MyX4e69V4l27RPz6qll1dAX1c6CSJcZPwZjc
Message-ID: <CADSE00+NL-tyQVaTiS0Xdin7f-P_2c84P0qs-X66VqYze0-kGQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] dma-buf: transfer memcg charges via DMA_BUF_IOCTL_XFER_CHARGE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:52=E2=80=AFPM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/4/26 12:09, Albert Esteve wrote:
> > dma-heap already supports charging a specific cgroup at allocation
> > time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> > originate from any exporter (DRM, V4L2, etc.), and the allocator may
> > not know the final owner at allocation time.
> >
> > Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's memcg charge
> > to a different cgroup after allocation. The target is identified by
> > charge_fd, which may be a cgroupfd or a pidfd.
> >
> > The transfer charges the new cgroup before uncharging the old one,
> > preserving the original charge on failure. Concurrent transfers are
> > serialized by the dma-buf reservation lock, so lockdep covers the
> > locking order of the charge path early. The transfer implementation
> > is generic (mem_cgroup_transfer_charge) and not dma-buf specific, so
> > it can be reused by other subsystems.
> >
> > Not all dma-buf exporters back their buffers with reclaimable system
> > memory. Some represent device registers, VRAM, or carved-out pools
> > where size is not a meaningful memory cost. The xfer ioctl returns
> > -EOPNOTSUPP for buffers whose memcg is not set. Exporters opt in by
> > passing a memcg through dma_buf_export_info at export time. Currently
> > only the system heap sets it, other exporters can opt in as needed.
> >
> > Usage example:
> >   int cg_fd =3D open("/sys/fs/cgroup/clients/app1", O_RDONLY | O_DIRECT=
ORY);
> >
> >   struct dma_buf_transfer_charge xfer =3D {
> >       .charge_fd =3D cg_fd,
> >   };
> >   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> >   /* charge now on app1's cgroup */
> >   close(cg_fd);
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/dma-buf/dma-buf.c    | 42 ++++++++++++++++++++++++++++++++++++=
++++++
> >  include/linux/dma-buf.h      |  3 ++-
> >  include/linux/memcontrol.h   | 13 +++++++++++++
> >  include/uapi/linux/dma-buf.h | 26 ++++++++++++++++++++++++++
> >  mm/memcontrol.c              | 42 ++++++++++++++++++++++++++++++++++++=
++++++
> >  5 files changed, 125 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 837666273550..3bd26fbb1109 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dma_bu=
f *dmabuf,
> >  }
> >  #endif
> >
> > +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_char=
ge */
> > +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> > +                             const void __user *user_data)
> > +{
> > +     struct dma_buf_transfer_charge arg;
> > +     struct mem_cgroup *memcg;
> > +     unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> > +     int ret =3D 0;
> > +
> > +     if (copy_from_user(&arg, user_data, sizeof(arg)))
> > +             return -EFAULT;
> > +
> > +     if (!IS_ENABLED(CONFIG_MEMCG))
> > +             return 0;
> > +
> > +     if (arg.flags !=3D 0)
> > +             return -EINVAL;
> > +
> > +     memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> > +     if (IS_ERR(memcg))
> > +             return PTR_ERR(memcg);
> > +
> > +     dma_resv_lock(dmabuf->resv, NULL);
> > +
> > +     if (!dmabuf->memcg) {
> > +             ret =3D -EOPNOTSUPP;
> > +             goto out;
> > +     }
> > +
> > +     if (dmabuf->memcg !=3D memcg &&
> > +         !mem_cgroup_transfer_charge(&dmabuf->memcg, memcg, MEMCG_DMAB=
UF, nr_pages))
>
> Please move the calculation of nr_pages after taking the dma_resv_lock().
>
> We currently don't have anybody dynamically changing DMA-buf sizes but ju=
st to be on the save side.

Sounds like a good defensive option. I was also tempted to move it.
Will do for v5.

>
> With that done Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>

Thanks!

BR,
Albert.

>
> Regards,
> Christian.
>
> > +             ret =3D -ENOMEM;
> > +
> > +out:
> > +     dma_resv_unlock(dmabuf->resv);
> > +     mem_cgroup_put(memcg);
> > +     return ret;
> > +}
> > +
> >  static long dma_buf_ioctl(struct file *file,
> >                         unsigned int cmd, unsigned long arg)
> >  {
> > @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
> >               return dma_buf_import_sync_file(dmabuf, (const void __use=
r *)arg);
> >  #endif
> >
> > +     case DMA_BUF_IOCTL_XFER_CHARGE:
> > +             return dma_buf_xfer_charge(dmabuf, (const void __user *)a=
rg);
> > +
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 85dd747c9b36..b01149d26b44 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -507,7 +507,8 @@ struct dma_buf_attachment {
> >   * @priv:    Attach private data of allocator to this buffer
> >   * @memcg:   memcg to charge for this buffer's memory. Set only for
> >   *           buffers backed by system memory where @size reflects the
> > - *           actual allocation in bytes.
> > + *           actual allocation in bytes. Enables charge transfer via
> > + *           DMA_BUF_IOCTL_XFER_CHARGE.
> >   *
> >   * This structure holds the information required to export the buffer.=
 Used
> >   * with dma_buf_export() only.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f8ec751b7d7b..af02d9777fe9 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -676,6 +676,11 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int fd);
> >  bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> >                              unsigned int nr_pages);
> >
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +                             struct mem_cgroup *new_memcg,
> > +                             enum memcg_stat_item item,
> > +                             unsigned int nr_pages);
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >
> >  /**
> > @@ -1197,6 +1202,14 @@ static inline void mem_cgroup_cancel_dmabuf(stru=
ct mem_cgroup *memcg,
> >  {
> >  }
> >
> > +static inline bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_=
memcg,
> > +                                           struct mem_cgroup *new_memc=
g,
> > +                                           enum memcg_stat_item item,
> > +                                           unsigned int nr_pages)
> > +{
> > +     return true;
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.=
h
> > index e827c9d20c5d..0aaf2e7d593b 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> >       __s32 fd;
> >  };
> >
> > +/**
> > + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg charge
> > + *
> > + * Any holder of a dma-buf file descriptor can perform a
> > + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> > + * cost to a specific cgroup, or move it from one cgroup to
> > + * another.  The ioctl charges the new cgroup before uncharging
> > + * the old one atomically.  On failure the original charge is
> > + * preserved.  If the buffer has no existing memcg charge, the
> > + * ioctl returns -EOPNOTSUPP.
> > + */
> > +struct dma_buf_transfer_charge {
> > +     /** @flags: Reserved, must be zero */
> > +     __u32 flags; /* unused for now */
> > +     /**
> > +      * @charge_fd: File descriptor identifying the target cgroup.
> > +      *
> > +      * May be either a pidfd, in which case the charge moves to the
> > +      * memory cgroup of the referenced process, or a cgroupfd obtaine=
d
> > +      * by opening a cgroup v2 directory, in which case the charge mov=
es
> > +      * directly to that cgroup's memory controller.
> > +      */
> > +     __u32 charge_fd;
> > +};
> > +
> >  #define DMA_BUF_BASE         'b'
> >  #define DMA_BUF_IOCTL_SYNC   _IOW(DMA_BUF_BASE, 0, struct dma_buf_sync=
)
> >
> > @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> >  #define DMA_BUF_SET_NAME_B   _IOW(DMA_BUF_BASE, 1, __u64)
> >  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE       _IOWR(DMA_BUF_BASE, 2, st=
ruct dma_buf_export_sync_file)
> >  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE       _IOW(DMA_BUF_BASE, 3, str=
uct dma_buf_import_sync_file)
> > +#define DMA_BUF_IOCTL_XFER_CHARGE    _IOW(DMA_BUF_BASE, 4, struct dma_=
buf_transfer_charge)
> >
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 17fdefc56b97..3e717b5663c8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5752,6 +5752,48 @@ void mem_cgroup_cancel_dmabuf(struct mem_cgroup =
*memcg, unsigned int nr_pages)
> >  }
> >  EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> >
> > +/**
> > + * mem_cgroup_transfer_charge - move a charge between memcgs
> > + * @ptr_memcg: pointer to the memcg to transfer from
> > + * @new_memcg: target memcg; caller must hold a reference
> > + * @item: stat counter to adjust
> > + * @nr_pages: number of pages to transfer
> > + *
> > + * Transfers @nr_pages of charge from *@ptr_memcg to @new_memcg and, o=
n
> > + * success, stores @new_memcg in *@ptr_memcg.
> > + *
> > + * Updates to *@ptr_memcg must be serialized by the caller.
> > + * Returns %true on success, %false if the charge against @new_memcg
> > + * failed.
> > + */
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +                             struct mem_cgroup *new_memcg,
> > +                             enum memcg_stat_item item,
> > +                             unsigned int nr_pages)
> > +{
> > +     struct mem_cgroup *old_memcg =3D *ptr_memcg;
> > +
> > +     if (!new_memcg || mem_cgroup_disabled())
> > +             return true;
> > +
> > +     if (try_charge(new_memcg, GFP_KERNEL, nr_pages))
> > +             return false;
> > +
> > +     mod_memcg_state(new_memcg, item, nr_pages);
> > +     css_get(&new_memcg->css);
> > +     *ptr_memcg =3D new_memcg;
> > +
> > +     if (old_memcg) {
> > +             /* Uncharge old cgroup */
> > +             mod_memcg_state(old_memcg, item, -nr_pages);
> > +             if (!mem_cgroup_is_root(old_memcg))
> > +                     refill_stock(old_memcg, nr_pages);
> > +             mem_cgroup_put(old_memcg);
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  /**
> >   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> >   * @dmabuf: buffer to uncharge
> >
>

