Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648384;
	b=WMQUmARbG97o40LdOmMhFgnHmYA0k7t5TvluWXIIr1FYbr3tgnAmFXinEkbY4l4E9/+H
	 VQvNd0hVyEqI6Bq1nWhWfnbbtS/mk5jUKWLpGNqI+yN8UG/WFUv4B13HNEvv5sOFMTpw9
	 uY0ViH/QCdUi/HHVlYALWuyg1WgPhYeLYh+W9hxYsj7nN++98OtI8RhQlShD/oEWGHTYd
	 4l4Q8tE79/2Bb3pnq+FnXv4ZcejrLPyWJxlBiXGfPO+AZkrMsmNcSe3UqKqTCH8Jo2n8W
	 7XweP/iM6yxbF0D9r0OrlbOEwy9h8hPpqbSFgJCGALQ7R4wjFG6NxXRefJ2hmwIXjew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
	b=4LJY4eA95VUbWS4O42WmbGI57B3e4HiAJPA+LgIudbTZGDYKdpVtpf4uKOXy0VPbLnI9
	 fLNHqQe8SUoAcnfnCma2Ho1JnfezjpvrglffUhKmqUdDWn0iS7TZbjK5fOjOhZKr3SsUJ
	 nIKX3VT7OX9lHyT3k+4dFhD6IQyJuccvPHsm9flJc9ho38PvIXEzllswmTzpkSHq9lRAn
	 kyqiJTDuDWwsu5Fpy98mhURjs3qJ+tX7kxJGxqog9rWzw+ud6qvmBOgvTaTRDTxLH4YuY
	 EOQw8Woo5N3mEQVz1oiZfV/PC9znjzkMLyPF6yYgJVJKrlaMltLFOkqvsW19WJYya1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NhlqvCEA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444A606A324
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 19:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9444A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NhlqvCEA
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1221721b3a.3
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 11:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648378; cv=none;
        d=google.com; s=arc-20260327;
        b=hLmA2RzshQ/83JZtgX5rxQt00x4byuQKf7MPsoVEdnvldGZ2wktkM3FNRAxNXCgS5z
         qHKj//yFDHr+vk5yY9pa9XFOmJbMxMZ8Sw+cJDUZl9K/9SLEWog6kqGbGh4xkE0IpPgY
         +XMRoCVKttm68bJstkA4FiPM3XiTN4TeZv88Ggtu8WKQQZwQmOAiFt/syjAC8g8JXU5d
         TRDo42MK4LeUW0y88K11rQPlYbqLsvjLotfNniBvYB3gwDeE6m9+hpDVrXO3FUsTV7uU
         jj/fye6b0sjYpjleo59K+T6O1iW5EtqFouJm8+aOdnabz4NyVlHijQ3+GR7Wi0d469jz
         A49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        fh=cfAztFI6uc4BwG0V1e42V8xq9wP/yYtEmffygjDedCY=;
        b=d5V8n0IlR1dGjFsADXB+WCb+jjAD2VzGeOAtM64AsLyb8F5upMjg6i/EbaRhAI6wV+
         5pY14LQA/MYtEdJxnohAOTPdf8z5r7Tf4fw4TccieYMXCAf/QlXlV5tzefCGrjH/J5hO
         lcuRrJpHz6xqaEnRBlaB49esSP+GfmQTCLX0qjQKcOMfGq1oOdRKdRvfOK971ESRRIFI
         ePao5gK6QNsA/h8QPYHOKyqwmbPeuvwqjW2rYOE6+zBRYdog7syB++cWuCicSGdlOa1+
         1opJoauanzTSR+tkyAiL3QwulfYZ5Ze0bEaej6gsKI2D/tCOeuAWHsMFC8ZW+2eRBI5Z
         tPaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793648378; x=1794253178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        b=NhlqvCEAqNeQh82h66VjeQRCvmLs88bUiMN8vsKnqKJ9wOlSOkwk3pTRZNEo2Wk7dK
         HZv/BWl8uEe1rlLq4Esk4h0lNwnLc7ae2Ug4sIcT0bKI7VrNR03T1LZQUc4K6ZwzXmn6
         He3DDsns3zqXONgEkB7fjVVE0uQ4EfO58HLmbhylcYi+XV4OsEafFtSN66UNdGEqLvGf
         6+P0rp5Bbft2KMHvVeggiGD6wOnDjs5EEn+ovAV85fjamgZf+13AnKK26O49HqVD+JId
         Nx6Te9tI8mE+yrOdmnPFjh4Tt7FpFJqRk8cVNQb3naMOyfjmKyriiJkGVwtVtYKbw4fR
         FC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648378; x=1794253178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        b=EG4VyE+aJFL46F6uarsXCiRwIqnPG6E/y+npnQZTs2RyF4OX/2mTFpavWZein0U90l
         ZVM4bBJbOoRQ5YQ4DEC6rdZryAS0gsnejuRmo/fiq5twEtzNrrko014KYHmQK2BLP8e6
         iitDGf8Z9p8DJe9BHXz6fO9j5CJFdXYt0eHrB9zaQVdpEr5gxt3Q7h03c6E0wZzmYpwo
         qsgOs6L6McIvsb7G0QMj6DeOfEpsCkmiqAG2+GgNCMXIWamCbyIuzCrPb8YdBR10m1jW
         I/ItOfxgqpQK1IcxIdCf5bvw7hWn54XI1yJZxeFA2ByFSTDYFLf9XKRUp24LvgDlfrIi
         dU+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6tWZ2dlFL0L+ipnHjmO0kL41aQz/AmlWrAmHMxtsSCbX6QavNXYUKWKUk2PNiFCCQkZB5KCrZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8YTT+5A/DvaUxKlG5tZOOfNtYj4MadVU5e8BSvPNtkiKgbq0y5
	KtCgVz8qoiVDGZG69e4e3giHJUBCR+Per/5f9VMoEuehXp6BeNNyWB9TXNbkhnXpLF6kIpjKj1l
	sgWeu2XYt3w3Gb+4BjvndkieWwRcIRjn99y7zxCgD
