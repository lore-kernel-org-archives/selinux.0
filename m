Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646411;
	b=jzjr9rIfNccqpu0dKIKc5W6olwPO7uh0EkR9AqTnf5MzJboxvMeCb189T76Plhh0HxuE
	 smbIF0gIIsxCpLoZxptzyalEvutKusByE5AcGOUhiRONUYvgKBoDfqd376stxvc0Z0+tP
	 OWxYIOVvgOtDIaPQq9Vku40zbsgnMwCipb/EfzN6TfN5AzcESKuQ7J4MFfufix2Mk6/W7
	 xpjvgq6vbIQazD9FrDAkVttw6btD4wscfnwR1wAJLgl2dlQROpxrzQjQdDExEowPckpkE
	 YFlwEvhH1F8T1DgnZW/5521RHoHi95lIZnKKnO+z9y2BhNZY5edXXbwfqk1UfBO5k2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
	b=2sXurOFhr6vuoCMfzJ2Iz6K2y8N8iE8rNLqoDTC+XLxPzKnne/gMPnoykRoyXQiFXrsU
	 dfD9YFrqrAgU7zfeHVAtz0wQRMv09jIc3NzO8/whTyW9jZNxNzQRzZEo2dYPLCZRUJKud
	 eU3XlFUZkSqgXoac30zN6TxGNNctcwbWpbY8qqnSmxMAKnPB4bBAp6EkFF1ODfw0O2J/w
	 sCRTAqRuFDuKXOJUM6YioteFZn0PKxFT0NHOG2F3nkbv5DyWQzaFapphqbwVow61NdWhY
	 nN/cGRtAXn6Uwsf6NVBx4oYT3ptKfzaanmDZ0PkYZzOP3fhRTECHXz4nog7/PKisLfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnNnjlYE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E66606A32D
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 19:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E66606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnNnjlYE
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679e86015e2so4523716d50.1
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 11:06:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646410; cv=none;
        d=google.com; s=arc-20260327;
        b=pvQMT+R7hw/wqiicub0knFTqVagDajPGfE3QeVWokTeLwv6rdBT3lTgCjfSYZpaev6
         gUPyzFu6vg9btbuFgAzAOLVeVk0NQ7CLCkUzNJZwY7QU0bHBUTlAOEwTX4xj0W+Evk0V
         sX0ULYL471yFkiQTeDspTjmfDsLJ5rWBkh7NNVhaWSHD+k71m4/F3GVu6ogJaahUm8ZS
         rUIX0Ht5/m2HXBclVmEAlbXUzY0yCgMxu5htbiIgOfoyJyOjf5b1jTZ7XGZnqD/NFQ7U
         rcaywywt/20YP27SOHjXsHEt5gPtUn/SbhiQ1cunj3BbkyV8/79kXlowsdYe1ihAOBWO
         FT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
        fh=ut7823SRL01f1mbS2NC2rVzyYjoxK4ucCBahacp24JQ=;
        b=G9nlxxGlTFa/cRPfCDpIIq6kmeUY8rqvIgmTnOVk5/SH7gFiVDRofUfaONKkWiR+GQ
         su3F6RIwlaYG0qOh9pM8o5R46KhTnMXmikHX+C9X9I7/jmeTF7Jsq2w9DDh2Pj+MRSGz
         I/FsNfQaJ/4zqnfWajSxeG7TTtkgtmwNnN3Hl9WdydniigXXzK3eBYbFliWF7Zgkt4Nh
         WPvLSBkshLJsg6qc5epLXbakqXXU1WB5eDFNoEATbruQ+nG7Bz5sdUS66lbl1zUO/QT/
         D6NdCBI/POICUnCH4DrREyAf/y21R8HH9ENyveKHibFmvAA+/8ilmgew8cHwWS6FDCqd
         HvBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646410; x=1794251210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
        b=tnNnjlYEC10sRjaX8VVbgcAd8IKKiRclExe8oUiilq9oJbJXGXPaFX7svfDWA5VLcT
         dOrwbO+NBopmy9Rrtc6LeuIOKlv9sNYHZeMG9OC5fE9TOe9mWgw2wNWZQtspd9LRsAK2
         C6/Fd8cuZZCW6A0ONYIN37BzGXlDL9/3Cq419MKJAvuV+BEd67LaqKQwLsTh3j9I0VSq
         caiKXG/Jt2mJ+QGF8dd5beMFmncSCIGhzIqJjv2AeR6ntBD/ovF5X+Z9WgKo7D5LXKy7
         EJ1DiHzkPdusb/TESQq1QJDbStCB4CUmD/ziqBshYiv2TZsxjLh0ZHwxzhWc8cEUWunN
         yyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646410; x=1794251210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoGzdrvvaViECSeg3PiBflj+0qzs8BGFy96FG4d/cj8=;
        b=ntCpdibVEzKwS7Q/pcxAB3FDcbHeCvFa9DRdVrlNXvxP3mSrS+7ya3qr2X+khm85Sc
         r2ToD6//NfLah/TyA+I2dshKgmux1TjMWxca6OBjotRb0+K95gS8DAgdHupcZ1MjWfE+
         M2rCYzjzf9bW5SjytEARogfLYJcTGOAy0dOtWVPGrZd90w9xhh8BC1gjYRkQJfymXmlC
         7tINlUwtHKJFWtl/sd50jcC5HRSz3iGH/KMhuckoG0bFsh3/osDtgV2ZEgyKCp8jBq2q
         R7eg5R2MZ9sf/8uqnSdrGm2Dmjpz1LIlZNQ6McpYQ33w1pEYW+RAl/SZDPM/mduMwQQg
         ArWg==
