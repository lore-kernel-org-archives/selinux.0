Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy6bWMJB"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A215123
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 08:24:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2886579d59fso2261446a91.1
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702052646; x=1702657446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fah9tQfE3hiL7YDJ+EihRmqhrVjTqzDPNdDHjhE6ss=;
        b=fy6bWMJBdpZAN8ayANY6B3xD/xRDgJ18I4Ar3MGVYMQKcj8LKxI4GuD7Qod70e4cGw
         EXqX1v0tivLsui0dvl0dNqmZi+cQnYPwVvzHZKfwrGfK5KM/s2AdbtCsDVq7+d3+RL+o
         sn5FF0Crd9XUHboqvwZ3vAnoHImfH//NEOs1BsTCx5+4KjJpzTdb3K9ey4T0Cn+VeOEM
         49sDu86TTokVm3qecaIXmaA/TEWrDP7oDarz/V8FSs5eMOt9bSBFuDb6V8rXO3+4/d9/
         ioOpEpVutNRLD9raoI/BYf6XwI4+GjP8FGtWnQRl1zdjBtjB2zFtYOk2bGspZBEZvSbm
         klyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052646; x=1702657446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Fah9tQfE3hiL7YDJ+EihRmqhrVjTqzDPNdDHjhE6ss=;
        b=Cleze53JMqX3dibOjfhpMuXQgN6ndfWd1QfWSpHJaaXwSKnMyPdYinEh5bwW4EFm2H
         /hke1g+AAY84QP9/5fnFWnCCPmsNIT63P/ASnbycvHkERbHEVrcqNeoZMaMFxRC81QLB
         cYDCf9gXpUrotyyZikIXQF3fpJZuABu/4h5GqUkHDMoHv1XJFqj95dgJgRS6phJDxiL0
         SarlI+qa++M5f5YT8B+5kefymzVGDc95hUazSdsSWEyqWkm9TF0su9vTdGqLl60GCEMR
         Ter/mtqUtGZXNTTAuZh6idO6JZ0ryKbdOeGs9Xdsq0YajL9/cJI99FIDinafRj5kR6vl
         4aUw==
X-Gm-Message-State: AOJu0Yyjpi5cIKX4vorgFto16mZfciLzMmyL/xN1yHtD4XqhgfCjti4R
	wMwtxqlR4xqi+26dYkDns5wEM8eieFp9IRcL8+CAOyk3
X-Google-Smtp-Source: AGHT+IEvDDYcVKiGcouLwWlzjmFdOyGa5JGJfxe03LM/HFH/BPqZZ8mayS+Qv+NFcyH5wAd1n3/evcrhauTl7NT3cxg=
X-Received: by 2002:a17:90b:ec3:b0:28a:41cb:2ffc with SMTP id
 gz3-20020a17090b0ec300b0028a41cb2ffcmr315520pjb.15.1702052645803; Fri, 08 Dec
 2023 08:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207165319.63889-1-cgzones@googlemail.com> <CAEjxPJ4htnqzDyHFNR_aNJH-hrz_wbM=Z=NN7BjUQDrKBa8e9A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4htnqzDyHFNR_aNJH-hrz_wbM=Z=NN7BjUQDrKBa8e9A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Dec 2023 11:23:54 -0500
Message-ID: <CAEjxPJ7=VvyEzd-NmDvKZokdCrQ_t41++qdNhk1=EZG0ohf5BQ@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: validate permission identifier length
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 11:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 11:53=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Limit the maximum length of permission identifiers.  Otherwise
> > formatting an access vector might fail in the common used helper
> > sepol_av_to_string().
> >
> > The current longest permission within the Reference Policy is
> > x_application_data { paste_after_confirm } with a length of 19.
>
> Android has longer permission names. I'd rather just fix
> sepol_av_to_string() than impose some arbitrary limit here.

Looking at AOSP master, it appears that the longest permission is
32-bytes but since we haven't imposed such a limit in the past, we
have no way of knowing what any particular version of refpolicy, AOSP
policy, or downstream policies might have used.
