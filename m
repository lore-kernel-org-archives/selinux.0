Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84426B955
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977696; cv=none; b=YYokZstC2HGJrX5ddLdnkwkkRtohYv8ByydrvyI8utiyTaidDIBQP7GjpnEbosgSooVQ8GwSoWwTg5Kncd4Vn5NZjE9G9a36K1aMne8QkeQzhYFSeeePMQ2W5Y78B/Q8n4CrNizVmU35Xs4YHSbktwBVX16Q1SAmdIQEPC890UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977696; c=relaxed/simple;
	bh=WM8wGPBFYRmbXHcJCQX9OWIQ73tKJH7ox+2wQ4nrK0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3eMs1wCtEr32rH/ttI6wJB0rypRB4ZMl3JQedHWbe2azbrBgR9s69wnWBTvEC+aoIESraxphntcXcZbc6vmU25O4I/WVz01AVW2x+W1UonIyYzT/jnODaWQp/ecA4j0IFYMcK7vJ0dPG3+UNJR+z7znPeGYlYGB0YZ8PexTDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqycPF+x; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqycPF+x"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso4648441a91.1
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760977691; x=1761582491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjEL1GKQPs6gkLLu+raUELSTbcK8Y9kKgVzAad92Vnk=;
        b=MqycPF+xplDXvv0fnoFWbkwUTcV2bEIJOQvGmX1vXrXVpx9sSrlz28X/sDcXgJDlaj
         Y/3ZSvHyX87WSkZhngxzrG8BBqJGXNDDyebEbDizRyw+th+iCJCOVqv3OoxmYe9Zl2x4
         ZDwPQ23b3Z2NW0G/nw1mLn8iO14NYrsMPPPrvKz7fPlcTe+Q8bNKZBsdJFlt0qVfRWEH
         O/MUH29c30YOLlU73I6AiFxZZz5h5dUQSLiM+PPfXvwmEHbs2CZm3/QCHY75meYA3QHI
         nZwf1I8iNTOQfUVORk3bCR+xOp3xIu53HGuCz9RMxyOXkGGnIIvxAZiKFbyLqygKaPie
         +K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977691; x=1761582491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjEL1GKQPs6gkLLu+raUELSTbcK8Y9kKgVzAad92Vnk=;
        b=dIgWOyCiD9ZJophUNV82tRyp8d3yWp6LvT5IiyXPIKiNNNXOOK/OFYv4Sag++TZhOX
         LqGt2cuzP5Gn3tP8HR5MqiT1qsMKt+5vJywivbuuoarB5yiLPLlrBH1x9c3U0LbLctnQ
         7I9Nx9TtHRKEX1MyJkzqcRHLxhmeStzmKZA/66hjEF1hKHJbcgBPiBwYNAGew6dfYPlH
         G5PboIszyMZl5Ch3OTneUmeYPGivzkY1Ys4PbOTAhIGEA/D/OKsPETLhUTK2HjyNInEO
         lsLeSeXeqVUUjjN+NmjK2W0BsNQHcQtdr6w2iXbTXjMgesHbPqfgeT+ecYONn8HqBxfQ
         RHWA==
X-Gm-Message-State: AOJu0YyGRYbBfHGV+s51kUbCgT5206zYeyqhe/LEeJ0mLwuFJaA3EkSb
	4OXEjYmF+B4A6ah/yZqz0XoJlgUbGfhIzDKYcRbaa5dRjqyuzoEABMBAM6wF19bO3kNy/tU/FFq
	VGTQpSe7mwpLvPohLycVo+qj+aNT/iQe+Ww==
X-Gm-Gg: ASbGncv9ECMClngBCdq0okA83YSqmTjnmVjzSuyX5RnnJUUcDDisQdNq5f9LwMEfQIV
	C0jsGTnot127Zn65K2yz3G92awOr1TJQIrmh3n8MADeF2C4GRJPumrGw/r0tCmkoySqg7elKpzT
	q745JwPzr02yDhNoGdCx3Z3FL4OiuRhvQi3cYkAN/wJPfv9cQFYroxRe2meAImbOpaVUNLZ2ARu
	WCS58yw1m7ZSV9lvJfCKbm3s2Wx0SDBhU5JAvoTO+aYsRc/6XNtDaFBw8NH
X-Google-Smtp-Source: AGHT+IEQjmbUMDWwmJDjWU/0zXcTDa1s/wOGHPeiE6d9L38DcuCMlaF8+AQ3uPPrrgV29g3EvzOk/G2WNSqgYI+aDJM=
X-Received: by 2002:a17:90b:2781:b0:335:2a21:69db with SMTP id
 98e67ed59e1d1-33bcf88837fmr18486216a91.10.1760977690498; Mon, 20 Oct 2025
 09:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018051945.51425-1-nvraxn@gmail.com> <CAEjxPJ6dzwny-82pHpEHf6ugMDpXb_atFe5Q-EZBzte=NYy7_g@mail.gmail.com>
 <DDN73GJRM4FD.64O8R1T8XR3M@gmail.com>