X-Gm-Gg: AYBFou1y3een2I3LLBqFp7Npv79WCKdWpMhZHQyV9eEdG+Qwu1C02CByqRG/7J+4C6J
	cgi2Xj4j2WJE71iRcCaBGeIe2D8xFwaaGP3gBCUeXyZEqGxWPhgG65ttX4RfSeq77GZFPmDhopr
	3kXJXCDVvZlqlEwMbL6+6OnT9x3fMa/aSINzMkOBaR/VmV1iUjq14RrlerppvBbs040/ADVSLff
	BI/ZoiXvMXgDCKtVSFQBTGMmn16tI4g9JL9jZwIS7BdwN3s0u/1zMEyXhwMyrCfSMAxz3BPaYTt
	bLjFLDj0sGLFQ9Cj/IULX7Qt4+4+DSDR3sIe7cgDTbE3mxk3Bg67ATLvGO85JMPoWgx1ukldGiB
	Ujs3PUTuxOTM/b3rZcKlVxP0KLJy9G2aT8PB3zSada1bQGhDY3r8B0Z7ZsE0sVPPzPa6X
X-Received: by 2002:a05:6a00:3c89:b0:8a0:3307:c46c with SMTP id
 d2e1a72fcca58-8a9bea6b19cmr8445171b3a.36.1793648377853; Mon, 02 Nov 2026
 11:39:37 -0800 (PST)
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
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Nov 2026 14:39:25 -0500
X-Gm-Features: AclHuK_N7t88qS7YSGZ1TxDpP4hXHc3j5T0g0RysETh1DoLdW5UuZOpzEfeNB98
Message-ID: <CAHC9VhRU1WZrsnw4q+vA_pKGGPs6kydHZsLbycWzbN27ygLXdg@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, James Morris <jmorris@namei.org>, 
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

I've only given this a quick look, but I'm also not excited about the
LSM hook being conditional on the "sealed" flag.  I'd prefer for the
security_file_receive() hook to catch all the files, but take an
additional bool argument indicating the sealed state; this would allow
individual LSMs to decide how best to handle this.

  security_file_receive(struct file *file, bool sealed)

--=20
paul-moore.com
