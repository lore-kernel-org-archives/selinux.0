Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412C3148D4;
	Wed,  3 Sep 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918581; cv=none; b=ZMZXaaxLNjFU/ywNWERZFuksmKxgqfpX+eoHlg3Gd8i8XMGgoqegGtyqiG2r+3cyLn3qBsIvNo8X85sKAjTZYBNK1Hjpz0dl4LjyVOI7j+xK2EoeCbG+fDqYYvC3S639cnBrWe0ZN606FpWS6EpOiHf8wEI0EMsOjFjoP1VQ8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918581; c=relaxed/simple;
	bh=WSXNAkU61phTHVgMjDo2idvCnQzCtc7XxOwUia6Vq9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQXmiRxxclpqf+YanZNt4kfvrSfPYsqCj+RHWW0YYEY5VJ0OpKbvNw2a509leR/8scfWfDQdecLA3CVftcB/ggJ78kEwLUHcCgq3ptidWMEeibfTGlfPrF4JEx1boKJN2vm9zO/Y1ltmdaa05knjUGtO2bMhM3xXPQ7yr/wl1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlzsC2KP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlzsC2KP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-327771edfbbso37498a91.0;
        Wed, 03 Sep 2025 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918579; x=1757523379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dccdTdtSVBoWd1R6G1eLWRzjrSI6LDUnIwi04bR8bg0=;
        b=BlzsC2KP5VZOKk5NArfmJRQORlubmk9tVChFh7XvkHW0gpJPt88DF94ExpRLi95ntp
         GzTn1KeokpW8b6Pa9MlJbFssvH4Q+8kj/13I2h7QDeocLYH+4sjHRQlmJH3dlnyyCREX
         sSBMBqp5YIiBnnVkIjwLtsIKYyVoD7cYGVLKH0MlWlUd/1z2koaF/rItiM9a6ReTXR0n
         oqEFwFRK3QCrj6DXZuwREi7Qeu9arkbNwH+s+r1hqhi2VXqsyuQVTwSj08pLuLWb8/dD
         6nPmxhKIFsDpLI9/kux6KiDxHz1ip/5hjtqg+42vDbk+rWTbgZYZ9MeR46uJrQTztTxe
         CF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918579; x=1757523379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dccdTdtSVBoWd1R6G1eLWRzjrSI6LDUnIwi04bR8bg0=;
        b=UyP5OdHta4cud9poKga+x84J/IwPNksZR1MRwmmVnllC+pzT7ZxN2KubwxDa6Gcf3E
         JUGfKPx6qWHwyYIFJRetcTb9VZciZZDUE8A2r80PdyL8NIcHsMOmJmvi5KReY3jCVvUB
         N0KeSTbNnXd7Ua9q0qaYI1dAvS0yED1dNvxsSPOoFwlk9VOWFvFd0LWrEd+r8ns5WM8Y
         hrBbldX7pi1XB4j7WnnJDchPOa1i8dcqWUkLGbcTwNBArYPNRw+GNq16JU5zjINWgqju
         AXvIYumFf5RRsnOEpfXKdZLwvh0/i4/StdHJNonVo6J40B8gahropIAOgVnZxWumAFIO
         WZZw==
X-Forwarded-Encrypted: i=1; AJvYcCUd7Y0aIxlXGAPH2shmTIoDgQ9XTaq97lYkSZMy1dB9Tp3/6qos2iqwK0/9gRFjG3zX9JzvZMV2atfO/2qRWX16WzMzS7wJ@vger.kernel.org, AJvYcCUtorpB0wq6IeK6iU7K40aHxHvYiqab3FqO6ixs6oD7kNXR7ShHJlT5j52e4X6L27I/b7sfU/0V1Lcjw4M=@vger.kernel.org, AJvYcCXMHBEC4zM//6IunFNO/q/n9Su2Y03H1dEGYuOIOH4FEohWooSRi45+e9yRaW14kve9I6gNLXu1LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAu/zeYGxyiuxeaBuNxKCUBqoDfxevjCGxGqP4N+8d6+JOffPq
	4Ue/b0+VxOWQlXitZeURHr/X1RC25P7JRZveUyEhUkfuGCF7SfDH0+RUwVEJ9/CwXtUPE63mIUd
	x6gurx02IBtGJK6GXVYsF/nNHy0PzIOQ=
X-Gm-Gg: ASbGnct8XsFF7jd8eL9OmcJn6oOHQGIl4P0YttSOc59dBoVC0ZJUgtbK3KZMWSGx4ln
	A/RDc+Tsb/YsHPxan3VQyI4V9eH9wjHJedIvFxrdD3T9yQ6zEbbyQ3eGTlehB7HqF6RCmV/tYJE
	OIrJXUZZqtptgv7HHiI2bOJ6rZWv0o1mt1nBCE7jT+ybdPcYDkV7L+FImYA8CrRWhsD7xNApgyf
	5SvPRQ=
X-Google-Smtp-Source: AGHT+IFIoD21s+dgvxQwnZtU4Sq8/ACTY9GY3T1TUUfdMCaJfXlRUuwQdlKMspanUL1IZbHyARr6Wzg6PdqlUngk1+8=
X-Received: by 2002:a17:90a:dfcf:b0:329:8d0b:6f6d with SMTP id
 98e67ed59e1d1-3298d0b7063mr15671983a91.26.1756918579096; Wed, 03 Sep 2025
 09:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Sep 2025 12:56:06 -0400
X-Gm-Features: Ac12FXxdxISEk6HTcciX9MP3BtKPgGrHTm5LZn51Nrn5tqsOxJ7s30vupNBsxNo
Message-ID: <CAEjxPJ7Y_gkPN4-iS5Q8h16oE8Y1=vD=i=Yu4qQwHKyS97+4Wg@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 25, 2025 at 11:18=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> This looks good to me, but do you have a test for it, preferably via
> patch for the selinux-testsuite?
> See https://github.com/SELinuxProject/selinux-testsuite/commit/023b79b831=
9e5fe222fb5af892c579593e1cbc50
> for an example.
>
> Otherwise, you can add my:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

And now having run the tests posted in:
    https://lore.kernel.org/selinux/20250902055401.618729-1-tweek@google.co=
m/
you can also add my:
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