In-Reply-To: <DDN73GJRM4FD.64O8R1T8XR3M@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 12:27:59 -0400
X-Gm-Features: AS18NWDO5uTmbbS6KdI0PEj5CEnAg9j9BUDp3jFKiwnCC_n4ZZ6zUO_rEYHCdio
Message-ID: <CAEjxPJ6FTYB6B3qn3cCGE-16h4kUT-mjGzxxCP9JFDAA-k99hA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:48=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> On Mon Oct 20, 2025 at 2:15 PM BST, Stephen Smalley wrote:
> > On Sat, Oct 18, 2025 at 1:20=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com>=
 wrote:
> >>
> >> In package build/install environments, when semodule(8) is passed the
> >> `--path` option, it is expected that it creates the entire directory
> >> tree for the policy root.
> >>
> >> Some package managers warn or error if permissions do not align betwee=
n
> >> the tree on the existing system and the build environment about to be
> >> merged. To make sure this is a non-issue, create the tree of the polic=
y
> >> root with 0755 permissions (in line with standards for `/var/lib`) and
> >> then chmod the final path to the more restrictive 0700 permissions. As
> >> the contents being placed in the policy root are security sensitive,
> >> erorr instead of warning if we fail to chown the policy root to 0700.
> >
> > error
> >
> >>
> >> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> >> ---
> >>  libsemanage/src/semanage_store.c | 58 ++++++++++++++++++++++++++++---=
-
> >>  1 file changed, 52 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semana=
ge_store.c
> >> index 1731c5e8..c1425f15 100644
> >> --- a/libsemanage/src/semanage_store.c
> >> +++ b/libsemanage/src/semanage_store.c
> >> @@ -491,6 +491,44 @@ char *semanage_conf_path(void)
> >>         return semanage_conf;
> >>  }
> >>
> >> +/* Recursively create a directory from a path string.
> >> + * Returns 0 on success, -errno on failure.
> >> + */
> >> +static int mkdir_recursive(const char *path, mode_t mode)
> >> +{
> >> +       if (!path || !*path) {
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       char path_buffer[PATH_MAX] =3D {0};
> >> +       size_t len =3D strlen(path);
> >> +       /* + 1 for nullterm.  */
> >> +       if (len + 1 >=3D sizeof(path_buffer)) {
> >
> > if len =3D=3D sizeof(path_buffer) - 1, then len + 1 =3D=3D sizeof(path_=
buffer)
> > and this condition will evaluate to true even though the path + NUL
> > terminator will fit into the buffer, right?
> >
>
> Yea, forgot to change the check from `>=3D` to `>` when I added the +1 to
> make the nullterm more clear. Will update.
>
> >> +               return -ENAMETOOLONG;
> >> +       }
> >> +
> >> +       strncpy(path_buffer, path, sizeof(path_buffer) - 1);
> >
> > Not sure why "sizeof(path_buffer) - 1" is used as "n" here or why we
> > even need to use strncpy() at this point. We already know that path
> > has length len and that len < sizeof(path_buffer), right?
> >
>
> Should be fine as I initalise with `=3D {0}`, but it isn't great agreed,
> will change this.
>
> >> +
> >> +       /* trim possible trailing slashes, except if '/' is the entire=
 path.  */
> >> +       while (len > 1 && path_buffer[len - 1] =3D=3D '/') {
> >> +               path_buffer[--len] =3D '\0';
> >> +       }
> >> +
> >> +       for (char *pos =3D path_buffer + 1, *slash; (slash =3D strchr(=
pos, '/')); pos =3D slash + 1) {
> >
> > Assumes that path_buffer originally starts with a "/"? Likely always
> > true but noting it.
> >
>
> I don't think this is the case, there are two cases here:
>
> 1. We start with a /, so `/foo/bar`. In this case, we have the + 1, so
>    the `/` is skipped over and we start searching from the `f` character
>    and find the next `/` before `bar`. In this case, we set that to '\0'
>    so mkdir doesn't read past that, only creating `/foo` (because we did
>    not actually modify the first slash in `path_buffer`. We modify pos,
>    which is how we calculate where '/' is to set it to '\0'.
>
> 2. We don't start with a /, so `foo/bar`. in this case, we have the + 1
>    again, but this doesn't actually matter! Sure, pos advances, but we
>    never remove or change the initial character in the `path_buffer`, we
>    only advance past it when searching for the `/`, which then continues
>    the case like we did above, setting the `/` to '\0'.
>
> I might have had some oversight though, please do correct me if I have
> missed something.

I assumed incorrectly that you are calling mkdir() with pos to create
each directory component in turn. On 2nd look though I see you are
just passing path_buffer each time. But that won't work if you have a
multi-component pathname with more than one directory level, yes?

>
> >> @@ -529,6 +573,8 @@ int semanage_create_store(semanage_handle_t * sh, =
int create)
> >>                         return -1;
> >>                 }
> >>         }
> >> +       /* We no longer need to use mkdir_recursive at this point: the=
 toplevel
> >> +          directory heirachy has been created by now.  */
> >
> > hierarchy
>
> Will fix - whoops.
>
> Regards,
> Rahul