X-Forwarded-Encrypted: i=1; AKwUvByPdKi/kw3S0mBJChNmzajqixSrzVjabWtbHync7jmmO19DXA9U/dhIvHA9n0sRXRtfmuC9gxft@vger.kernel.org
X-Gm-Message-State: APuU4Z+EroXhk7WnRNRTvkAIcj843yPUXG8Rj1O/25KZhhMLaPTiSTJ5
	LxX2CYYYXqpwOjf1UbNY4B6sYP3cTiEleyCAW69ncH4UTAAg1Om1hAc5MjeczYNW0EI+r2sPLoE
	m08pXbWVWSSqb4RBELKVkeW4LwfpXTV4=
X-Gm-Gg: AYBFou3un8Y+fNL4POqoqqhXgJ9IwRe+BM+Xke1C1fVtNr+0KRiDVIteUshvfpHFt2O
	6AYZN5SEuGjaa0przUo1wx3YoohwEa7MzN3wy8iVfwdxUt4HYw5x+4WDSxzLdj5xRqDz4No8idC
	iinXySrJ62RLuYrnF5SOq+o3eC6eZSgJC+w2WdStS6Ik+AFvzZ0rtIxdcX5fEZXxBEWK914Q5ec
	E07W/IRJVjrA4ZH2HlFSrZqTgTXYWpz7H+YLnwq4Wb9+eMcwPLxFO3Mg7kNxo4U6CEHecGZG/J7
	B9Q+lZJTrm6hrK9NG868CQJZMJ8X5gnHCCegruezQMXXaDQeLnzHBaQpdbtnMIQ+XPUl4DHjMB+
	YtZf6e0drPQ8wz/5bD2xJ1eHmKwbXYcUV0CH70DhYwNb2+JtDKgEnocDa8ODQ3t2dwUEvVAbqVN
	1k0yAvhXCngCTn1PeXrIyLe/tVAwqaS5PesOIfK14X6siS6+1bK7shNLpp8w==
X-Received: by 2002:a05:690e:1c20:b0:679:90f4:3223 with SMTP id
 956f58d0204a3-67a8d3987b5mr8777022d50.9.1793646409776; Mon, 02 Nov 2026
 11:06:49 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com> <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Nov 2026 14:06:38 -0500
