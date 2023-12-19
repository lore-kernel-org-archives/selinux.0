Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8B39842
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YvGSRlqR"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd7248ac28so478624276.2
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 10:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703010043; x=1703614843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgph0xx62tfEVrK2mU0HsXwH2WGhvP+EnxtPD5Kw9NY=;
        b=YvGSRlqRT+hX3yAzJBHLxMgvxXGvh9/BAUMl5S53xiEIl02NzQUpA4XuPOcJnSzbGN
         /2GORRUSlTT5ZAEL3alqwIkhhMjuJFwnbDwiA708ZZH4Cmaww/VnoyRTiUcW80d+cjJo
         sgpBJW4LJmF4fACuqjpNzlblIqxbcPmbHj/GsP9qNkYZr+viBf8uxv/Sj5LH+0CDJMzL
         XrmYdJUCw55ok9+4wjWNUNW2pgHxYZ2Xkef3wPry5Gdzvgtmpqktbo37HGtQG01CFF8P
         ovjP7PWH1o0qQyK/FhcXzGtHvBcOr94V/yn1Jz1d9ifyXOLdQ2Kv102t52s2NmqWlwlP
         OvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010043; x=1703614843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgph0xx62tfEVrK2mU0HsXwH2WGhvP+EnxtPD5Kw9NY=;
        b=cddX1schfqZdf7/OzuDHOzFcd2H6+F8Qe7gV7faFqS8wquEJz4hLlQXDH29f/ZiEr3
         TnZ+X+T+53afsLdZ/G6QP86GMkCW9s9R0KTN32O34El78skP7yx/SjIl6BmPgjweW284
         fuU5jR/+oEeWSig8+pSPyXiPkMhBpiqPctzIdJIno+upv9W7IoTwvZVSq467Usg4UJ64
         LBUTZdB8gsqbxb0mCg2FPjD47i9FOdgKT6gG5UUCFTcNcvNgAyE1CU8yWjpsD2egaBam
         73tr967MoO1Vsu91jiMW9OpIYrVWchsZ7V21tETMwpsBefIVKysKyQdXlpzXmaOtezIe
         rQkA==
X-Gm-Message-State: AOJu0Ywt7XijWeOiv4+dEsb6Iy06fafdEofK40hEFPwEIjAkfDBllEZB
	ZxNjanhzsE+8t8opoMCg41uHdUVAtY1cjvd62jQL
X-Google-Smtp-Source: AGHT+IG2ONgtcoT47Z9l781a7bW2xcjjJeRGvkYkQbojW55k5C8WrZ/0wZW5Ybv1u01qKlii34AZLXUE8IlWaWZfrbo=
X-Received: by 2002:a25:ac01:0:b0:dbc:efce:f34c with SMTP id
 w1-20020a25ac01000000b00dbcefcef34cmr4115248ybi.0.1703010042731; Tue, 19 Dec
 2023 10:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-5-maxime.coquelin@redhat.com> <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Dec 2023 13:20:31 -0500
Message-ID: <CAHC9VhSkGwzWV8T06LdoGXyvrnP7tiYMPYmbmVxWoQg6wzEDiQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 12:21=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> > This patch introduces a LSM hook for devices creation,
> > destruction (ioctl()) and opening (open()) operations,
> > checking the application is allowed to perform these
> > operations for the Virtio device type.
>
> Can you explain why the existing LSM hooks and SELinux implementation
> are not sufficient? We already control the ability to open device
> nodes via selinux_inode_permission() and selinux_file_open(), and can
> support fine-grained per-cmd ioctl checking via selinux_file_ioctl().
> And it should already be possible to label these nodes distinctly
> through existing mechanisms (file_contexts if udev-created/labeled,
> genfs_contexts if kernel-created). What exactly can't you do today
> that this hook enables?

I asked something similar back in the v4 patchset to see if there was
some special labeling concerns that required the use of a dedicated
hook and from what I can see there are none.

> Other items to consider:
> - If vduse devices are created using anonymous inodes, then SELinux
> grew a general facility for labeling and controlling the creation of
> those via selinux_inode_init_security_anon().

For the vduse folks, the associated LSM API function is
security_inode_init_security_anon(); please don't call into SELinux
directly.

> - You can encode information about the device into its SELinux type
> that then allows you to distinguish things like net vs block based on
> the device's SELinux security context rather than encoding that in the
> permission bits.
> - If you truly need new LSM hooks (which you need to prove first),
> then you should pass some usable information about the object in
> question to allow SELinux to find a security context for it. Like an
> inode associated with the device, for example.

I agree with Stephen and I still remain skeptical that these hooks are
needed.  Until I see a compelling case as to why the existing LSM
hooks are not sufficient I can't ACK these hooks.

--=20
paul-moore.com
