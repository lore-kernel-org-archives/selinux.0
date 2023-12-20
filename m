Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09433FC07
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3WquGNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3W0GnoD8052wYxUNxx5sjwSUJEmm53y4MFQD1spj90=;
	b=S3WquGNb0wV5Ufyisioku8ps3Q8D/XXpXEtURD1GSoA5tFOIM5wBfB4Mqgt7e2FPf9ELOs
	7BzNHZ6eh46vBXHlgd+Yd938tdFvWDghGUBKIp4IlrwtCjYrLc4VVtWdYoIU5W5kJZ3b7f
	vmIZXC6H7+r1Kt2MtzxcqiRJC9z6yNg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7bl6V0ptNbGnbWMNsU7Q-w-1; Tue, 19 Dec 2023 22:50:32 -0500
X-MC-Unique: 7bl6V0ptNbGnbWMNsU7Q-w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cda7a3768bso2070233a12.2
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 19:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044232; x=1703649032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3W0GnoD8052wYxUNxx5sjwSUJEmm53y4MFQD1spj90=;
        b=jPzejp8seE/CWyYXVhGR7sWz5zsLeMdf0MqUlIqZsvkbQANc2nLjNr6V51e1Npnxvh
         kt+DL2y413RGkDu75e8fxiZK+KVlSLn67xE4EQB7Z1uBUuoA3XqDY3mXFfuQlHha2hO4
         0UIdVOolf1eVAWXOyvIEUaKEYuy1LRCAeP5M7irYvpdBkF8hSvVVhu5B2wiTx+NVugoD
         oJ2E7VfTfxFKnWwRGz95LN9YMzhLFjhK2kIeWDGB4gBY1BDV2Hw6eXcxjOXbn0E5JgDu
         lS2h6XUjPpw17gcULrocfpeFHwmydqooOUOQFcInC5G9xm+z9tfZOG9NnCNJEkclSt2I
         a1Bw==
X-Gm-Message-State: AOJu0YxsLbl2QCh9lYXWtddsrfVMphQq0E22kgOvwcQDUBhm9MbQPq8b
	61Sb74fDMInIsz392XiYJdMD5we+dLH15M488IerhlIWOBIp6oVoUd+2Niv/u/ClQvDBXTEVN+q
	j7ssf7ad7jXYiQU6anM8ym/DCVTn2G24d5A==
X-Received: by 2002:a05:6a20:3942:b0:18f:97c:6163 with SMTP id r2-20020a056a20394200b0018f097c6163mr25126884pzg.96.1703044231871;
        Tue, 19 Dec 2023 19:50:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlS58nfNxtutIIFpX7OkMLYAGwj8W61RJzPQoLQF6krRhPkz+M0a6Jvi/MXgB4l8Yvs6wX2joqA2UTLWTKpdM=
X-Received: by 2002:a05:6a20:3942:b0:18f:97c:6163 with SMTP id
 r2-20020a056a20394200b0018f097c6163mr25126875pzg.96.1703044231593; Tue, 19
 Dec 2023 19:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-3-maxime.coquelin@redhat.com> <CACGkMEthp13a20TGashiFNDovK+b10mgfdX8L=3Xv05g5-eo0w@mail.gmail.com>
 <8afc44f7-cef5-4b4a-afac-85a4eb967d3e@redhat.com> <CACGkMEtNZyHDzo2e_N9SM9dw4CK8vpZHWBrk7TFFixD1T7cdjw@mail.gmail.com>
 <b793a98c-dfde-4bf6-9057-6fa359cf4723@redhat.com>
In-Reply-To: <b793a98c-dfde-4bf6-9057-6fa359cf4723@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:50:20 +0800
Message-ID: <CACGkMEsUcVazoagKuTuFQdn55khyyDwOnYKLJuOyyt8_ib7wiA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] vduse: Temporarily disable control queue features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 5:21=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 12/18/23 03:50, Jason Wang wrote:
> > On Wed, Dec 13, 2023 at 7:23=E2=80=AFPM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> >>
> >> Hi Jason,
> >>
> >> On 12/13/23 05:52, Jason Wang wrote:
> >>> On Tue, Dec 12, 2023 at 9:17=E2=80=AFPM Maxime Coquelin
> >>> <maxime.coquelin@redhat.com> wrote:
> >>>>
> >>>> Virtio-net driver control queue implementation is not safe
> >>>> when used with VDUSE. If the VDUSE application does not
> >>>> reply to control queue messages, it currently ends up
> >>>> hanging the kernel thread sending this command.
> >>>>
> >>>> Some work is on-going to make the control queue
> >>>> implementation robust with VDUSE. Until it is completed,
> >>>> let's disable control virtqueue and features that depend on
> >>>> it.
> >>>>
> >>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >>>
> >>> I wonder if it's better to fail instead of a mask as a start.
> >>
> >> I think it is better to use a mask and not fail, so that we can in the
> >> future use a recent VDUSE application with an older kernel.
> >
> > It may confuse the userspace unless userspace can do post check after
> > CREATE_DEV.
> >
> > And for blk we fail when WCE is set in feature_is_valid():
> >
> > static bool features_is_valid(u64 features)
> > {
> >          if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> >                  return false;
> >
> >          /* Now we only support read-only configuration space */
> >          if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
> >                  return false;
> >
> >          return true;
> > }
>
> Ok, consistency with other devices types is indeed better.
>
> But should I fail if any of the feature advertised by the application is
> not listed by the VDUSE driver, or just fail if control queue is being
> advertised by the application?

Maybe it's better to fail for any other of the features that depend on
the control vq.

Thanks

>
> Thanks,
> Maxime
>
> > Thanks
> >
> >>
> >> Why would it be better to fail than negotiating?
> >>
> >> Thanks,
> >> Maxime
> >>
> >
>