X-Gm-Features: AclHuK9UEiLULgDNF_R4Op6pxR3pAD5yp_wmeU60kO8Lo7f2jaleNkGh11hTlfk
Message-ID: <CAEjxPJ6X3Hvd5eOCxmqaNWi-vqbGEj6rULHiFJGgD41uPxAm7w@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnac=
ek@gmail.com> wrote:
> >
> > Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> > mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> > like SELinux to validate the receiver's access to the received file
> > (similarly to a process inheriting file descriptors through execve(2)).
> >
> > However, there are cases (such as dbus daemon/dbus-broker) where the
> > receiver doesn't intend to access the received file and merely wants to
> > forward it to a third process. In this case the forwarding process woul=
d
> > need to have the appropriate r/w access to the file in order to receive
> > it, even though it will never actually acess it. That leads to the
> > security policy having to grant the forwarder access to a potentially
> > wide range of files (in case of dbus-broker basically all files), which
> > is not ideal.
> >
> > This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> > recvmsg(2), wraps any received files into an opaque anonymous inode wit=
h
> > the name "[envelope]", skipping the security_file_receive() LSM check.
> > The returned "[envelope]" file descriptor can't be used in any
> > meaningful way other than being passed forward via sendmsg(2) with the
> > MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> > sent via SCM_RIGHTS to the receiver. The receiver can then either
> > receive the file as normal (subject to the LSM check) or again "sealed"
> > in the "[envelope]" anon inode for further forwarding.
> >
> > Note that sending the "[envelope]" file is only allowed with the
> > MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> > unexpected behavior. Attempting to send it without this flag will fail
> > with an error. This also avoids recursive nesting of "[envelope]" files=
,
> > which would only make this feature harder to audit for possible issues.
> >
> > This patch also adds a simple read-only sockopt for UNIX sockets that
> > allows userspace to determine if this feature is present (passing
> > unknown CMSG flags unfortunately doesn't lead to an error currently).
> > The minimal code to do so can look like this:
> >
> >     #ifndef SO_RIGHTS_SEALED_SUPPORTED
> >     #define SO_RIGHTS_SEALED_SUPPORTED 88
> >     #endif
> >
> >     #include <sys/socket.h>
> >     #include <unistd.h>
> >     #include <stdbool.h>
> >
> >     bool MSG_CMSG_SEALED_supported(void)
> >     {
> >         int sock, ret;
> >         socklen_t optlen =3D 0;
> >
> >         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
> >         if (sock < 0) {
> >             /* handle error */
> >             /* ... */
> >         }
> >
> >         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED=
,
> >                          NULL, &optlen);
> >         close(sock);
> >
> >         return ret =3D=3D 0;
> >     }
> >
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
>
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index ae38f3c1165c..08822b2a1f22 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, stru=
ct scm_fp_list **fplp)
> >
> >                 if (fd < 0 || !(file =3D fget_raw(fd)))
> >                         return -EBADF;
> > -               /* don't allow io_uring files */
> > -               if (io_is_uring_fops(file)) {
> > -                       fput(file);
> > -                       return -EINVAL;
> > +
> > +               if (sealed) {
> > +                       /* Only allow sealed files */
> > +                       if (file->f_op !=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This leaks a file reference.
>
> > +
> > +                       file =3D (struct file *)file->private_data;
>
> This fails to take a reference to the underlying file but will later get =
fput().
>
> > +
> > +                       /*
> > +                        * No need to check for io_uring files here as =
the
> > +                        * underlying file had already successfully pas=
sed the
> > +                        * check when it was first sent.
> > +                        */
> > +               } else {
> > +                       /* Don't allow sealed files */
> > +                       if (file->f_op =3D=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This also leaks a file reference.
>
> > @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
> >  }
> >
> >  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flag=
s,
> > -                   bool notrunc)
> > +                   bool notrunc, bool sealed)
> >  {
> > +       struct file *f_received;
> >         int error;
> >
> >         if (!ufd)
> >                 return -EFAULT;
> >
> > -       error =3D security_file_receive(f);
> > -       if (error)
> > -               return notrunc ? put_user(error, ufd) : error;
>
> Design point: I would suggest adding and using a new LSM hook that
> allows security modules (like SELinux) to still be able to check a
> (new) permission that governs whether a process can pass along these
> sealed fds so that we do not entirely lose control over their use.

One other design point: you are creating the envelope with
anon_inode_getfile(); consider using anon_inode_getfile_secure()
instead so that security_inode_init_security_anon() can give the
envelope a labelable context, which SELinux could then use to label
and control envelope use directly.
